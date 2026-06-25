# Onboarding Coach-Marks (Anchored Spotlight Tooltips) — Tasarım

**Tarih:** 2026-06-26
**Durum:** Onaylandı (brainstorming)
**Kapsam:** qulov2 (Flutter mobile) — server/DB değişikliği YOK

---

## 1. Amaç ve Bağlam

Qulo'nun çekirdek mekaniği quiz-based eşleşme: kullanıcı keşfet ekranında partner adayının sorularını çözer, hepsi doğruysa eşleşir. Mevcut 5 sayfalık onboarding (`features/onboarding/`) uygulamayı tanıtıyor ama **belirli UI elemanlarının üstüne ışık tutan, bağlam-içi (in-context) anchored tooltip/coach-mark** sistemi yok.

Projede halihazırda:
- `tutorial_coach_mark`, `showcaseview` gibi bir coach-mark paketi **yüklü değil**.
- `page_messages` sistemi var ama serbest banner/bottom-sheet/modal gösteriyor — belirli bir widget'a sabitlenen, "delik açıp ışık tutan", sıralı (queue) tur yapısı **yok**.

Bu spec, bu boşluğu dolduran **yeniden kullanılabilir bir anchored coach-mark motoru** ve onu 3 yüzeyde kullanan turları tanımlar.

### Funnel notu (bağlam, kapsam dışı)
Canlı DB analizi: 89 kayıt → 38 silinmiş (`is_deleted`), 51 gerçek kullanıcı, bunların 22'si 2+ soruya sahip, 18'i tam discover-ready, 7 aktif match. 0 sorulu kullanıcılar **soru zorunluluğu öncesi** kayıtlardan (mevcut bug değil). Bu spec churn/funnel sorununu çözmeyi hedeflemez; bağlam-içi rehberlikle kullanıcı kavrayışını artırmayı hedefler.

---

## 2. Onaylanan Kararlar

| Karar | Seçim |
|---|---|
| İçerik yeri | Statik l10n (16 dil, app ile gelir) — mevcut onboarding pattern'i |
| Motor | Özel hafif overlay (core/), paket değil — Hardware Manager pattern'e uygun |
| Persistence | Lokal SharedPreferences, yüzey başına flag |
| Quiz güç tanıtımı | Tek toplu kart (power_bar vurgulu, 6 güç açıklamalı) |
| Discover tur | 3 adım (tanıtım + soru/çöz + eşleşme) |
| Server/DB | Değişiklik yok |

---

## 3. Mimari

### 3.1 Core Motor — `lib/core/coach_mark/`

**`coach_mark_step.dart` — `CoachMarkStep` (model)**
- `GlobalKey? targetKey` — vurgulanacak widget; `null` ise ekran ortasında modal kart (anchorsız adım).
- `String titleKey`, `String bodyKey` — l10n key'leri (hardcode YOK).
- `String ctaKey` — buton etiketi key'i (örn. `coach.cta.next` / `coach.cta.start`).
- `CoachMarkShape shape` — `rect` | `circle` (cutout şekli).
- `VoidCallback? onShow`, `VoidCallback? onDismiss` — adım gösterilince/kapanınca tetiklenir (quiz timer pause/resume buraya bağlanır).

**`coach_mark_controller.dart` — `CoachMarkController`**
- Bir tur'un step listesini, mevcut index'i tutar.
- `next()`, `skip()`, `complete()` — queue ilerletme.
- Son adım sonrası `complete()` → ilgili `onDismiss` + persistence flag set.
- Saf Dart/State mantığı; widget'a bağlı değil → **unit test edilebilir**.

