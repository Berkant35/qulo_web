# Social Auth (Google Sign-In & Apple Sign-In) Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Qulo dating app'e Google ve Apple sosyal login ekleyerek kullanıcıların email/şifre olmadan giriş/kayıt yapabilmesini sağlamak.

**Architecture:** Mevcut custom JWT auth korunuyor. Flutter'da `google_sign_in` ve `sign_in_with_apple` paketleri ile provider'dan ID token alınıyor → Server'da token verify edilip kendi JWT pair'i dönülüyor. Profil eksikse (age/gender null) `profileGuard` middleware ile uygulama kullanımı engelleniyor.

**Tech Stack:** Node.js/Express + `google-auth-library` + `jsonwebtoken` (Apple verify), Flutter + `google_sign_in` + `sign_in_with_apple`, Supabase PostgreSQL migration.

---

## Task 1: Supabase Migration — users tablosuna auth_provider & provider_id ekle

**Files:**
- Create: `qulo-server/supabase/migrations/014_social_auth.sql`

- [ ] **Step 1: Migration SQL dosyasını oluştur**

```sql
-- 014_social_auth.sql
-- Social authentication support: Google Sign-In & Apple Sign-In

-- auth_provider: hangi yöntemle kayıt olunduğunu belirtir
ALTER TABLE users ADD COLUMN auth_provider TEXT NOT NULL DEFAULT 'email';

-- provider_id: Google/Apple sub claim (unique identifier)
ALTER TABLE users ADD COLUMN provider_id TEXT;

-- provider_id unique olmalı (aynı sosyal hesapla çoklu kayıt engellemek için)
CREATE UNIQUE INDEX idx_users_provider_id ON users (provider_id) WHERE provider_id IS NOT NULL;

-- password_hash nullable (sosyal login kullanıcılarının şifresi yok)
ALTER TABLE users ALTER COLUMN password_hash DROP NOT NULL;
```

- [ ] **Step 2: Migration'ı Supabase'de çalıştır**

Supabase MCP tool ile SQL'i execute et. Proje ref: `vtntrtozgoyhjdvvurkj`

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add supabase/migrations/014_social_auth.sql
git commit -m "feat(db): add auth_provider and provider_id columns for social login"
```

---

## Task 2: Server — Env variables & Google/Apple verify util'leri

**Files:**
- Modify: `qulo-server/src/config/env.ts`
- Create: `qulo-server/src/utils/social-auth.ts`

**Dependencies:** `google-auth-library` npm paketi eklenmeli

- [ ] **Step 1: google-auth-library paketini ekle**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
npm install google-auth-library
```

- [ ] **Step 2: Env schema'ya sosyal auth değişkenlerini ekle**

`qulo-server/src/config/env.ts` dosyasında `envSchema`'ya şu alanları ekle:

```typescript
// Social Auth — Google
GOOGLE_CLIENT_ID_WEB: z.string().default(''),
GOOGLE_CLIENT_ID_IOS: z.string().default(''),
GOOGLE_CLIENT_ID_ANDROID: z.string().default(''),

// Social Auth — Apple
APPLE_BUNDLE_ID: z.string().default(''),
APPLE_TEAM_ID: z.string().default(''),
```

- [ ] **Step 3: social-auth.ts util dosyasını oluştur**

`qulo-server/src/utils/social-auth.ts`:

```typescript
import { OAuth2Client } from "google-auth-library";
import jwt from "jsonwebtoken";
import crypto from "crypto";
import { env } from "../config/env.js";
import { Errors } from "./errors.js";

export interface SocialAuthPayload {
  provider: "google" | "apple";
  providerId: string;
  email: string;
  name?: string;
  surname?: string;
}

// ─── Google ───

const googleClient = new OAuth2Client();

export async function verifyGoogleToken(idToken: string): Promise<SocialAuthPayload> {
  const audiences = [
    env.GOOGLE_CLIENT_ID_WEB,
    env.GOOGLE_CLIENT_ID_IOS,
    env.GOOGLE_CLIENT_ID_ANDROID,
  ].filter(Boolean);

  if (audiences.length === 0) {
    console.error("[social-auth] No Google client IDs configured");
    throw Errors.SERVER_ERROR();
  }

  const ticket = await googleClient.verifyIdToken({
    idToken,
    audience: audiences,
  });

  const payload = ticket.getPayload();
  if (!payload || !payload.sub || !payload.email) {
    throw Errors.INVALID_TOKEN();
  }

  // iat freshness check — reject tokens older than 5 minutes
  const now = Math.floor(Date.now() / 1000);
  if (payload.iat && now - payload.iat > 300) {
    throw Errors.INVALID_TOKEN();
  }

  return {
    provider: "google",
    providerId: payload.sub,
    email: payload.email,
    name: payload.given_name ?? undefined,
    surname: payload.family_name ?? undefined,
  };
}

// ─── Apple ───

interface AppleJwtPayload {
  iss: string;
  aud: string;
  exp: number;
  iat: number;
  sub: string;
  nonce?: string;
  email?: string;
}

// Apple public keys cache
let appleKeysCache: jwt.Secret | null = null;
let appleKeysCacheExpiry = 0;

async function getApplePublicKeys(): Promise<jwt.Secret> {
  const now = Date.now();
  if (appleKeysCache && now < appleKeysCacheExpiry) {
    return appleKeysCache;
  }

  const res = await fetch("https://appleid.apple.com/auth/keys");
  if (!res.ok) {
    throw Errors.SERVER_ERROR();
  }

  const jwks = await res.json();
  appleKeysCache = jwks;
  appleKeysCacheExpiry = now + 3600_000; // Cache for 1 hour
  return jwks;
}

export async function verifyAppleToken(
  idToken: string,
  nonce?: string,
): Promise<SocialAuthPayload> {
  const bundleId = env.APPLE_BUNDLE_ID;
  if (!bundleId) {
    console.error("[social-auth] APPLE_BUNDLE_ID not configured");
    throw Errors.SERVER_ERROR();
  }

  // Decode header to get kid
  const header = JSON.parse(
    Buffer.from(idToken.split(".")[0], "base64url").toString(),
  );

  // Fetch Apple public keys
  const jwks = (await getApplePublicKeys()) as { keys: Array<{ kid: string; kty: string; n: string; e: string }> };
  const key = jwks.keys.find((k: { kid: string }) => k.kid === header.kid);
  if (!key) {
    throw Errors.INVALID_TOKEN();
  }

  // Convert JWK to PEM
  const pubKey = crypto.createPublicKey({ key, format: "jwk" });

  // Verify JWT signature and claims
  let decoded: AppleJwtPayload;
  try {
    decoded = jwt.verify(idToken, pubKey, {
      algorithms: ["RS256"],
      issuer: "https://appleid.apple.com",
      audience: bundleId,
    }) as AppleJwtPayload;
  } catch {
    throw Errors.INVALID_TOKEN();
  }

  // iat freshness check
  const now = Math.floor(Date.now() / 1000);
  if (decoded.iat && now - decoded.iat > 300) {
    throw Errors.INVALID_TOKEN();
  }

  // Nonce verification
  if (nonce) {
    const expectedNonce = crypto
      .createHash("sha256")
      .update(nonce)
      .digest("hex");
    if (decoded.nonce !== expectedNonce) {
      throw Errors.INVALID_TOKEN();
    }
  }

  if (!decoded.sub) {
    throw Errors.INVALID_TOKEN();
  }

  return {
    provider: "apple",
    providerId: decoded.sub,
    email: decoded.email ?? "",
    // Apple sadece ilk authorize'da isim döner — client'tan gelecek
  };
}
```

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add src/config/env.ts src/utils/social-auth.ts package.json package-lock.json
git commit -m "feat(server): add social auth token verification utilities"
```

---

## Task 3: Server — Error tanımları & Rate limiter

**Files:**
- Modify: `qulo-server/src/utils/errors.ts`
- Modify: `qulo-server/src/middleware/rateLimit.ts`

- [ ] **Step 1: Yeni error tanımları ekle**

`qulo-server/src/utils/errors.ts` — `Errors` objesine şunları ekle:

```typescript
SOCIAL_AUTH_FAILED: () =>
  new AppError("SOCIAL_AUTH_FAILED", 401, "Social authentication failed"),

