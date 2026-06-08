# Notification Locale Sync + Match Email — Design Spec

**Tarih:** 2026-06-08
**Branch:** APP-1915
**Etki Alanı:** qulo-server, qulov2 (mobile), Supabase DB
**İlgili Skill Tetikleri:** `i18n-guardian` (16 dil key), `chat-flow-guard` (notification akışı)

---

## 1. Problem Tanımı

İki bağımsız ama ilişkili problem tek spec'te çözülecek:

### Problem 1 — Bildirim Dili Bug'ı
Server `users.locale` kolonunu (kayıt anındaki dil) kullanarak push notification gönderiyor. Kullanıcı uygulamada dil değiştirdiğinde bu kolon güncellenmiyor, mobile bunu backend'e bildirmiyor. Sonuç: Fransızca kullanıcısına İngilizce push gidiyor. Push template'leri de sadece 2 dilde (tr, en), email ise 15 dilde — drift var.

### Problem 2 — Eksik Retention Kanalı
Match oluştuğunda push gidiyor (`new_match` owner'a, `new_match_solver` solver'a) ama email kanalı yok. Bir gün boyunca app açmayan owner match'i kaçırıyor — re-engagement fırsatı kayıp.

---

## 2. Karar Matrisi (Brainstorming Çıktısı)

| Soru | Karar |
|---|---|
| Dil kaynağı | App UI dili (mobile'dan PATCH ile sync) |
| Email alıcı | Sadece owner (sorusu çözülen) |
| Solver bildirim | Mevcut `new_match_solver` yeterli, sadece dil fix |
| Inactive threshold | 24 saat |
| Email içerik | Anonim merak tetikleyici (solver kimliği YOK) |
| Email opt-out | Settings toggle + email body unsubscribe link |
| Push dil kapsamı | 2 → 16 dile genişlet (email seti ile hizala) |

---

## 3. Mimari Özet

3 katmanlı çözüm:

| Katman | Değişiklik |
|---|---|
| **Mobile** | `LocaleProvider.setLocale` → backend sync · App resume → activity heartbeat · Settings'e email opt-out toggle |
| **Server** | `PATCH /users/me` extend (`locale` + `email_notifications_enabled`) · `POST /users/me/heartbeat` yeni · `MatchEmailService` yeni · 16 dilde push template · `GET /unsubscribe?token=...` HTML route |
| **DB** | `users.last_active_at TIMESTAMPTZ` · `users.email_notifications_enabled BOOLEAN DEFAULT true` · `email_unsubscribe_tokens` tablosu · `idx_users_last_active_at` |

**Kapsam dışı (explicitly NOT in scope):**
- Per-question bildirim (sadece match-anı)
- Solver'a email
- Daily digest cron
- Push admin panel override değişikliği
- Yeni email türleri (sadece `match_new`)

---

## 4. DB Şeması ve Migration

**Dosya:** `qulo-server/migrations/013_notification_locale_email.sql`

```sql
BEGIN;

-- 1) last_active_at: inactive owner tespiti için
ALTER TABLE users
  ADD COLUMN IF NOT EXISTS last_active_at TIMESTAMPTZ;

UPDATE users
  SET last_active_at = COALESCE(created_at, NOW())
  WHERE last_active_at IS NULL;

-- 2) email_notifications_enabled: opt-out kontrolü
ALTER TABLE users
  ADD COLUMN IF NOT EXISTS email_notifications_enabled BOOLEAN NOT NULL DEFAULT true;

-- 3) Inactive filtresi için index
CREATE INDEX IF NOT EXISTS idx_users_last_active_at
  ON users(last_active_at);

-- 4) Unsubscribe token tablosu (JWT alternatifi: revoke + audit)
CREATE TABLE IF NOT EXISTS email_unsubscribe_tokens (
  token        TEXT PRIMARY KEY,
  user_id      UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  email_type   TEXT NOT NULL,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  used_at      TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS idx_email_unsubscribe_tokens_user_id
  ON email_unsubscribe_tokens(user_id);

COMMIT;
```

**Token formatı:** `crypto.randomBytes(32).toString('hex')` (64 char).

**JWT YERİNE TABLO seçildi çünkü:**
- Revoke edilebilir
- Audit log tutar (kim ne zaman unsubscribe etti)
- `used_at` ile single-use enforce edilebilir
- Secret değişirse eski linkler ölmez

**Rollback:** `DROP TABLE` + `ALTER TABLE DROP COLUMN`. Eski client'lar etkilenmez (default'lar mevcut davranışı korur).

