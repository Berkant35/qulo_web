# Qulo — Test Case Kataloğu

Tüm katmanların test envanteri. **Her task'ta ilgili bölüm açılır, kontrol edilir,
gerekiyorsa yeni case eklenir.** Kural seti: root `CLAUDE.md` → "Test Disiplini".

## Nasıl kullanılır
1. Task'a başlarken: dokunacağın alanın bölümünü aç, mevcut case'leri oku.
2. Task biterken: yazdığın case'i `[x]` yap. Yeni davranış eklediysen **yeni satır ekle**.
3. Bir case'i yazmamaya karar verdiysen **sil** — `[ ]` olarak bırakıp geçme, yanlış izlenim verir.

## Öncelik
| | Anlamı | Kırılırsa |
|---|---|---|
| **P0** | Para, yetki, veri sızıntısı | Doğrudan gelir kaybı veya güvenlik olayı |
| **P1** | Ürünün çekirdek mekaniği | Uygulama işlevsiz, kullanıcı kaybı |
| **P2** | Destekleyici akışlar | Bozuk deneyim, telafi edilebilir |
| **P3** | Çeper | Kozmetik |

## Durum (son güncelleme: 2026-09-01)
| Katman | Test | Kapsanan alan |
|---|---|---|
| Server | 439 | diamond, exchange, subscription, scoring, auth, revenuecat, webhook, retention, referral, economy-config, badge, report, locale, validator, page-message, referral, segment, quick-assign, user-interests, ai-suggest, notification template, unsubscribe, heartbeat, deletion-feedback, app-config, push-messages |
| Mobile | 47 | user/page-message/acquisition model, coach-mark (registry/controller/overlay/visibility/service), overlay queue, pending languages, onboarding provider, i18n parity |
| Supabase | 0 | — |
| Web | 0 | — |

---

# SERVER (`qulo-server`)

