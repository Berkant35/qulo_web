# Power Inventory Display — Design Spec

**Tarih:** 2026-03-19
**Branch:** APP-1915
**Durum:** Onaylandı

## Problem

Kullanıcı profil sayfasından sahip olduğu özel güçlerin (power-up) envanter durumunu göremiyor. Güçleri görmek için exchange ekranına gitmek zorunda.

## Çözüm

Profil sayfasına yeni `PowerInventoryGrid` widget'ı eklenerek kompakt güç envanteri gösterilecek.

> **Not:** Exchange ekranındaki `PowerShopCard` zaten `inventoryCount` parametresi alıyor ve envanter sayısını gösteriyor. Bu tarafta değişiklik gerekmez.

## Kararlar

| Karar | Seçim |
|-------|-------|
| Profildeki konum | BadgeBar ile "About Me" section arasına |
| Profildeki format | Kompakt grid — 6 ikon yan yana, altlarında ×N sayısı |
| Tıklama davranışı | PowerPurchaseSheet açılır (mevcut quiz sheet) |
| Sıfır envanter | Soluk/disabled (opacity 0.35, gri ton) |
| Yaklaşım | Profil-only yeni widget |

## Tasarım Detayları

### 1. PowerInventoryGrid Widget

**Dosya:** `qulov2/lib/features/profile/widgets/power_inventory_grid.dart`

**Görünüm:**
```
┌─ SectionCard ────────────────────────────────────────┐
│  "Güçlerim" başlık                                    │
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
- SectionCard başlığı: `context.tr('my_powers')` localization key'i ile

**Tıklama detayı:** Sheet tüm güçleri gösterir (mevcut davranış). Tıklanan güce scroll/highlight yapılmaz — kullanıcı istediğini seçer.

### 2. Profil Sayfası Entegrasyonu

**Dosya:** `qulov2/lib/features/profile/screens/profile_screen.dart`

**Değişiklik:** `BadgeBar` widget'ının altına `PowerInventoryGrid` eklenir.

**Veri yükleme:** `initState`'te `ref.read(exchangeProvider.notifier).fetchAll()` çağrılır. Guard: `if (state.rates != null) return;` kontrolü `fetchAll` içine veya çağıran tarafa eklenir (gereksiz tekrar fetch önlenir).

## Veri Akışı

```
Profil açılır → fetchAll() (rates == null ise) → ExchangeState.inventory dolur → Grid render
Güce tıklanır → PowerPurchaseSheet açılır → Satın alma → Provider güncellenir → Grid güncellenir
```

## Edge Case'ler

| Durum | Davranış |
|-------|----------|
| İlk yükleme (loading) | Grid shimmer/skeleton gösterir |
| Refresh sırasında | Stale data gösterilmeye devam eder (flash önleme) |
| API hatası | Grid gizlenir (rates == null && !isLoading koşulu) |
| Yeni güç eklenirse | PowerType enum'dan aktif güçler filtrelenir |

## Dokunulan Dosyalar

| Dosya | Değişiklik |
|-------|-----------|
| `qulov2/lib/features/profile/widgets/power_inventory_grid.dart` | **Yeni** — kompakt grid widget |
| `qulov2/lib/features/profile/screens/profile_screen.dart` | Grid ekleme + fetchAll çağrısı |
| `qulov2/lib/core/l10n/app_localizations.dart` | `my_powers` key ekleme (TR + EN) |

## Kapsam Dışı

- Backend/API değişikliği yok
- Exchange ekranı değişikliği yok (zaten envanter gösteriyor)
- PowerBlock/PowerUnblock güçleri henüz aktif değil, grid'e dahil edilmez
