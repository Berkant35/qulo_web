# Supabase Auth — Google + Apple Sign In

**Tarih:** 2026-03-26
**Proje:** tabul/ (Flutter mobil uygulama)
**Durum:** Onaylandı

---

## Özet

Tabul uygulamasına Google Sign In ve Apple Sign In eklenmesi. Mevcut Supabase Auth altyapısı korunarak, Supabase native OAuth provider desteği kullanılacak.

## Mevcut Durum

- Auth: Supabase Email/Password (PKCE flow)
- Service: `SupabaseAuthService` → `AuthRepo` → `AuthCubit`
- Firebase: Sadece Analytics, Crashlytics, Remote Config (auth yok)
- Bundle ID (iOS): `com.socrepho.tabul`
- Package (Android): `com.socrepho.tabul`
- Firebase Project: `tabul-bd6aa`

## Mimari

```
UI (Social Login Butonları) → AuthCubit → AuthRepo → SupabaseAuthService → Supabase OAuth
```

Mevcut auth akışı korunur. Ek olarak `signInWithGoogle()` ve `signInWithApple()` metodları eklenir.

## Bileşenler

### 1. Supabase Dashboard Konfigürasyonu

**Google Provider:**
- Google Cloud Console'da OAuth 2.0 Client ID oluştur (Web Application tipi)
- Client ID ve Client Secret'ı Supabase Dashboard → Authentication → Providers → Google'a ekle
- Authorized redirect URI: `https://iymsedniejfbtjtagzda.supabase.co/auth/v1/callback`

**Apple Provider:**
- Apple Developer → Certificates, Identifiers & Profiles → Service IDs → yeni Service ID oluştur
- Sign in with Apple capability ekle
- Key oluştur (Sign in with Apple seçili)
- Supabase Dashboard → Authentication → Providers → Apple'a Service ID, Team ID, Key ID ve Private Key ekle

### 2. Platform Konfigürasyonu

**pubspec.yaml:**
```yaml
google_sign_in: ^6.2.1
sign_in_with_apple: ^6.1.3
crypto: ^3.0.3  # Apple Sign In nonce hash için
```

**iOS — Info.plist:**
```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>$(REVERSED_CLIENT_ID)</string>
    </array>
  </dict>
</array>
```

**iOS — Runner.entitlements:**
```xml
<key>com.apple.developer.applesignin</key>
<array>
  <string>Default</string>
</array>
```

**Android — google-services.json:**
- Firebase Console'dan OAuth client ekle (SHA-1 fingerprint ile)
- Veya Google Cloud Console'dan Android OAuth Client ID oluştur

### 3. SupabaseAuthService Genişleme

İki yeni metod:

**signInWithGoogle():**
1. `GoogleSignIn().signIn()` ile native Google popup aç
2. `idToken` ve `accessToken` al
3. `Supabase.instance.client.auth.signInWithIdToken(provider: OAuthProvider.google, idToken: idToken, accessToken: accessToken)` çağır
4. Supabase session otomatik oluşur

**signInWithApple():**
1. Random nonce oluştur, SHA-256 hash'le
2. `SignInWithApple.getAppleIDCredential(scopes: [email, fullName], nonce: hashedNonce)` ile native Apple popup aç
3. `identityToken` al
4. `Supabase.instance.client.auth.signInWithIdToken(provider: OAuthProvider.apple, idToken: identityToken, nonce: rawNonce)` çağır
5. Supabase session otomatik oluşur

### 4. AuthRepo Genişleme

```dart
Future<Either<Failure, AuthResponse>> signInWithGoogle();
Future<Either<Failure, AuthResponse>> signInWithApple();
```

Mevcut `Either<Failure, Data>` pattern'i korunur.

### 5. AuthCubit Genişleme

```dart
Future<void> signInWithGoogle();
Future<void> signInWithApple();
```

State'ler: `AuthLoading` → `AuthSuccess` / `AuthError` (mevcut state'ler)

### 6. Auth UI Güncelleme

`landing_bottom_sheet_page.dart` veya `sign_in_body.dart`'a:
- "Google ile Devam Et" butonu
- "Apple ile Devam Et" butonu (sadece iOS'ta göster)
- Mevcut email/password formundan bir divider ile ayrılmış

## Veri Akışı

```
Kullanıcı "Google ile Giriş" tıklar
  → Native Google Sign In popup açılır
  → Kullanıcı hesap seçer
  → idToken + accessToken alınır
  → Supabase.auth.signInWithIdToken() çağrılır
  → Supabase session oluşur
  → Mevcut checkCurrentSession() logic'i devam eder
  → Ana sayfaya yönlendirilir
```

## Hata Yönetimi

| Senaryo | Davranış |
|---------|----------|
| Kullanıcı popup'ı iptal etti | Sessizce geri dön (state değişikliği yok) |
| Network hatası | Mevcut `Failure` pattern'i ile hata mesajı göster |
| Aynı email farklı provider | Supabase otomatik account linking yapar |
| Token expired/invalid | Retry veya hata mesajı |

## Kapsam Dışı

- Firebase Auth migration yok
- Account linking/unlinking UI yok
- Mevcut kullanıcıların social login'e migration'ı yok
- Social login ile kayıt olmuş kullanıcıya şifre ekleme UI'ı yok

## Gerekli Console İşlemleri (Manuel)

1. **Google Cloud Console:** OAuth 2.0 Client ID oluştur (Web + iOS + Android)
2. **Apple Developer:** Service ID + Key oluştur
3. **Supabase Dashboard:** Google ve Apple provider'ları aktif et, credential'ları gir
4. **Firebase Console:** SHA-1 fingerprint ile Android OAuth client ekle (opsiyonel)