SOCIAL_ACCOUNT_EXISTS: () =>
  new AppError("SOCIAL_ACCOUNT_EXISTS", 409, "This social account is already linked to another user"),

PASSWORD_LOGIN_ONLY: () =>
  new AppError("PASSWORD_LOGIN_ONLY", 400, "This account uses email/password login"),

SOCIAL_LOGIN_ONLY: () =>
  new AppError("SOCIAL_LOGIN_ONLY", 400, "This account was created with social login. Use Google or Apple to sign in"),

PROFILE_NOT_COMPLETE: () =>
  new AppError("PROFILE_NOT_COMPLETE", 403, "Profile must be completed before accessing this feature"),

UNDERAGE_USER: () =>
  new AppError("UNDERAGE_USER", 403, "You must be at least 18 years old"),
```

- [ ] **Step 2: Social login rate limiter ekle**

`qulo-server/src/middleware/rateLimit.ts` — Mevcut `authLimiter` yanına ekle:

```typescript
export const socialAuthLimiter = rateLimit({
  windowMs: 60 * 1000, // 1 dakika
  max: 5, // 5 req/dk/IP
  standardHeaders: true,
  legacyHeaders: false,
  message: { code: "RATE_LIMITED", message: "Too many requests" },
});
```

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add src/utils/errors.ts src/middleware/rateLimit.ts
git commit -m "feat(server): add social auth errors and rate limiter"
```

---

## Task 4: Server — socialLogin service metodu

**Files:**
- Modify: `qulo-server/src/services/auth.service.ts`

- [ ] **Step 1: Import'ları ekle**

`auth.service.ts`'in başına:

```typescript
import { verifyGoogleToken, verifyAppleToken, type SocialAuthPayload } from "../utils/social-auth.js";
```

- [ ] **Step 2: socialLogin metodunu AuthService class'ına ekle**

`resetPassword` metodundan sonra, `AuthService` class'ına:

