# Push Notification Paneli — Phase 1 Kapanış (Design Spec)

**Tarih:** 2026-06-08
**Kapsam:** Phase 1 punch list — tip listesi temizliği + production deploy + canlı verifikasyon + admin guide
**Ön koşul:** Phase 1 ana implementation tamamlanmış (commit `e5ba1e1` → `75fb3d3`, qulo-server `main` branch)
**Ana spec:** [`2026-06-05-dynamic-notification-system-design.md`](2026-06-05-dynamic-notification-system-design.md)

---

## 1. Motivasyon

Phase 1 implementation (DB tablo, getTemplate helper, admin endpoints, admin views, testler) tamamlandı ama henüz canlıya alınmadı. Ayrıca panelde gösterilen push tip listesi gerçek durumla tutarsız: `quiz_started` ve `passport_expired` hiç tetiklenmiyor, `campaign` ise tetikleniyor ama body'si her kampanya tarafından dinamik geliyor (panelde editlemek anlamsız).

Bu spec, sapmayı kapatıp Phase 1'i "canlıda doğrulanmış" duruma getirir.

---

## 2. Kapsam

| İçinde | Dışında |
|---|---|
| PUSH_TYPES whitelist temizliği (6 admin-editable tip) | Phase 2 (retention push) |
| `campaign` için internal type ayrımı | Phase 3 (gamification push) |
| Dead locale entry temizliği (`quiz_started`, `passport_expired`) | Phase 4 (14 dil çevirisi) |
| Railway deploy + live override + rollback testi | Phase 5 (A/B, audit log, cache, analytics) |
| Admin user guide (TR, 1 sayfa) | Match email tasarımı (ayrı session) |
| Marketing doc update (apple-search-ads.md) | Email template editleme |

---

## 3. Mevcut Durum Tespiti

### 3.1 Aktif push tipleri (kod tabanında gerçekten `sendPush` çağrısı olanlar)

