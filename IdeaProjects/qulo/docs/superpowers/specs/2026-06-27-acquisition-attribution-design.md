# "Bizi Nereden Duydunuz?" Attribution + Backoffice Kanal Yönetimi

**Tarih:** 2026-06-27
**Kapsam:** Server (API + Admin) + Mobile (Flutter) + DB (Supabase migration)
**Durum:** Tasarım onaylandı, plana hazır

## 1. Amaç ve Kapsam

Yeni kullanıcıların uygulamayı nereden duyduğunu ("TikTok, Instagram, Twitter/X, arkadaş, reklam…") ölçmek. Kanal listesi backoffice'ten yönetilir (ekle/çıkar/sırala/aktif-pasif). Backoffice ayrıca kanal başına dönüşüm raporunu gösterir.

**Kapsam dışı (ayrı backlog):**
- Influencer'a özel custom referral kodu + tek kodu çok kişiye kullandırma (many-to-one). Mevcut referral sistemi (1:1 otomatik kod, mor elmas ödülü, `/invite/:code` deep link) **çalışıyor** ve bu işte ona dokunulmaz.
- Ücretli reklam UTM/kampanya kaynağı eşleştirmesi.

**Ekonomi etkisi:** Yok. Anketin ödülü yoktur; saf attribution.
**Chat akışı etkisi:** Yok.

## 2. Veri Modeli (yeni migration)

Mevcut `page_messages` 16-dil JSONB pattern'i baz alınır.

### `acquisition_channels`
| kolon | tip | açıklama |
|---|---|---|
| `id` | uuid PK | |
| `key` | text UNIQUE | slug, snapshot/analitik için stabil kimlik (ör. `tiktok`, `friend`, `other`) |
| `label` | jsonb | 16 dil etiket `{ "tr": "...", "en": "...", ... }`. Marka adları her dile aynı yazılır; generic seçenekler gerçek çeviri alır |
| `emoji` | text | basit görsel (ör. 🎵, 📸). Asset yönetimi yok |
| `sort_order` | int | listede sıra |
| `is_active` | boolean default true | pasif kanal mobile listesinde görünmez |
| `is_freeform` | boolean default false | true ise seçildiğinde opsiyonel serbest metin alanı açılır (ör. "Diğer") |
| `created_by` | uuid → admin_users | |
| `created_at` / `updated_at` | timestamptz | |

İndeks: `idx_acquisition_channels_active_order (is_active, sort_order)`.

### `user_acquisition`
| kolon | tip | açıklama |
|---|---|---|
| `id` | uuid PK | |
| `user_id` | uuid → users **UNIQUE** | tek seferlik; bir kullanıcı tek kayıt |
| `channel_id` | uuid → acquisition_channels **nullable** | atlandıysa null |
| `channel_key` | text nullable | cevaplama anındaki `key` snapshot'ı (kanal sonradan silinse/değişse de rapor bozulmaz) |
| `freeform_text` | text nullable | `is_freeform` kanal seçildiyse opsiyonel; **zorunlu değil**, boş olabilir |
| `skipped` | boolean default false | "Atla" |
| `created_at` | timestamptz | |

İndeks: `idx_user_acquisition_channel (channel_key)`, `idx_user_acquisition_created (created_at)`.

`channel_id` silinen kanal için `ON DELETE SET NULL`; rapor `channel_key` snapshot'ı üzerinden yürür. Kanallar soft-delete (`is_active=false`) edilir, fiziksel silme tercih edilmez.