```typescript
async socialLogin(data: {
  provider: "google" | "apple";
  id_token: string;
  name?: string;
  surname?: string;
  nonce?: string;
}) {
  // 1. Token verify
  let socialPayload: SocialAuthPayload;
  try {
    if (data.provider === "google") {
      socialPayload = await verifyGoogleToken(data.id_token);
    } else {
      socialPayload = await verifyAppleToken(data.id_token, data.nonce);
    }
  } catch (err) {
    if (err instanceof AppError) throw err;
    console.error("[social-login] Token verification failed:", err);
    throw Errors.SOCIAL_AUTH_FAILED();
  }

  const email = normalizeEmail(socialPayload.email);
  const providerId = socialPayload.providerId;

  // Use name from social payload, fallback to client-provided name
  const name = socialPayload.name || data.name || "";
  const surname = socialPayload.surname || data.surname || "";

  // 2. Case A: provider_id ile eşleşen kullanıcı var → login
  const { data: existingByProvider } = await supabase
    .from("users")
    .select("id, email, is_deleted, is_banned, age")
    .eq("provider_id", providerId)
    .maybeSingle();

  if (existingByProvider) {
    if (existingByProvider.is_deleted) {
      throw Errors.INVALID_CREDENTIALS();
    }
    if (existingByProvider.is_banned) {
      throw Errors.ACCOUNT_BANNED();
    }
    return this.createSocialSession(existingByProvider.id, existingByProvider.email, existingByProvider.age);
  }

  // 3. Case B: Aynı email ile mevcut kullanıcı var → hesap bağla
  if (email) {
    const { data: existingByEmail } = await supabase
      .from("users")
      .select("id, email, is_deleted, is_banned, age, provider_id")
      .eq("email", email)
      .maybeSingle();

    if (existingByEmail) {
      if (existingByEmail.is_deleted) {
        // Soft-deleted account — hard delete and create new
        await this.hardDeleteUser(existingByEmail.id);
      } else {
        if (existingByEmail.is_banned) {
          throw Errors.ACCOUNT_BANNED();
        }
        // Link provider_id to existing account
        if (!existingByEmail.provider_id) {
          await supabase
            .from("users")
            .update({ provider_id: providerId, auth_provider: data.provider })
            .eq("id", existingByEmail.id);
        }
        return this.createSocialSession(existingByEmail.id, existingByEmail.email, existingByEmail.age);
      }
    }
  }

  // 4. Case C: Yeni kullanıcı oluştur
  const referralCode = await referralService.generateUniqueCode();

  const { data: newUser, error: insertError } = await supabase
    .from("users")
    .insert({
      email: email || `${providerId}@social.qulo.app`, // Apple relay email boş gelebilir
      name,
      surname,
      auth_provider: data.provider,
      provider_id: providerId,
      email_verified: true, // Sosyal login ile email zaten doğrulanmış
      referral_code: referralCode,
      locale: "tr",
    })
    .select("id, email, age")
    .single();

  if (insertError || !newUser) {
    console.error("[social-login] Insert user failed:", insertError?.message);
    throw Errors.SERVER_ERROR();
  }

  // Non-blocking background tasks
  consentService.recordRegistrationConsents(newUser.id).catch((err) => {
    console.error("[social-login] Failed to record consents:", err);
  });

  userLanguageService.addLanguage(newUser.id, "tr").catch((err) => {
    console.error("[social-login] Failed to add language:", err);
  });

  return this.createSocialSession(newUser.id, newUser.email, newUser.age);
}

private async createSocialSession(userId: string, email: string, age: number | null) {
  const payload = { userId, email };
  const accessToken = signAccessToken(payload);
  const refreshToken = signRefreshToken(payload);
  const refreshTokenHash = hashToken(refreshToken);

  await Promise.all([
    supabase.from("refresh_tokens").insert({
      user_id: userId,
      token_hash: refreshTokenHash,
      expires_at: getRefreshTokenExpiry(),
    }),
    supabase
      .from("users")
      .update({ last_seen_at: new Date().toISOString(), is_online: true })
      .eq("id", userId),
  ]);

  return {
    accessToken,
    refreshToken,
    userId,
    profileIncomplete: age == null,
  };
}
```

- [ ] **Step 3: login metoduna sosyal login koruması ekle**

`auth.service.ts` → `login` metodu, password check'ten **önce** (satır 140 civarı, `comparePassword` çağrısından önce):

```typescript
// Sosyal login kullanıcısı email/password ile giremez
if (!user.password_hash) {
  throw Errors.SOCIAL_LOGIN_ONLY();
}
```

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add src/services/auth.service.ts
git commit -m "feat(server): add socialLogin service method with account linking"
```

---

## Task 5: Server — Validator, Controller & Route

**Files:**
- Modify: `qulo-server/src/validators/auth.validator.ts`
- Modify: `qulo-server/src/controllers/auth.controller.ts`
- Modify: `qulo-server/src/routes/auth.routes.ts`

- [ ] **Step 1: Social login validator ekle**

`qulo-server/src/validators/auth.validator.ts` — dosyanın sonuna, `resetPasswordSchema`'dan sonra:

```typescript
export const socialLoginSchema = z.object({
  provider: z.enum(["google", "apple"]),
  id_token: z.string().min(1),
  name: z.string().optional(),
  surname: z.string().optional(),
  nonce: z.string().optional(),
});

export type SocialLoginInput = z.infer<typeof socialLoginSchema>;
```

- [ ] **Step 2: Social login controller handler ekle**

`qulo-server/src/controllers/auth.controller.ts` — dosyanın sonuna:

```typescript
export async function socialLoginHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const data = req.body as import("../validators/auth.validator.js").SocialLoginInput;
    const result = await authService.socialLogin(data);
    res.json(result);
  } catch (err) {
    next(err);
  }
}
```

- [ ] **Step 3: Route'u ekle**

`qulo-server/src/routes/auth.routes.ts` — Mevcut import'lara `socialLoginSchema` ve `socialLoginHandler` ekle, sonra route ekle:

Import satırlarına ekle:
```typescript
import { socialLoginSchema } from "../validators/auth.validator.js";
import { socialLoginHandler } from "../controllers/auth.controller.js";
import { socialAuthLimiter } from "../middleware/rateLimit.js";
```

Route'lar arasına (login'den sonra):
```typescript
router.post("/social-login", socialAuthLimiter, validate(socialLoginSchema), socialLoginHandler);
```

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add src/validators/auth.validator.ts src/controllers/auth.controller.ts src/routes/auth.routes.ts
git commit -m "feat(server): add social-login endpoint with validation and rate limiting"
```

---

## Task 6: Server — profileGuard middleware & complete-profile endpoint

**Files:**
- Create: `qulo-server/src/middleware/profileGuard.ts`
- Modify: `qulo-server/src/validators/user.validator.ts`
- Modify: `qulo-server/src/controllers/user.controller.ts`
- Modify: `qulo-server/src/services/user.service.ts`
- Modify: `qulo-server/src/routes/user.routes.ts`

- [ ] **Step 1: profileGuard middleware oluştur**

`qulo-server/src/middleware/profileGuard.ts`:

```typescript
import type { Request, Response, NextFunction } from "express";
import { supabase } from "../config/supabase.js";
import { Errors } from "../utils/errors.js";

/**
 * Profil tamamlanmamış kullanıcıların hassas endpoint'lere erişimini engeller.
 * age == null → profil tamamlanmamış demektir (sosyal login ile kayıt olmuş).
 */
export async function profileGuard(
  req: Request,
  _res: Response,
  next: NextFunction,
): Promise<void> {
  const userId = req.user?.userId;
  if (!userId) {
    return next(Errors.INVALID_TOKEN());
  }

  const { data: user } = await supabase
    .from("users")
    .select("age")
    .eq("id", userId)
    .single();

  if (!user || user.age == null) {
    return next(Errors.PROFILE_NOT_COMPLETE());
  }

  next();
}
```

- [ ] **Step 2: complete-profile validator ekle**

`qulo-server/src/validators/user.validator.ts` — dosyaya ekle:

