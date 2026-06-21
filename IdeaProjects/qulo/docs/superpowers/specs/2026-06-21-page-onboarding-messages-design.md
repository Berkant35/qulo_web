# Sayfa-Özelinde Segment Bazlı Onboarding/Info Mesajları — Tasarım Spec'i

- **Tarih:** 2026-06-21
- **Durum:** Tasarım onaylandı, plan bekliyor
- **Kapsam:** Monorepo (qulo-server + qulov2 + Supabase)
- **Branch (hedef):** kök `APP-1915` · qulo-server feature branch · qulov2 feature branch

---

## 1. Amaç

Backoffice'ten (admin paneli) yönetilebilen, **kullanıcı belirli bir uygulama sayfasına girdiğinde** gösterilen, **segment bazlı** (kişiye özel) in-app bilgilendirme mesajları. Mesajlar bir yönlendirme (deep link) içerebilir. Admin içeriği, hedef sayfayı, hedef kitleyi, gösterim formatını ve frekansı koddan bağımsız olarak ayarlar.

**Mevcut push campaign sisteminden farkı:** Push campaign sistemi (`campaigns` tablosu) kullanıcıya **bildirim gönderir** (FCM, dışarıdan tetiklenir). Bu sistem **in-app** çalışır — kullanıcı sayfaya girince **uygulama içinde** gösterilir, push gitmez. İki sistem **segment motorunu paylaşır**, gerisi ayrıdır.

## 2. Onaylanan Kararlar (brainstorming çıktısı)

| Konu | Karar |
|------|-------|
| Gösterim formatı | 4 tip: `banner`, `bottom_sheet`, `modal`, `inline_card` — admin her mesajda seçer |
| Frekans | Admin her mesajda seçer: `once`, `every_visit`, `until_dismissed`, `daily` |
| Lokalizasyon | **16 dil zorunlu manuel** — admin hepsini doldurmadan yayınlayamaz (validator zorlar) |
| Segment | Mevcut motoru paylaş + genişlet. **Faz 1:** demografik + `users` tablosunda hazır davranışsal alanlar. **Faz 2:** JOIN gerektiren davranışsal segmentler |
| Yönlendirme | Mevcut `DeepLinkParser` + `NavigationService` reuse — yeni navigasyon kodu yok |
| Çakışma | `priority` alanı — en yüksek olan gösterilir, sayfa başına bir seferde tek mesaj |
| Zamanlama | `start_at` / `end_at` opsiyonel yayın aralığı + `is_active` toggle |
| Analitik | **Faz 1:** performans dashboard (gösterim/tıklama/kapatma + CTR + segment kırılımı). **Faz 2:** dönüşüm takibi (mimari hazır, implement sonra) |
| Mimari | **B yaklaşımı:** yeni `page_messages` tablosu + segment motorunu paylaşılan servise çıkar |

## 3. Mimari (B yaklaşımı)

```
                    ┌─────────────────────┐
                    │  segment.service.ts │  (YENİ — paylaşılan)
                    │  buildSegmentQuery  │  segment → user listesi (SQL)
                    │  matchesSegment     │  user → uyuyor mu (in-memory)
                    └──────────┬──────────┘
              ┌────────────────┴────────────────┐
   ┌──────────▼──────────┐         ┌────────────▼────────────┐
   │  campaign.service   │         │  page-message.service   │  (YENİ)
   │  (push — değişmez)  │         │  fetch / filtre / event │
   └─────────────────────┘         │  + admin CRUD           │
                                   └─────────────────────────┘
```

- `campaign.service.ts`'teki `buildSegmentQuery` + `previewSegmentCount` → yeni `segment.service.ts`'e taşınır. Campaign **sadece import değiştirir, davranışı birebir korunur**.
- Page-message servisi aynı motoru kullanır ama **ters yönde** (`matchesSegment`): "bu kullanıcı verilen mesajın segment'ine uyuyor mu?".