**`coach_mark_overlay.dart` — `CoachMarkOverlay` (widget)**
- `Overlay` entry olarak basılır (NavigationService overlay context'i veya kök overlay).
- Yarı saydam karartılmış barrier (gamified: koyu zemin + hafif blur).
- Hedef widget'ın global rect'i `RenderBox.localToGlobal` + `size` ile hesaplanır.
- `CustomPainter` (delik/cutout) ile hedefin üstü "ışıklı" bırakılır.
- Tooltip kartı: başlık + açıklama + adım göstergesi (•••) + CTA butonu (AppButton, AppSpacing). Hedefin altına/üstüne otomatik konumlanır (ekran kenarına taşmayı önler).

**`coach_mark_painter.dart` — `CoachMarkPainter` (CustomPainter)**
- Tüm ekranı karartır, hedef rect'i `BlendMode.clear`/path-difference ile boşaltır.
- `rect` ve `circle` şekilleri.

**`lib/core/services/coach_mark_service.dart` — `CoachMarkService` (singleton)**
- Tek giriş noktası (Hardware Manager pattern): feature'lar yalnızca bunu çağırır, Overlay/Painter detaylarını bilmez.
- `Future<void> startTour({required String tourId, required List<CoachMarkStep> steps})` — flag kontrolü + tek-tur garantisi + overlay yaşam döngüsü.
- `bool isSeen(String tourId)` / `Future<void> markSeen(String tourId)` — SharedPreferences kapısı.
- **Tek tur garantisi:** aktif tur varken ikinci `startTour` çağrısı yok sayılır (veya sıraya alınır).

### 3.2 Anchoring Akışı
1. Hedef widget'a `GlobalKey` verilir.
2. `WidgetsBinding.addPostFrameCallback` içinde rect okunur.
3. Widget henüz layout olmadıysa → kısa retry (örn. bir-iki frame).
4. Bulunamaz/ekran dışıysa → o adım atlanır (tur çökmez); gerekiyorsa görünüre kaydırma denenir.

---

## 4. Tur Tanımları (3 Yüzey)

### 4.1 Discover — Transparan Queue Turu
**Dosya:** `lib/features/discover/coach/discover_coach_marks.dart`
**Tetik:** İlk discover ziyareti, `coach_discover_seen == false`.
**Stacking koruması:** `QuestionGateBanner` görünüyorsa (kullanıcının < min soru) tur **ertelenir** — gate ile çakışmaz.

**Adımlar:**
1. Ortada modal (anchorsız) — `coach.discover.intro.*`: "Qulo nasıl çalışır?" kısa şeffaf tanıtım.
2. Anchored → keşfet kartındaki soru/çöz alanı — `coach.discover.solve.*`: "Bu kişinin sorularını çöz, hepsi doğruysa eşleşirsin."
3. Anchored → like/eşleşme aksiyonu — `coach.discover.match.*`.

Son adım CTA `coach.cta.start` → `markSeen('discover')`.

### 4.2 Quiz Solve — Güç Alanları Tanıtımı (kritik edge case)
**Dosya:** `lib/features/quiz/coach/quiz_power_coach_marks.dart`
**Tetik:** İlk soru çözme oturumu, `coach_quiz_powers_seen == false`.
**İçerik:** Tek toplu kart — `power_bar` tümü vurgulanır; kartta 6 güç (`oracle`, `half`, `skip`, `hint`, `timeExtend`, `skipAll`) ikon + kısa açıklama. l10n: `coach.quiz.powers.title/body` + `coach.quiz.power.<name>.label`.

**Timer güvenliği — mevcut altyapı yeniden kullanılır:**
`quiz_screen.dart`'taki `onSheetOpening → timer.pause()` / `onSheetClosed → timer.resume()` hook'ları mevcut. Coach-mark bir "sheet" gibi ele alınır:
- `onShow` → `timerKey.currentState?.pause()`.
- `onDismiss` (yalnızca tur tamamlanınca/kapanınca) → `timerKey.currentState?.resume()`.

**Edge case'ler:**
- Tur sırasında app arka plana atılırsa → timer zaten duruyor; resume yalnızca tur kapanınca tetiklenir.
- Kullanıcı tur ortasında geri/çıkış yaparsa → `onDismiss` **mutlaka** çağrılır (resume garantisi; timer asla kilitli kalmaz).
- Resume **idempotent** (çift resume yok).
- Tur açıkken `power_bar` butonları disable kalır (yanlışlıkla güç harcanmaz).

### 4.3 Chat — Soru Hazırlama Butonu
**Dosya:** `lib/features/chat/coach/chat_question_coach_marks.dart`
**Tetik:** İlk kez bir match chat'ine girince, `coach_chat_question_seen == false`.
**İçerik:** Anchored → "soru hazırla/gönder" butonu — `coach.chat.question.*`: "Buradan partnerine yeni bir soru hazırlayıp gönderebilirsin." Tek tooltip.

---

## 5. i18n (16 Dil, Statik l10n)

Yeni namespace `coach.*`, 16 çeviri dosyasına (`lib/core/l10n/translations/`) eklenir:
- `coach.cta.next`, `coach.cta.start`, `coach.cta.gotIt`
- `coach.discover.intro.title/body`, `coach.discover.solve.title/body`, `coach.discover.match.title/body`
- `coach.quiz.powers.title/body`, `coach.quiz.power.oracle.label`, `.half`, `.skip`, `.hint`, `.timeExtend`, `.skipAll`
- `coach.chat.question.title/body`

Feature sonrası `i18n-guardian` ile tamlık doğrulanır.

---

## 6. Persistence (SharedPreferences)

Mevcut `onboarding_v2_seen` pattern'i ile simetrik:
- `coach_discover_seen`
- `coach_quiz_powers_seen`
- `coach_chat_question_seen`

`CoachMarkService.isSeen/markSeen` üzerinden yönetilir.

---

## 7. Dosya Yapısı (Proje Kurallarına Uygun)

```
lib/core/coach_mark/
  coach_mark_step.dart
  coach_mark_controller.dart
  coach_mark_overlay.dart
  coach_mark_painter.dart
lib/core/services/
  coach_mark_service.dart        (singleton)
lib/features/discover/coach/
  discover_coach_marks.dart
lib/features/quiz/coach/
  quiz_power_coach_marks.dart
lib/features/chat/coach/
  chat_question_coach_marks.dart
```

- Screen dosyaları yalnızca tetiklemeyi çağırır (thin orchestration); tur içerikleri ayrı dosyada.
- Feature'lardan core motor servisine erişim; Overlay/Painter doğrudan import edilmez.

---

## 8. Edge Case'ler (Genel)

- Hedef widget layout olmadan → postFrame + retry; bulunamazsa adım atlanır.
- Tablet/responsive (AppScaffold maxWidth 560) → rect, layout değişiminde yeniden hesaplanır.
- `page_messages` banner + coach-mark çakışması → coach-mark öncelikli; banner tur bitince.
- Tek tur garantisi: `CoachMarkService` aynı anda ikinci tur başlatmaz.
- Quiz timer resume idempotent guard.

---

## 9. Test Edilebilirlik

- `CoachMarkController` — unit test (queue ilerleme, complete, skip).
- `CoachMarkService` — SharedPreferences mock ile isSeen/markSeen + tek-tur garantisi testi.
- Motor feature'lardan izole olduğundan widget testleri turlardan bağımsız yazılabilir.

---

## 10. Kapsam Dışı (YAGNI)

- Server-side onboarding tracking / cihazlar arası senkron.
- A/B test, backoffice yönetimi (page_messages bunu zaten serbest mesajlar için sağlıyor).
- Animasyonlu maskot/karakter.
- "Tekrar göster" / ayarlardan onboarding sıfırlama (gerekirse ayrı iş).

---

## 11. Reuse Haritası

| İhtiyaç | Yeniden kullanılan |
|---|---|
| Persistence pattern | `onboarding_v2_seen` (SharedPreferences) |
| Quiz timer pause/resume | `quiz_screen.dart` mevcut `onSheetOpening/onSheetClosed` hook'ları |
| Buton/tasarım | AppButton, AppSpacing, q_icons (gamified) |
| i18n | `context.l10n` + 16 translation dosyası |
| Tetik zamanlaması | `addPostFrameCallback` (mevcut mixin pattern) |