Helper: `tests/helpers/fake-supabase.ts` + `tests/helpers/economy-config.fixture.ts`.
Yeni testler `tests/` altına (`src/__tests__` build'e dahil, oraya ekleme).

## P0 — Para

### ✅ `diamond.service` (23) — `tests/services/diamond.service.test.ts`
### ✅ `exchange.service` (25) — `tests/services/exchange.service.test.ts`

### ✅ `subscription.service` (34) — `tests/services/subscription.service.test.ts`
Kapsanan: getStatus (5), activate (5, webhook tekrarı dahil), renew (3), cancel (3),
expire (2), change (3), getDailyStats (7, lazy reset dahil), increment (4), getLimits (2).
Not: `SubscriptionPlan = 'plus' | 'premium'` — `'free'` aktive edilebilir plan değil.

### ✅ `revenuecat.service` (19) + `webhook.service` (19)
`tests/services/revenuecat.service.test.ts`, `tests/services/webhook.service.test.ts`
Kritik: API çökünce satın alma **geçerli sayılmıyor**; (transaction_id, event_type)
çifti başına tek işlem; bozuk payload 500 atmıyor (sonsuz retry olurdu).

### ✅ `retention.service` (20) — `tests/services/retention.service.test.ts`
Dört uygunluk kapısı ayrı ayrı; `claim` uygunluğu yeniden doğruluyor.

### ✅ `referral.service` (36) — `tests/services/referral.service.test.ts`
Eski `src/__tests__` dosyası kaldırıldı (getStats bloğu tautolojiydi).

### ✅ `economy-config.service` (25) — `tests/services/economy-config.service.test.ts`
Cache TTL/hata dayanıklılığı, schema reddi, RPC yedek yolu.

### ✅ `auth.service` (58) — `tests/services/auth.service.test.ts`
### ✅ `auth.validator` (22) — `tests/validators/auth.validator.test.ts`
🔴 **Bulunan bug (düzeltildi):** `locale` enum'ı `tr|en`'de kalmıştı; mobil cihaz
dilini gönderdiği için 14 dilde kayıt 400 alıyordu. Regresyon testi eklendi.
socialLogin'de Case A/Case B'nin silinmiş hesapta simetrik davrandığı sabitlendi.

### [ ] `middleware/auth.ts`
- [ ] Token yoksa 401
- [ ] Süresi geçmiş token 401
- [ ] Bozuk imzalı token 401
- [ ] Geçerli token `req.user`'ı doldurur

### [ ] `middleware/profileGuard.ts`
- [ ] Setup tamamlanmamış kullanıcı korumalı endpoint'e giremez
- [ ] Setup tamam olan geçer
- [ ] Muaf endpoint'ler (profil tamamlama) guard'a takılmaz

### [ ] `middleware/idempotency.ts`
- [ ] Aynı key ile ikinci istek işlemi tekrar çalıştırmaz, ilk cevabı döner
- [ ] Farklı key'ler bağımsız çalışır
- [ ] Key yoksa normal akış

### [ ] `middleware/rateLimit.ts`
- [ ] Limit aşılınca 429
- [ ] Pencere dolunca sıfırlanır

### [ ] `block.service` — engelleme her yerde geçerli olmalı
- [ ] `block` — çift engelleme ikinci kayıt açmaz
- [ ] `isBlocked` — iki yönlü kontrol (engelleyen ve engellenen)
- [ ] Engellenen kullanıcı `discover`'da çıkmaz
- [ ] Engelleme sonrası mevcut match'te mesaj gönderilemez
- [ ] `getBlockedIds` / `getBlockerIds` sadece ilgili kullanıcıyı döner

### [ ] Veri izolasyonu (yatay — her serviste ayrı case)
- [ ] `chat.getMessages` — başka kullanıcının match'inin mesajları alınamaz
- [ ] `chat.deleteMessage` — başkasının mesajı silinemez
- [ ] `question.updateQuestion` / `deleteQuestion` — başkasının sorusu düzenlenemez
- [ ] `quiz.getSessionResult` — başkasının oturumu okunamaz
- [ ] `support-ticket.getById` — başkasının ticket'ı okunamaz
- [ ] `user.getPublicProfile` — hassas alanlar (e-posta, token, konum hassasiyeti) sızmaz

## P1 — Çekirdek Mekanik

### [ ] `quiz.service` (1031 satır — en büyük dosya, sıfır test)
- [ ] `startSession` — soru sayısı 2-10 aralığında
- [ ] `startSession` — aday soru yoksa oturum açılmaz
- [ ] `startSession` — aynı hedefe açık oturum varken ikinci oturum açılmaz
- [ ] `startSession` — engellenmiş kullanıcıya oturum açılmaz
- [ ] `getCurrentQuestion` — sıradaki soruyu döner, cevabı sızdırmaz
- [ ] `answerQuestion` — doğru cevap ilerletir
- [ ] `answerQuestion` — yanlış cevap oturumu düşürür (rescue yoksa)
- [ ] `answerQuestion` — aynı soruya ikinci cevap kabul edilmez (re-solve guard)
- [ ] `answerQuestion` — süre dolmuş oturumda cevap kabul edilmez
- [ ] `answerQuestion` — son soru doğru → eşleşme oluşur
- [ ] Eşleşme — çift match kaydı oluşmaz
- [ ] `rescueWithSkip` — SKIP gücü tüketilir, oturum devam eder
- [ ] `rescueWithSkip` — güç yoksa reddedilir
- [ ] `failSession` — oturum kapanır, tekrar cevaplanamaz
- [ ] `getSessionResult` — doğru/yanlış dökümü ve ödül tutarı
- [ ] Ödül — `baseAnswerReward × questionCountMultiplier` config'ten hesaplanır
- [ ] `getMatchQuizSummary` — sadece eşleşmenin taraflarına açık

### [ ] Güç kullanımı ve idempotency (migration 036/037 alanı)
- [ ] `quiz_session_mark_power` RPC iki kez çağrılınca tek kez ücretlendirir
- [ ] `chat_question_mark_power` aynı garanti
- [ ] Güç işaretlemesi başarısız olursa ücret alınmaz
- [ ] Envanterdeki güç önce tüketilir, sonra elmas (`tryUseInventory` önceliği)
- [ ] `use_power_block` alanı gönderilir (`has_power_block` DEĞİL — 3x revert edildi)

### [ ] `chat-question.service` (870 satır, sıfır test)
- [ ] `createQuestion` — günlük limit tier'a göre uygulanır
- [ ] `createQuestion` — eşleşmemiş kullanıcıya soru sorulamaz
- [ ] `answerQuestion` — doğru/yanlış sonucu ve `unmatch riski`
- [ ] `answerQuestion` — aynı soruya ikinci cevap reddedilir
- [ ] `rescueQuestion` — güç tüketir, yanlışı telafi eder
- [ ] `usePower` — yetersiz bakiye reddedilir, güç harcanmaz
- [ ] `handleTimeout` — süre dolan soru kaybedilmiş sayılır
- [ ] `saveDraft` / `getDrafts` / `deleteDraft` — kullanıcı izolasyonu
- [ ] `getHistory` — sayfalama ve sıralama

### [ ] `matching.service` (589 satır) — cold-start ile doğrudan bağlı
- [ ] `discover` — min 2 soru filtresi
- [ ] `discover` — min 1 foto filtresi
- [ ] `discover` — `email_verified` filtresi
- [ ] `discover` — radius dışındakiler elenir
- [ ] `discover` — `gender_pref` iki yönlü eşleşir
- [ ] `discover` — yaş aralığı filtresi
- [ ] `discover` — dil eşleşmesi
- [ ] `discover` — engellenen/engelleyen elenir
- [ ] `discover` — daha önce swipe edilen tekrar gelmez
- [ ] `discover` — **7 gün aktiflik HARD filtre DEĞİL** (sadece scoring'de %20 recency)
- [ ] `discover` — kendini görmez
- [ ] `discover` — günlük limit tier'a göre
- [ ] `swipe` — karşılıklı like eşleşme yaratır
- [ ] `swipe` — aynı hedefe ikinci swipe kayıt açmaz
- [ ] `undoSwipe` — limit tier'a göre, limit dolunca reddedilir
- [ ] `unmatch` — iki taraf için de biter, mesajlar erişilemez
- [ ] `getMatches` — sadece kendi eşleşmeleri

### ✅ `scoring.service` (24) — `tests/services/scoring.service.test.ts`
Kapsanan: 5 skor fonksiyonu + totalScore. Sabitlenen davranışlar:
`profileScore` üst sınırı 13 (diğerleri 10), `totalScore` ağırlıkları 0.95 topluyor
(1.0 değil), boost sabit +50 ile her şeyi eziyor, 7 gün+ recency 0 ama **elenmiyor**.

### [ ] `question.service`
- [ ] `createQuestion` — max soru sayısı tier'a göre
- [ ] `createQuestion` — 4 şık zorunlu, doğru cevap indeksi geçerli
- [ ] `quickAssignQuestions` — mevcut sorularla çakışmaz
- [ ] `reorderByIds` — eksik/fazla id reddedilir
- [ ] `deleteQuestion` — min 2 soru altına düşürmez (setup gate)
- [ ] `getQuestionCount` — `sync_user_question_count` ile tutarlı

### [ ] `pending-change.service` — aktif quiz sırasında profil değişimi
- [ ] `hasActiveQuiz` — açık oturumu doğru tespit eder
- [ ] `queueChange` — aktif quiz varken değişiklik kuyruğa alınır
- [ ] `applyPendingChanges` — quiz bitince uygulanır
- [ ] `cancelPendingChange` — sadece kendi değişikliğini iptal edebilir

## P2 — Destekleyici

### [ ] `chat.service`
- [ ] `sendMessage` — eşleşme yoksa reddedilir
- [ ] `sendMessage` — boş/çok uzun mesaj reddedilir
- [ ] `markAsRead` — sadece karşı tarafın mesajlarını okundu yapar
- [ ] `addReaction` — aynı kullanıcı aynı mesaja iki farklı reaksiyon bırakamaz
- [ ] `deleteMessage` — silinen mesaj listede görünmez

### [ ] `media.service`
- [ ] `requestMedia` — karşı taraf onaylamadan medya açılmaz
- [ ] `respondToRequest` — sadece istek sahibinin karşısı cevaplayabilir
- [ ] `disableMedia` — tek taraflı kapatma iki tarafı da etkiler

### [ ] `user.service` (643 satır)
- [ ] `getMe` — hassas alan sızdırmaz
- [ ] `updateProfile` — geçersiz yaş/gender reddedilir
- [ ] `updateLocation` — geçersiz koordinat reddedilir
- [ ] `uploadPhoto` — max foto sayısı aşılamaz
- [ ] `deletePhoto` — son fotoyu silmek setup gate'i bozar (beklenen davranış netleştirilmeli)
- [ ] `deleteAccount` — soft delete, veri hemen silinmez
- [ ] `deleteAccount` — silinmiş hesapla login denemesi
- [ ] `boost` — yetersiz yeşil elmas reddedilir
- [ ] `boost` — aktif boost varken ikinci boost
- [ ] `heartbeat` — `last_seen_at` günceller (✅ kısmen var)
- [ ] `completeProfile` — üç setup kapısı da kontrol edilir

### [ ] `notification.service` + `notification-api.service`
- [ ] Şablon kullanıcının diline göre seçilir (✅ kısmen var)
- [ ] Bilinmeyen locale `en` fallback
- [ ] Bildirim tercihi kapalıysa gönderilmez
- [ ] `markAllAsRead` sadece kendi bildirimlerini etkiler
- [ ] `getUnreadCount` — engellenen kullanıcıdan gelen bildirimler sayılmaz

### [ ] `page-message.service`
- [ ] `getActiveForUser` — segment eşleşmesi
- [ ] `passesFrequency` — once/every_visit/until_dismissed/daily (✅ var)
- [ ] Tarih aralığı dışındaki mesaj gösterilmez
- [ ] `recordEvent` — shown/clicked/dismissed sayaçları

### [ ] `campaign.service`
- [ ] `previewSegmentCount` — gerçek gönderimle aynı segmenti kullanır
- [ ] `sendCampaign` — iki kez gönderilemez
- [ ] `cancelCampaign` — gönderilmiş kampanya iptal edilemez

### [ ] `passport.service`
- [ ] `activate` — free tier'da reddedilir
- [ ] `activate` — discover konumunu değiştirir
- [ ] `deactivate` — gerçek konuma döner

### [ ] `user-language.service` / `user-interests.service`
- [ ] Desteklenmeyen dil kodu reddedilir
- [ ] Boş liste kabul/ret davranışı
- [ ] Max ilgi alanı sayısı

### [ ] `consent.service`
- [ ] `recordRegistrationConsents` — zorunlu onaylar eksikse kayıt olmaz
- [ ] Aynı onay iki kez kaydedilmez

### [ ] Utils
- [ ] `utils/jwt` — imza doğrulama, süre, bozuk payload
- [ ] `utils/hash` — hash/verify tur döngüsü, yanlış şifre
- [ ] `utils/pii` — maskeleme gerçekten maskeliyor
- [ ] `utils/math` — sınır değerler
- [ ] `utils/validation` — ortak doğrulayıcılar
- [ ] ✅ `utils/locales` — `resolveLocale`, `pickLabel`

### [ ] Validators (26 dosya — saf zod, mock gerekmez, ucuz)
- [ ] Her validator için: geçerli girdi kabul + her zorunlu alan eksikliği reddedilir
      + sınır değerler + tip uyuşmazlığı
- [ ] ✅ `page-message.validator` (15)
- [ ] ✅ `user.validator` (setInterests)
- [ ] ✅ `push-template.validator`
- [ ] Öncelik sırası: `auth` → `quiz` → `chat-question` → `diamond` → `exchange`
      → `question` → `user` → `match` → gerisi

### [ ] Cron
- [ ] `presence.cron` — çevrimdışı işaretleme eşiği
- [ ] `analytics.cron` — çift toplama yapmaz
- [ ] `weekly-report.service` — bildirim tercihi kapalıya göndermez

---

# MOBILE (`qulov2`)

`mocktail` eklenecek (Faz 3). Repository'ler interface + constructor injection ile
zaten test edilebilir; `Result<T>` sayesinde exception yerine tip kontrolü yapılır.

## P0

### [ ] Repository `Result<T>` eşlemesi (22 repository, ortak desen)
Her repository için: **başarı payload'ı doğru parse edilir** + **`DioException` →
beklenen `Failure` tipine dönüşür** + **beklenmeyen exception `UnknownFailure` olur**.
- [ ] `auth_repository` — 7 metot (register/login/verifyEmail/refresh/logout/forgot/reset)
- [ ] `diamond_repository` — getBalance/getHistory/purchase
- [ ] `exchange_repository` — convert/buyPower/getInventory/getRates
- [ ] `quiz_repository` — 7 metot
- [ ] `match_repository` — discover/swipe/getMatches/undoSwipe/unmatch
- [ ] `chat_repository` — 22 metot (en büyük; öncelik: sendMessage, getMessages, usePower)
- [ ] `user_repository` — 20 metot (öncelik: getMe, deleteAccount, uploadPhoto)
- [ ] `question_repository`, `subscription_repository`, `referral_repository`
- [ ] `block_repository`, `report_repository`, `support_ticket_repository`
- [ ] `passport_repository`, `power_repository`, `notification_repository`
- [ ] `app_config_repository`, `acquisition_repository` (✅ model testi var)

### [ ] Token/oturum akışı
- [ ] 401 alınca refresh denenir, başarılıysa istek tekrarlanır
- [ ] Refresh de başarısızsa oturum kapanır (sonsuz döngü yok)
- [ ] Eşzamanlı 401'lerde tek refresh yapılır

## P1

### [ ] Modeller — `fromJson` dayanıklılığı (40 model)
Ortak desen: eksik alan default'a düşer, `null` çökmez, bilinmeyen alan yoksayılır.
- [ ] ✅ `user_model` (setupComplete üç kapı dahil)
- [ ] ✅ `page_message_model` (localized fallback)
- [ ] ✅ `acquisition_channel_model`
- [ ] `discover_model`, `match_model`, `message_model`, `quiz_*`, `chat_question_model`
- [ ] `diamond_model`, `exchange_model`, `power_model`, `subscription` ilgili modeller
- [ ] `economy_config_model` — server config'i ile alan uyumu
- [ ] `public_profile_model` — hassas alan taşımadığını doğrula

### [ ] Provider'lar (33 provider — kritik olanlar)
- [ ] `auth_provider` — login/logout state geçişleri, hata state'i
- [ ] `auth_provider` — Apple Sign In: `fetchMe` `state=authenticated`'ten ÖNCE
- [ ] `quiz_provider` — oturum ilerleme, yanlış cevap, süre
- [ ] `diamond_provider` / `exchange_provider` — bakiye güncellemesi, yetersiz bakiye
- [ ] `match_provider` — discover listesi, swipe sonrası liste güncellenmesi
- [ ] `subscription_provider` — tier değişince limitler güncellenir
- [ ] `locale_provider` — dil değişimi kalıcı olur
- [ ] `location_provider` — izin reddi akışı
- [ ] `page_messages_provider` — frequency mantığı
- [ ] ✅ `onboarding_seen_provider`

### [ ] i18n
- [ ] ✅ `translation_parity_test` — key seti, boş çeviri, placeholder, snake_case
- [ ] Kod içinde hardcoded string taraması (yeni: `context.tr()` dışı literal yakalama)

## P2

### [ ] Core services
- [ ] ✅ `overlay_queue_service` — öncelik ve sıra
- [ ] ✅ `coach_mark_*` (registry/controller/overlay/visibility/service)
- [ ] ✅ `pending_languages_store`
- [ ] `deep_link_parser` — geçerli/geçersiz link, quloapp.com dışı reddedilir
- [ ] `version_manager` — zorunlu güncelleme eşiği
- [ ] `image_picker_manager` — izin reddi → doğru dialog key'i
- [ ] `revenuecat_service` — satın alma iptal/hata akışı
- [ ] `notification_manager` — payload → route eşlemesi
- [ ] `presence_manager` — app lifecycle geçişleri

### [ ] Widget testleri (sadece kritik akışlar)
- [ ] Paywall — yasal linkler görünür ve tıklanabilir (16 dilde metin var)
- [ ] Soru çözme ekranı — güç butonları maliyeti gösterir, yetersiz bakiyede uyarır
- [ ] Profile Setup Gate — üç kart doğru sırayla ve tamamlananlar işaretli
- [ ] Boş discover — boş state mesajı gösterilir (cold-start senaryosu)
- [ ] Banned screen — destek adresi görünür

---

# SUPABASE

Test branch'i ücretli olduğu için **DB'ye vuran test yok.** Bu bölüm
"migration uygulanmadan önce elle doğrulanacak" kontrol listesi.

### [ ] Migration disiplini
- [ ] Her migration'ın `*_rollback.sql` eşi var
- [ ] Migration'lar tek dizinde (şu an 3 dizine dağılmış: `qulo-server/migrations` 16,
      `qulo-server/supabase/migrations` 6, `qulov2/supabase/migrations` 19)
- [ ] Uygulanmış sürüm kaydı prod ile senkron

### [ ] RLS kararı (yazıya dökülmeli)
- [ ] 26 tabloda RLS **kapalı** — bilinçli mi, unutulmuş mu? Karar yazılacak
- [ ] 23 tabloda RLS açık ama **policy yok** — bu tablolara erişim tamamen kapalı
- [ ] `anon` rolünün grant'leri — mobil sadece Realtime için anon key taşıyor
- [ ] Realtime publication'daki tablolar en riskli grup, en sona bırakılır
- [ ] Her adım için baseline → tek değişiklik → re-test → karar (root CLAUDE.md kuralı)

### [ ] RPC davranışı (server entegrasyonundan dolaylı doğrulanır)
- [ ] `quiz_session_mark_power` / `chat_question_mark_power` — idempotent
- [ ] `increment_*` sayaçları — negatife düşmez
- [ ] `create_economy_config_version` — versiyon çakışması

---

# WEB (`web`)

Şu an **hiç test tooling'i yok** (vitest/playwright kurulu değil).
Kampanya funnel'ı için öncelik düşük — landing sayfası statik.

### [ ] Kurulum (gerektiğinde)
- [ ] vitest + testing-library
- [ ] i18n parity — `next-intl` mesaj dosyaları arasında key seti

### [ ] P2 case'ler
- [ ] `assetlinks.json` / AASA erişilebilir ve doğru paket adı
- [ ] Deep link sayfaları — `quloapp.com` dışı yönlendirme yok
- [ ] Blog/SEO sayfaları — kaynaksız istatistik iddiası yok (`source` alanı zorunlu)

---

# FAZ 4 — Funnel smoke script (test değil, kampanya aracı)

`scripts/smoke.ts` — kampanya öncesi ve sırasında elle çalıştırılır.
- [ ] kayıt → e-posta doğrulama → profil setup → discover **dolu mu** → paywall config
- [ ] Sonunda tek satır özet, hangi adımda kırıldığını söyler
- [ ] Yarattığı test kullanıcısını temizler