## 4. Veri Modeli (Supabase — migration `032_page_messages.sql`)

### Tablo: `page_messages`
| Alan | Tip | Açıklama |
|------|-----|----------|
| `id` | uuid PK `gen_random_uuid()` | |
| `title` | text NOT NULL | Admin-içi etiket (kullanıcıya gösterilmez) |
| `page` | text NOT NULL | Hedef sayfa anahtarı (bkz. §9 sayfa registry) |
| `display_type` | text NOT NULL | `banner` \| `bottom_sheet` \| `modal` \| `inline_card` |
| `content` | jsonb NOT NULL | 16 dil map: `{ "tr": {"title","body","cta_label"}, "en": {...}, ... }` |
| `image_url` | text NULL | Opsiyonel görsel |
| `action_url` | text NULL | Opsiyonel deep link (`quloapp.com/...`); boşsa CTA yok |
| `frequency` | text NOT NULL DEFAULT `'once'` | `once` \| `every_visit` \| `until_dismissed` \| `daily` |
| `priority` | int NOT NULL DEFAULT 0 | Çakışmada yüksek olan kazanır |
| `segment` | jsonb NULL | Segment filtresi (boş = herkes); campaign ile aynı şema |
| `start_at` | timestamptz NULL | Yayın başlangıcı |
| `end_at` | timestamptz NULL | Yayın bitişi |
| `is_active` | boolean NOT NULL DEFAULT true | Aç/kapa |
| `created_by` | uuid REFERENCES admin_users(id) | |
| `created_at` | timestamptz DEFAULT now() | |
| `updated_at` | timestamptz DEFAULT now() | (updated_at trigger — mevcut konvansiyon) |

İndeksler: `idx_page_messages_active_page ON page_messages(is_active, page)`.

### Tablo: `page_message_events` (frekans state + analitik — çift görevli)
| Alan | Tip | Açıklama |
|------|-----|----------|
| `id` | uuid PK | |
| `page_message_id` | uuid NOT NULL REFERENCES page_messages(id) ON DELETE CASCADE | |
| `user_id` | uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE | |
| `event` | text NOT NULL | `shown` \| `clicked` \| `dismissed` |
| `created_at` | timestamptz DEFAULT now() | |

İndeksler: `idx_pme_msg_event ON page_message_events(page_message_id, event)`, `idx_pme_user_msg ON page_message_events(user_id, page_message_id)`.

**Neden JSONB `content` (ayrı `templates` tablosu değil):** Use-case "16 dil zorunlu" — tek kayıtta hepsi yazılır, mobile `content->locale` ile okur (EN fallback), validator tüm dillerin doluluğunu tek noktada zorlar. `push_messages`'ın ayrı-satır + override modeli farklı bir ihtiyaç (kısmi override); buraya uymaz.

**Frekans motoru — tek tablo iki iş:** `page_message_events` hem analitik hem frekans state. Server, mobile'a mesaj verirken bu tabloya bakıp **kalıcı frekans** filtresini uygular:
- `once` → user'da `shown` varsa verme
- `daily` → user'da bugün `shown` varsa verme
- `until_dismissed` → user'da `dismissed` varsa verme
- `every_visit` → her zaman ver (oturum-içi tekrarı client yönetir)

## 5. Backend (qulo-server)

