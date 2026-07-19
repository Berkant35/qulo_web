# Faz 1 — Huni Tamiri + Funnel Ölçüm Implementasyon Planı (v2.0.6)

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Onboarding carousel'i auth öncesine al, social-first landing ekle, paywall'ı ilk eşleşmeye ertele ve funnel event ölçümünü başlat — reklam öncesi huni tamiri.

**Architecture:** Mevcut Flutter parçalarının yeri/sırası değişir (büyük yeniden yazım yok). Carousel `_MainShell.initState` yerine bir GoRouter pre-auth guard'ıyla açılır; dil seçimi local saklanıp auth sonrası flush edilir; paywall `quiz_screen_mixin` celebration-çıkışına taşınır; funnel event'leri hibrit `FunnelEvents` helper'ıyla (Firebase + server `flow_events`) basılır.

**Tech Stack:** Flutter + Riverpod (Notifier) + GoRouter (NavigationService wrapper) + SharedPreferences + Firebase Analytics + custom Dart-map l10n.

## Global Constraints

- `flutter analyze` sıfır hata (qulov2 dizininden; `dart analyze` değil).
- Kod commit'leri **qulov2 kendi git repo'suna** (`qulov2/`, branch `main`). Docs dış repo'da.
- Localization: yeni her key **16 dilde** (`lib/core/l10n/translations/*.dart`: ar, de, en, es, fr, hi, it, ja, ko, nl, pl, pt, ru, sv, tr, zh). Hardcode string YASAK; `context.tr('key')` kullan.
- Screen dosyası max ~200 satır, sadece UI orchestration; logic mixin'de (`mixin XScreenMixin on ConsumerState<XScreen>` + `initMixin`/`disposeMixin`).
- Raw `Scaffold` YASAK (full-bleed istisnası dışında) → `AppScaffold`. `Widget _buildX()` pattern YASAK → ayrı widget class. `CircularProgressIndicator` YASAK → `AppLoadingWidget`.
- Navigasyon SADECE `ref.read(navigationServiceProvider).push/go(RouteNames.x)` — doğrudan GoRouter/Navigator YASAK.
- Donanım paketleri sadece `core/services/` singleton manager üzerinden.
- Renkler/spacing/text style theme'den; hardcoded değer yok.
- Bitişte `/flutter-review` (otomatik). Ekonomi analizi (paywall) yapıldı: `memory/economy_impact_log.md` — ORTA, config değişmiyor.

---

## Task 1: FunnelEvents hibrit helper + event sabitleri

**Files:**
- Create: `qulov2/lib/core/services/funnel_events.dart`
- Modify: `qulov2/lib/core/services/analytics_events.dart` (yeni sabitler ekle)

**Interfaces:**
- Consumes: `AnalyticsManager.instance.logEvent(String, {Map<String,Object>?})`, `AnalyticsForwarder.instance.track(String, {String? category, Map<String,dynamic>? metadata})` (mevcut).
- Produces:
  - `FunnelEvents.logPreAuth(String name, {Map<String,Object>? params})` → sadece Firebase.
  - `FunnelEvents.logAuthed(String name, {Map<String,Object>? params})` → Firebase + server flow_events.
  - `FunnelEvents.logAuthedOnce(String flagKey, String name, {Map<String,Object>? params}) → Future<void>` → SharedPreferences flag'li tek-seferlik logAuthed.
  - Yeni `AnalyticsEvents` sabitleri (aşağıda).

- [ ] **Step 1: FunnelEvents helper'ı oluştur**

`qulov2/lib/core/services/funnel_events.dart`:

```dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qulo_v2/core/services/analytics_manager.dart';
import 'package:qulo_v2/core/services/analytics_forwarder.dart';

/// Hibrit funnel logger.
///
/// - [logPreAuth]: auth ONCESI event — yalnizca Firebase (client-side, JWT
///   gerekmez). Carousel, landing, register adimlari icin.
/// - [logAuthed]: auth SONRASI event — Firebase + server `flow_events`
///   (POST /analytics/track, JWT'li). Admin panelde SQL sorgulanabilir.
/// - [logAuthedOnce]: tek-seferlik logAuthed (ilk discover / ilk quiz gibi).
///
/// Firebase = tam funnel gorunumu; server = auth-sonrasi detay.
abstract final class FunnelEvents {
  static void logPreAuth(String name, {Map<String, Object>? params}) {
    AnalyticsManager.instance.logEvent(name, params: params);
  }

  static void logAuthed(String name, {Map<String, Object>? params}) {
    AnalyticsManager.instance.logEvent(name, params: params);
    AnalyticsForwarder.instance.track(
      name,
      category: 'funnel',
      metadata: params,
    );
  }

  static Future<void> logAuthedOnce(
    String flagKey,
    String name, {
    Map<String, Object>? params,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(flagKey) ?? false) return;
    await prefs.setBool(flagKey, true);
    logAuthed(name, params: params);
  }
}
```

- [ ] **Step 2: analytics_events.dart'a yeni sabitleri ekle**

`AnalyticsEvents` sınıfı içine (mevcut gruplama takip edilerek; `paramTrigger`, `paramStepIndex`, `onboardingV2Complete`, `onboardingStepView`, `discoverScreenView`, `quizStart`, `quizComplete`, `setupGenderPrefSelected` ZATEN VAR — tekrar ekleme). Ekle:

```dart
  // Auth Landing (Faz 1)
  static const String authLandingView = 'auth_landing_view';
  static const String authLandingSocialSelected = 'auth_landing_social_selected';
  static const String authLandingEmailSelected = 'auth_landing_email_selected';

  // Onboarding carousel (Faz 1 — pre-auth)
  static const String onboardingV2PageView = 'onboarding_v2_page_view';
  static const String onboardingV2Skip = 'onboarding_v2_skip';

  // Funnel milestones (Faz 1 — post-auth)
  static const String paywallShown = 'paywall_shown';
  static const String firstDiscoverView = 'first_discover_view';
  static const String firstQuizComplete = 'first_quiz_complete';
```

Param key'leri bölümüne (mevcut `paramStepIndex`, `paramTrigger` yanına) ekle:

```dart
  static const String paramProvider = 'provider';
  static const String paramPageName = 'page_name';
  static const String paramPageIndex = 'page_index';
```

SharedPreferences flag key sabitlerini de buraya ekle (tek-seferlik event/paywall guard'ları için tek kaynak):

```dart
  // Faz 1 SharedPreferences flag key'leri
  static const String flagPaywallFirstMatch = 'paywall_after_first_match_shown';
  static const String flagFirstDiscoverView = 'funnel_first_discover_view_seen';
  static const String flagFirstQuizComplete = 'funnel_first_quiz_complete_seen';
```

- [ ] **Step 3: flutter analyze**

Run: `cd qulov2 && flutter analyze`
Expected: 0 hata. (Not: FunnelEvents delegation-only; singleton'lar inject edilemediği için unit test yerine cihaz testinde doğrulanır — Task 8.)

- [ ] **Step 4: Commit**

```bash
cd qulov2
git add lib/core/services/funnel_events.dart lib/core/services/analytics_events.dart
git commit -m "feat(funnel): FunnelEvents hibrit logger + Faz 1 event sabitleri"
```

---

## Task 2: Dil seçimini pre-auth local sakla + auth sonrası flush

**Files:**
- Create: `qulov2/lib/core/services/pending_languages_store.dart`
- Test: `qulov2/test/core/services/pending_languages_store_test.dart`
- Modify: `qulov2/lib/features/onboarding/mixins/onboarding_screen_mixin.dart` (`onStart` — `userLanguagesProvider.save()` yerine store'a yaz)
- Modify: `qulov2/lib/app.dart` (auth-transition listener'a flush ekle, ~satır 50-58)

**Interfaces:**
- Produces:
  - `PendingLanguagesStore.write(List<String> languages) → Future<void>`
  - `PendingLanguagesStore.read() → Future<List<String>>` (boşsa `[]`)
  - `PendingLanguagesStore.clear() → Future<void>`
- Consumes (flush): `ref.read(userRepositoryProvider).setUserLanguages(List<String>)` (mevcut, `PUT /users/me/languages`).

- [ ] **Step 1: Failing test yaz**

`qulov2/test/core/services/pending_languages_store_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qulo_v2/core/services/pending_languages_store.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('read boş liste döner (hiç yazılmamışsa)', () async {
    expect(await PendingLanguagesStore.read(), isEmpty);
  });

  test('write sonrası read aynı listeyi döner', () async {
    await PendingLanguagesStore.write(['tr', 'en']);
    expect(await PendingLanguagesStore.read(), ['tr', 'en']);
  });

  test('clear pending diller siler', () async {
    await PendingLanguagesStore.write(['de']);
    await PendingLanguagesStore.clear();
    expect(await PendingLanguagesStore.read(), isEmpty);
  });

  test('boş liste yazımı read tarafında boş döner', () async {
    await PendingLanguagesStore.write([]);
    expect(await PendingLanguagesStore.read(), isEmpty);
  });
}
```

- [ ] **Step 2: Test'i çalıştır, fail ettiğini doğrula**

Run: `cd qulov2 && flutter test test/core/services/pending_languages_store_test.dart`
Expected: FAIL — "PendingLanguagesStore not defined" / dosya yok.

- [ ] **Step 3: PendingLanguagesStore'u oluştur**

`qulov2/lib/core/services/pending_languages_store.dart`:

```dart
import 'package:shared_preferences/shared_preferences.dart';

/// Onboarding carousel AUTH ONCESI gosterildiginden, dil secimi authenticated
/// `PUT /users/me/languages` endpoint'ine gonderilemez (401). Secim burada
/// local tutulur; ilk basarili auth'ta [app.dart] listener'i flush eder.
abstract final class PendingLanguagesStore {
  static const _key = 'pending_languages';

  static Future<void> write(List<String> languages) async {
    final prefs = await SharedPreferences.getInstance();
    if (languages.isEmpty) {
      await prefs.remove(_key);
      return;
    }
    await prefs.setStringList(_key, languages);
  }

  static Future<List<String>> read() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? const [];
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
```

- [ ] **Step 4: Test'i çalıştır, geçtiğini doğrula**

Run: `cd qulov2 && flutter test test/core/services/pending_languages_store_test.dart`
Expected: PASS (4 test).

- [ ] **Step 5: Carousel onStart'ı store'a yazacak şekilde değiştir**

`onboarding_screen_mixin.dart` `onStart()` (~satır 106-116). Mevcut:
```dart
    ref.read(userLanguagesProvider.notifier).save(selectedLanguages);
    _showPremiumSuggestion();
```
Yerine (paywall Task 6'da kaldırılacak; burada sadece dil satırını değiştir):
```dart
    // Auth oncesi: secimi local sakla, auth sonrasi app.dart flush eder.
    PendingLanguagesStore.write(selectedLanguages);
    _showPremiumSuggestion();
```
Import ekle: `import 'package:qulo_v2/core/services/pending_languages_store.dart';`
Not: `userLanguagesProvider` importu başka yerde kullanılmıyorsa kaldır (loop refactor — `flutter analyze` unused import uyarısını takip et).

- [ ] **Step 6: app.dart auth-transition listener'ına flush ekle**

`app.dart` ~satır 50-58 mevcut listener'ın içine (locale push'un yanına):
```dart
    ref.listenManual<AuthState>(authProvider, (prev, next) {
      final wasAuthenticated = prev?.status == AuthStatus.authenticated;
      if (next.status == AuthStatus.authenticated && !wasAuthenticated) {
        final code = ref.read(localeProvider).languageCode;
        unawaited(ref.read(userRepositoryProvider).updateProfile({'locale': code}));
        ref.read(pageMessagesProvider.notifier).fetch();
        // Faz 1: onboarding'de (pre-auth) secilen dilleri flush et.
        unawaited(_flushPendingLanguages(ref));
      }
    });
```
Aynı dosyada (app.dart) yardımcı fonksiyon (top-level veya sınıf metodu, mevcut yapıya uygun şekilde):
```dart
Future<void> _flushPendingLanguages(WidgetRef ref) async {
  final pending = await PendingLanguagesStore.read();
  if (pending.isEmpty) return;
  final result = await ref.read(userRepositoryProvider).setUserLanguages(pending);
  result.when(
    success: (_) => PendingLanguagesStore.clear(),
    failure: (_) {}, // basarisizsa key kalir, sonraki auth'ta tekrar denenir
  );
}
```
Import ekle: `import 'package:qulo_v2/core/services/pending_languages_store.dart';` (ve `Result`/`when` için gerekli importlar zaten varsa dokunma).
Not: `ref` tipi app.dart'taki mevcut listener bağlamına göre `WidgetRef`/`Ref` olabilir — mevcut `ref.read` kullanımıyla aynı tipi kullan.

- [ ] **Step 7: flutter analyze**

Run: `cd qulov2 && flutter analyze`
Expected: 0 hata (unused import kalmadı).

- [ ] **Step 8: Commit**

```bash
cd qulov2
git add lib/core/services/pending_languages_store.dart test/core/services/pending_languages_store_test.dart lib/features/onboarding/mixins/onboarding_screen_mixin.dart lib/app.dart
git commit -m "feat(onboarding): dil secimini pre-auth local sakla + auth sonrasi flush"
```

---

## Task 3: Carousel'i auth öncesine al (OnboardingSeenNotifier + router guard)

**Files:**
- Create: `qulov2/lib/providers/onboarding_seen_provider.dart`
- Test: `qulov2/test/providers/onboarding_seen_provider_test.dart`
- Modify: `qulov2/lib/main.dart` (SharedPreferences preload + ProviderScope override)
- Modify: `qulov2/lib/routing/app_router.dart` (redirect guard + `_AuthNotifierListenable`)
- Modify: `qulov2/lib/routing/app_routes.dart` (`_MainShell` `_checkOnboarding` push'unu kaldır)

**Interfaces:**
- Produces:
  - `onboardingSeenProvider` (`NotifierProvider<OnboardingSeenNotifier, bool>`).
  - `OnboardingSeenNotifier.markSeen() → Future<void>` (flag'i `true` yapar + prefs yazar).
  - `onboardingSeenPrefsProvider` (`Provider<SharedPreferences>`) — main.dart override ile inject, senkron ilk-frame okuması için.
- Consumes: SharedPreferences key `onboarding_v2_seen` (MEVCUT — geçmişte carousel görmüş kullanıcı tekrar görmez).

- [ ] **Step 1: Failing test yaz**

`qulov2/test/providers/onboarding_seen_provider_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qulo_v2/providers/onboarding_seen_provider.dart';

void main() {
  test('prefs true ise initial state true (senkron okuma)', () async {
    SharedPreferences.setMockInitialValues({'onboarding_v2_seen': true});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(overrides: [
      onboardingSeenPrefsProvider.overrideWithValue(prefs),
    ]);
    addTearDown(container.dispose);
    expect(container.read(onboardingSeenProvider), isTrue);
  });

  test('prefs boş ise initial state false', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(overrides: [
      onboardingSeenPrefsProvider.overrideWithValue(prefs),
    ]);
    addTearDown(container.dispose);
    expect(container.read(onboardingSeenProvider), isFalse);
  });

  test('markSeen state true yapar ve prefs yazar', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(overrides: [
      onboardingSeenPrefsProvider.overrideWithValue(prefs),
    ]);
    addTearDown(container.dispose);
    await container.read(onboardingSeenProvider.notifier).markSeen();
    expect(container.read(onboardingSeenProvider), isTrue);
    expect(prefs.getBool('onboarding_v2_seen'), isTrue);
  });
}
```

- [ ] **Step 2: Test'i çalıştır, fail ettiğini doğrula**

Run: `cd qulov2 && flutter test test/providers/onboarding_seen_provider_test.dart`
Expected: FAIL — provider tanımlı değil.

- [ ] **Step 3: OnboardingSeenNotifier'ı oluştur (senkron prefs okuması)**

`qulov2/lib/providers/onboarding_seen_provider.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// main.dart'ta preload edilmis SharedPreferences — router redirect ILK FRAME'de
/// senkron okuyabilsin diye override ile inject edilir.
final onboardingSeenPrefsProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('main.dart override etmeli'),
);

/// Onboarding carousel'in gorulup gorulmedigini senkron tutar. Router auth-oncesi
/// guard'i bunu `ref.read` ile okur. Key mevcut `onboarding_v2_seen` — gecmiste
/// carousel gormus kullanici tekrar gormez.
class OnboardingSeenNotifier extends Notifier<bool> {
  static const key = 'onboarding_v2_seen';

  @override
  bool build() {
    final prefs = ref.read(onboardingSeenPrefsProvider);
    return prefs.getBool(key) ?? false;
  }

  Future<void> markSeen() async {
    state = true;
    final prefs = ref.read(onboardingSeenPrefsProvider);
    await prefs.setBool(key, true);
    await prefs.setBool('onboarding_questions_seen', true); // legacy tutarlilik
  }
}

final onboardingSeenProvider =
    NotifierProvider<OnboardingSeenNotifier, bool>(OnboardingSeenNotifier.new);
```

- [ ] **Step 4: Test'i çalıştır, geçtiğini doğrula**

Run: `cd qulov2 && flutter test test/providers/onboarding_seen_provider_test.dart`
Expected: PASS (3 test).

- [ ] **Step 5: main.dart'ta SharedPreferences preload + override**

`main.dart` — `runApp`'ten önce (mevcut manager init zinciri, ~satır 25-28 civarı) prefs preload et:
```dart
  final prefs = await SharedPreferences.getInstance();
```
Ve `runApp` içindeki `ProviderScope`'a override ekle (~satır 36):
```dart
  runApp(
    ProviderScope(
      overrides: [
        onboardingSeenPrefsProvider.overrideWithValue(prefs),
      ],
      child: const QuloApp(),
    ),
  );
```
Import ekle: `import 'package:shared_preferences/shared_preferences.dart';` ve `import 'package:qulo_v2/providers/onboarding_seen_provider.dart';`

- [ ] **Step 6: Router'a onboarding guard + listenable ekle**

`app_router.dart` — `_AuthNotifierListenable` (~satır 64-68) onboarding flag'ini de dinlesin:
```dart
class _AuthNotifierListenable extends ChangeNotifier {
  _AuthNotifierListenable(Ref ref) {
    ref.listen<AuthState>(authProvider, (_, __) => notifyListeners());
    ref.listen<bool>(onboardingSeenProvider, (_, __) => notifyListeners());
  }
}
```
`redirect` içine — `initial` beklemesinden (satır 85) SONRA, `!isAuth → login` bloğundan (satır 122) ÖNCE ekle:
```dart
        // Faz 1: onboarding carousel AUTH ONCESI. Gorulmemisse ve auth degilse
        // carousel'e yonlendir (auth/legal/update route'lari haric).
        final onboardingSeen = ref.read(onboardingSeenProvider);
        final isOnboardingRoute = state.matchedLocation == '/onboarding';
        if (!isAuth &&
            !onboardingSeen &&
            !isOnboardingRoute &&
            !isAuthRoute &&
            !isUpdateRoute &&
            !isLegalRoute) {
          return '/onboarding';
        }
```
Import ekle: `import 'package:qulo_v2/providers/onboarding_seen_provider.dart';` (app_router.dart veya part dosyası uygun olan yere).
Not: `/onboarding` route'u `app_routes.dart`'ta zaten root navigator'da tam ekran var — değiştirme.

- [ ] **Step 7: Onboarding tamamlanınca markSeen çağır + eski trigger'ı kaldır**

`onboarding_screen_mixin.dart` `_markSeen()` (~satır 133-137) doğrudan prefs yazıyor; bunu notifier'a yönlendir (router'ın haberdar olması + refresh için):
```dart
  Future<void> _markSeen() async {
    await ref.read(onboardingSeenProvider.notifier).markSeen();
  }
```
Import ekle: `import 'package:qulo_v2/providers/onboarding_seen_provider.dart';`

`app_routes.dart` — `_MainShellState`'teki `_checkOnboarding()` çağrısını ve metodunu **kaldır** (initState'ten `_checkOnboarding()` satırını ve metod gövdesini sil). Carousel artık auth öncesi router guard'ından açılıyor; çift gösterimi önle. `initState`'te başka iş yoksa `super.initState()` kalsın.

- [ ] **Step 8: flutter analyze**

Run: `cd qulov2 && flutter analyze`
Expected: 0 hata (kaldırılan `_checkOnboarding` sonrası kullanılmayan import/SharedPreferences varsa temizle — loop refactor).

- [ ] **Step 9: Cihaz doğrulaması (deferred — Task 8 E2E'de)**

Not: Router redirect + ilk-frame senkron okuma davranışı widget/cihaz testinden çok gerçek akışta doğrulanır (Task 8). Bu task'ın otomatik kanıtı: notifier unit testleri (Step 4) + `flutter analyze`.

- [ ] **Step 10: Commit**

```bash
cd qulov2
git add lib/providers/onboarding_seen_provider.dart test/providers/onboarding_seen_provider_test.dart lib/main.dart lib/routing/app_router.dart lib/routing/app_routes.dart lib/features/onboarding/mixins/onboarding_screen_mixin.dart
git commit -m "feat(onboarding): carousel'i auth oncesine al (router guard + senkron seen notifier)"
```

---

## Task 4: SocialAuthMixin extraction (loop refactor)

**Files:**
- Create: `qulov2/lib/features/auth/mixins/social_auth_mixin.dart`
- Modify: `qulov2/lib/features/auth/mixins/login_screen_mixin.dart` (`socialLogin` + `_errorCodeOf`'u mixin'e devret)

**Interfaces:**
- Produces:
  - `mixin SocialAuthMixin<T extends StatefulWidget> on ConsumerState<T>, LoadingMixin<T>`
  - `SocialAuthMixin.socialLogin(String provider) → Future<void>`
  - Abstract: `void onSocialAuthError(String errorCode)` (ekran kendi hata state'ini set eder).
  - `String? errorCodeOf(AppFailure failure)` (paylaşılan).
- Consumes: `ref.read(authProvider.notifier).socialLogin(provider)` (mevcut).

- [ ] **Step 1: SocialAuthMixin'i oluştur**

`qulov2/lib/features/auth/mixins/social_auth_mixin.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/mixins/loading_mixin.dart';
import 'package:qulo_v2/core/error/app_failure.dart';
import 'package:qulo_v2/providers/auth_provider.dart';

/// Social login (Google/Apple) davranisini login VE landing ekranlarinda
/// paylasir. Ekrana ozgu hata gosterimi [onSocialAuthError] ile delege edilir.
mixin SocialAuthMixin<T extends StatefulWidget>
    on ConsumerState<T>, LoadingMixin<T> {
  void onSocialAuthError(String errorCode);

  String? errorCodeOf(AppFailure failure) => switch (failure) {
        ServerFailure(:final code) => code,
        NetworkFailure() => 'NETWORK_ERROR',
        TimeoutFailure() => 'TIMEOUT',
        _ => null,
      };

  Future<void> socialLogin(String provider) => withLoading(() async {
        final result =
            await ref.read(authProvider.notifier).socialLogin(provider);
        if (!mounted) return;
        result.when(
          success: (_) {},
          failure: (f) {
            if (f.message?.contains('cancelled') == true) return;
            final code = errorCodeOf(f);
            if (code != null) onSocialAuthError(code);
          },
        );
      });
}
```
Not: import yolları mevcut projedeki gerçek yollara göre düzelt (`app_failure.dart`, `loading_mixin.dart`, `auth_provider.dart` — `login_screen_mixin.dart`'taki mevcut importlardan birebir kopyala).

- [ ] **Step 2: LoginScreenMixin'i SocialAuthMixin kullanacak şekilde refactor et**

`login_screen_mixin.dart`:
- `on` zincirine ekle: `SocialAuthMixin<LoginScreen>` (mevcut: `ConsumerState<LoginScreen>, FormMixin<LoginScreen>, LoadingMixin<LoginScreen>` → sonuna `, SocialAuthMixin<LoginScreen>`).
- Mixin içindeki `socialLogin(...)` metodunu (satır 97-112) ve `_errorCodeOf(...)` (satır 74-79) **kaldır** (artık SocialAuthMixin'den geliyor).
- Ekranın hata gösterimi için `onSocialAuthError` implement et:
```dart
  @override
  void onSocialAuthError(String errorCode) {
    setState(() => loginError = context.l10n.errorMessage(errorCode));
  }
```
- Eski `socialLogin` içindeki `setState(() => loginError = null)` davranışını korumak için: SocialAuthMixin `socialLogin` başında error temizlemiyor. Login'de her denemede eski hatayı temizlemek istiyorsan `onSocialAuthError` yeterli (yeni hata set ediyor); temiz başlangıç için `withLoading` çağrısı öncesi login ekranına özel bir override gerekmiyor — mevcut UX (hata yeni denemede güncellenir) korunur. `import 'package:qulo_v2/features/auth/mixins/social_auth_mixin.dart';` ekle.

- [ ] **Step 3: flutter analyze**

Run: `cd qulov2 && flutter analyze`
Expected: 0 hata. `login_screen.dart:135` `socialLogin('google')` çağrısı hâlâ derlenir (metod artık mixin'den).

- [ ] **Step 4: Cihaz doğrulaması (deferred — Task 8)**: login ekranından Google/Apple hâlâ çalışmalı. Otomatik kanıt: `flutter analyze` (imza uyumu).

- [ ] **Step 5: Commit**

```bash
cd qulov2
git add lib/features/auth/mixins/social_auth_mixin.dart lib/features/auth/mixins/login_screen_mixin.dart
git commit -m "refactor(auth): socialLogin'i paylasilan SocialAuthMixin'e cikar"
```

---

## Task 5: AuthLandingScreen + route + redirect hedefi + l10n

**Files:**
- Create: `qulov2/lib/features/auth/screens/auth_landing_screen.dart`
- Create: `qulov2/lib/features/auth/mixins/auth_landing_mixin.dart`
- Modify: `qulov2/lib/routing/route_names.dart` (`authLanding` sabiti)
- Modify: `qulov2/lib/routing/app_routes.dart` (`/auth/landing` GoRoute)
- Modify: `qulov2/lib/routing/app_router.dart` (redirect: `!isAuth → /auth/landing`; guard'lar landing'i auth-route sayar)
- Modify: `qulov2/lib/core/l10n/translations/*.dart` (16 dosya — landing key'leri)

**Interfaces:**
- Consumes: `SocialAuthMixin.socialLogin(provider)`, `SocialLoginButtons` (mevcut), `navigationServiceProvider.push(RouteNames.login)`, `FunnelEvents.logPreAuth`.
- Produces: `RouteNames.authLanding = 'auth-landing'`, route `/auth/landing`.

- [ ] **Step 1: l10n key'lerini 16 dile ekle**

Her `qulov2/lib/core/l10n/translations/<code>.dart` dosyasına ekle (min en+tr dolu, diğerleri en fallback — ama spec 16 dil ister; her dosyaya uygun çeviri ekle). Örnek `tr.dart`:
```dart
  'auth_landing_title': 'Qulo\'ya hoş geldin',
  'auth_landing_subtitle': 'Doğru soruları soran biriyle eşleş.',
  'auth_landing_continue_email': 'E-posta ile devam et',
```
`en.dart`:
```dart
  'auth_landing_title': 'Welcome to Qulo',
  'auth_landing_subtitle': 'Match with someone who asks the right questions.',
  'auth_landing_continue_email': 'Continue with email',
```
Google/Apple buton metinleri: mevcut social key'leri varsa (`continue_with_google` vb.) `SocialLoginButtons` zaten kullanıyordur — yeni key ekleme, mevcut widget'ın metinlerini koru. Diğer 14 dile `auth_landing_*` üç key'i uygun çeviriyle ekle (bkz. mevcut `first_match_congrats`'ın 16 dilde nasıl eklendiği — birebir aynı dizilim).

- [ ] **Step 2: AuthLandingMixin'i oluştur**

`qulov2/lib/features/auth/mixins/auth_landing_mixin.dart`:

```dart
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/mixins/loading_mixin.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/navigation/navigation.dart';
import 'package:qulo_v2/core/services/funnel_events.dart';
import 'package:qulo_v2/core/services/analytics_events.dart';
import 'package:qulo_v2/features/auth/mixins/social_auth_mixin.dart';
import 'package:qulo_v2/features/auth/screens/auth_landing_screen.dart';
import 'package:qulo_v2/routing/route_names.dart';

mixin AuthLandingMixin on ConsumerState<AuthLandingScreen>, LoadingMixin<AuthLandingScreen>, SocialAuthMixin<AuthLandingScreen> {
  String? landingError;

  void initMixin() {
    FunnelEvents.logPreAuth(AnalyticsEvents.authLandingView);
  }

  void disposeMixin() {}

  @override
  void onSocialAuthError(String errorCode) {
    setState(() => landingError = context.l10n.errorMessage(errorCode));
  }

  void onGoogle() {
    FunnelEvents.logPreAuth(
      AnalyticsEvents.authLandingSocialSelected,
      params: {AnalyticsEvents.paramProvider: 'google'},
    );
    socialLogin('google');
  }

  void onApple() {
    FunnelEvents.logPreAuth(
      AnalyticsEvents.authLandingSocialSelected,
      params: {AnalyticsEvents.paramProvider: 'apple'},
    );
    socialLogin('apple');
  }

  void onEmail() {
    FunnelEvents.logPreAuth(AnalyticsEvents.authLandingEmailSelected);
    ref.read(navigationServiceProvider).push(RouteNames.login);
  }
}
```
Not: importlar (`l10n.dart`, `navigation.dart`, `loading_mixin.dart`) gerçek proje yollarıyla eşleşmeli — `login_screen_mixin.dart`'tan kopyala.

- [ ] **Step 3: AuthLandingScreen'i oluştur (ince, AppScaffold)**

`qulov2/lib/features/auth/screens/auth_landing_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/mixins/loading_mixin.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/widgets/app_scaffold.dart';
import 'package:qulo_v2/features/auth/mixins/auth_landing_mixin.dart';
import 'package:qulo_v2/features/auth/mixins/social_auth_mixin.dart';
import 'package:qulo_v2/features/auth/widgets/social_login_buttons.dart';

class AuthLandingScreen extends ConsumerStatefulWidget {
  const AuthLandingScreen({super.key});

  @override
  ConsumerState<AuthLandingScreen> createState() => _AuthLandingScreenState();
}

class _AuthLandingScreenState extends ConsumerState<AuthLandingScreen>
    with LoadingMixin<AuthLandingScreen>, SocialAuthMixin<AuthLandingScreen>, AuthLandingMixin {
  @override
  void initState() {
    super.initState();
    initMixin();
  }

  @override
  void dispose() {
    disposeMixin();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBackButton: false,
      isLoading: isLoading,
      body: AuthLandingBody(
        title: context.tr('auth_landing_title'),
        subtitle: context.tr('auth_landing_subtitle'),
        continueEmailLabel: context.tr('auth_landing_continue_email'),
        error: landingError,
        socialButtons: SocialLoginButtons(
          isLoading: isLoading,
          onGooglePressed: onGoogle,
          onApplePressed: onApple,
        ),
        onEmail: onEmail,
      ),
    );
  }
}
```
`AuthLandingBody`'yi ayrı widget dosyasına yaz (screen ≤200 satır + `Widget _buildX` yasağı): `qulov2/lib/features/auth/widgets/auth_landing_body.dart` — marka başlığı (Text `title`/`subtitle` theme style'larıyla), `socialButtons`, `error != null` ise inline kırmızı hata (mevcut inline error pattern'i — login ekranındaki hata gösterimini örnek al), `AppButton`/mevcut buton komponentiyle `onEmail` CTA. Hardcode renk/style YOK — theme'den. `CircularProgressIndicator` YOK.

- [ ] **Step 4: Route sabiti + GoRoute ekle**

`route_names.dart` Auth grubuna:
```dart
  static const authLanding = 'auth-landing';
```
`app_routes.dart` — `/auth/login` GoRoute'unun kardeşi olarak (üstüne) ekle:
```dart
GoRoute(
  path: '/auth/landing',
  name: RouteNames.authLanding,
  pageBuilder: (context, state) => CustomTransitionPage(
    key: state.pageKey,
    child: const AuthLandingScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
    transitionDuration: const Duration(milliseconds: 500),
  ),
),
```
Import: `import 'package:qulo_v2/features/auth/screens/auth_landing_screen.dart';` (app_routes.dart part'ının importlarına).

- [ ] **Step 5: Redirect hedefini landing yap**

`app_router.dart` redirect — `!isAuth → login` bloğu (satır 122-124) hedefini landing yap:
```dart
        if (!isAuth && !isAuthRoute && !isUpdateRoute) {
          return '/auth/landing';
        }
```
Not: `isAuthRoute = state.matchedLocation.startsWith('/auth')` olduğundan `/auth/landing` zaten auth-route sayılır (döngü olmaz). Pending deep-link bloğundaki (satır 118) `return '/auth/login'` ve invite bloğu login'de kalabilir (deep-link kullanıcıyı doğrudan login'e alır — kabul; landing'e almak istersen aynı şekilde değiştir, ama YAGNI: sadece ana giriş landing).

- [ ] **Step 6: flutter analyze**

Run: `cd qulov2 && flutter analyze`
Expected: 0 hata.

- [ ] **Step 7: Cihaz doğrulaması (deferred — Task 8)**: fresh install → carousel → landing → Google/Apple/email üç yol.

- [ ] **Step 8: Commit**

```bash
cd qulov2
git add lib/features/auth/screens/auth_landing_screen.dart lib/features/auth/mixins/auth_landing_mixin.dart lib/features/auth/widgets/auth_landing_body.dart lib/routing/route_names.dart lib/routing/app_routes.dart lib/routing/app_router.dart lib/core/l10n/translations/
git commit -m "feat(auth): social-first landing ekrani + route + 16 dil l10n"
```

---

## Task 6: Paywall'ı ilk eşleşmeye ertele

**Files:**
- Modify: `qulov2/lib/features/onboarding/mixins/onboarding_screen_mixin.dart` (`_showPremiumSuggestion` çağrısını kaldır)
- Modify: `qulov2/lib/features/quiz/mixins/quiz_screen_mixin.dart` (`onStartChat`/`onGoBack` → first-match paywall)

**Interfaces:**
- Consumes: `navigationServiceProvider.showAppBottomSheet(CustomBottomSheet(...PremiumSuggestionSheet...))` (mevcut pattern), SharedPreferences flag `AnalyticsEvents.flagPaywallFirstMatch`, `FunnelEvents.logAuthed`.
- Produces: `_maybeShowFirstMatchPaywall({required String nextRoute}) → Future<void>` (quiz_screen_mixin private).

- [ ] **Step 1: Carousel sonundan paywall'ı kaldır**

`onboarding_screen_mixin.dart` `onStart()` (~satır 106-116) — `_showPremiumSuggestion();` satırını **kaldır**. Ardından `_markSeen()` + dil write sonrası doğrudan discover'a değil, router zaten auth öncesi olduğundan `onStart` sadece flag + dil yazar ve carousel kapanır (router landing'e alır). Mevcut `_showPremiumSuggestion` metodunu ve onun `.then((_) => nav.go(discover))` gövdesini **kaldır** (artık çağrılmıyor — ölü kod bırakma, loop refactor). `PremiumSuggestionSheet` import'u onboarding mixin'de başka yerde kullanılmıyorsa kaldır.

Not: Carousel artık auth öncesi olduğu için `onStart` sonrası hedef, router guard'ının doğal sonucudur (onboardingSeen=true → landing). `onStart` içinde `nav.go(discover)` KALMAMALI (auth yok). Eğer mevcut skip yolu (`onSkip`) `nav.go(discover)` yapıyorsa onu da kaldır — `markSeen` sonrası router otomatik landing'e alır. Skip/başla sonrası yalnızca `markSeen` (+başla'da dil write) yeterli; explicit navigation kaldırılır.

- [ ] **Step 2: quiz_screen_mixin'e first-match paywall helper ekle**

`quiz_screen_mixin.dart` — `onStartChat` (~satır 381) ve `onGoBack` (~satır 387) mevcut. Değiştir:

```dart
void onStartChat() {
  ref.invalidate(matchListProvider);
  _maybeShowFirstMatchPaywall(nextRoute: RouteNames.matches);
}

void onGoBack() {
  if (celebrationMatched) {
    _maybeShowFirstMatchPaywall(nextRoute: RouteNames.discover);
  } else {
    ref.read(navigationServiceProvider).go(RouteNames.discover);
  }
}
```
Yeni metod (aynı mixin içine):
```dart
Future<void> _maybeShowFirstMatchPaywall({required String nextRoute}) async {
  final nav = ref.read(navigationServiceProvider);
  final prefs = await SharedPreferences.getInstance();
  final shown = prefs.getBool(AnalyticsEvents.flagPaywallFirstMatch) ?? false;
  if (shown) {
    nav.go(nextRoute);
    return;
  }
  await prefs.setBool(AnalyticsEvents.flagPaywallFirstMatch, true);
  FunnelEvents.logAuthed(
    AnalyticsEvents.paywallShown,
    params: {AnalyticsEvents.paramTrigger: 'first_match'},
  );
  if (!mounted) return;
  nav.showAppBottomSheet(
    CustomBottomSheet(
      name: 'premium_suggestion',
      maxHeightFactor: 0.85,
      builder: (context) => const PremiumSuggestionSheet(),
    ),
  ).then((_) {
    if (mounted) nav.go(nextRoute);
  });
}
```
Import ekle: `shared_preferences`, `funnel_events.dart`, `analytics_events.dart`, `PremiumSuggestionSheet` (`features/onboarding/widgets/premium_suggestion_sheet.dart`), `CustomBottomSheet` (navigation). `RouteNames`, `navigationServiceProvider`, `matchListProvider` zaten kullanılıyor.

**AppReview çakışması:** Mevcut `onStartChat`/`onGoBack` içindeki `AppReviewManager.instance.tryShowReview(trigger: 'match_celebration')` çağrısı varsa — first-match paywall gösterildiği turda review'ı ATLA (aynı anda iki modal açma). En temizi: `_maybeShowFirstMatchPaywall` içinde paywall gösterildiyse review çağrısı yapılmaz; flag zaten true iken (ikinci+ match) mevcut review davranışı korunur. Uygulama: review çağrısını `_maybeShowFirstMatchPaywall`'ın `shown==true` dalına taşı, ya da onStartChat/onGoBack'te review'ı paywall gösterilmediyse çağır. Mevcut kodun review çağrısını buna göre düzenle (celebration'ı bozmadan).

- [ ] **Step 3: flutter analyze**

Run: `cd qulov2 && flutter analyze`
Expected: 0 hata (onboarding'de ölü kod/unused import kalmadı).

- [ ] **Step 4: Cihaz doğrulaması (deferred — Task 8)**: ilk eşleşme celebration → çıkışta paywall bir kez; ikinci eşleşmede paywall yok.

- [ ] **Step 5: Commit**

```bash
cd qulov2
git add lib/features/onboarding/mixins/onboarding_screen_mixin.dart lib/features/quiz/mixins/quiz_screen_mixin.dart
git commit -m "feat(paywall): carousel sonu paywall'i ilk eslesme celebration cikisina ertele"
```

---

## Task 7: Funnel event yerleşimleri (carousel, register, first-*)

**Files:**
- Modify: `qulov2/lib/features/onboarding/mixins/onboarding_screen_mixin.dart` (carousel page view + skip)
- Modify: `qulov2/lib/features/auth/screens/register_screen.dart` (onPageChanged → step view)
- Modify: `qulov2/lib/features/discover/mixins/discover_screen_mixin.dart` (first_discover_view)
- Modify: `qulov2/lib/features/quiz/mixins/quiz_screen_mixin.dart` (first_quiz_complete)

**Interfaces:**
- Consumes: `FunnelEvents.logPreAuth`, `FunnelEvents.logAuthedOnce`, `AnalyticsEvents.*` (Task 1).

- [ ] **Step 1: Carousel page view + skip event'leri**

`onboarding_screen_mixin.dart` — PageView `onPageChanged` (carousel sayfa değişimi; mixin'de sayfa index/isim state'i var, `_pageNames` satır 17-23). Sayfa değişince:
```dart
FunnelEvents.logPreAuth(
  AnalyticsEvents.onboardingV2PageView,
  params: {
    AnalyticsEvents.paramPageIndex: index,
    AnalyticsEvents.paramPageName: _pageNames[index],
  },
);
```
`onSkip()` içine (mevcut ~satır 97-104):
```dart
FunnelEvents.logPreAuth(
  AnalyticsEvents.onboardingV2Skip,
  params: {AnalyticsEvents.paramStepIndex: currentPageIndex},
);
```
`onStart` içindeki mevcut `onboardingV2Complete`/`onboardingV2LanguagesSelected` `logEvent` çağrılarını `FunnelEvents.logPreAuth`'a çevir (pre-auth tutarlılığı; Firebase'de aynı, kod niyeti açık). Import: `funnel_events.dart`.

- [ ] **Step 2: Register step view event'i**

`register_screen.dart` `onPageChanged` (~satır 68-70):
```dart
onPageChanged: (index) {
  setState(() => currentStep = index);
  FunnelEvents.logPreAuth(
    AnalyticsEvents.onboardingStepView,
    params: {AnalyticsEvents.paramStepIndex: index},
  );
},
```
Import: `funnel_events.dart` + `analytics_events.dart`. (Register akışı auth öncesi → logPreAuth.)

- [ ] **Step 3: first_discover_view event'i**

`discover_screen_mixin.dart` `initMixin()` (~satır 19-23), mevcut `discoverSessionStart` yanına:
```dart
FunnelEvents.logAuthedOnce(
  AnalyticsEvents.flagFirstDiscoverView,
  AnalyticsEvents.firstDiscoverView,
);
```
Import: `funnel_events.dart`. (Discover auth sonrası → logAuthedOnce, server flow_events'e bir kez.)

- [ ] **Step 4: first_quiz_complete event'i**

`quiz_screen_mixin.dart` — quiz complete noktası (mevcut `quizComplete` logEvent, ~satır 219/318). Yanına:
```dart
FunnelEvents.logAuthedOnce(
  AnalyticsEvents.flagFirstQuizComplete,
  AnalyticsEvents.firstQuizComplete,
  params: {AnalyticsEvents.paramMatched: matched},
);
```
Not: `paramMatched` yoksa `{'matched': matched}` yerine mevcut bir param key kullan ya da paramsız bırak. `matched` bool → `Map<String,Object>` uyumlu. Import zaten var (Task 6).

- [ ] **Step 5: flutter analyze**

Run: `cd qulov2 && flutter analyze`
Expected: 0 hata.

- [ ] **Step 6: Commit**

```bash
cd qulov2
git add lib/features/onboarding/mixins/onboarding_screen_mixin.dart lib/features/auth/screens/register_screen.dart lib/features/discover/mixins/discover_screen_mixin.dart lib/features/quiz/mixins/quiz_screen_mixin.dart
git commit -m "feat(funnel): carousel/register/first-* funnel event yerlesimleri"
```

---

## Task 8: i18n tamlığı + /flutter-review + E2E cihaz testi

**Files:**
- Verify: `qulov2/lib/core/l10n/translations/*.dart` (16 dilde `auth_landing_*` key'leri)
- No new code (review + doğrulama task'ı)

- [ ] **Step 1: i18n eksik key taraması**

Run:
```bash
cd qulov2
for k in auth_landing_title auth_landing_subtitle auth_landing_continue_email; do
  echo "=== $k ==="; grep -L "$k" lib/core/l10n/translations/*.dart
done
```
Expected: her key için `grep -L` boş (hiçbir dosya key'i eksik değil). Eksik varsa o dile ekle.

- [ ] **Step 2: flutter analyze (final)**

Run: `cd qulov2 && flutter analyze`
Expected: 0 hata.

- [ ] **Step 3: Unit testleri çalıştır**

Run: `cd qulov2 && flutter test test/core/services/pending_languages_store_test.dart test/providers/onboarding_seen_provider_test.dart`
Expected: tüm testler PASS.

- [ ] **Step 4: /flutter-review çalıştır**

Skill: `/flutter-review` — dokunulan dosyaları incele (screen ≤200 satır, mixin, AppScaffold, hardcode yok, reuse). Çıkan bulguları aynı PR'da düzelt (loop refactor).

- [ ] **Step 5: E2E cihaz testi (manuel — talimat kullanıcıya verilir)**

Fresh install (veya `onboarding_v2_seen` + `pending_languages` + `paywall_after_first_match_shown` prefs temizle) sonrası:
1. Splash → **carousel açılır (auth ÖNCESİ)**. 5 sayfa ilerle, sayfa 5'te dil seç, "Başla".
2. **Landing ekranı** açılır (Google/Apple/E-posta). Firebase DebugView'da `auth_landing_view`, `onboarding_v2_page_view` (x5), `onboarding_v2_complete` görünür.
3. **Google/Apple** ile giriş → profile-completion/setup gate → discover. Auth sonrası: dil tercihi backend'e yazıldı mı? (`GET /users/me/languages` = carousel'de seçilen). Server `flow_events` tablosunda `first_discover_view` düştü mü?
4. Bir quiz'i tüm sorular doğru çöz → **MatchCelebrationScreen** → çıkış (Start Chat / Go Back) → **premium paywall sheet bir kez** açılır. `flow_events`'te `paywall_shown` (trigger=first_match) + `first_quiz_complete`.
5. İkinci bir eşleşme yap → **paywall AÇILMAZ** (flag).
6. "E-posta ile devam" yolu: landing → login → register (7 adım). Firebase'de `auth_landing_email_selected`, `onboarding_step_view` (register adımları).

Kontrol noktaları: Firebase DebugView (pre-auth event'ler) + Supabase `flow_events` tablosu SQL (`select event_name, count(*) from flow_events where created_at > now() - interval '1 hour' group by 1`) — post-auth event'ler düştü.

- [ ] **Step 6: Faz Log + sürüm hazırlığı (plan sonrası)**

Plan bitince ana session: roadmap Faz 1 checkbox'larını işaretle + Faz Log satırı ekle; 2.0.6 build (`/deploy-testflight` qulov2 scoped) TestFlight.

---

## Self-Review (yazım sonrası)

**Spec coverage:**
- 1.1 funnel events → Task 1 (helper+sabit) + Task 7 (yerleşim) + Task 5/6 (landing/paywall event'leri). ✓
- 1.2 social-first → Task 4 (SocialAuthMixin) + Task 5 (landing). ✓
- 1.3 carousel pre-auth + dil persist → Task 2 (dil store+flush) + Task 3 (router guard+notifier). ✓
- 1.4 paywall defer → Task 6. ✓
- Değişmez kurallar (l10n 16 dil, mixin, AppScaffold, flutter analyze) → Task 5 (l10n) + Task 8 (review). ✓

**Placeholder:** "add appropriate error handling" vb. yok; her kod adımı gerçek kod içeriyor. Cihaz-doğrulama adımları (UI/router) bilinçli — bu parçalar unit test yerine E2E'de doğrulanır (Task 8), gerekçe belirtildi.

**Type tutarlılığı:** `FunnelEvents.logPreAuth/logAuthed/logAuthedOnce`, `PendingLanguagesStore.write/read/clear`, `OnboardingSeenNotifier.markSeen` + `onboardingSeenPrefsProvider`, `SocialAuthMixin.socialLogin/onSocialAuthError/errorCodeOf`, `_maybeShowFirstMatchPaywall({required String nextRoute})` — task'lar arası imzalar tutarlı.

**Açık nokta (kabul):** analytics_events.dart'taki bazı mevcut sabit adları (ör. `paramMatched`) executor tarafından dosyada doğrulanmalı; yoksa paramsız/uygun key kullanılır (Task 7 Step 4'te not edildi). Register/carousel'deki `currentPageIndex`/`_pageNames` gibi mevcut alan adları executor tarafından dosyadan teyit edilir.
