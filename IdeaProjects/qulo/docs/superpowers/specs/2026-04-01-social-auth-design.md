# Social Authentication (Google Sign-In & Apple Sign-In) — Tasarım Dokümanı

**Tarih:** 2026-04-01
**Branch:** APP-1915
**Kapsam:** Server (qulo-server) + Flutter (qulov2) + Supabase Migration

---

## 1. Özet

Qulo dating app'e Google Sign-In ve Apple Sign-In entegrasyonu. Mevcut email/password auth sisteminin yanına sosyal login ekleniyor. Kendi JWT sistemi korunuyor — sosyal provider'lar sadece kimlik doğrulama kaynağı olarak kullanılıyor.

---

## 2. Kararlar

| Konu | Karar |
|------|-------|
| Buton yerleşimi | Email formunun altında "veya" ayırıcısıyla |
| Aynı email çakışması | Otomatik hesap bağlama (provider_id eklenir) |
| Apple Hide My Email | Relay email kabul, provider_id (sub) ile bağlama |
| Profil bilgileri | Google/Apple'dan isim al, eksik alanlar için onboarding |
| 18 yaş kontrolü | Doğum tarihi zorunlu, null ise uygulama kullandırma |
| Ayarlardan bağlama | MVP'de yok, sadece giriş ekranında |
| Token verify | Kendi server'ında (Google/Apple API ile verify → kendi JWT dön) |

---

## 3. Server API

### 3.1 Yeni Endpoint: `POST /api/v1/auth/social-login`

**Request Body:**
```json
{
  "provider": "google" | "apple",
  "id_token": "string",
  "name": "string (optional)",
  "surname": "string (optional)",
  "nonce": "string (optional, Apple için)"
}
```

**Akış:**
1. `id_token`'ı provider'a göre verify et:
   - Google → `google-auth-library` ile `verifyIdToken()`, `aud` = web/ios/android client ID'lerinden biri
   - Apple → JWT verify, `aud` = Bundle ID, `iss` = `https://appleid.apple.com`, nonce doğrulama
2. Token'dan `email` ve `provider_id` (sub claim) çıkar
3. Her iki provider'da `iat` (issued at) 5 dakikadan eski → reddet
4. DB'de ara:
   - **Case A:** `provider_id` ile eşleşen kullanıcı var → login (JWT pair dön)
   - **Case B:** Aynı `email` ile mevcut kullanıcı var → `provider_id` ekle (hesap bağla) → login
   - **Case C:** Hiç yok → yeni kayıt oluştur (isim Google/Apple'dan, age/gender null) → JWT pair dön
5. `profileIncomplete` flag'i: `age == null` ise `true`

**Response:**
```json
{
  "accessToken": "...",
  "refreshToken": "...",
  "userId": "...",
  "profileIncomplete": true | false
}
```

### 3.2 Yeni Endpoint: `POST /api/v1/users/complete-profile`

**Request Body:**
```json
{
  "birthday": "2000-01-15",
  "gender": "MAN" | "WOMAN" | "OTHER",
  "lat": 41.0082 (optional),
  "lng": 28.9784 (optional)
}
```

**Akış:**
1. Birthday'den yaş hesapla → 18 altı ise reddet (hesabı sil + hata dön)
2. `users` tablosunda age, gender, lat, lng güncelle
3. `profileIncomplete` artık false

### 3.3 Token Doğrulama Detayları

**Google:**
- Paket: `google-auth-library`
- `verifyIdToken({ idToken, audience: [WEB_ID, IOS_ID, ANDROID_ID] })`
- Payload'dan: `sub` (provider_id), `email`, `email_verified`, `name`, `given_name`, `family_name`

**Apple:**
- Apple public key fetch → JWT signature verify
- Claims kontrol: `iss` = `https://appleid.apple.com`, `aud` = Bundle ID
- Nonce: client'ın gönderdiği nonce'ın SHA-256 hash'i token'daki `nonce` claim ile eşleşmeli
- Payload'dan: `sub` (provider_id), `email` (ilk login'de gelir)

---

## 4. Veritabanı Değişiklikleri

### 4.1 Migration: `users` tablosu

```sql
-- auth_provider kolonu
ALTER TABLE users ADD COLUMN auth_provider TEXT NOT NULL DEFAULT 'email';

-- provider_id kolonu (Google sub / Apple sub)
ALTER TABLE users ADD COLUMN provider_id TEXT UNIQUE;

-- password_hash nullable (sosyal login kullanıcılarının şifresi yok)
ALTER TABLE users ALTER COLUMN password_hash DROP NOT NULL;
```

### 4.2 Mevcut Login Koruması

Email/password login endpoint'inde kontrol:
- `auth_provider != 'email'` ve `password_hash IS NULL` → "Bu hesap sosyal login ile oluşturulmuş, Google/Apple ile giriş yapın" hatası

---

## 5. Flutter Tarafı

### 5.1 Yeni Paketler
- `google_sign_in` — Google ID token almak için
- `sign_in_with_apple` — Apple ID token almak için