### Tek-seferlik durumu
Kullanıcı objesine türetilmiş alan: `acquisition_answered` (bool) — `user_acquisition` kaydının varlığından hesaplanır. Mobile `GET /users/me` yanıtında döner; ekstra round-trip yok. (Migration'da kolon eklemeye gerek yok; serializer hesaplar. Performans gerekirse `users.acquisition_answered_at timestamptz` denormalize alanı eklenir — plan kararı.)

## 3. Server — Mobile API

Mevcut `referral.routes.ts` + validator + service simetrisi.

### `GET /api/v1/acquisition/channels`
- Auth + rate limit.
- Aktif kanalları `sort_order` ile döner.
- Her kanalın `label`'ı **kullanıcının diline** resolve edilir (fallback zinciri: user.language → `en` → ilk dolu dil). Mevcut locale-resolve helper'ı (notification/page-message tarafında var) yeniden kullanılır.
- Yanıt: `[{ id, key, label, emoji, is_freeform }]`.

### `POST /api/v1/acquisition/answer`
- Auth + rate limit + validation.
- Body: `{ channel_id?: uuid, skipped?: boolean, freeform_text?: string }`.
- **Idempotent / tek-seferlik:** kayıt zaten varsa 200 + mevcut kayıt (yeni yazma yok, sessizce kabul). Yarış durumunda `user_id` UNIQUE guard.
- `channel_id` verilmişse `channel_key` snapshot'ı doldurulur; `is_freeform=false` kanal için `freeform_text` yok sayılır.
- `skipped=true` ile `channel_id` birlikte gelmez (validator çapraz kontrol).

Tek-seferlik durumu için ayrı endpoint yok; `acquisition_answered` flag'i `/users/me` ile gelir.

## 4. Server — Backoffice (`campaigns` pattern'i)

Dosya simetrisi: `acquisition.admin.controller.ts` + `acquisition-channel.service.ts` + EJS views + sidebar link + routes. Auth/CSRF/IP-whitelist mevcut admin middleware zinciri.

### Routes (`admin.routes.ts`)
```
GET    /admin/acquisition                  → list (kanallar + özet rapor)
GET    /admin/acquisition/new              → newForm
POST   /admin/acquisition                  → create        (csrfValidate)
GET    /admin/acquisition/:id              → editForm
POST   /admin/acquisition/:id              → update        (csrfValidate)
POST   /admin/acquisition/:id/toggle       → toggleActive  (csrfValidate)
POST   /admin/acquisition/:id/delete       → softDelete    (csrfValidate)
POST   /admin/acquisition/reorder          → reorder (opsiyonel; sort_order güncelle)
```

### Views
- **`acquisition-list.ejs`**: kanal tablosu (emoji, key, TR/EN etiket önizleme, sıra, aktif/pasif badge, edit/toggle) + **rapor bloğu**: her kanaldan kaç kullanıcı (count + %), skip oranı, toplam cevaplayan; tarih aralığı filtresi (querystring `from`/`to`).
- **`acquisition-edit.ejs`** (new + edit ortak): `key`, 16 dil `label` inputları (page-messages-edit.ejs deseni), `emoji`, `sort_order`, `is_active`, `is_freeform` checkbox. CSRF token.

### Rapor sorgusu
`acquisition-channel.service.ts.getReport(from, to)`: `user_acquisition`'ı `channel_key` ile grupla, count; `skipped` ayrı sayılır; aktif kanal listesiyle join edilip 0'lı kanallar da gösterilir. Supabase aggregate/RPC veya kod tarafı reduce.

### Sidebar (`_header.ejs`)
Yeni bölüm: **ACQUISITION** → "Kaynak & Reklam" (`/admin/acquisition`).

## 5. Mobile (Flutter)

Mevcut **referral** modül simetrisi (model + repository + provider + retrofit service). Hardware-Manager kuralı: API erişimi provider üzerinden.

### Katmanlar
- `lib/core/network/services/acquisition_service.dart` — retrofit (`GET /acquisition/channels`, `POST /acquisition/answer`).
- `lib/data/models/acquisition_channel_model.dart` — `AcquisitionChannel { id, key, label, emoji, isFreeform }`.
- `lib/data/repositories/acquisition_repository.dart` — service → model, error handling.
- `lib/providers/acquisition_provider.dart` — Riverpod AsyncNotifier; `loadChannels()`, `submit(channelId/skip/freeform)`.

### UI ve yerleşim
- **Tetik:** profile-setup-gate (foto + 2 soru) **tamamlandıktan** sonra, ilk discover'a girişte tek seferlik. Gate'i bloklamaz (gate üstüne gate yok). `users.acquisition_answered == false` ise gösterilir.
- **Bileşen:** `lib/features/discover/widgets/acquisition_sheet.dart` (veya modal kart). Mevcut `NavigationService.showAppBottomSheet` / `CustomBottomSheet` ile.
- Başlık + alt başlık (l10n). Kanallar tek-seçim listesi/grid (emoji + label). Seçince `is_freeform` ise opsiyonel `TextField` belirir (boş geçilebilir). "Devam" + "Atla" aksiyonları.
- Seçim/atlama → `POST` → kapat. Başarıdan bağımsız UI'yi kilitleme (fire-and-forget değil; loading state mevcut `AppLoadingWidget.small`).
- **Tekrar gösterme guard:** birincil server flag (`acquisition_answered`), ikincil SharedPreferences cache (`acquisition_seen`), coach-mark/page-message ile çakışmayı önlemek için tek seferde tek overlay.

### Tek seferlik koordinasyon
Discover'da aynı anda birden çok "ilk açılış" UI'si var (coach-mark intro, page-message, bu anket). Sıra: **page-message/coach-mark akışı → anket** çakışmasın diye anket yalnızca diğer overlay aktif değilken ve `acquisition_answered==false` iken açılır (plan netleştirir; basit `if any-overlay-active return` guard).

### l10n (16 dil)
`acq_title`, `acq_subtitle`, `acq_skip`, `acq_continue`, `acq_thanks`, `acq_other_hint`. Kanal etiketleri server'dan (admin-managed), uygulama l10n'ında değil.

## 6. Code-Review Standartları (proje kuralları)

- **Server:** geliştirme sonrası `/server-review` (SOLID + Security). Validator zorunlu, service'te `throw` yerine controller'a hata propagasyonu, idempotent guard.
- **Flutter:** geliştirme sonrası `/flutter-review`. Hardcoded renk/string yok, `AppLoadingWidget`, NavigationService, mixin/widget ayrımı, `package:qulo_v2/...` import, `dart analyze` temiz (bu FVM'de `flutter analyze` crash eder).
- **Localization:** 14+ dil zorunlu; uygulama string'leri 16 dil l10n. Kanal etiketleri admin tarafında 16 dil.
- **Migration:** Supabase SQL Editor ile manuel; RLS disabled (service_role).

## 7. Açık Kararlar (onaylandı)

- Tek seçim (first-touch), çoklu değil.
- "Diğer" → `is_freeform`; serbest metin **opsiyonel, zorunlu değil**.
- Ödül yok.
- Referral sistemine dokunulmaz (yalnızca çalıştığı doğrulandı).
- Anket atlanabilir; profile-setup-gate sonrası tek seferlik.

## 8. Riskler / Dikkat

- **Overlay çakışması** (coach-mark + page-message + anket aynı ilk-açılışta): tek-overlay guard şart.
- **Locale fallback:** admin bir kanala sadece TR yazarsa EN/diğer diller fallback ile TR görür — kabul edilebilir, admin UX'inde "en az EN+TR" önerisi notu.
- **Snapshot tutarlılığı:** rapor `channel_key` üzerinden; kanal silinince/yeniden adlandırılınca geçmiş bozulmaz.
- **profile-setup-gate yarışı:** anket gate akışını bloklamamalı; gate `complete` event'inden sonra tetiklenir.