| Tip | Tetikleyici | Body kaynağı |
|---|---|---|
| `new_message` | `chat-question.service.ts:270`, `media.service.ts:92,158` | Locale template + `{name}` |
| `new_message_image` | `chat.service.ts:191` (image ternary) | Locale template + `{name}` |
| `new_match` | `quiz.service.ts:553` | Locale template + opsiyonel `{badge}` (badgeTemplateKey ile `new_match_badge`'e promote olur) |
| `new_match_solver` | `quiz.service.ts:552` | Locale template |
| `new_match_badge` | `new_match` içinde otomatik promote (`params.badge` varsa) | Locale template + `{badge}` |
| `chat_question_answered` | `chat-question.service.ts:336,470` | Locale template |
| `campaign` | `campaign.service.ts:141`, `weekly-report.service.ts:23` | `params.body` (kampanya tarafından sağlanır), template fallback |

### 3.2 Dead tipler

| Tip | Sebep |
|---|---|
| `quiz_started` | PUSH_TYPES ve locale dosyalarında var, hiçbir `sendPush` çağrısı yok |
| `passport_expired` | PUSH_TYPES ve locale dosyalarında var, hiçbir `sendPush` çağrısı yok (cron planlanmış ama hiç eklenmedi) |

### 3.3 Sapma

- Admin panel `PUSH_TYPES`'a bakar → şu an 8 tip gösterir.
- 2 tip (dead) editlense bile etkisiz — kafa karıştırıcı.
- `campaign` tipi gösteriliyor ama body dinamik geldiği için editlemenin anlamı sınırlı.

---

## 4. Mimari Karar — Admin-Editable vs Internal Tip Ayrımı

`campaign`'i tamamen silmek mümkün değil — `sendPush` çağrısı hâlâ var, type sistem bozulur, production'da campaign push'ları kırılır.

**Çözüm:** İki ayrı const + bir union tip.

```ts
// Admin panel SADECE bunları düzenler.
// Validator (pushTemplateParamsSchema) bu enum'u kullanır.
export const PUSH_TYPES = [
  'new_message',
  'new_message_image',
  'new_match',
  'new_match_solver',
  'new_match_badge',
  'chat_question_answered',
] as const;
export type PushType = typeof PUSH_TYPES[number];

// Internal — kodda tetiklenir ama admin paneline gelmez.
// Body'si dinamik (campaign satırından).
const INTERNAL_PUSH_TYPES = ['campaign'] as const;
type InternalPushType = typeof INTERNAL_PUSH_TYPES[number];

// sendPush ve getTemplate ikisini de kabul eder.
export type AnyPushType = PushType | InternalPushType;
```

### 4.1 Etki noktaları

| Dosya | Değişiklik |
|---|---|
| `notification.service.ts` | `PUSH_TYPES` listesi 6'ya indirilir; `INTERNAL_PUSH_TYPES` + `AnyPushType` eklenir; `sendPush(type: AnyPushType, ...)`, `getTemplate(type: AnyPushType, ...)` signature |
| `push-template.validator.ts` | Hâlihazırda `PUSH_TYPES` import ediyor — otomatik daralır, ek değişiklik gerekmez |
| `admin.service.ts` `pushTemplateAdminService.list()` | `PUSH_TYPES.map(...)` — otomatik 6 tip döner |
| `campaign.service.ts`, `weekly-report.service.ts` | `"campaign"` string literal'i `AnyPushType`'a uymak için type-cast veya signature gevşemesi gerekebilir |
| `chat.service.ts:191` | `new_message`/`new_message_image` ternary'si `PushType` döner — değişiklik yok |

### 4.2 Locale dosyaları

`tr.json` ve `en.json` `push` bloğundan **3 entry silinir:**
- `quiz_started`
- `passport_expired`
- `campaign` (body dinamik geldiği için gerek yok — silersek getTemplate `null` dönecek; `sendPush` campaign için `params.body` üzerinden gönderiyor mu kontrol et: evet, mevcut kod `body` paramı varsa onu kullanıyor. **Doğrulama Task 0'da yapılacak.**)

Eğer kontrol gösterirse ki `campaign` template'i hâlâ fallback için gerekli, locale'de bırakılır ama panel'de gizli kalır.

---

## 5. Deploy + Verifikasyon

### 5.1 Adım sırası

| Adım | Aksiyon | Beklenen |
|---|---|---|
| 1 | Lokal: tip değişikliklerini yap, `npm run build` | Type error yok |
| 2 | `npx vitest run` | Tüm testler ✅ (eski getTemplate testleri PUSH_TYPES değişiminden etkilenir mi kontrol — etkilenirse test fixture'ları güncelle) |
| 3 | `git push origin main` (qulo-server repo'su) | Railway auto-deploy başlar |
| 4 | `railway logs --since 5m` | "Build successful" + server start log |
| 5 | Production admin: `https://qulo-server-production.up.railway.app/admin/push-messages?locale=tr` | 6 tip listeleniyor, hepsi 🟢 Aktif, hepsi "default" |
| 6 | **Live override:** `new_message` → title "Yeni mesaj 👀" → Kaydet | List'te override var, yeni timestamp |
| 7 | seed test user `tester_001@qulo.test` cihazından kendi telefonuna mesaj gönder | Push title "Yeni mesaj 👀" geliyor |
| 8 | **Rollback:** "Default'a dön" → kaydet | List "default"a dönüyor |
| 9 | Aynı user tekrar mesaj gönder | Push original locale text ile geliyor |
| 10 | `railway logs --since 15m \| grep -iE "getTemplate\|push_messages"` | Warn/error yok |

### 5.2 Test cihazı + user setup

- Berkant'ın kendi gerçek cihazı (FCM token aktif)
- Seed user `tester_001@qulo.test` — mesaj göndermek için
- Eşleşme testi için 2 hesap arası ön match olabilir (opsiyonel)

### 5.3 Rollback (deploy bozulursa)

| Sorun | Aksiyon |
|---|---|
| Build fail | Hatayı lokal'de tekrar et, düzelt, yeniden push |
| Type cast hatası (`campaign` ile ilgili) | `AnyPushType` signature'ını gevşet veya `as PushType` cast ekle |
| Live test push gelmez | `getTemplate` null dönüyor → locale'den `campaign` veya başka entry yanlışlıkla silinmiş; restore + redeploy |
| Acil tam geri | `git revert HEAD~N` + push (Phase 1 implementation commit'lerini geri almadan, sadece kapanış commit'lerini revert) |

---

## 6. Admin Guide İçeriği

`qulo-server/docs/admin-push-messages-guide.md` — 1 sayfa TR, mevcut admin guide'ların stiline uyumlu.

**Bölümler:**

1. **Ne için var** — push metinleri deploy gerektirmeden değiştirilir
2. **Nereden açılır** — admin → sidebar → "🔔 Push Mesajları"
3. **Mesaj düzenleme** — adım adım (tip seç → düzenle → title/body → kaydet)
4. **Placeholder kullanımı** — `{name}`, `{badge}`, `{result}` allowed list + örnek
5. **Push tamamen kapatma** — Aktif kutusu kaldır → kaydet → confirm
6. **Default'a dönme** — tek alan veya tüm override
7. **Hata davranışı** — DB sorunu olursa auto-fallback locale'e
8. **6 tipin listesi** — her birinin ne zaman tetiklendiği

---

## 7. Marketing Doc Update

`docs/marketing/apple-search-ads.md` — varsa ilgili bölüme satır ekle:

```markdown
### 🟢 [HAZIR] Dinamik Push Sistemi (2026-06-08 canlı)

Phase 1 production'da. Push metinleri admin panelden değiştirilebiliyor. ASA kampanyası sırasında kötü performans gösteren push 2 dakikada A→B'ye geçirilebilir.
Detay: `docs/superpowers/specs/2026-06-05-dynamic-notification-system-design.md`
```

Eğer `apple-search-ads.md` bulunamazsa bu adım atlanır (in-scope değil, ASA prep ayrı iş).

---

## 8. Başarı Kriterleri

Phase 1 "canlıda doğrulanmış" demek için **5 maddenin tamamı:**

- [ ] `PUSH_TYPES` 6 tip; `quiz_started` + `passport_expired` hem kodda hem locale'de yok; `campaign` `INTERNAL_PUSH_TYPES`'ta
- [ ] `npm run build` + `npx vitest run` tertemiz
- [ ] Production deploy başarılı, admin panel 6 tip gösteriyor
- [ ] **Live override:** `new_message` override → mobile cihazda yeni metin alındı
- [ ] **Rollback:** "Default'a dön" → mobile cihazda original metin alındı

---

## 9. Risk Analizi

| Risk | Olasılık | Etki | Önlem |
|---|---|---|---|
| `campaign` cast'i unutulur → TypeScript build fail | Orta | Deploy block | Lokal `npm run build` zorunlu, build geçmeden push yok |
| `campaign` locale entry'si silinir + dinamik body de yoksa → push body boş | Düşük | Boş kampanya push'u | Task 0'da campaign.service'in body param geçirdiği teyit edilir; teyit edilemezse locale entry silinmez |
| Live test sırasında FCM gecikmesi → false negative | Düşük | Yanlış "başarısız" izlenimi | 2 dakika bekle, tekrar dene, telefon ekranı kilitli değil |
| Phase 1 testleri `PUSH_TYPES` daralınca düşer (fixture `'new_message'` kullanıyor — yine var, sorun yok) | Çok düşük | Test fail | Lokal test çalıştırılır, fix gerekirse fixture güncellenir |
| Admin paneline başka bir admin override yazmış (production'da) → live test başlamadan üzerine yazılır | Çok düşük | Eski override kaybolur | Live test öncesi `SELECT * FROM push_messages` ile mevcut override var mı kontrol et |

---

## 10. Açık Sorular

İmplementation planında netleşecek:

1. `campaign` push'unun `params.body` davranışı — `sendPush`'un template body'yi nasıl override ettiği kontrol edilecek (Task 0)
2. `chat.service.ts:191` `new_message_image` ternary — `as PushType` cast'i gerekiyor mu, otomatik mı geçiyor (Task 0)
3. Production'da mevcut `push_messages` satırı var mı (zaten panel kullanılmış mı) — live test öncesi `SELECT *` ile kontrol
4. Railway env vars + Supabase service role key Phase 1 implementation sırasında set edilmişti mi (varsayım: evet, deploy zaten çalışıyordu) — `railway variables list` ile teyit

---

## 11. İlgili Bağlam

- **Ana spec:** `docs/superpowers/specs/2026-06-05-dynamic-notification-system-design.md`
- **Ana plan:** `docs/superpowers/plans/2026-06-05-dynamic-notification-system-phase1.md`
- **Phase 1 commit'leri (qulo-server main):** `e5ba1e1`, `c828f19`, `ec4cba9`, `0507fc9`, `e64f9fe`, `75fb3d3`
- **Notification entry:** `qulo-server/src/services/notification.service.ts`
- **Admin panel:** `qulo-server/src/admin/views/push-messages-*.ejs`
- **Test user'lar:** `tester_001@qulo.test` (şifre `Test1234!`)

---

_Spec hazırlayan: Berkant Çalıkuşu + Claude_
_Son güncelleme: 2026-06-08_