### 5.1 Segment servisi (YENİ — paylaşılan)
`src/services/segment.service.ts`:
- `buildSegmentQuery(segment)` → Supabase query (campaign'den taşınır, birebir).
- `matchesSegment(user, segment): boolean` → in-memory değerlendirme (page-message fetch için).
- `previewSegmentCount(segment)` → campaign'den taşınır.
- **Faz 1 davranışsal alanlar** burada eklenir (her ikisi de aynı kuralı kullanır): `question_count`, `photo_count`, `green_diamonds`/`purple_diamonds` aralığı, `is_premium`/`subscription_plan`. (`has_match` zaten validator'da yarım — burada tamamlanır.)
- `campaign.service.ts` refactor: segment metotlarını import eder, kendi içinde tutmaz.

### 5.2 Page-message servisi (YENİ)
`src/services/page-message.service.ts` (singleton class — `notification.service` / `campaign.service` pattern'i):
- `getActiveForUser(userId)` → aktif + tarih aralığı + kalıcı frekans filtresi + `matchesSegment` geçen mesajlar (priority sıralı). Aktif mesaj sayısı düşük (admin elle girer), user tek satır → hafif in-memory filtre.
- `recordEvent(userId, messageId, event)` → `page_message_events` insert.
- CRUD: `list(page)`, `getById`, `create`, `update`, `toggleActive`, `remove`.
- `getStats(messageId)` → on-the-fly aggregate (bkz. §7).

### 5.3 Mobile API (auth'lu)
`src/routes/page-message.routes.ts` (`notification.routes.ts` middleware stack pattern'i: `authMiddleware`, `generalLimiter`):
- `GET /api/v1/page-messages` → `getActiveForUser(req.user.userId)`. App açılışı/login/resume'da bir kez çekilir, client cache'ler.
- `POST /api/v1/page-messages/:id/event` body `{ event }` → `recordEvent`. (`notification.routes` `POST /:id/click` pattern'i.)

### 5.4 Admin paneli (EJS — campaign UI şablonu)
`src/admin/admin.routes.ts`'e eklenir (mevcut campaign blok stili, `adminAuth` + `csrfGenerate`/`csrfValidate`):
- `GET /admin/page-messages` (liste) · `/new` (form) · `POST /admin/page-messages` (oluştur) · `GET /admin/page-messages/:id` (edit) · `POST /admin/page-messages/:id` (güncelle) · `POST /admin/page-messages/:id/toggle` · `DELETE` (JSON API)
- `POST /admin/api/page-messages/preview-segment` → `previewSegmentCount` reuse (kaç kişiye denk geliyor önizleme).
- Controller: `src/admin/page-message.controller.ts` (admin.controller campaign metotları + flash `req.session.pageMessageError` pattern'i).
- View'lar: `src/admin/views/page-messages-list.ejs`, `page-messages-edit.ejs`.
  - **16 dil girişi:** `push-messages-edit.ejs`'in locale-tab/accordion pattern'i reuse (her dil için title/body/cta_label).
  - **Segment filtreleri:** `campaign-new.ejs`'in `segment_*` form alanları reuse.
  - Sayfa dropdown, format dropdown, frekans dropdown, öncelik, görsel, deep link, tarih aralığı, aktif toggle.

### 5.5 Validator (YENİ)
`src/validators/page-message.validator.ts` (Zod):
- `segment` → `campaign.validator`'ın `segmentSchema`'sını reuse (+ Faz 1 yeni alanlar).
- `content` → **16 dilin hepsi dolu** zorunluluğu `.refine()` ile (`SUPPORTED_LOCALES` üzerinden, `push-template.validator`'ın refine pattern'i).
- `display_type`, `frequency` → `z.enum`. `page` → `z.enum` (sayfa registry).

## 6. Mobile (qulov2)

### 6.1 Feature yapısı
```
lib/features/page_messages/
  data/
    models/page_message_model.dart          (@JsonSerializable + Equatable — notification_model pattern)
    repositories/page_message_repository.dart (Result<T> + DioException — notification_repository pattern)
    services/page_message_service.dart        (@RestApi Retrofit — notification_service pattern)
  providers/page_messages_provider.dart       (Notifier + state + copyWith — notification_provider pattern)
  widgets/
    page_message_host.dart                    (dispatcher — display_type → format)
    page_message_content.dart                 (ortak içerik adaptörü: content map → title/body/cta/image)
```

### 6.2 Gösterim — mevcut core widget'lara delege (sıfırdan yazma yok)
Dispatcher (`page_message_host.dart`) `display_type`'a göre **mevcut** primitive'leri çağırır:

| Format | Reuse | Yöntem |
|--------|-------|--------|
| `banner` | `core/widgets/in_app_banner.dart` | Mevcut banner'a `content` + opsiyonel `image_url` besle |
| `bottom_sheet` | `NavigationService.showAppBottomSheet(CustomBottomSheet(...))` + `milestone_celebration_sheet.dart` yapısı | Overlay olarak aç |
| `modal` | `NavigationService.showAppDialog(CustomDialog(...))` (`app_dialog.dart`) | Overlay olarak aç |
| `inline_card` | `core/widgets/profile_section_card.dart` / `referral_invite_card.dart` yapısı | Build ağacına gömülü |
| CTA butonu | `core/widgets/app_button.dart` | As-is (primary/secondary) |

Yeni görsel kod yalnızca **`page_message_content.dart`** (16-dil content map'i → mevcut widget'ların beklediği title/body/cta/image dönüşümü) ve gerekirse mevcut widget'lara ufak parametre eklemeleri. Yeni ortak görsel parça gerekirse `core/widgets/`'a yazılır (qulov2 kuralı).

### 6.3 State akışı
- `PageMessagesNotifier`: app açılışı/login/`didChangeAppLifecycleState(resumed)` → `GET /page-messages` (mevcut `LocationNotifier.onAppResumed` resume pattern'i) → cache → `page`'e göre grupla. Oturum-içi gösterilenleri izle (`every_visit` hariç tekrar yok).
- `messagesForPage(pageName)` → en yüksek priority gösterilebilir mesaj.

### 6.4 Entegrasyon
- Hedef sayfalar `PageMessageHost` ekler (tek satır). Banner/inline_card gömülü; bottom_sheet/modal post-frame callback'te overlay.
- **CTA →** `action_url`'ü `DeepLinkParser.parse` → `NavigationService.navigateDeepLink` (reuse). Tıklama `clicked` event'i yollar.
- **Gösterimde** `shown`, **kapatmada** `dismissed` event'i.

### 6.5 Lokalizasyon ayrımı (kritik)
- **Mesaj içeriği:** server'dan 16 dil `content` map'i — **dinamik veri, i18n key DEĞİL.** `content[localeCode] ?? content['en']`.
- **Widget statik UI'ı** (kapat ikonu tooltip'i, "Daha fazla" vb.): app l10n (`core/l10n/translations/*.dart`, 16 dosya) — i18n-guardian denetler.

## 7. Analitik (Faz 1 — performans)
- **On-the-fly aggregate**, denormalize sayaç tablosu yok. Admin mesaj detayı açılınca `page_message_events`'ten `COUNT` + `COUNT(DISTINCT user_id)` GROUP BY event.
- Mesaj başına: gösterim (toplam + tekil kullanıcı), tıklama, kapatma, **CTR** (clicked/shown) + cinsiyet/segment kırılımı (`users` JOIN — `getCampaignBreakdown` pattern'i).
- **Dönüşüm (Faz 2):** event tablosuna ileride `converted` tipi/ayrı kayıt eklenince funnel açılır — bugünkü şema buna engel değil.

## 8. Fazlama

**Faz 1 (bu spec):**
- DB: 2 tablo. Segment: demografik + `users` tablosu davranışsal (soru/foto/elmas/premium) + `has_match`. Backend: servis/route/admin/validator. Mobile: feature + dispatcher + mevcut widget reuse. Analitik: performans dashboard. 4 format, 4 frekans, 16 dil zorunlu.

**Faz 2 (sonra — mimari bugün hazır):**
- JOIN'li davranışsal segmentler ("hiç eşleşmemiş", "hiç soru çözmemiş", "X gündür mesajlaşmamış").
- Dönüşüm takibi (`converted` event + funnel).

## 9. Sayfa Registry (hedeflenebilir sayfalar)
Mobil route'lardan türetilir; admin dropdown'da gösterilir, validator `page` enum'ı ile eşleşir:
`discover`, `matches`, `chat`, `profile`, `profile_detail`, `questions`, `quiz`, `diamonds`, `exchange`, `passport`, `settings`, `notifications`.
(Tek kaynak: server'da `PAGE_KEYS` const + mobile route_names eşlemesi. Yeni sayfa eklemek = listeye satır.)

## 10. Reuse Haritası (özet — "sıfırdan yazma" referansı)

### Server
| Parça | Reuse kaynağı |
|------|----------------|
| Segment motoru | `services/campaign.service.ts` → `segment.service.ts`'e taşı |
| Service iskeleti | `services/notification.service.ts`, `campaign.service.ts` (singleton class) |
| Validator | `validators/campaign.validator.ts` (segment), `push-template.validator.ts` (refine) |
| 16 dil const | `constants/locales.ts` `SUPPORTED_LOCALES`, `utils/locales.ts` `resolveLocale` |
| Mobile route | `routes/notification.routes.ts` (auth+limiter, `POST /:id/click`) |
| Admin route/controller | `admin/admin.routes.ts`, `admin/admin.controller.ts` (campaign blokları) |
| Admin form (16 dil) | `admin/views/push-messages-edit.ejs` |
| Admin form (segment) | `admin/views/campaign-new.ejs` |
| Admin liste | `admin/views/campaigns.ejs` |
| Error/flash | `utils/errors.ts`, `req.session.*Error` pattern |
| Migration stili | `migrations/025_push_messages.sql`, `026_notification_locale_email.sql` |

### Mobile
| Parça | Reuse kaynağı |
|------|----------------|
| Banner | `core/widgets/in_app_banner.dart` |
| Bottom sheet | `core/widgets/milestone_celebration_sheet.dart` + `NavigationService.showAppBottomSheet` |
| Modal | `core/navigation/models/app_dialog.dart` + `NavigationService.showAppDialog` |
| Inline card | `core/widgets/profile_section_card.dart`, `referral_invite_card.dart` |
| CTA buton | `core/widgets/app_button.dart` |
| Tasarım sistemi | `core/theme/app_spacing.dart`, `app_colors.dart` (`context.appColors`), `app_text_styles.dart`, `core/constants/q_icons.dart` |
| Model | `data/models/notification_model.dart` |
| Repository | `data/repositories/notification_repository.dart` (`Result<T>`) |
| Notifier | `providers/notification_provider.dart` |
| Retrofit servis | `core/network/services/notification_service.dart` (`@RestApi`) |
| Deep link / nav | `core/services/deep_link_parser.dart`, `core/navigation/navigation_service.dart` |
| Resume pattern | `app.dart` `didChangeAppLifecycleState`, `LocationNotifier.onAppResumed` |
| Locale | `providers/locale_provider.dart` |

## 11. Güvenlik & Tehdit Modeli

Bu feature **"admin-girdisi içerik + URL → kitlesel dağıtım + mobile render + yönlendirme"** zinciri olduğundan güvenlik birinci sınıf gereksinim. En büyük risk: admin paneli ele geçirilir veya yanlış/kötü `action_url` girilirse, tüm hedef kitle phishing/scam'e yönlendirilebilir.

### Tehdit yüzeyi ve zorunlu kontroller
| # | Tehdit | Zorunlu kontrol |
|---|--------|-----------------|
| **T1** | **Open redirect / phishing** (`action_url` admin'den, kitleye dağıtılır) | **İki katman.** (a) Server validator: `action_url` SADECE internal deep-link path (`/^\/[a-zA-Z0-9_\/-]+$/`) veya `quloapp.com` host'lu tam URL; `javascript:`/`data:`/harici host **reddedilir**. (b) Mobile: CTA navigasyonu YALNIZCA `DeepLinkParser.parse()` → `navigateDeepLink()`. **`handleDeepLink(rawString)` ASLA kullanılmaz.** |
| **T2** | **Admin panel XSS / HREF injection** (`action_url`/`image_url` EJS'te `href`'e basılır) | EJS'te user-input URL `href`'e basılırken protocol whitelist (`http(s):` veya relative `/`). `<%= %>` text-escape `href` context'inde `javascript:`'i durdurmaz; validator (T1) + view defansif birlikte. |
| **T3** | **image_url kötüye kullanımı** (tracking pixel / mixed content) | Validator: `https://` only (http reddet). Server **fetch etmez** (SSRF yok — mevcut durum korunur). Mobile `CachedNetworkImage` (mevcut). |
| **T4** | **IDOR / event manipülasyonu** (başkası adına / görmediği mesaja event) | Event endpoint user'ı `req.user.userId`'den alır (body'den ASLA). `notification-api.service` ownership pattern'i: insert öncesi mesajın aktif + bu user'a uygun (`matchesSegment`) olduğunu doğrula. |
| **T5** | **Segment / PII sızıntısı** | Mobile `GET /page-messages` payload'u SADECE gösterim alanları döner (id, display_type, content[locale], image_url, action_url, frequency, priority). `segment`, `created_by` vb. admin alanları **dönmez**. |
| **T6** | **Yetki / audit** | Admin CRUD `adminAuth` + CSRF (mevcut). `created_by`/`updated_by` + zaman damgası şemada. (Opsiyonel: yayın-öncesi ikinci-admin onayı — Faz 2.) |
| **T7** | **Event spam / rate** | Mobile event endpoint `generalLimiter` (mevcut). Admin CRUD'a makul limit. |

### Reuse edilecek SAĞLAM kontroller (mevcut — doğrulandı)
- Admin session: `httpOnly` + `secure`(prod) + `sameSite strict` (`index.ts:79-90`) ✓
- CSRF: `crypto.randomBytes(32)`, POST/PUT/DELETE validate (`admin.middleware.ts:51-66`) ✓
- IP whitelist: `ADMIN_ALLOWED_IPS`, prod'da enforce (`admin.middleware.ts:32-49`) ✓
- JWT: `req.user.userId` token'dan, body/param'dan değil (`middleware/auth.ts:52`) ✓
- IDOR koruması: ownership check pattern (`notification-api.service.ts:30-57`) ✓
- Mobile render: `Text()` widget — HTML/JS injection yüzeyi yok ✓

### ⚠️ Mevcut campaign sisteminde keşfedilen açıklar (bu feature TEKRARLAMAMALI)
Tehdit modeli, **mevcut** push campaign akışında üç gerçek açık buldu. Bizim feature bunları reuse ederken **taşımamalı**; ayrıca başlı başına düzeltmeye değerler (ayrı iş olarak ele alınabilir):
- **handleDeepLink bypass** (`notifications_screen.dart:38,45` → `navigation_service.handleDeepLink` parser'sız `router.go`): admin `action_url`'i parser'ı atlıyor → open redirect. → **Bizim CTA bu yolu kullanmaz.**
- **action_url whitelist yok** (`campaign.validator.ts:26`): `javascript:`/harici URL kabul. → **Bizim validator whitelist yapar.**
- **Admin EJS href injection** (`campaign-detail.ejs:69`): user-input URL `href`'e basılıyor. → **Bizim view'lar protocol-whitelist'li basar.**

## 12. Definition of Done / Uyum Kontrol Listesi

### qulov2 (Flutter) kuralları
- [ ] Screen/host dosyaları orchestration odaklı, makul satır sınırında; UI parçaları ayrı widget dosyalarında.
- [ ] `_buildXxx()` pattern YOK — ayrı widget class'ları.
- [ ] Ortak görsel parçalar `core/widgets/`'ta; format render'ı mevcut core widget'lara delege.
- [ ] Dialog/sheet **yalnızca** `NavigationService.showAppDialog` / `showAppBottomSheet` üzerinden; doğrudan GoRouter/Navigator YOK.
- [ ] Loading gerekiyorsa `AppLoadingWidget` (asla `CircularProgressIndicator`).
- [ ] Hardcode renk/spacing/string YOK — theme + i18n. Mesaj içeriği server `content` map'inden (dinamik, i18n key değil).
- [ ] `flutter analyze` sıfır hata.

### qulo-server kuralları
- [ ] Tüm endpoint'ler Zod validator ile doğrulanır; `content` 16 dil refine zorunlu.
- [ ] Auth + ownership: mobile event endpoint `req.user.userId` ile yazar; admin endpoint `adminAuth` + CSRF.
- [ ] Router → Controller → Service → DB katman ayrımı; servisler singleton class.
- [ ] Error handling: `AppError`/`Errors` + `next(err)` (admin'de flash redirect).
- [ ] Rate limit: mobile route'larda `generalLimiter`.
- [ ] Migration `032_` numarası, `IF NOT EXISTS`, index + updated_at trigger konvansiyonu.

### i18n
- [ ] Eklenen statik UI string'leri 16 dilde (`i18n-guardian` ile yayılır).
- [ ] Server `content` 16 dil zorunluluğu validator + admin UI'da garanti.

### Güvenlik (DoD — §11 tehdit modeli)
- [ ] `action_url` server validator: internal path / `quloapp.com` whitelist; `javascript:`/`data:`/harici **reddedilir** (test ile doğrula).
- [ ] `image_url`: `https://` only.
- [ ] Mobile CTA: yalnızca `DeepLinkParser.parse` → `navigateDeepLink`; `handleDeepLink(raw)` **kullanılmaz**.
- [ ] Event endpoint: `req.user.userId` + ownership/eligibility (`matchesSegment`) check; `generalLimiter`.
- [ ] Mobile `GET /page-messages` payload'u `segment`/admin alanları **içermez**.
- [ ] Admin EJS: user-input URL `href`'leri protocol-whitelist'li basılır.

### businessCaseSkills tetikleme
- [ ] **economy-impact** → plana geçerken çalıştırılır. Beklenti: feature ekonomi **sabitlerini/formüllerini değiştirmez**; yalnızca mevcut paywall/diamond ekranlarına **deep link yönlendirmesi** yapar (yeni harcama/kazanım noktası yok). Tahmini risk: DÜŞÜK/YOK — yine de skill ile doğrulanır.
- [ ] **chat-flow-guard** → `chat` hedef sayfa olduğundan çalıştırılır. Beklenti: feature chat **akışını** (mesaj/soru lifecycle/realtime/lock) değiştirmez; chat ekranına yalnızca bir gösterim host'u ekler. Beklenen sonuç: SAFE — yine de skill ile doğrulanır.
- [ ] **flutter-review** → mobile implementasyon sonrası.
- [ ] **server-review** → server implementasyon sonrası.
- [ ] **owasp-security** (mobile) + **web-security-review** (admin EJS) → güvenlik review'ları, implementasyon sonrası (§11 vektörlerini doğrula).

## 13. Açık Sorular / Riskler
- **`every_visit` + event hacmi:** `shown` event'i sık birikebilir. Faz 1'de on-the-fly aggregate + index yeterli; ölçek sorunu olursa Faz 2'de denormalize sayaç. (Şimdilik `log`/izleme yeterli, erken optimize etme.)
- **Overlay çakışması:** Sayfa açılışında modal/bottom_sheet açılırken, başka bir sistem overlay'i (paywall, permission) ile aynı anda gelmemeli. Host, sayfa "settle" olduktan sonra (post-frame + mevcut overlay yokken) açar.
- **Sayfa registry senkronu:** Server `page` enum'ı ile mobile route anahtarları elle senkron tutulur. Tek kaynak liste + iki tarafta eşleme; uyuşmazlık validator'da yakalanır.
```