---

## 5. Mobile Değişiklikleri (qulov2)

### 5.1 Locale Sync

**Dosya:** `lib/providers/locale_provider.dart`

```dart
Future<void> setLocale(Locale newLocale) async {
  await _prefs.setString('app_locale', newLocale.languageCode);  // mevcut
  state = newLocale;  // mevcut

  // YENİ:
  if (_ref.read(authStateProvider).isAuthenticated) {
    unawaited(_ref.read(userServiceProvider).syncLocale(newLocale.languageCode));
  }
}
```

**Dosya:** `lib/core/services/user_service.dart`

```dart
Future<void> syncLocale(String locale) async {
  try {
    await _dio.patch('/users/me', data: {'locale': locale});
  } catch (e) {
    // silent fail — local locale yine geçerli, sonraki app açılışında retry
  }
}
```

**Login sonrası tek-shot sync:** `lib/app.dart` veya auth listener'da:
```dart
ref.listen(authStateProvider, (prev, next) {
  if (next.isAuthenticated && (prev?.isAuthenticated ?? false) == false) {
    final current = ref.read(localeProvider).languageCode;
    ref.read(userServiceProvider).syncLocale(current);
  }
});
```

### 5.2 Activity Heartbeat

**Dosya:** `lib/app.dart` (AppLifecycleState listener)

```dart
@override
void didChangeAppLifecycleState(AppLifecycleState state) {
  super.didChangeAppLifecycleState(state);
  if (state == AppLifecycleState.resumed) {
    ref.read(userServiceProvider).heartbeat();  // fire-and-forget
    // mevcut: LocationNotifier.onAppResumed() vs.
  }
}
```

**Dosya:** `lib/core/services/user_service.dart`

```dart
DateTime? _lastHeartbeat;

Future<void> heartbeat() async {
  if (_lastHeartbeat != null &&
      DateTime.now().difference(_lastHeartbeat!) < Duration(minutes: 5)) {
    return;  // debounce
  }
  _lastHeartbeat = DateTime.now();
  try {
    await _dio.post('/users/me/heartbeat');
  } catch (_) {
    // silent
  }
}
```

**Debounce sebebi:** Kullanıcı app'i 1 dakikada 10 kere açabilir, gereksiz network engelle.

### 5.3 Settings Toggle

**Dosya:** `lib/features/settings/screens/settings_screen.dart`

```dart
SwitchListTile(
  title: Text(context.t.settings.emailNotifications),
  subtitle: Text(context.t.settings.emailNotificationsDesc),
  value: ref.watch(userProvider).emailNotificationsEnabled,
  onChanged: (v) async {
    await ref.read(userServiceProvider).setEmailNotifications(v);
  },
)
```

**Settings screen 200 satırı aşarsa**: Notification section'ı ayrı widget'a (`notification_settings_section.dart`) taşı — Flutter dosya yapısı kuralı.

### 5.4 User Model

**Dosya:** `lib/core/models/user.dart`

```dart
final bool emailNotificationsEnabled;

factory User.fromJson(Map<String, dynamic> json) => User(
  // ...
  emailNotificationsEnabled: json['email_notifications_enabled'] as bool? ?? true,
);
```

### 5.5 i18n Key Ekleme

Yeni key'ler (`i18n-guardian` ile 16 dile yayılacak):
- `settings.emailNotifications`
- `settings.emailNotificationsDesc`

---

## 6. Server Değişiklikleri (qulo-server)

### 6.1 SUPPORTED_LOCALES Centralize

**Dosya:** `src/utils/locales.ts`

```typescript
export const SUPPORTED_LOCALES = [
  'tr', 'en', 'de', 'fr', 'es', 'ar', 'ru', 'pt',
  'it', 'ja', 'ko', 'zh', 'nl', 'pl', 'sv', 'hi'
] as const;

export type SupportedLocale = typeof SUPPORTED_LOCALES[number];

export function resolveLocale(input?: string | null): SupportedLocale {
  if (input && (SUPPORTED_LOCALES as readonly string[]).includes(input)) {
    return input as SupportedLocale;
  }
  return 'en';
}
```