```typescript
export const completeProfileSchema = z.object({
  birthday: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
  gender: z.enum(["MAN", "WOMAN", "OTHER"]),
  lat: z.number().min(-90).max(90).optional(),
  lng: z.number().min(-180).max(180).optional(),
});

export type CompleteProfileInput = z.infer<typeof completeProfileSchema>;
```

- [ ] **Step 3: complete-profile service metodu ekle**

`qulo-server/src/services/user.service.ts` — `UserService` class'ına ekle:

```typescript
async completeProfile(userId: string, data: {
  birthday: string;
  gender: string;
  lat?: number;
  lng?: number;
}) {
  // Birthday'den yaş hesapla
  const birthDate = new Date(data.birthday);
  const today = new Date();
  let age = today.getFullYear() - birthDate.getFullYear();
  const monthDiff = today.getMonth() - birthDate.getMonth();
  if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
    age--;
  }

  if (age < 18) {
    // 18 yaşından küçük — hesabı sil
    const { error: deleteError } = await supabase
      .from("users")
      .delete()
      .eq("id", userId);
    if (deleteError) {
      console.error("[completeProfile] Failed to delete underage user:", deleteError.message);
    }
    throw Errors.UNDERAGE_USER();
  }

  if (age > 99) {
    throw Errors.VALIDATION_ERROR({ birthday: "Invalid date of birth" });
  }

  const updateData: Record<string, unknown> = {
    age,
    gender: data.gender,
  };

  if (data.lat != null && data.lng != null) {
    updateData.lat = data.lat;
    updateData.lng = data.lng;
  }

  const { error } = await supabase
    .from("users")
    .update(updateData)
    .eq("id", userId);

  if (error) {
    console.error("[completeProfile] Update failed:", error.message);
    throw Errors.SERVER_ERROR();
  }

  // Auto-add user's default language
  await userLanguageService.addLanguage(userId, "tr").catch(() => {});

  return { age, gender: data.gender };
}
```

Dosya başına import ekle:
```typescript
import { userLanguageService } from "./user-language.service.js";
```

- [ ] **Step 4: complete-profile controller handler ekle**

`qulo-server/src/controllers/user.controller.ts` — dosya sonuna:

```typescript
export async function completeProfileHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const userId = req.user!.userId;
    const data = req.body as import("../validators/user.validator.js").CompleteProfileInput;
    const result = await userService.completeProfile(userId, data);
    res.json(result);
  } catch (err) {
    next(err);
  }
}
```

- [ ] **Step 5: Route'ları güncelle**

`qulo-server/src/routes/user.routes.ts` — Import'lara ekle:

```typescript
import { completeProfileSchema } from "../validators/user.validator.js";
import { completeProfileHandler } from "../controllers/user.controller.js";
import { profileGuard } from "../middleware/profileGuard.js";
```

`router.use(authMiddleware, generalLimiter);` satırından sonra, `router.get("/me")` satırından **önce**:

```typescript
// Profile completion — profileGuard yok çünkü bu endpoint profil tamamlamak için
router.post("/me/complete-profile", validate(completeProfileSchema), completeProfileHandler);
```

Ardından mevcut hassas route'lara `profileGuard` ekle. `router.get("/me")` ve `router.patch("/me")` satırları **hariç**, diğer route'lara profileGuard eklenmeli. En basit yaklaşım: discover, match, diamond, power, question route'larının tanımlandığı ana `index.ts` veya ilgili route dosyalarına profileGuard middleware eklemek. Ancak user.routes.ts'de sadece user route'ları var — ana route'larda profileGuard'ı central middleware olarak eklemek daha iyi.

Şimdilik `user.routes.ts` içinde boost ve diamond-affecting route'lara profileGuard ekle:

```typescript
router.post("/me/boost", profileGuard, boostHandler);
router.post("/me/claim-badge-reward", profileGuard, claimBadgeRewardHandler);
```

- [ ] **Step 6: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add src/middleware/profileGuard.ts src/validators/user.validator.ts src/controllers/user.controller.ts src/services/user.service.ts src/routes/user.routes.ts
git commit -m "feat(server): add profileGuard middleware and complete-profile endpoint"
```

---

## Task 7: Server — Ekonomi koruması (24 saat kilidi) & server doğrulama

**Files:**
- Modify: `qulo-server/src/services/diamond.service.ts` (veya ilgili ekonomi service)

- [ ] **Step 1: Diamond service'e 24 saat kilidi ekle**

Diamond transfer/harcama işlemlerinde `created_at` kontrolü:

```typescript
// Her diamond harcama/transfer işleminin başına:
const { data: user } = await supabase
  .from("users")
  .select("created_at, auth_provider")
  .eq("id", userId)
  .single();

if (user?.auth_provider !== "email") {
  const createdAt = new Date(user.created_at);
  const hoursSinceCreation = (Date.now() - createdAt.getTime()) / (1000 * 60 * 60);
  if (hoursSinceCreation < 24) {
    throw new AppError("DIAMOND_COOLDOWN", 403, "Diamond transactions are locked for 24 hours after social signup");
  }
}
```

Bu kontrolü ilgili diamond harcama fonksiyonlarına ekle.

- [ ] **Step 2: Server'ın hatasız başladığını doğrula**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
npm run build
```

Hata yoksa başarılı.

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add -A
git commit -m "feat(server): add 24h diamond cooldown for social signups"
```

---

## Task 8: Flutter — Paketleri ekle & SocialAuthService oluştur

**Files:**
- Modify: `qulov2/pubspec.yaml`
- Create: `qulov2/lib/core/services/social_auth_service.dart`
- Modify: `qulov2/lib/providers/api_provider.dart`

- [ ] **Step 1: Paketleri ekle**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
flutter pub add google_sign_in sign_in_with_apple crypto
```

- [ ] **Step 2: SocialAuthService oluştur**

`qulov2/lib/core/services/social_auth_service.dart`:

```dart
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialSignInResult {
  final String provider;
  final String idToken;
  final String? name;
  final String? surname;
  final String? nonce; // Apple only

  const SocialSignInResult({
    required this.provider,
    required this.idToken,
    this.name,
    this.surname,
    this.nonce,
  });
}

class SocialAuthService {
  SocialAuthService._();
  static final instance = SocialAuthService._();

  final _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  /// Google Sign-In → ID token döner
  Future<SocialSignInResult> signInWithGoogle() async {
    // Önceki oturumu temizle (hesap seçim ekranını her seferinde göster)
    await _googleSignIn.signOut();

    final account = await _googleSignIn.signIn();
    if (account == null) {
      throw Exception('Google sign-in cancelled');
    }

    final auth = await account.authentication;
    final idToken = auth.idToken;
    if (idToken == null) {
      throw Exception('Google sign-in: no ID token');
    }

    // İsim parse
    final nameParts = (account.displayName ?? '').split(' ');
    final name = nameParts.isNotEmpty ? nameParts.first : null;
    final surname = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : null;

    return SocialSignInResult(
      provider: 'google',
      idToken: idToken,
      name: name,
      surname: surname,
    );
  }

  /// Apple Sign-In → ID token + nonce döner
  Future<SocialSignInResult> signInWithApple() async {
    // Generate nonce
    final rawNonce = _generateNonce();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );

    final idToken = credential.identityToken;
    if (idToken == null) {
      throw Exception('Apple sign-in: no identity token');
    }

    return SocialSignInResult(
      provider: 'apple',
      idToken: idToken,
      name: credential.givenName,
      surname: credential.familyName,
      nonce: rawNonce, // Server'a hash'lenmemiş nonce gönder
    );
  }

  String _generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }
}
```

- [ ] **Step 3: Provider ekle**

`qulov2/lib/providers/api_provider.dart` — import ekle ve provider tanımla:

```dart
import 'package:qulo_v2/core/services/social_auth_service.dart';

// ─── Social Auth ───
final socialAuthServiceProvider = Provider<SocialAuthService>(
  (_) => SocialAuthService.instance,
);
```

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git add pubspec.yaml pubspec.lock lib/core/services/social_auth_service.dart lib/providers/api_provider.dart
git commit -m "feat(flutter): add SocialAuthService with Google and Apple sign-in"
```

---

## Task 9: Flutter — Auth model & service güncelleme

**Files:**
- Modify: `qulov2/lib/data/models/auth_model.dart`
- Modify: `qulov2/lib/core/network/services/auth_service.dart`

- [ ] **Step 1: SocialLoginResponse model ekle**

`qulov2/lib/data/models/auth_model.dart` — dosya sonuna (`RefreshResponse`'dan sonra):

```dart
@JsonSerializable()
class SocialLoginResponse extends Equatable {
  @JsonKey(name: 'accessToken')
  final String accessToken;
  @JsonKey(name: 'refreshToken')
  final String refreshToken;
  @JsonKey(name: 'userId')
  final String userId;
  @JsonKey(name: 'profileIncomplete')
  final bool profileIncomplete;

  const SocialLoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.userId,
    required this.profileIncomplete,
  });

  factory SocialLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$SocialLoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SocialLoginResponseToJson(this);

  @override
  List<Object?> get props => [accessToken, refreshToken, userId, profileIncomplete];
}
```

- [ ] **Step 2: AuthService'e social-login ve complete-profile endpoint'leri ekle**

`qulov2/lib/core/network/services/auth_service.dart` — `AuthService` abstract class'ına:

```dart
@POST('/auth/social-login')
Future<SocialLoginResponse> socialLogin(@Body() Map<String, dynamic> body);

@POST('/users/me/complete-profile')
Future<Map<String, dynamic>> completeProfile(@Body() Map<String, dynamic> body);
```

Dosya başındaki import'a `SocialLoginResponse` eklenmeli (zaten `auth_model.dart`'tan geliyor).

- [ ] **Step 3: Kod üret**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git add lib/data/models/auth_model.dart lib/data/models/auth_model.g.dart lib/core/network/services/auth_service.dart lib/core/network/services/auth_service.g.dart
git commit -m "feat(flutter): add social login response model and API endpoints"
```

---

## Task 10: Flutter — AuthProvider'a socialLogin metodu ekle

**Files:**
- Modify: `qulov2/lib/providers/auth_provider.dart`

- [ ] **Step 1: Import'ları ekle**

`auth_provider.dart` başına:

```dart
import 'package:qulo_v2/core/services/social_auth_service.dart';
import 'package:qulo_v2/data/models/auth_model.dart';
```

