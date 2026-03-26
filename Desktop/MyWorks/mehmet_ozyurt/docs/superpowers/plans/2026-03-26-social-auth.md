# Social Auth (Google + Apple Sign In) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Tabul uygulamasına Supabase Auth üzerinden Google Sign In ve Apple Sign In eklemek.

**Architecture:** Mevcut `SupabaseAuthService` → `AuthRepo` → `AuthCubit` katman yapısı korunur. Native Google/Apple SDK'lar ile token alınır, `Supabase.auth.signInWithIdToken()` ile Supabase session oluşturulur. UI'da `LandingIdle` sayfasına social login butonları eklenir.

**Tech Stack:** `google_sign_in: ^6.2.1`, `sign_in_with_apple: ^6.1.3`, `crypto: ^3.0.6`, Supabase Auth native OAuth providers

---

## Dosya Haritası

| İşlem | Dosya | Sorumluluk |
|-------|-------|------------|
| Modify | `pubspec.yaml` | Yeni paketler ekle |
| Modify | `ios/Runner/Info.plist` | Google URL scheme ekle |
| Create | `ios/Runner/Runner.entitlements` | Apple Sign In capability |
| Create | `ios/Runner/RunnerDebug.entitlements` | Apple Sign In capability (debug) |
| Modify | `ios/Runner.xcodeproj/project.pbxproj` | Entitlements referansı |
| Modify | `.env` | Google iOS Client ID ekle |
| Modify | `lib/core/service/supabase/supabase_auth_service.dart` | `signInWithGoogle()` ve `signInWithApple()` metodları |
| Modify | `lib/feature/auth/data/repo/auth_repo.dart` | Yeni metodları delegasyon |
| Modify | `lib/feature/auth/bloc/cubit/auth_cubit.dart` | Social login cubit metodları |
| Create | `lib/feature/auth/view/widgets/social_login_buttons.dart` | Google/Apple buton widget'ları |
| Modify | `lib/feature/auth/view/landing_idle_body.dart` | Social butonları landing sayfasına ekle |
| Modify | `lib/l10n/intl_tr.arb` | Yeni lokalizasyon key'leri |
| Modify | `lib/l10n/intl_en.arb` | Yeni lokalizasyon key'leri (EN) |

---

## Ön Koşul: Console Konfigürasyonları (Manuel)

Bu adımlar kod yazmadan önce tamamlanmalıdır:

### Google Cloud Console
1. https://console.cloud.google.com → Proje: `tabul-bd6aa`
2. APIs & Services → Credentials → Create Credentials → OAuth 2.0 Client ID
3. **Web Application** tipi oluştur:
   - Name: `Tabul Supabase`
   - Authorized redirect URI: `https://vdizifjaynrkuypeanke.supabase.co/auth/v1/callback`
   - Client ID ve Client Secret'ı not al
4. **iOS** tipi oluştur:
   - Bundle ID: `com.socrepho.tabul`
   - Client ID'yi not al (`.env`'ye `GOOGLE_IOS_CLIENT_ID` olarak eklenecek)
5. **Android** tipi oluştur (varsa kontrol et):
   - Package: `com.socrepho.tabul`
   - SHA-1 fingerprint: `keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android`