Push + email + validation tek kaynaktan okuyacak — drift önler.

### 6.2 PATCH /users/me Extend

**Dosya:** `src/controllers/user.controller.ts`

```typescript
const updateMeSchema = z.object({
  locale: z.enum(SUPPORTED_LOCALES).optional(),
  email_notifications_enabled: z.boolean().optional(),
  // ... mevcut alanlar
});

export async function updateMe(req, res) {
  const body = updateMeSchema.parse(req.body);
  // mevcut UPDATE logic'i body'deki alanlara göre genişler
}
```

### 6.3 Heartbeat Endpoint

**Dosya:** `src/routes/user.routes.ts`

```typescript
router.post('/users/me/heartbeat', requireAuth, async (req, res) => {
  await db.query(
    'UPDATE users SET last_active_at = NOW() WHERE id = $1',
    [req.user.id]
  );
  res.status(204).send();
});
```

Minimal: body yok, response yok.

### 6.4 Unsubscribe Route

**Dosya:** `src/routes/unsubscribe.routes.ts` (yeni)

```typescript
router.get('/unsubscribe', async (req, res) => {
  const token = req.query.token as string;
  const row = await db.oneOrNone(
    `SELECT user_id, email_type, used_at
     FROM email_unsubscribe_tokens WHERE token = $1`, [token]);

  if (!row) return res.status(404).render('unsubscribe/invalid');
  if (row.used_at) return res.render('unsubscribe/already-done');

  await db.tx(async t => {
    await t.query(
      'UPDATE users SET email_notifications_enabled = false WHERE id = $1',
      [row.user_id]);
    await t.query(
      'UPDATE email_unsubscribe_tokens SET used_at = NOW() WHERE token = $1',
      [token]);
  });

  res.render('unsubscribe/success');
});
```

**View'ler:** `src/views/unsubscribe/{invalid,already-done,success}.ejs` — sade HTML, tr/en bilingual yeterli (kullanıcı email body'sinden gelir, ekstra dil yatırımı şart değil).

**Auth gerektirmez** — token doğrulama tek başına yeterli güvenlik.

### 6.5 MatchEmailService

**Dosya:** `src/services/match-email.service.ts` (yeni)

```typescript
import crypto from 'crypto';
import { SUPPORTED_LOCALES, resolveLocale } from '../utils/locales';
import { logger } from '../utils/logger';

export class MatchEmailService {
  static readonly INACTIVE_THRESHOLD_HOURS = 24;

  constructor(
    private userRepo: UserRepository,
    private tokenRepo: EmailUnsubscribeTokenRepository,
    private gmailClient: GmailClient,
    private env: { APP_BASE_URL: string; API_BASE_URL: string },
  ) {}

  async sendMatchEmail(ownerId: string): Promise<void> {
    const owner = await this.userRepo.findById(ownerId);
    if (!owner) return;

    // 1) Opt-out
    if (!owner.email_notifications_enabled) return;

    // 2) Inactive threshold
    const inactiveSince = owner.last_active_at
      ? Date.now() - new Date(owner.last_active_at).getTime()
      : Number.POSITIVE_INFINITY;
    const thresholdMs = MatchEmailService.INACTIVE_THRESHOLD_HOURS * 3600 * 1000;
    if (inactiveSince < thresholdMs) return;

    // 3) Locale
    const locale = resolveLocale(owner.locale);
    const tpl = await this.loadEmailTemplate('match_new', locale);

    // 4) Unsubscribe token
    const token = crypto.randomBytes(32).toString('hex');
    await this.tokenRepo.create({
      token,
      user_id: ownerId,
      email_type: 'match_new',
    });

    // 5) Render + send
    const html = await renderEjs('emails/match-new', {
      ...tpl,
      ctaUrl: `${this.env.APP_BASE_URL}/open`,
      unsubscribeUrl: `${this.env.API_BASE_URL}/unsubscribe?token=${token}`,
    });

    await this.gmailClient.send({
      to: owner.email,
      subject: tpl.subject,
      html,
    });
  }
}
```

**Critical:** Caller fire-and-forget yapacak, match flow bloklamayacak.

### 6.6 Match Flow Integration

**Dosya:** `src/services/quiz.service.ts` → `createMatch`

