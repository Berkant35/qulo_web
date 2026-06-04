# Dinamik Push Bildirim Sistemi — Design Spec

**Tarih:** 2026-06-05
**Kapsam:** Phase 1 — Foundation (Template engine + Admin dashboard)
**Hedef:** Push notification metinlerini deploy gerektirmeden değiştirebilme

---

## 1. Motivasyon

Qulo'da push notification metinleri şu an `qulo-server/src/locales/tr.json` ve `en.json` dosyalarında hardcoded. Her değişiklik kod commit + Railway deploy gerektiriyor. ASA kampanyaları başlarken push metinlerini hızlıca A/B test edebilmek, kötü performans gösteren bir mesajı 2 dakikada değiştirebilmek mümkün değil.

Bu spec, push metinleri için **deploy gerektirmeyen, admin panelinden yönetilebilir, geri dönüşü kolay** bir altyapı kuruyor. Aynı altyapı sonraki fazlarda (retention push'ları, gamification, multi-locale) temel olarak kullanılacak.

---

## 2. Yaklaşım — DB Override + Locale Fallback

İki kaynaklı bir sistem:

- **Locale dosyaları** (`tr.json`, `en.json`) — default + git-tracked, kaynak gerçek. Hiç dokunulmuyor.
- **DB tablosu** (`push_messages`) — override katmanı. Boş bırakılırsa default geçerli.

Render mantığı:
```
sendPush(type, locale, params)
  → override = SELECT * FROM push_messages WHERE type=? AND locale=?
  → if (override?.is_active === false)            → push iptal
  → title = override.title ?? locale_file.title
  → body  = override.body  ?? locale_file.body
  → replace placeholders ({name}, {badge}, vb.)
  → FCM payload
```

DB sorgusu hata verirse → `console.warn` + locale dosyasına düş. Self-healing.

---

## 3. DB Schema

### Yeni tablo: `push_messages`

| Kolon | Tip | Açıklama |
|---|---|---|
| `id` | `uuid` | Primary key, `gen_random_uuid()` default |
| `type` | `text` | Push tipi (örn. `new_message`, `new_match`) |
| `locale` | `text` | Dil kodu (örn. `tr`, `en`) |
| `title` | `text` nullable | Override başlık. Null → locale default |
| `body` | `text` nullable | Override gövde. Null → locale default |
| `is_active` | `boolean` not null default `true` | False → push hiç gönderilmez |
| `updated_at` | `timestamptz` not null default `now()` | Son değişiklik zamanı |
| `updated_by` | `text` nullable | Admin email/id (audit için) |

**Constraint'ler:**
- `UNIQUE (type, locale)` — her tip+dil için tek satır
- `CHECK (title IS NOT NULL OR body IS NOT NULL OR is_active = false)` — boş override anlamsız

**Index:**
- `(type, locale)` zaten unique index olarak gelir
- Ek index gerekmez (tablo max ~150 satıra ulaşır)

### Migration sırası

```sql
-- migrations/025_push_messages.sql
CREATE TABLE IF NOT EXISTS push_messages (
  id          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  type        text NOT NULL,
  locale      text NOT NULL,
  title       text,
  body        text,
  is_active   boolean NOT NULL DEFAULT true,
  updated_at  timestamptz NOT NULL DEFAULT now(),
  updated_by  text,
  UNIQUE (type, locale),
  CHECK (title IS NOT NULL OR body IS NOT NULL OR is_active = false)
);
```

Mevcut tablolara (`users`, `notifications`, `campaigns`) dokunulmaz.

---

## 4. Server Değişiklikleri

### 4.1 Yeni helper — `getTemplate()`

Dosya: `qulo-server/src/services/notification.service.ts` (mevcut servisin içine)

```ts
async function getTemplate(
  type: PushType,
  locale: SupportedLocale
): Promise<{ title: string; body: string; isActive: boolean } | null> {
  // 1. DB override'ı çek
  let override = null;
  try {
    const { data } = await supabase
      .from('push_messages')
      .select('title, body, is_active')
      .eq('type', type)
      .eq('locale', locale)
      .maybeSingle();
    override = data;
  } catch (err) {
    console.warn('[push] override fetch failed, falling back to locale file:', err);
  }

  // 2. is_active=false → push iptal
  if (override?.is_active === false) return null;

  // 3. Locale dosyasından default
  const defaults = loadLocale(locale).push[type];
  if (!defaults) return null;

  return {
    title: override?.title ?? defaults.title,
    body: override?.body ?? defaults.body,
    isActive: true,
  };
}
```

### 4.2 `sendPush` değişikliği

Mevcut `sendPush` fonksiyonu `getTemplate()` çağıracak. Placeholder replacement (örn. `{name}`) aynı şekilde devam eder. Override veya default olması fark etmez — string template aynı format.

`null` dönerse (`is_active=false` veya template hiç yoksa) push gönderilmez, log atılır.

### 4.3 Admin endpoint'leri

Dosya: `qulo-server/src/admin/admin.controller.ts` (mevcut controller'a eklenir)

| Method | Path | Görev |
|---|---|---|
| `GET` | `/admin/api/push-messages?locale=tr` | Tüm tipleri listele (locale bazlı). Her tip için: type, default başlık, override var mı, durum, updated_at |
| `GET` | `/admin/api/push-messages/:type?locale=tr` | Tek bir tipin detayını döner: default title/body + override title/body (varsa) + is_active |
| `PUT` | `/admin/api/push-messages/:type?locale=tr` | Body: `{ title?, body?, is_active }`. Upsert (varsa update, yoksa insert). `updated_by` = req.user.email |
| `DELETE` | `/admin/api/push-messages/:type?locale=tr` | Override'ı siler — default'a geri döner |

**Validation:**
- `type` mevcut `PushType` enum'unda olmalı (whitelist)
- `locale` desteklenen dil olmalı (şu an `tr`, `en`)
- `title`/`body` içindeki placeholder'lar (`{name}` vb.) regex ile kontrol edilir — bilinmeyen placeholder reject edilir

---

## 5. Admin Panel UI

Mevcut admin paneline (`qulo-server/src/admin/views/`) 2 yeni sayfa eklenir. Tasarım minimum — mevcut admin view stiline uyumlu.

### 5.1 Liste sayfası — `/admin/push-messages`

- Üst sağ: dil seçici (TR ▼ / EN)
- Tablo kolonları: **Tip** · **Başlık (default veya override)** · **Durum (🟢 aktif / 🔴 pasif)** · **Son düzenlenme**
- "default" etiketi → hiç override yok
- "2 saat önce" gibi tarih → override var
- Satıra tıklayınca edit sayfasına gider

### 5.2 Edit sayfası — `/admin/push-messages/:type`

- Üstte: tetikleyici açıklaması + kullanılabilir parametreler listesi (`{name}` gibi)
- Başlık input + altında "Default: ..." gösterimi + "Default'a dön" butonu
- Gövde input + altında "Default: ..." gösterimi + "Default'a dön" butonu
- Durum: Aktif / Pasif radio (Pasif seçilince "emin misin?" onayı)
- **Önizleme bölümü:** input'a yazdıkça canlı güncellenir, placeholder'ları örnek değerle doldurur (örn. `{name}` → "Berkant")
- Alt: İptal · Kaydet

Pasif yapma onayında uyarı: "Bu push artık hiç gönderilmeyecek. Emin misin?"

---

## 6. Migration & Rollout

### Zero-downtime sırası

| Adım | Aksiyon | Durum sırasında |
|---|---|---|
| 1 | Supabase migration: `push_messages` boş tablo oluştur | Sistem normal çalışır (yeni tablo kullanılmıyor) |
| 2 | Railway code deploy: `getTemplate()` + admin endpoint'leri | Tablo boş, tüm push'lar default ile gider — kullanıcı tarafında hiçbir değişiklik yok |
| 3 | Admin sayfalar canlı | Sen panelden override yazana kadar hâlâ default'lar geçerli |
| 4 | İlk override (manuel) | Bir push'a girip metin değiştirirsin, anında geçerli olur |

### Rollback

Her adım geri alınabilir:
- Adım 4 → "Default'a dön" tıkla
- Adım 3 → admin route'unu kapat (kullanıcıya etki yok)
- Adım 2 → `git revert` + redeploy
- Adım 1 → `DROP TABLE push_messages` (yeniden oluşturulur)

### Locale dosyaları silinmez

`tr.json` ve `en.json` git'te kalır. Sebepler:
1. Source of truth — code review güvencesi
2. "Default'a dön" mantığının kaynağı
3. Yeni dil eklenince önce dosyaya, sonra admin'e

### Initial seed YOK

Tablo boş başlar. DB'ye dosyadaki metinleri kopyalamak override fikrini bozar.

---

## 7. Risk Analizi

| Risk | Olasılık | Etki | Önlem |
|---|---|---|---|
| DB sorgu fail | Düşük | Push default ile gider | `try/catch` → locale fallback |
| Yanlış metin canlıya çıkar | Orta | Kötü UX | "Default'a dön" 1 tık + preview |
| Geçersiz placeholder | Orta | Mesajda `{nme}` görünür | PUT öncesi regex validation |
| Tablo şişer | Çok düşük | Yok | Max ~150 satır (8 tip × 16 dil ≤ 128, Phase 1'de 16) |
| Aktif push yanlışlıkla pasif | Düşük | İlgili push gönderilmez | Pasif onay diyaloğu |
| Migration + deploy çakışması | Çok düşük | Kısa süreli hata | Migration önce, kod sonra |

---

## 8. Başarı Kriterleri

Phase 1 "tamamlandı" denmesi için 5 maddenin tamamı:

- [ ] `push_messages` tablosu Supabase'de canlı (migration uygulanmış)
- [ ] `notification.service.ts` → 8 mevcut push tipi `getTemplate()` kullanıyor
- [ ] Admin panelde `/admin/push-messages` sayfası açılıyor, 8 tip listeleniyor
- [ ] **Canlı test:** Bir push tipine (örn. `new_message`) admin panelden override yazılıyor → 30 saniye içinde gerçek kullanıcıya yeni metin gidiyor → mobile cihazda doğrulanıyor
- [ ] **Rollback test:** "Default'a dön" tıklanıyor → bir sonraki push orijinal metinle gidiyor

---

## 9. Faz Roadmap (Phase 1 sonrası)

| Phase | İçerik | Süre | Ön koşul |
|---|---|---|---|
| **1** (bu spec) | Foundation: tablo + helper + admin panel | 2-3 gün | — |
| **2** | Retention push'ları (Day 1/3/7/14) + cron | 2-3 gün | Phase 1 |
| **3** | Gamification (badge_earned, diamond_earned, level_up) | 2-3 gün | Phase 1 |
| **4** | 16 dile yayılma (14 yeni dil çeviri) | 1-2 gün (kod) + çeviri süresi | Phase 1 |
| **5** | A/B test · audience segment · audit log · cache · analytics | İçerik bazlı, 2-4 gün her madde | Phase 1-3 |

Phase 2/3/4 paralel olabilir. Önerilen sıra: Phase 2 önce (ASA dönerken retention en kritik).

---

## 10. Out of Scope (Phase 1)

- Email template'leri editleme
- In-app banner editleme
- Campaign sistemi değişikliği (yan yana yaşar)
- A/B test, audience segment
- Analytics dashboard
- Edit geçmişi tam audit (sadece `updated_at + updated_by` yeterli)
- Çoklu admin rol/yetki sistemi
- Cache layer
- Mobile tarafında client-side template override

---

## 11. Açık Sorular (implementation planında netleşecek)

1. `loadLocale(locale)` fonksiyonu zaten var mı yoksa email helper'ı mı kullanılacak? — implementation'da kontrol
2. `req.user.email` admin oturumunda mevcut mu? — `updated_by` için
3. Admin view şablon dili (EJS) — yeni sayfa için aynı engine
4. Push tip enum'u tek bir kaynaktan mı geliyor (server) — admin endpoint validation için

Bu sorular implementation plan aşamasında cevaplanacak.

---

## 12. İlgili Bağlam

- **Server notification entry point:** `qulo-server/src/services/notification.service.ts`
- **Mevcut locale dosyaları:** `qulo-server/src/locales/{tr,en}.json` (push bölümü)
- **Admin paneli kökü:** `qulo-server/src/admin/`
- **Memory referansı:** Notification System tamamlanmış (16 task, 6 phase) — Qulo CLAUDE.md
- **Bildirim envanteri:** Bu spec öncesi çıkarılan tablo (tüm 8 push tipi ve trigger noktaları)
- **ASA kampanya bağlamı:** `docs/marketing/apple-search-ads.md` — push retention için Phase 2 motivasyonu

---

_Spec hazırlayan: Berkant Çalıkuşu + Claude_
_Son güncelleme: 2026-06-05_
