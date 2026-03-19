# Power Inventory Display — Design Spec

**Tarih:** 2026-03-19
**Branch:** APP-1915
**Durum:** Onaylandı

## Problem

Kullanıcı profil sayfasından sahip olduğu özel güçlerin (power-up) envanter durumunu göremiyor. Güçleri görmek için exchange ekranına gitmek zorunda. Ayrıca exchange ekranındaki shop kartlarında mevcut envanter sayısı gösterilmiyor.

## Çözüm

İki noktada envanter görünürlüğü sağlanacak:

1. **Profil sayfası** — Yeni `PowerInventoryGrid` widget'ı ile kompakt güç envanteri
2. **Exchange ekranı** — Mevcut `PowerShopCard`'lara envanter count badge'i

## Kararlar

| Karar | Seçim |
|-------|-------|
| Profildeki konum | BadgeBar ile "About Me" section arasına |
| Profildeki format | Kompakt grid — 6 ikon yan yana, altlarında ×N sayısı |
| Tıklama davranışı | PowerPurchaseSheet açılır (mevcut quiz sheet) |
| Sıfır envanter | Soluk/disabled (opacity 0.35, gri ton) |
| Exchange'deki format | Her shop card'ın köşesinde envanter count badge |
| Yaklaşım | Tek PowerInventoryGrid widget, iki yerde kullanım |

## Tasarım Detayları

### 1. PowerInventoryGrid Widget

**Dosya:** `lib/features/profile/widgets/power_inventory_grid.dart`

**Görünüm:**
```
┌─ SectionCard "Güçlerim" ─────────────────────────────┐
│                                                       │
│  [Oracle]  [50/50]  [Skip]  [SkipAll]  [Time]  [Hint]│
│    ×3       ×2       ×0      ×1        ×5       ×0   │
│                                                       │
└───────────────────────────────────────────────────────┘
```

**Davranış:**
- `exchangeProvider` dinler → `ExchangeState.inventory` ile sayıları alır
- 6 aktif güç tipi sabit sırada: Oracle, Half, Skip, SkipAll, TimeExtend, Hint
- Her güç: `PowerIcon` + altında count text (×N)
- count == 0 → opacity 0.35, ikon gri tonlu
- count > 0 → tam opacity, gücün kendi rengi
- Herhangi bir güce tıklayınca → `PowerPurchaseSheet` açılır
- Layout: `Row` + `MainAxisAlignment.spaceEvenly`

**Veri yükleme:** Profil sayfasının `initState`'inde `ref.read(exchangeProvider.notifier).fetchAll()` çağrılır (lazy — sadece henüz yüklenmemişse).

### 2. PowerShopCard Envanter Badge

**Dosya:** `lib/features/exchange/widgets/power_shop_card.dart`

**Değişiklik:** Kartın sağ üst köşesine envanter count badge'i eklenir.

```
┌─────────────────────────────────────────┐
│ PowerIcon  │  Oracle          │  [×3]   │
│            │  Bir şık önerir  │  [P 5]  │
│            │                  │  [G 15] │
└─────────────────────────────────────────┘
```

**Davranış:**
- `exchangeState.getCount(power.name)` ile sayı alınır
- count > 0 → renkli badge (gücün rengi arka plan, beyaz text) "×3" formatında
- count == 0 → badge gri tonlu veya gösterilmez
- Satın alma sonrası otomatik güncellenir (mevcut provider akışı)

### 3. Profil Sayfası Entegrasyonu

**Dosya:** `lib/features/profile/screens/profile_screen.dart`

**Değişiklik:** `BadgeBar` widget'ının altına `PowerInventoryGrid` eklenir.

## Veri Akışı

```
Profil açılır → fetchAll() → ExchangeState.inventory dolur → Grid render
Güce tıklanır → PowerPurchaseSheet açılır → Satın alma → Provider güncellenir → Grid güncellenir
```

## Edge Case'ler

| Durum | Davranış |
|-------|----------|
| Loading | Tüm güçler ×0 soluk gösterilir |
| API hatası | Grid gizlenir, mevcut error handling pattern |
| Yeni güç eklenirse | PowerType enum'dan aktif güçler filtrelenir |

## Dokunulan Dosyalar

| Dosya | Değişiklik |
|-------|-----------|
| `lib/features/profile/widgets/power_inventory_grid.dart` | **Yeni** — kompakt grid widget |
| `lib/features/profile/screens/profile_screen.dart` | Grid ekleme + fetchAll çağrısı |
| `lib/features/exchange/widgets/power_shop_card.dart` | Envanter count badge ekleme |

## Kapsam Dışı

- Backend/API değişikliği yok
- Yeni localization key yok (mevcut `power_*` ve `power_*_desc` key'leri kullanılır)
- PowerBlock/PowerUnblock güçleri henüz aktif değil, grid'e dahil edilmez