```typescript
private async createMatch(sessionId, solverId, targetId) {
  // mevcut DB insert + push'lar
  await this.notificationService.sendPush(solver, 'new_match_solver');
  await this.notificationService.sendPush(target, 'new_match');

  // YENİ — fire-and-forget
  this.matchEmailService.sendMatchEmail(targetId)
    .catch(err => logger.error('Match email failed', { err, targetId }));
}
```

### 6.7 16 Dilde Push Template

**Mevcut:** `src/locales/{tr,en}.json` → `push.*`

**Eklenen:** 14 yeni dosya: `de, fr, es, ar, ru, pt, it, ja, ko, zh, nl, pl, sv, hi`

**Key set:**
```json
{
  "push": {
    "new_message": "...",
    "new_match": "...",
    "new_match_solver": "...",
    "new_match_badge": "...",
    "chat_question_answered": "..."
  }
}
```

`new_match_badge` `{badge}` placeholder'ı içerir, `{name}` interpolasyon mevcut yapı korunur.

**Çeviri kalitesi:** `locales/emails/<lang>.json` aynı terminoloji setinde — referans olarak kullanılacak. Release öncesi native speaker review önerilir (en az TR/EN dışındaki 14 dil için).

### 6.8 Email Template (16 dilde)

**Konum:** `src/locales/emails/<lang>.json` → `match_new` section'ı

```json
"match_new": {
  "subject": "Birisi sorularınızı çözdü 🎉",
  "preheader": "Yeni bir eşleşmeniz var",
  "headline": "Birisi tüm sorularınızı çözdü",
  "body": "Qulo'da yeni bir eşleşmeniz var. Şimdi kim olduğunu görün.",
  "cta": "Şimdi gör",
  "unsubscribe_label": "E-posta bildirimlerini kapat"
}
```

**EJS template:** `src/views/emails/match-new.ejs` (tek dosya, locale-driven content).

**Anonim merak prensibi:** Solver adı/fotoğrafı YOK. Sadece "birisi" + CTA "Şimdi gör".

### 6.9 NotificationService resolveLocale Kullanımı

**Dosya:** `src/services/notification.service.ts`

Mevcut fallback (`user.locale && locales[user.locale] ? user.locale : 'en'`) → `resolveLocale(user.locale)` ile değiştir. Tek kaynağa indir.

---

## 7. Data Flow Diyagramları

### Flow A — Locale Değişikliği
```
[User Settings'te dili FR'ye çevirir]
       ↓
LocaleProvider.setLocale(Locale('fr'))
       ↓
SharedPreferences.save('app_locale', 'fr')
       ↓
if authenticated:
  UserService.syncLocale('fr')
       ↓
  PATCH /users/me { locale: 'fr' }
       ↓
  Zod validate: 'fr' ∈ SUPPORTED_LOCALES ✓
       ↓
  UPDATE users SET locale='fr' WHERE id=$1
       ↓
  204 No Content
       ↓
state = Locale('fr')  // UI rebuild
```

### Flow B — App Resume → Heartbeat
```
[User app'i background'dan açar]
       ↓
AppLifecycle.resumed
       ↓
UserService.heartbeat()
       ↓
debounce: son 5 dk içinde gitmiş mi?
  ├─ Evet → no-op
  └─ Hayır → POST /users/me/heartbeat
            ↓
            UPDATE users SET last_active_at=NOW() WHERE id=$1
            ↓
            204
```

### Flow C — Match Email Kararı
```
[Solver son soruyu doğru cevaplar]
       ↓
QuizService.completeSession()
       ↓
QuizService.createMatch(sessionId, solverId, ownerId)
       ├─ INSERT matches
       ├─ sendPush(solver, 'new_match_solver', locale=solver.locale)
       ├─ sendPush(owner, 'new_match', locale=owner.locale)
       └─ MatchEmailService.sendMatchEmail(ownerId)  // fire-and-forget
                ↓
            opt-out? → return
                ↓
            inactive? (NOW - last_active_at < 24h) → return
                ↓
            locale = resolveLocale(owner.locale)
                ↓
            token = crypto.randomBytes(32).hex
            INSERT email_unsubscribe_tokens
                ↓
            render emails/match-new.ejs
                ↓
            GmailClient.send
                ↓
            ✓ log success
```