### Supabase Dashboard
1. https://supabase.com/dashboard → Proje: `vdizifjaynrkuypeanke`
2. Authentication → Providers → Google:
   - Enable: ON
   - Client ID: (Web Application'dan aldığın)
   - Client Secret: (Web Application'dan aldığın)
3. Authentication → Providers → Apple:
   - Enable: ON
   - (Apple Developer'dan alınacak bilgiler aşağıda)

### Apple Developer
1. https://developer.apple.com → Certificates, Identifiers & Profiles
2. Identifiers → App ID `com.socrepho.tabul` → Sign in with Apple capability etkinleştir
3. Keys → Create Key → "Sign in with Apple" seç → Key ID ve `.p8` dosyasını indir
4. Supabase Dashboard → Apple provider'a:
   - Service ID (veya Bundle ID): `com.socrepho.tabul`
   - Team ID: (Apple Developer üyelik sayfasından)
   - Key ID: (oluşturduğun key'den)
   - Private Key: (`.p8` dosyasının içeriği)

---

### Task 1: Paket Bağımlılıkları

**Files:**
- Modify: `tabul/pubspec.yaml`

- [ ] **Step 1: pubspec.yaml'a yeni paketleri ekle**

`tabul/pubspec.yaml` dosyasında `dependencies:` bloğuna ekle (mevcut `supabase_flutter` satırının altına):

```yaml
  google_sign_in: ^6.2.1
  sign_in_with_apple: ^6.1.3
  crypto: ^3.0.6
```

- [ ] **Step 2: Paketleri indir**

Run: `cd tabul && flutter pub get`
Expected: `Got dependencies!` mesajı, hata yok

- [ ] **Step 3: Commit**

```bash
git add tabul/pubspec.yaml tabul/pubspec.lock
git commit -m "feat(auth): add google_sign_in, sign_in_with_apple, crypto packages"
```

---

### Task 2: Lokalizasyon Key'leri

**Files:**
- Modify: `tabul/lib/l10n/intl_tr.arb`
- Modify: `tabul/lib/l10n/intl_en.arb`

- [ ] **Step 1: intl_tr.arb'ye yeni key'leri ekle**

Dosyanın sonuna (kapanış `}` öncesine) ekle:

```json
  "continue_with_google": "Google ile devam et",
  "continue_with_apple": "Apple ile devam et",
  "or_divider": "veya",
  "auth_error_social_cancelled": "Giriş işlemi iptal edildi",
  "auth_error_social_failed": "Sosyal giriş başarısız oldu, lütfen tekrar deneyin"
```

- [ ] **Step 2: intl_en.arb'ye aynı key'leri ekle**

```json
  "continue_with_google": "Continue with Google",
  "continue_with_apple": "Continue with Apple",
  "or_divider": "or",
  "auth_error_social_cancelled": "Sign in was cancelled",
  "auth_error_social_failed": "Social sign in failed, please try again"
```

- [ ] **Step 3: Lokalizasyon dosyalarını generate et**

Run: `cd tabul && flutter gen-l10n`
Expected: Hatasız tamamlanır

- [ ] **Step 4: Commit**

```bash
git add tabul/lib/l10n/
git commit -m "feat(auth): add social login localization keys"
```

---

### Task 3: iOS Platform Konfigürasyonu

**Files:**
- Modify: `tabul/ios/Runner/Info.plist`
- Create: `tabul/ios/Runner/Runner.entitlements`
- Create: `tabul/ios/Runner/RunnerDebug.entitlements`
- Modify: `tabul/.env`

- [ ] **Step 1: .env dosyasına Google iOS Client ID ekle**

`tabul/.env` dosyasının sonuna ekle:

```
# Google Sign In
GOOGLE_IOS_CLIENT_ID=BURAYA_GOOGLE_CLOUD_CONSOLE_DAN_ALDIGIN_IOS_CLIENT_ID
GOOGLE_IOS_CLIENT_ID_REVERSED=BURAYA_REVERSED_CLIENT_ID
```

NOT: Bu değerler Google Cloud Console'dan iOS OAuth Client ID oluşturduktan sonra güncellenecek. Reversed Client ID formatı: `com.googleusercontent.apps.XXXX`

- [ ] **Step 2: Info.plist'e Google URL scheme ekle**

`tabul/ios/Runner/Info.plist` dosyasında `</dict>` kapanış tag'ından önce ekle:

```xml
	<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>$(GOOGLE_IOS_CLIENT_ID_REVERSED)</string>
			</array>
		</dict>
	</array>
	<key>GIDClientID</key>
	<string>$(GOOGLE_IOS_CLIENT_ID)</string>
```

NOT: `$(GOOGLE_IOS_CLIENT_ID_REVERSED)` yerine gerçek reversed client ID yazılacak (ör: `com.googleusercontent.apps.630355916835-xxxxx`). Bu değer Google Cloud Console'dan iOS client oluşturduktan sonra belli olacak.

- [ ] **Step 3: Runner.entitlements dosyası oluştur**

Yeni dosya: `tabul/ios/Runner/Runner.entitlements`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>com.apple.developer.applesignin</key>
	<array>
		<string>Default</string>
	</array>
</dict>
</plist>
```

- [ ] **Step 4: RunnerDebug.entitlements dosyası oluştur**

Yeni dosya: `tabul/ios/Runner/RunnerDebug.entitlements`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>com.apple.developer.applesignin</key>
	<array>
		<string>Default</string>
	</array>
</dict>
</plist>
```

- [ ] **Step 5: Xcode project'e entitlements referansı ekle**

Bu adım Xcode üzerinden yapılmalı:
1. Xcode'da `tabul/ios/Runner.xcworkspace` aç
2. Runner target → Signing & Capabilities → "+ Capability" → "Sign in with Apple" ekle
3. Build Settings → Code Signing Entitlements:
   - Debug: `Runner/RunnerDebug.entitlements`
   - Release: `Runner/Runner.entitlements`
   - Profile: `Runner/Runner.entitlements`

Alternatif: `project.pbxproj` dosyasını elle düzenle — her build configuration'a `CODE_SIGN_ENTITLEMENTS = Runner/Runner.entitlements;` (debug için `RunnerDebug.entitlements`) satırını ekle.

- [ ] **Step 6: Commit**

```bash
git add tabul/ios/Runner/Info.plist tabul/ios/Runner/Runner.entitlements tabul/ios/Runner/RunnerDebug.entitlements tabul/.env
git commit -m "feat(auth): add iOS config for Google and Apple Sign In"
```

---

### Task 4: SupabaseAuthService — Social Login Metodları

**Files:**
- Modify: `tabul/lib/core/service/supabase/supabase_auth_service.dart`

- [ ] **Step 1: Import'ları ekle**

Dosyanın üst kısmına ekle:

```dart
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
```

- [ ] **Step 2: signInWithGoogle() metodunu ekle**

`SupabaseAuthService` sınıfına yeni metod ekle (mevcut `signInUser` metodundan sonra):

```dart
  /// Google ile giris yapar
  /// Native Google Sign In SDK ile idToken alinir,
  /// Supabase signInWithIdToken ile session olusturulur
  Future<Either<Failure, ItemDto<User>>> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn(
        clientId: dotenv.env['GOOGLE_IOS_CLIENT_ID'],
      );

      final googleUser = await googleSignIn.signIn();

      // Kullanici iptal etti
      if (googleUser == null) {
        return Left(
          Failure(
            message: S.current.error,
            code: 0,
            description: S.current.auth_error_social_cancelled,
          ),
        );
      }

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;
      final accessToken = googleAuth.accessToken;

      if (idToken == null) {
        return Left(
          Failure(
            message: S.current.error,
            code: 400,
            description: S.current.auth_error_social_failed,
          ),
        );
      }

      final response = await sAuth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      final user = response.user;
      if (user == null) {
        return Left(
          Failure(
            message: S.current.error,
            code: 400,
            description: S.current.auth_error_social_failed,
          ),
        );
      }

      return Right(ItemDto<User>(data: user));
    } catch (e) {
      myCustomLogger.e('signInWithGoogle error: $e');
      return Left(SupabaseAuthErrorHandler.handle(e));
    }
  }
```

- [ ] **Step 3: signInWithApple() metodunu ekle**

`SupabaseAuthService` sınıfına yeni metod ekle (signInWithGoogle'dan sonra):

```dart
  /// Apple ile giris yapar
  /// Native Apple Sign In ile identityToken alinir,
  /// Supabase signInWithIdToken ile session olusturulur
  Future<Either<Failure, ItemDto<User>>> signInWithApple() async {
    try {
      final rawNonce = _generateNonce();
      final hashedNonce =
          sha256.convert(utf8.encode(rawNonce)).toString();

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );

      final idToken = credential.identityToken;

      if (idToken == null) {
        return Left(
          Failure(
            message: S.current.error,
            code: 400,
            description: S.current.auth_error_social_failed,
          ),
        );
      }

      final response = await sAuth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
        nonce: rawNonce,
      );

      final user = response.user;
      if (user == null) {
        return Left(
          Failure(
            message: S.current.error,
            code: 400,
            description: S.current.auth_error_social_failed,
          ),
        );
      }

      return Right(ItemDto<User>(data: user));
    } on SignInWithAppleAuthorizationException catch (e) {
      // Kullanici iptal etti
      if (e.code == AuthorizationErrorCode.canceled) {
        return Left(
          Failure(
            message: S.current.error,
            code: 0,
            description: S.current.auth_error_social_cancelled,
          ),
        );
      }
      myCustomLogger.e('signInWithApple error: $e');
      return Left(SupabaseAuthErrorHandler.handle(e));
    } catch (e) {
      myCustomLogger.e('signInWithApple error: $e');
      return Left(SupabaseAuthErrorHandler.handle(e));
    }
  }

  /// Apple Sign In icin guvenli nonce olusturur
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }
```

- [ ] **Step 4: Compile kontrol**

Run: `cd tabul && flutter analyze lib/core/service/supabase/supabase_auth_service.dart`
Expected: Hata yok

- [ ] **Step 5: Commit**

```bash
git add tabul/lib/core/service/supabase/supabase_auth_service.dart
git commit -m "feat(auth): add signInWithGoogle and signInWithApple to SupabaseAuthService"
```

---

### Task 5: AuthRepo — Social Login Delegasyonu

**Files:**
- Modify: `tabul/lib/feature/auth/data/repo/auth_repo.dart`

- [ ] **Step 1: İki yeni metod ekle**

`AuthRepo` sınıfına ekle:

```dart
  Future<Either<Failure, ItemDto<User>>> signInWithGoogle() async {
    return SupabaseAuthService().signInWithGoogle();
  }

  Future<Either<Failure, ItemDto<User>>> signInWithApple() async {
    return SupabaseAuthService().signInWithApple();
  }
```

- [ ] **Step 2: Commit**

```bash
git add tabul/lib/feature/auth/data/repo/auth_repo.dart
git commit -m "feat(auth): add social login methods to AuthRepo"
```

---

### Task 6: AuthCubit — Social Login State Yönetimi

**Files:**
- Modify: `tabul/lib/feature/auth/bloc/cubit/auth_cubit.dart`

- [ ] **Step 1: signInWithGoogle() metodunu ekle**

`AuthCubit` sınıfına ekle (mevcut `signIn` metodundan sonra):

```dart
  /// Google ile giris yapar
  Future<void> signInWithGoogle({VoidCallback? callBack}) async {
    emit(state.copyWith(status: UIStateStatus.loading));

    final result = await _authRepo.signInWithGoogle();

    result.fold(
      (failure) {
        // Iptal durumunda sessizce geri don
        if (failure.code == 0) {
          _idleState();
          return;
        }
        emit(
          state.copyWith(
            status: UIStateStatus.error,
            failure: failure,
          ),
        );
        _showErrorDialog(failure);
        _idleState();
      },
      (response) {
        final user = response.data;
        emit(
          state.copyWith(
            status: UIStateStatus.success,
            authStatus: AuthStatus.authenticated,
            supabaseUser: user,
          ),
        );
        _setFirebaseUserProperties(user!);
        _checkAndGrantWelcomeBonus(user.id);
        callBack?.call();
      },
    );
  }
```

- [ ] **Step 2: signInWithApple() metodunu ekle**

```dart
  /// Apple ile giris yapar
  Future<void> signInWithApple({VoidCallback? callBack}) async {
    emit(state.copyWith(status: UIStateStatus.loading));

    final result = await _authRepo.signInWithApple();

    result.fold(
      (failure) {
        // Iptal durumunda sessizce geri don
        if (failure.code == 0) {
          _idleState();
          return;
        }
        emit(
          state.copyWith(
            status: UIStateStatus.error,
            failure: failure,
          ),
        );
        _showErrorDialog(failure);
        _idleState();
      },
      (response) {
        final user = response.data;
        emit(
          state.copyWith(
            status: UIStateStatus.success,
            authStatus: AuthStatus.authenticated,
            supabaseUser: user,
          ),
        );
        _setFirebaseUserProperties(user!);
        _checkAndGrantWelcomeBonus(user.id);
        callBack?.call();
      },
    );
  }
```

- [ ] **Step 3: Compile kontrol**

Run: `cd tabul && flutter analyze lib/feature/auth/bloc/cubit/auth_cubit.dart`
Expected: Hata yok

- [ ] **Step 4: Commit**

```bash
git add tabul/lib/feature/auth/bloc/cubit/auth_cubit.dart
git commit -m "feat(auth): add social login methods to AuthCubit"
```

---

### Task 7: Social Login Butonları Widget

**Files:**
- Create: `tabul/lib/feature/auth/view/widgets/social_login_buttons.dart`

- [ ] **Step 1: Widget dosyasını oluştur**

```dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tabul/core/extension/gap_extension.dart';
import 'package:tabul/core/injection/locator.dart';
import 'package:tabul/core/localization/s_proxy.dart';
import 'package:tabul/core/shared/text/app_text.dart';
import 'package:tabul/core/utils/my_colors.dart';
import 'package:tabul/feature/auth/bloc/cubit/auth_cubit.dart';
import 'package:tabul/feature/auth/bloc/cubit/landing_sheet_cubit.dart';

/// Landing sayfasinda Google ve Apple ile giris butonlari
class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _GoogleSignInButton(),
        if (Platform.isIOS) ...[
          context.gap12,
          _AppleSignInButton(),
        ],
      ],
    );
  }
}

class _GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton.icon(
        onPressed: _onPressed,
        icon: Image.asset(
          'assets/icons/google_logo.png',
          height: 24,
          width: 24,
        ),
        label: AppText.bodyMedium(
          text: S.current.continue_with_google,
        ),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(
            color: MyColors.myGrey300,
          ),
        ),
      ),
    );
  }

  void _onPressed() {
    final authCubit = locator<AuthCubit>();
    final landingCubit = locator<LandingSheetCubit>();

    authCubit.signInWithGoogle(
      callBack: () {
        landingCubit.executeAndClearAuthSuccessCallback();
      },
    );
  }
}

class _AppleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: _onPressed,
        icon: const Icon(
          Icons.apple,
          size: 24,
          color: Colors.white,
        ),
        label: AppText.bodyMedium(
          text: S.current.continue_with_apple,
          color: Colors.white,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  void _onPressed() {
    final authCubit = locator<AuthCubit>();
    final landingCubit = locator<LandingSheetCubit>();

    authCubit.signInWithApple(
      callBack: () {
        landingCubit.executeAndClearAuthSuccessCallback();
      },
    );
  }
}
```

NOT: `assets/icons/google_logo.png` dosyası gerekiyor. 24x24 Google "G" logosu. Eğer proje convention'ı SVG kullanıyorsa `flutter_svg` ile SVG versiyonu da tercih edilebilir.

- [ ] **Step 2: Google logo asset'i ekle**

Google'ın resmi brand guidelines'ından 24px Google "G" logosunu `tabul/assets/icons/google_logo.png` olarak indir ve ekle. Veya mevcut projede uygun bir asset varsa onu kullan.

- [ ] **Step 3: Commit**

```bash
git add tabul/lib/feature/auth/view/widgets/social_login_buttons.dart tabul/assets/icons/google_logo.png
git commit -m "feat(auth): add SocialLoginButtons widget with Google and Apple buttons"
```

---

### Task 8: Landing Idle Sayfasına Entegrasyon

**Files:**
- Modify: `tabul/lib/feature/auth/view/landing_idle_body.dart`

- [ ] **Step 1: Import ekle**

```dart
import 'package:tabul/feature/auth/view/widgets/social_login_buttons.dart';
```

- [ ] **Step 2: LandingIdle build metodunu güncelle**

Mevcut `Column` children'ına social butonları ve divider ekle:

```dart
  @override
  Widget build(BuildContext context) {
    final cubit = locator<LandingSheetCubit>();
    return Column(
      children: [
        const Header(),
        context.gap32,
        const SocialLoginButtons(),
        context.gap16,
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppText.bodySmall(
                text: S.current.or_divider,
                color: MyColors.myGrey500,
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        context.gap16,
        AppButton.large(
          text: S.current.login,
          onPressed: () =>
              cubit.setLandingSheetEnum(LandingSheetEnum.signInSheet),
        ),
        context.gap16,
        AppButton.large(
          text: S.current.register,
          onPressed: () =>
              cubit.setLandingSheetEnum(LandingSheetEnum.signUpSheet),
        ),
      ],
    );
  }
```

- [ ] **Step 3: Gerekli import'ları ekle**

Eksik import varsa ekle:
```dart
import 'package:tabul/core/shared/text/app_text.dart';
import 'package:tabul/core/utils/my_colors.dart';
```

- [ ] **Step 4: Compile kontrol**

Run: `cd tabul && flutter analyze lib/feature/auth/view/landing_idle_body.dart`
Expected: Hata yok

- [ ] **Step 5: Commit**

```bash
git add tabul/lib/feature/auth/view/landing_idle_body.dart
git commit -m "feat(auth): integrate social login buttons into landing page"
```

---

### Task 9: Tam Uygulama Derleme ve Doğrulama

**Files:** Tüm değişiklikler

- [ ] **Step 1: flutter analyze**

Run: `cd tabul && flutter analyze`
Expected: Hata yok (varsa düzelt)

- [ ] **Step 2: build_runner**

Run: `cd tabul && flutter pub run build_runner build --delete-conflicting-outputs`
Expected: Freezed/generated dosyalar güncellenir

- [ ] **Step 3: iOS build kontrol**

Run: `cd tabul && flutter build ios --no-codesign`
Expected: Build başarılı

- [ ] **Step 4: Android build kontrol**

Run: `cd tabul && flutter build apk --debug`
Expected: Build başarılı

- [ ] **Step 5: Final commit**

```bash
git add -A
git commit -m "feat(auth): complete Google and Apple Sign In integration"
```

---

## Test Planı (Manuel)

Console konfigürasyonları tamamlandıktan sonra:

1. **Google Sign In (iOS):**
   - Landing → "Google ile devam et" → Google hesap seçimi → Başarılı giriş → Ana sayfa
   - Landing → "Google ile devam et" → İptal → Sessizce landing'e dön

2. **Google Sign In (Android):**
   - Aynı akış Android cihazda test

3. **Apple Sign In (iOS):**
   - Landing → "Apple ile devam et" → Face ID/Touch ID → Başarılı giriş → Ana sayfa
   - Landing → "Apple ile devam et" → İptal → Sessizce landing'e dön

4. **Edge Cases:**
   - Aynı email ile farklı provider'dan giriş → Account linking kontrolü
   - Network kesintisi sırasında social login → Hata mesajı
   - AuthGuard callback'li social login → Protected route'a yönlendirme