### 5.2 Login Ekranı (`login_screen.dart`)
- Mevcut email/password formunun altına:
  - "veya" divider widget'ı
  - "Google ile Giriş Yap" butonu (Google branded)
  - "Apple ile Giriş Yap" butonu (Apple branded, **sadece iOS'ta** göster)

### 5.3 Yeni Service: `social_auth_service.dart`
```dart
class SocialAuthService {
  Future<GoogleSignInResult> signInWithGoogle();  // → id_token, name, surname
  Future<AppleSignInResult> signInWithApple();    // → id_token, name, surname, nonce
}
```

### 5.4 Auth Service Ek Endpoint (`auth_service.dart`)
```dart
@POST('/auth/social-login')
Future<SocialLoginResponse> socialLogin(@Body() SocialLoginRequest request);
```

### 5.5 Auth Provider Değişiklikleri (`auth_provider.dart`)
Yeni metod: `socialLogin(String provider)`:
1. `SocialAuthService` ile Google/Apple akışını başlat → ID token al
2. `AuthService.socialLogin()` ile server'a gönder
3. JWT token'ları `FlutterSecureStorage`'a kaydet
4. `profileIncomplete == true` → profil tamamlama ekranına yönlendir
5. `profileIncomplete == false` → normal login akışı (user fetch, providers init, discover'a git)

### 5.6 Yeni Ekran: `profile_completion_screen.dart`
- 3 adımlı PageView — mevcut register widget'larını reuse:
  - `RegisterStepBirthday` → doğum tarihi (18+ kontrol)
  - `RegisterStepGender` → cinsiyet seçimi
  - `RegisterStepLocation` → konum (opsiyonel)
- Tamamlanınca `POST /users/complete-profile` çağır
- Başarılı → normal login akışına devam (user fetch, providers init, discover)

### 5.7 Router Değişiklikleri (`app_router.dart`)
- `checkAuth()` → profil fetch → `age == null` ise `/profile-completion`'a redirect
- Profil tamamlanmadan başka route'a gitmeyi engelle

---

## 6. Güvenlik Katmanları

### 6.1 Token Doğrulama
- Google: `aud` claim bizim 3 client ID'den biri olmalı
- Apple: `aud` = Bundle ID, `iss` = `https://appleid.apple.com`, nonce doğrulama
- Her ikisi: `iat` 5 dakikadan eski → reddet
- Her ikisi: `exp` kontrolü

### 6.2 Rate Limiting
- `/auth/social-login`: **5 req/dk/IP** (mevcut authLimiter'dan agresif)
- Aynı `provider_id` ile: **1 req/dk** (token replay engeli)

### 6.3 Profil Tamamlanmamış Middleware (`profileGuard`)
- `age == null` olan kullanıcılar için endpoint kısıtlaması:
  - **Açık:** `/users/complete-profile`, `/users/me`, `/auth/logout`, `/auth/refresh`
  - **Bloklu:** discover, match, diamond, power, question ve diğer tüm endpoint'ler

### 6.4 Ekonomi Koruması
- Yeni sosyal kayıt sonrası **elmas işlemleri 24 saat kilitli**
- `created_at` kontrolü ile enforce edilecek
- Bot'ların fake hesap açıp elmas transferi engellenecek

### 6.5 Edge Case Korumaları

| Edge Case | Çözüm |
|-----------|-------|
| Token replay attack | `iat` 5dk kontrolü + provider_id rate limit |
| Sahte token | Server-side verify (asla client'a güvenme) |
| Email değiştirme saldırısı | Hesap bağlama provider_id bazlı, email sadece ilk eşleştirmede |
| Apple relay email | Email eşleşmezse yeni hesap, provider_id ile bağlama |
| Apple ilk login sonrası bilgi kaybı | İlk login'de isim/email mutlaka DB'ye kaydet |
| Aynı provider ile çoklu hesap | `provider_id` UNIQUE constraint |
| Profil tamamlanmadan API erişimi | `profileGuard` middleware |

---

## 7. Platform Setup (Implementasyon Sonunda)

### 7.1 Google Cloud Console

1. Google Cloud Console → mevcut Firebase projesini seç
2. APIs & Services → Credentials → OAuth 2.0 Client IDs:
   - **iOS Client:** Bundle ID: `com.wordpress.calikusuberkant.qulorelease`
   - **Android Client:** Package: `com.wordpress.calikusuberkant.qulo` + SHA-1 fingerprint
   - **Web Client:** Server token verify için (Firebase ile oluşmuş olabilir)
3. OAuth Consent Screen → External → Yayınla
4. SHA-1 fingerprint alma:
   ```bash
   keytool -list -v -keystore android/app/cp-upload-keystore.jks
   ```
5. Railway env'e ekle:
   - `GOOGLE_CLIENT_ID_WEB`
   - `GOOGLE_CLIENT_ID_IOS`
   - `GOOGLE_CLIENT_ID_ANDROID`

### 7.2 Apple Developer Portal

1. Certificates, Identifiers & Profiles → Identifiers → App ID seç
2. Capabilities → **Sign In with Apple** aktifle
3. Keys → Create Key → "Sign In with Apple" → Primary App ID seç → `.p8` indir + Key ID kaydet
4. Xcode → Runner → Signing & Capabilities → "Sign In with Apple" ekle
5. Railway env'e ekle:
   - `APPLE_BUNDLE_ID` = `com.wordpress.calikusuberkant.qulorelease`
   - `APPLE_TEAM_ID` = `5W2U3NK284`
   - `APPLE_KEY_ID` = (key ID)
   - `APPLE_PRIVATE_KEY` = (.p8 içeriği)

### 7.3 Android Ek Ayarlar

- `android/app/build.gradle` → minSdkVersion 21+ kontrol
- SHA-1 fingerprint'i Google Cloud Console'da Android client'a ekle

---

## 8. Kapsam Dışı (MVP Sonrası)

- Ayarlardan Google/Apple hesap bağlama
- Facebook, X (Twitter) gibi ek provider'lar
- Sosyal login ile gelen kullanıcının şifre oluşturma özelliği
- Account unlinking (bağlı hesabı çözme)