### Flow D — Unsubscribe
```
[Owner email'deki link'e tıklar]
       ↓
GET /unsubscribe?token=abc123...
       ↓
SELECT email_unsubscribe_tokens WHERE token=$1
  ├─ Bulunamadı → 404 + invalid.ejs
  ├─ used_at NOT NULL → already-done.ejs
  └─ Bulundu, kullanılmamış:
       BEGIN
         UPDATE users SET email_notifications_enabled=false
         UPDATE email_unsubscribe_tokens SET used_at=NOW()
       COMMIT
       ↓
       success.ejs render
```

---

## 8. Error Handling Matrisi

| Senaryo | Davranış | Sebep |
|---|---|---|
| Mobile `syncLocale` 500 | Silent fail, local locale yine geçerli | UI dil değişimi blocking olmamalı |
| Mobile `heartbeat` network fail | Silent fail | Best-effort tracking |
| `PATCH /users/me` invalid locale | 400 Bad Request + zod error | Client bug'ı erken yakala |
| `MatchEmailService` Gmail API error | Log error, match flow devam | Email retention nice-to-have |
| `MatchEmailService` template missing | Fallback to 'en', warn log | Yeni dil eklenince template eksik kalabilir |
| Owner `last_active_at` NULL | Inactive kabul et (email gönder) | Yeni kullanıcı dahi olsa akış çalışsın |
| Unsubscribe token bulunamaz | 404 + nazik HTML | Eski link / yanlış URL |
| Unsubscribe token zaten kullanılmış | "Zaten kapattınız" mesajı | Bilgi, hata değil |
| Push template dil eksik | `resolveLocale` ile 'en' fallback | Production safety |
| Token DB insert race | UNIQUE PRIMARY KEY ile koruma | crypto.randomBytes çakışma riski ~0 |

---

## 9. Test Stratejisi

### 9.1 Server Unit Testleri

**`test/match-email.service.test.ts`:**
- opt-out=false → email gitmez
- last_active_at < 24h → email gitmez
- last_active_at NULL → email GİDER (inactive kabul)
- locale='zz' → 'en' fallback
- GmailClient throw → service yine resolve (caller etkilenmez)

**`test/locales.test.ts`:**
- `resolveLocale`: 16 dil + null + undefined + bilinmeyen → beklenen sonuç

**`test/unsubscribe.controller.test.ts`:**
- 3 state: geçerli / kullanılmış / yok

### 9.2 Server Integration Testleri

- `PATCH /users/me {locale:'fr'}` → DB'de güncellendi
- `PATCH /users/me {locale:'xx'}` → 400
- `POST /users/me/heartbeat` → `last_active_at` güncellendi
- Match flow end-to-end: solver complete → DB'de match, push log doğru locale, mock GmailClient çağrıldı

### 9.3 Mobile Unit Testleri

- `LocaleProvider.setLocale` → mock UserService.syncLocale çağrıldı
- `heartbeat` debounce: 1 dakika içinde 2 çağrı → 1 network call
- Logout state'te setLocale → syncLocale çağrılmaz

### 9.4 Mobile Manuel Smoke Test

1. TR dilinde login → settings'ten FR'ye çevir → backend'de `users.locale='fr'` doğrula (psql)
2. Match tetikle (test_users seed ile) → FR push gelir
3. DB'de `last_active_at` 25h öncesine zorla → match tetikle → FR email gelir
4. Email'deki unsubscribe link → success.ejs → `email_notifications_enabled=false`
5. Tekrar match → email GİTMEZ, push gider

### 9.5 Test Edilemeyecek Olanlar (manuel doğrulama)

- Gerçek Gmail teslimat (inbox vs spam) → 16 dilde test mail
- 16 dilde push görüntülenmesi → iOS + Android device matrix
- Sağdan-sola diller (ar) email render → manuel kontrol

---

## 10. Rollout Stratejisi

**Sıralı deploy:**
1. Migration 013 → tek başına, davranış değişmez
2. Server deploy → endpoint'ler hazır, push i18n hazır, mobile sync etmediği için davranış mevcut
3. Mobile build (TestFlight + Internal) → sync başlar, FR/DE kullanıcı bildirimlerini doğru dilde alır
4. Production release → store'a çıkar

