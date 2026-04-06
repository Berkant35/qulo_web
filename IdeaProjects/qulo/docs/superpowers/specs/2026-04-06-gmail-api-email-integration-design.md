# Gmail API Email Entegrasyonu — Design Spec

**Tarih:** 2026-04-06
**Branch:** APP-1915
**Durum:** Onaylandı

## Problem

Railway hosting platformu outbound SMTP portlarını (587/465) blokluyor. Mevcut Nodemailer + SMTP transport çalışmıyor. Email verification ve password reset gönderimleri aktif değil.

## Çözüm

SMTP transport yerine **Google Gmail API (HTTP tabanlı)** kullanarak email gönderimi. Port kısıtlamasından etkilenmez.

## Kararlar

| Karar | Seçim | Neden |
|-------|-------|-------|
| Email provider | Gmail API (googleapis) | HTTP tabanlı, Railway port sorunu yok, ücretsiz |
| From adresi | info@socrepho.com | Mevcut Workspace hesabı, üst marka |
| Auth yöntemi | Service Account + Domain-wide delegation | Server-to-server, token yönetimi otomatik |
| Web redirect domain | quloapp.com | Netlify'da aktif, reset-password sayfası hazır |

## Mimari

### Mevcut (çalışmıyor)
```
qulo-server → Nodemailer → SMTP (587) → Gmail ❌ (port bloklu)
```

### Yeni
```
qulo-server → googleapis → Gmail API (HTTPS/443) → Gmail ✅
```

## Kod Değişiklikleri

### 1. Email Gönderim Katmanı

**Dosya:** `src/utils/email.ts`

- SMTP transport kaldırılır
- Gmail API client eklenir (googleapis)
- `sendMail()` fonksiyonu Gmail API üzerinden gönderim yapar
- RFC 2822 formatında email oluşturulur (base64url encoded)
- Mevcut template sistemi (`email-base.html` + locale JSON'lar) aynen kalır

**Dosya:** `src/services/email.service.ts`

- Support ticket reply email'i de Gmail API'ye geçirilir
- Aynı gmail client kullanılır

### 2. Config Değişiklikleri

**Dosya:** `src/config/env.ts`

Kaldırılacak env vars:
```
SMTP_HOST
SMTP_PORT
SMTP_USER
SMTP_PASS
```

Yeni env vars:
```
GOOGLE_SERVICE_ACCOUNT_KEY  — Service Account JSON key (stringified)
EMAIL_FROM                  — Gönderici adresi (default: info@socrepho.com)
```

`SMTP_FROM` → `EMAIL_FROM` olarak rename (SMTP bağımlılığını kaldır).

### 3. Package Değişiklikleri

```
+ googleapis (Gmail API client)
- nodemailer (artık gerekli değil)
- @types/nodemailer
```

`resend` paketi de kullanılmıyorsa kaldırılabilir.

## Token TTL (Güvenlik İyileştirmesi)

### DB Migration

`users` tablosuna yeni kolon:
```sql
ALTER TABLE users ADD COLUMN token_expires_at TIMESTAMPTZ;
```

### Token Süreleri

| İşlem | TTL | Açıklama |
|-------|-----|----------|
| Email verification | 24 saat | Kayıt sonrası doğrulama |
| Password reset | 1 saat | Şifre sıfırlama |

### Kontrol Noktaları

- `verifyEmail()`: token + `token_expires_at > NOW()` kontrolü
- `resetPassword()`: token + `token_expires_at > NOW()` kontrolü
- Expired token → kullanıcıya "link süresi dolmuş" mesajı

## Email Verification → quloapp.com Redirect

### Mevcut Akış
```
GET /api/v1/auth/verify-email?token=... → HTML sayfası döner (API üzerinde)
```

### Yeni Akış
```
GET /api/v1/auth/verify-email?token=...
  → Success: 302 redirect → quloapp.com/{locale}/email-verified?status=success
  → Expired: 302 redirect → quloapp.com/{locale}/email-verified?status=expired
  → Invalid: 302 redirect → quloapp.com/{locale}/email-verified?status=error
```

### Web Sayfası (Yeni)

**Route:** `/[locale]/email-verified/page.tsx`

- `status` query param'a göre 3 durum:
  - `success`: "Email doğrulandı, uygulamaya dönebilirsin"
  - `expired`: "Link süresi dolmuş, tekrar dene"
  - `error`: "Geçersiz link"
- Deep link butonu: uygulamaya yönlendirme (varsa)

## Rate Limiting

| Endpoint | Limit | Pencere |
|----------|-------|---------|
| POST /forgot-password | 3 istek | 5 dakika (aynı email) |
| POST /register (verification email) | 3 istek | 5 dakika (aynı email) |

Mevcut rate limiter middleware kullanılır, endpoint bazlı config eklenir.

## Google Cloud Kurulum Adımları

1. **Google Cloud Console** → Yeni proje oluştur (veya mevcut "Qulo" projesi)
2. **APIs & Services** → Gmail API'yi aktifle
3. **IAM & Admin** → Service Accounts → Yeni service account oluştur
4. **Keys** → JSON key oluştur ve indir
5. **Google Workspace Admin Console** → Security → API Controls → Domain-wide delegation
   - Service Account client ID ekle
   - Scope: `https://www.googleapis.com/auth/gmail.send`
6. **Railway** → Environment Variables:
   - `GOOGLE_SERVICE_ACCOUNT_KEY` = JSON key içeriği (stringify)
   - `EMAIL_FROM` = `info@socrepho.com`

## Akış Diyagramları

### Email Verification
```
Kayıt (POST /register)
  → Server: token üret + hash'le + token_expires_at = NOW() + 24h
  → Gmail API: verification email gönder
  → Link: {APP_URL}/api/v1/auth/verify-email?token=...
  → Kullanıcı tıklar
  → Server: token doğrula + expiry kontrol
  → 302 redirect → quloapp.com/{locale}/email-verified?status=success
```

### Password Reset
```
Forgot (POST /forgot-password)
  → Rate limit kontrolü
  → Server: token üret + hash'le + token_expires_at = NOW() + 1h
  → Gmail API: reset email gönder
  → Link: quloapp.com/{locale}/reset-password?token=...
  → Kullanıcı yeni şifre girer
  → POST /reset-password → token + expiry doğrula → şifre güncelle
  → Tüm refresh token'lar silinir
```

## Error Handling

| Durum | Davranış |
|-------|---------|
| Gmail API quota aşımı (günlük) | Log error, retry 1x, fail gracefully |
| Service account auth hatası | Log critical, email gönderilmez, API 200 döner |
| Geçersiz token | Web sayfasında error mesajı |
| Expired token | Web sayfasında expired mesajı + "tekrar gönder" CTA |
| Rate limit aşımı | 429 Too Many Requests |

## Scope

### Dahil
- Gmail API entegrasyonu (SMTP → HTTP geçişi)
- Token TTL (DB migration + kontrol)
- Email verified redirect (API → quloapp.com)
- Web: email-verified sayfası
- Rate limiting (forgot-password)
- Google Cloud kurulum rehberi

### Hariç
- SPF/DKIM DNS kayıtları (kullanıcı sayısı artınca)
- Email queue/retry sistemi (gerekirse sonra)
- Email gönderim logları (DB)
- Bounce/complaint tracking
- `noreply@quloapp.com` gibi custom domain (sonra)