(Çoğu zaten mevcut — sadece `SocialAuthService` import'u yeni)

- [ ] **Step 2: socialLogin metodunu AuthNotifier'a ekle**

`login` metodundan sonra:

```dart
Future<Result<SocialLoginResponse>> socialLogin(String provider) async {
  state = state.copyWith(isLoading: true, failure: null);

  try {
    // 1. Provider'dan ID token al
    final socialService = ref.read(socialAuthServiceProvider);
    final SocialSignInResult signInResult;

    try {
      if (provider == 'google') {
        signInResult = await socialService.signInWithGoogle();
      } else {
        signInResult = await socialService.signInWithApple();
      }
    } catch (e) {
      // Kullanıcı iptal etti veya hata oluştu
      state = state.copyWith(isLoading: false);
      return Result.failure(AppFailure.unknown(e.toString()));
    }

    // 2. Server'a gönder
    final authService = ref.read(authServiceProvider);
    final response = await authService.socialLogin({
      'provider': signInResult.provider,
      'id_token': signInResult.idToken,
      if (signInResult.name != null) 'name': signInResult.name,
      if (signInResult.surname != null) 'surname': signInResult.surname,
      if (signInResult.nonce != null) 'nonce': signInResult.nonce,
    });

    // 3. Token'ları kaydet
    await _saveTokens(AuthTokens(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
      userId: response.userId,
    ));

    ErrorManager.setUser(response.userId);
    AnalyticsManager.instance.setUserId(response.userId);
    AnalyticsManager.instance.logEvent(AnalyticsEvents.authLoginSuccess, params: {
      AnalyticsEvents.paramMethod: provider,
    });

    try {
      await RevenueCatService.init(response.userId);
      await RevenueCatService.logIn(response.userId);
    } catch (_) {}

    // 4. Profil tamamlanmamışsa — authenticated yap ama profileIncomplete flag'i döndür
    state = state.copyWith(
      status: AuthStatus.authenticated,
      userId: response.userId,
      isLoading: false,
    );

    // Profil tamam ise normal post-login init
    if (!response.profileIncomplete) {
      await _postLoginInit();
    }

    return Result.success(response);
  } on DioException catch (e) {
    final failure = AppFailure.fromDioException(e);
    if (failure is ServerFailure && failure.code == 'ACCOUNT_BANNED') {
      state = state.copyWith(isLoading: false, status: AuthStatus.banned, failure: failure);
    } else {
      state = state.copyWith(isLoading: false, failure: failure);
    }
    return Result.failure(failure);
  } catch (e) {
    final failure = AppFailure.unknown(e.toString());
    state = state.copyWith(isLoading: false, failure: failure);
    return Result.failure(failure);
  }
}
```

- [ ] **Step 3: _postLoginInit helper metodunu extract et**

Mevcut `login` metodundaki post-login logic (fetchMe, analytics, location seed, discover pre-fetch, passport sync, notifications, languages, presence) tekrar eden kod. Bunu private metoda çıkar:

```dart
Future<void> _postLoginInit() async {
  await ref.read(userProvider.notifier).fetchMe();
  final user = ref.read(userProvider).value;
  if (user != null) {
    final analytics = AnalyticsManager.instance;
    analytics.updateUserProperties(
      gender: user.gender ?? '',
      ageRange: AnalyticsManager.ageRange(user.age ?? 0),
      city: user.city ?? '',
      photoCount: (user.photos?.length ?? 0).toString(),
    );
    if (user.lat != null && user.lng != null) {
      ref.read(locationProvider.notifier).seedFromProfile(
        lat: user.lat!,
        lng: user.lng!,
        city: user.city,
      );
      ref.read(discoverProvider.notifier).loadCards();
      ref.read(locationProvider.notifier).getCurrentLocation();
    }
    ref.read(passportProvider.notifier).syncFromUser(
      user.passportCity,
      user.passportLat,
      user.passportLng,
    );
  }
  ref.read(notificationProvider.notifier).init();
  ref.read(userLanguagesProvider.notifier).syncFromUser();
  ref.read(presenceManagerProvider).start();
}
```

Mevcut `login` metodundaki aynı kodu bu metod çağrısıyla değiştir. `checkAuth` metodundaki benzer kodu da bu metod ile değiştir.

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git add lib/providers/auth_provider.dart
git commit -m "feat(flutter): add socialLogin method to AuthNotifier"
```

---

## Task 11: Flutter — Profile Completion Screen

**Files:**
- Create: `qulov2/lib/features/auth/screens/profile_completion_screen.dart`
- Create: `qulov2/lib/features/auth/mixins/profile_completion_mixin.dart`

- [ ] **Step 1: ProfileCompletionMixin oluştur**

`qulov2/lib/features/auth/mixins/profile_completion_mixin.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/network/result.dart';
import 'package:qulo_v2/core/services/location_manager.dart';
import 'package:qulo_v2/features/auth/screens/profile_completion_screen.dart';
import 'package:qulo_v2/providers/api_provider.dart';
import 'package:qulo_v2/providers/auth_provider.dart';

mixin ProfileCompletionMixin on ConsumerState<ProfileCompletionScreen> {
  late final PageController pageController;
  int currentStep = 0;
  static const totalSteps = 3;

  // Step 1: Birthday
  DateTime? birthday;
  String? birthdayError;

  // Step 2: Gender
  String? gender;
  String? genderError;

  // Step 3: Location
  bool locationGranted = false;
  bool isRequestingLocation = false;
  double? lat;
  double? lng;
  String? locationError;

  bool isSubmitting = false;

  void initMixin() {
    pageController = PageController();
  }

  void disposeMixin() {
    pageController.dispose();
  }

  void goToStep(int step) {
    setState(() => currentStep = step);
    pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  bool validateBirthday() {
    if (birthday == null) {
      setState(() => birthdayError = 'Please select your date of birth');
      return false;
    }
    final age = DateTime.now().difference(birthday!).inDays ~/ 365;
    if (age < 18) {
      setState(() => birthdayError = 'You must be at least 18 years old');
      return false;
    }
    setState(() => birthdayError = null);
    return true;
  }

  bool validateGender() {
    if (gender == null) {
      setState(() => genderError = 'Please select your gender');
      return false;
    }
    setState(() => genderError = null);
    return true;
  }

  void onBirthdayContinue() {
    if (validateBirthday()) goToStep(1);
  }

  void onGenderContinue() {
    if (validateGender()) goToStep(2);
  }

  Future<void> requestLocation() async {
    setState(() {
      isRequestingLocation = true;
      locationError = null;
    });
    try {
      final position = await LocationManager.instance.getCurrentPosition();
      setState(() {
        lat = position.latitude;
        lng = position.longitude;
        locationGranted = true;
        isRequestingLocation = false;
      });
    } catch (e) {
      setState(() {
        locationError = e.toString();
        isRequestingLocation = false;
      });
    }
  }

  Future<void> completeProfile() async {
    setState(() => isSubmitting = true);

    try {
      final birthdayStr =
          '${birthday!.year}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}';

      final authService = ref.read(authServiceProvider);
      await authService.completeProfile({
        'birthday': birthdayStr,
        'gender': gender,
        if (lat != null) 'lat': lat,
        if (lng != null) 'lng': lng,
      });

      // Profil tamamlandı — post-login init yap
      if (mounted) {
        await ref.read(authProvider.notifier)._postLoginInit();
      }
    } catch (e) {
      if (mounted) {
        setState(() => isSubmitting = false);
      }
    }
  }

  bool handleBack() {
    if (currentStep > 0) {
      goToStep(currentStep - 1);
      return false; // Don't pop
    }
    return true; // Pop (logout)
  }
}
```

**Not:** `_postLoginInit()` private olduğu için auth_provider'da public yapılması gerekecek. Alternatif: `AuthNotifier`'a `completeProfileAndInit()` public metodu ekle.

- [ ] **Step 2: Alternatif — AuthNotifier'a completeProfileAndInit ekle**

`auth_provider.dart`'a ekle:

```dart
/// Sosyal login sonrası profil tamamlama tamamlandığında çağrılır
Future<void> onProfileCompleted() async {
  await _postLoginInit();
}
```

Mixin'deki `completeProfile` metodunda `ref.read(authProvider.notifier)._postLoginInit()` yerine `ref.read(authProvider.notifier).onProfileCompleted()` kullan.

- [ ] **Step 3: ProfileCompletionScreen oluştur**

`qulov2/lib/features/auth/screens/profile_completion_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/widgets/app_button.dart';
import 'package:qulo_v2/core/widgets/app_progress_bar.dart';
import 'package:qulo_v2/core/widgets/app_scaffold.dart';
import 'package:qulo_v2/features/auth/mixins/profile_completion_mixin.dart';
import 'package:qulo_v2/features/auth/widgets/register_step_birthday.dart';
import 'package:qulo_v2/features/auth/widgets/register_step_gender.dart';
import 'package:qulo_v2/features/auth/widgets/register_step_location.dart';
import 'package:qulo_v2/providers/auth_provider.dart';

class ProfileCompletionScreen extends ConsumerStatefulWidget {
  const ProfileCompletionScreen({super.key});

  @override
  ConsumerState<ProfileCompletionScreen> createState() => _ProfileCompletionScreenState();
}

class _ProfileCompletionScreenState extends ConsumerState<ProfileCompletionScreen>
    with ProfileCompletionMixin {
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          if (handleBack()) {
            // Step 0'da back → logout
            ref.read(authProvider.notifier).logout();
          }
        }
      },
      child: AppScaffold(
        isLoading: isSubmitting,
        padding: EdgeInsets.zero,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.pagePadding,
                vertical: AppSpacing.md,
              ),
              child: AppProgressBar(
                currentStep + 1,
                totalSteps: ProfileCompletionMixin.totalSteps,
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  RegisterStepBirthday(
                    selectedDate: birthday,
                    onDateSelected: (d) => setState(() => birthday = d),
                    errorText: birthdayError,
                    onContinue: onBirthdayContinue,
                  ),
                  RegisterStepGender(
                    selectedGender: gender,
                    onGenderSelected: (g) => setState(() => gender = g),
                    errorText: genderError,
                    onContinue: onGenderContinue,
                  ),
                  RegisterStepLocation(
                    locationGranted: locationGranted,
                    isRequesting: isRequestingLocation,
                    errorText: locationError,
                    onRequestLocation: requestLocation,
                    onContinue: completeProfile,
                    onSkip: completeProfile, // Konum opsiyonel
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git add lib/features/auth/screens/profile_completion_screen.dart lib/features/auth/mixins/profile_completion_mixin.dart lib/providers/auth_provider.dart
git commit -m "feat(flutter): add ProfileCompletionScreen for social login users"
```

---

## Task 12: Flutter — Router güncelleme (profileCompletion redirect)

**Files:**
- Modify: `qulov2/lib/routing/route_names.dart`
- Modify: `qulov2/lib/routing/app_router.dart`
- Modify: `qulov2/lib/routing/app_routes.dart`

- [ ] **Step 1: Route name ekle**

`qulov2/lib/routing/route_names.dart` — `RouteNames` class'ına:

```dart
static const profileCompletion = 'profile-completion';
```

- [ ] **Step 2: Route tanımı ekle**

`qulov2/lib/routing/app_routes.dart` — uygun yere GoRoute ekle (auth route'ları yanına):

```dart
GoRoute(
  path: '/profile-completion',
  name: RouteNames.profileCompletion,
  parentNavigatorKey: rootNavigatorKey,
  builder: (context, state) => const ProfileCompletionScreen(),
),
```

Import ekle:
```dart
import 'package:qulo_v2/features/auth/screens/profile_completion_screen.dart';
```

- [ ] **Step 3: Router redirect logic güncelle**

`qulov2/lib/routing/app_router.dart` — `redirect` callback'inde, "Auth + auth route veya splash → discover'a yonlendir" (satır 131) ifadesinden **önce**:

```dart
// Profile completion check — age null ise profil tamamlama ekranına yönlendir
if (isAuth && state.matchedLocation != '/profile-completion') {
  final user = ref.read(userProvider).value;
  if (user != null && user.age == null) {
    return '/profile-completion';
  }
}

// profile-completion route'unda olup profili tamamlanmışsa discover'a yönlendir
if (isAuth && state.matchedLocation == '/profile-completion') {
  final user = ref.read(userProvider).value;
  if (user != null && user.age != null) {
    return '/discover';
  }
  return null;
}
```

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git add lib/routing/route_names.dart lib/routing/app_router.dart lib/routing/app_routes.dart
git commit -m "feat(flutter): add profile-completion route with redirect logic"
```

---

## Task 13: Flutter — Login ekranına sosyal butonlar ekle

**Files:**
- Create: `qulov2/lib/features/auth/widgets/social_login_buttons.dart`
- Modify: `qulov2/lib/features/auth/screens/login_screen.dart`

- [ ] **Step 1: SocialLoginButtons widget oluştur**

`qulov2/lib/features/auth/widgets/social_login_buttons.dart`:

```dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';

class SocialLoginButtons extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onGooglePressed;
  final VoidCallback onApplePressed;

  const SocialLoginButtons({
    super.key,
    required this.isLoading,
    required this.onGooglePressed,
    required this.onApplePressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // "veya" divider
        Row(
          children: [
            Expanded(child: Divider(color: theme.colorScheme.outlineVariant)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                context.tr('or'),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            Expanded(child: Divider(color: theme.colorScheme.outlineVariant)),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Google butonu
        _SocialButton(
          label: context.tr('sign_in_with_google'),
          icon: 'assets/icons/ic_google.svg',
          isLoading: isLoading,
          onPressed: onGooglePressed,
          backgroundColor: theme.colorScheme.surface,
          foregroundColor: theme.colorScheme.onSurface,
          borderColor: theme.colorScheme.outline,
        ),

        // Apple butonu (sadece iOS)
        if (Platform.isIOS) ...[
          const SizedBox(height: AppSpacing.md),
          _SocialButton(
            label: context.tr('sign_in_with_apple'),
            icon: 'assets/icons/ic_apple.svg',
            isLoading: isLoading,
            onPressed: onApplePressed,
            backgroundColor: theme.brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            foregroundColor: theme.brightness == Brightness.dark
                ? Colors.black
                : Colors.white,
          ),
        ],
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final String icon;
  final bool isLoading;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;

  const _SocialButton({
    required this.label,
    required this.icon,
    required this.isLoading,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: Image.asset(
          icon.replaceAll('.svg', '.png'), // SVG yerine PNG kullanabiliriz
          width: 24,
          height: 24,
        ),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          side: borderColor != null
              ? BorderSide(color: borderColor!)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
        ),
      ),
    );
  }
}
```

**Not:** Google ve Apple logo ikonlarının projeye eklenmesi gerekecek. Mevcut `assets/icons/` klasöründe `iconsV2/ic_apple.svg` ve `iconsV2/ic_android.svg` var — Google ikonu eklenmeli veya Material Icons kullanılabilir. İmplementasyon sırasında asset durumuna göre ayarlanacak.

- [ ] **Step 2: LoginScreen'e sosyal butonları ekle**

`qulov2/lib/features/auth/screens/login_screen.dart` — Mevcut Column children'ına, "No account? Register" Row'undan **önce** ekle:

Import ekle:
```dart
import 'package:qulo_v2/features/auth/widgets/social_login_buttons.dart';
```

`_login` metodundan sonra sosyal login metodu ekle:

```dart
Future<void> _socialLogin(String provider) => withLoading(() async {
  setState(() => _loginError = null);
  final result = await ref.read(authProvider.notifier).socialLogin(provider);
  if (!mounted) return;
  result.when(
    success: (_) {},
    failure: (f) {
      final errorCode = switch (f) {
        ServerFailure(:final code) => code,
        NetworkFailure() => 'NETWORK_ERROR',
        TimeoutFailure() => 'TIMEOUT',
        _ => 'UNKNOWN',
      };
      // Kullanıcı iptal ettiyse hata gösterme
      if (errorCode != 'UNKNOWN') {
        setState(() => _loginError = context.l10n.errorMessage(errorCode));
      }
    },
  );
});
```

Column children'ında `AppButton` ile "No account? Register" Row arasına:

```dart
const SizedBox(height: AppSpacing.lg),
SocialLoginButtons(
  isLoading: isLoading,
  onGooglePressed: () => _socialLogin('google'),
  onApplePressed: () => _socialLogin('apple'),
),
```

- [ ] **Step 3: i18n string'leri ekle**

İlgili locale dosyalarına (tr.json, en.json) ekle:

```json
"or": "veya",
"sign_in_with_google": "Google ile Giriş Yap",
"sign_in_with_apple": "Apple ile Giriş Yap",
"SOCIAL_AUTH_FAILED": "Sosyal giriş başarısız oldu",
"SOCIAL_LOGIN_ONLY": "Bu hesap sosyal giriş ile oluşturulmuş. Google veya Apple ile giriş yapın",
"PROFILE_NOT_COMPLETE": "Profilinizi tamamlamanız gerekiyor",
"UNDERAGE_USER": "18 yaşından küçükler kayıt olamaz",
"DIAMOND_COOLDOWN": "Elmas işlemleri yeni hesaplarda 24 saat kilitlidir"
```

- [ ] **Step 4: flutter analyze çalıştır**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
flutter analyze
```

- [ ] **Step 5: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git add lib/features/auth/widgets/social_login_buttons.dart lib/features/auth/screens/login_screen.dart
git commit -m "feat(flutter): add social login buttons to login screen"
```

---

## Task 14: Platform Setup & Final Verification

Bu task implementasyon sonunda yapılacak — platform credential'ları gerektirir.

**Files:**
- Modify: `qulov2/ios/Runner/Runner.entitlements` (Sign in with Apple capability)
- Modify: `qulov2/ios/Runner.xcodeproj/project.pbxproj` (capability)

- [ ] **Step 1: Google Cloud Console setup**

1. Google Cloud Console → Firebase projesi seç
2. APIs & Services → Credentials → OAuth 2.0 Client IDs oluştur (iOS, Android, Web)
3. OAuth Consent Screen → External → Publish
4. SHA-1 fingerprint al: `keytool -list -v -keystore qulov2/android/app/cp-upload-keystore.jks`
5. Client ID'leri Railway env'e ekle

- [ ] **Step 2: Apple Developer Portal setup**

1. App ID'de "Sign In with Apple" capability aktifle
2. Key oluştur (.p8), Key ID kaydet
3. Xcode'da Sign In with Apple capability ekle
4. Railway env'e APPLE_BUNDLE_ID, APPLE_TEAM_ID, APPLE_KEY_ID ekle

- [ ] **Step 3: Railway env variables ekle**

```
GOOGLE_CLIENT_ID_WEB=<web-client-id>
GOOGLE_CLIENT_ID_IOS=<ios-client-id>
GOOGLE_CLIENT_ID_ANDROID=<android-client-id>
APPLE_BUNDLE_ID=com.wordpress.calikusuberkant.qulorelease
APPLE_TEAM_ID=5W2U3NK284
```

- [ ] **Step 4: End-to-end test**

1. iOS simulator'da Google Sign In test
2. iOS device'da Apple Sign In test (simulator'da çalışmaz)
3. Yeni kullanıcı → profil tamamlama akışı
4. Mevcut email kullanıcısı → hesap bağlama
5. Uygulama kapatıp açma → auto-login
6. Profil tamamlanmadan discover'a gidememe

- [ ] **Step 5: Server'ı Railway'e push et**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git push origin APP-1915
```

- [ ] **Step 6: Final commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git add -A
git commit -m "feat: complete social auth integration (Google + Apple Sign-In)"
```