**Geri dönüş senaryosu:**
- Mobile'da locale sync feature flag ile kapatılabilir (`const ENABLE_LOCALE_SYNC = false`)
- Server geri uyumlu — eski client'lar `locale` göndermez, davranış aynı

---

## 11. Dosya Etki Listesi

### Server
| Dosya | Tip | Değişiklik |
|---|---|---|
| `migrations/013_notification_locale_email.sql` | Yeni | DB şema değişikliği |
| `src/utils/locales.ts` | Yeni | SUPPORTED_LOCALES + resolveLocale |
| `src/controllers/user.controller.ts` | Mod | `updateMe` extend |
| `src/routes/user.routes.ts` | Mod | `POST /users/me/heartbeat` |
| `src/routes/unsubscribe.routes.ts` | Yeni | Unsubscribe handler |
| `src/views/unsubscribe/{success,invalid,already-done}.ejs` | Yeni | 3 view |
| `src/services/match-email.service.ts` | Yeni | Match email logic |
| `src/services/quiz.service.ts` | Mod | createMatch fire-and-forget email |
| `src/services/notification.service.ts` | Mod | resolveLocale kullan |
| `src/locales/{de,fr,es,ar,ru,pt,it,ja,ko,zh,nl,pl,sv,hi}.json` | Yeni | 14 dil push section'lı |
| `src/locales/emails/*.json` | Mod | `match_new` section 16 dil |
| `src/views/emails/match-new.ejs` | Yeni | Email template |

### Mobile
| Dosya | Tip | Değişiklik |
|---|---|---|
| `lib/providers/locale_provider.dart` | Mod | `setLocale` içine sync çağrısı |
| `lib/core/services/user_service.dart` | Mod | `syncLocale`, `heartbeat`, `setEmailNotifications` |
| `lib/app.dart` | Mod | resume → heartbeat, login → locale sync |
| `lib/features/settings/screens/settings_screen.dart` | Mod | Email opt-out switch |
| `lib/core/models/user.dart` | Mod | `emailNotificationsEnabled` alanı |
| `lib/i18n/*.json` (16 dil) | Mod | 2 yeni key (i18n-guardian) |

---

## 12. Açık Sorular ve Varsayımlar

**Varsayımlar:**
- `users.email` her zaman doluyor (Apple Sign-In private relay olabilir — bu durumda email gönderim teslim edilemez ama bu mevcut davranış).
- `users.locale` her zaman ISO 639-1 lowercase ('tr', 'en', vs.) — mevcut yapı bunu garantiliyor.
- Gmail API quota'sı match email hacmini karşılayacak (mevcut verification/password reset için kullanılıyor, kapasitesi var).
- 16 dilde push çevirileri için profesyonel translator yatırımı release öncesi yapılacak — bu spec çeviri içerik kalitesini garanti etmez, sadece infrastruktür.

**Açık karar (release öncesi):**
- 16 dilde push template çevirileri: ChatGPT-grade ön çeviri + native speaker review, ya da profesyonel translator service? → marketing/PM kararı.

---

## 13. Skill Tetikleri

Implementation sırasında aşağıdaki Qulo skill'leri otomatik çalışacak:

- **`i18n-guardian`** — yeni i18n key'leri 16 dile yayma, mobile + server
- **`chat-flow-guard`** — match flow değişikliği (push + email entegrasyonu) bozulma riski analizi
- **Server review** — `quiz.service.ts`, `match-email.service.ts`, controller değişiklikleri sonrası `/server-review`
- **Flutter review** — `LocaleProvider`, `user_service.dart`, `settings_screen.dart` değişiklikleri sonrası `/flutter-review`

---

## 14. Başarı Kriterleri

- [ ] FR dili kullanıcı app açtığında, match push'u FR olarak gelir
- [ ] 24+ saat inactive owner match email'i FR olarak alır
- [ ] Aktif owner email almaz (push yeter)
- [ ] Opt-out yapan owner artık email almaz, push almaya devam eder
- [ ] Unsubscribe link tek-kullanımlık çalışır
- [ ] Push template'leri 16 dilde mevcut, eksik dil 'en' fallback
- [ ] `last_active_at` her app resume'da güncellenir, 5 dk debounce çalışır
- [ ] Mobile dil değişikliği < 1 saniye içinde server'a sync edilir (network olağan)
- [ ] Tüm değişiklikler arkaya uyumlu: eski client çalışmaya devam eder
