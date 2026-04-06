# Gmail API Email Integration — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace SMTP-based email sending with Gmail API (HTTP) to bypass Railway's port blocking, add token TTL for security, and redirect email verification to quloapp.com.

**Architecture:** googleapis package with Service Account + Domain-wide delegation authenticates as info@socrepho.com. Emails are sent via Gmail API REST endpoint (HTTPS/443) instead of SMTP (587). Existing template system (email-base.html + locale JSONs) stays unchanged — only the transport layer changes.

**Tech Stack:** googleapis (Gmail API), Supabase (DB migration), Next.js (web page), express-rate-limit

**Spec:** `docs/superpowers/specs/2026-04-06-gmail-api-email-integration-design.md`

---

## File Structure

### Server (qulo-server)

| File | Action | Responsibility |
|------|--------|---------------|
| `src/utils/gmail.ts` | CREATE | Gmail API client — auth, send, RFC 2822 builder |
| `src/utils/email.ts` | MODIFY | Replace SMTP calls with gmail.ts functions |
| `src/services/email.service.ts` | MODIFY | Replace SMTP calls with gmail.ts for ticket reply |
| `src/config/env.ts` | MODIFY | Remove SMTP_* vars, add GOOGLE_SERVICE_ACCOUNT_KEY + EMAIL_FROM |
| `src/controllers/auth.controller.ts` | MODIFY | verifyEmail → 302 redirect to quloapp.com |
| `src/services/auth.service.ts` | MODIFY | Add token_expires_at to verify/reset flows |
| `src/middleware/rateLimit.ts` | MODIFY | Add forgotPasswordLimiter |
| `supabase/migrations/012_token_expires_at.sql` | CREATE | Add token_expires_at column |

### Web (web)

| File | Action | Responsibility |
|------|--------|---------------|
| `src/app/[locale]/email-verified/page.tsx` | CREATE | Email verified status page |
| `src/lib/i18n/dictionaries/en.json` | MODIFY | Add emailVerified keys |
| `src/lib/i18n/dictionaries/tr.json` | MODIFY | Add emailVerified keys |
| `netlify.toml` | MODIFY | Add email-verified redirect rules |

---

## Task 0: Google Cloud Setup (Manuel — Kullanıcı yapar)

Bu adım kullanıcıyla birlikte yapılır. Kod değişikliği yok.

- [ ] **Step 1: Google Cloud Console'da proje oluştur veya seç**

https://console.cloud.google.com/ adresine git.
Mevcut bir proje varsa seç, yoksa "New Project" → "Qulo" adıyla oluştur.

- [ ] **Step 2: Gmail API'yi aktifle**

Sol menü → "APIs & Services" → "Library" → "Gmail API" ara → "Enable" tıkla.

- [ ] **Step 3: Service Account oluştur**

Sol menü → "IAM & Admin" → "Service Accounts" → "Create Service Account":
- Name: `qulo-email-sender`
- Description: `Sends verification and reset emails via Gmail API`
- "Create and Continue" → Skip roles → "Done"

- [ ] **Step 4: JSON key oluştur ve indir**

Service account listesinden `qulo-email-sender` tıkla → "Keys" tab → "Add Key" → "Create new key" → "JSON" → "Create".
İndirilen JSON dosyasını kaydet. İçindeki `client_email` ve `client_id` değerlerini not al.

- [ ] **Step 5: Domain-wide delegation ayarla**

Google Workspace Admin Console'a git: https://admin.google.com/
- "Security" → "Access and data control" → "API controls" → "Manage Domain Wide Delegation"
- "Add new" tıkla
- Client ID: Service Account'un `client_id` değeri (JSON'dan)
- OAuth Scopes: `https://www.googleapis.com/auth/gmail.send`
- "Authorize" tıkla

- [ ] **Step 6: Railway'e env vars ekle**

Railway dashboard → qulo-server → Variables:
```
GOOGLE_SERVICE_ACCOUNT_KEY=<JSON dosyasının tüm içeriği, tek satır>
EMAIL_FROM=info@socrepho.com
```

Not: JSON içeriğini tek satır olarak yapıştır. Newline'lar `\n` olarak kalabilir.

---

## Task 1: Config — env.ts güncellemesi

**Files:**
- Modify: `qulo-server/src/config/env.ts`

- [ ] **Step 1: SMTP vars'ı kaldır, Gmail API vars ekle**

`src/config/env.ts` dosyasında SMTP bölümünü şu şekilde değiştir:

```typescript
  // Email (Gmail API)
  GOOGLE_SERVICE_ACCOUNT_KEY: z.string().default("{}"),
  EMAIL_FROM: z.string().default("info@socrepho.com"),
```

Kaldırılacak satırlar:
```typescript
  // SMTP
  SMTP_HOST: z.string().optional(),
  SMTP_PORT: z.coerce.number().optional(),
  SMTP_USER: z.string().optional(),
  SMTP_PASS: z.string().optional(),
  SMTP_FROM: z.string().default("info@socrepho.com"),
```

- [ ] **Step 2: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add src/config/env.ts
git commit -m "refactor(email): replace SMTP env vars with Gmail API config"
```

---

## Task 2: Gmail API Client — gmail.ts oluştur

**Files:**
- Create: `qulo-server/src/utils/gmail.ts`

- [ ] **Step 1: googleapis paketini ekle, nodemailer ve resend kaldır**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
npm install googleapis
npm uninstall nodemailer @types/nodemailer resend
```

- [ ] **Step 2: Gmail API client dosyasını oluştur**

`src/utils/gmail.ts`:

```typescript
import { google } from "googleapis";
import { env } from "../config/env.js";

let gmailClient: ReturnType<typeof google.gmail> | null = null;

function getGmailClient() {
  if (gmailClient) return gmailClient;

  const key = JSON.parse(env.GOOGLE_SERVICE_ACCOUNT_KEY);

  const auth = new google.auth.JWT({
    email: key.client_email,
    key: key.private_key,
    scopes: ["https://www.googleapis.com/auth/gmail.send"],
    subject: env.EMAIL_FROM,
  });

  gmailClient = google.gmail({ version: "v1", auth });
  return gmailClient;
}

function buildRawEmail(options: {
  from: string;
  to: string;
  subject: string;
  html: string;
  text: string;
}): string {
  const boundary = `boundary_${Date.now()}`;
  const lines = [
    `From: "Qulo" <${options.from}>`,
    `To: ${options.to}`,
    `Subject: =?UTF-8?B?${Buffer.from(options.subject).toString("base64")}?=`,
    "MIME-Version: 1.0",
    `Content-Type: multipart/alternative; boundary="${boundary}"`,
    "",
    `--${boundary}`,
    "Content-Type: text/plain; charset=UTF-8",
    "Content-Transfer-Encoding: base64",
    "",
    Buffer.from(options.text).toString("base64"),
    "",
    `--${boundary}`,
    "Content-Type: text/html; charset=UTF-8",
    "Content-Transfer-Encoding: base64",
    "",
    Buffer.from(options.html).toString("base64"),
    "",
    `--${boundary}--`,
  ];

  const raw = lines.join("\r\n");
  return Buffer.from(raw)
    .toString("base64")
    .replace(/\+/g, "-")
    .replace(/\//g, "_")
    .replace(/=+$/, "");
}

export async function sendEmail(options: {
  to: string;
  subject: string;
  html: string;
  text: string;
}): Promise<string | null> {
  const key = JSON.parse(env.GOOGLE_SERVICE_ACCOUNT_KEY);
  if (!key.client_email || !key.private_key) {
    console.warn("[gmail] Email skipped — GOOGLE_SERVICE_ACCOUNT_KEY not configured");
    return null;
  }

  const gmail = getGmailClient();
  const raw = buildRawEmail({
    from: env.EMAIL_FROM,
    to: options.to,
    subject: options.subject,
    html: options.html,
    text: options.text,
  });

  try {
    const res = await gmail.users.messages.send({
      userId: "me",
      requestBody: { raw },
    });
    console.log(`[gmail] Email sent to ${options.to}, messageId: ${res.data.id}`);
    return res.data.id ?? null;
  } catch (err: unknown) {
    console.error(`[gmail] Failed to send email to ${options.to}:`, err);
    throw err;
  }
}
```

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add src/utils/gmail.ts package.json package-lock.json
git commit -m "feat(email): add Gmail API client with Service Account auth"
```

---

## Task 3: email.ts — SMTP'den Gmail API'ye geçiş

**Files:**
- Modify: `qulo-server/src/utils/email.ts`

- [ ] **Step 1: Nodemailer import'larını ve SMTP transport'u kaldır, gmail.ts'i kullan**

`src/utils/email.ts` dosyasını şu şekilde yeniden yaz (template ve locale sistemi aynen kalır):

```typescript
import { readFileSync } from "fs";
import { join, dirname } from "path";
import { fileURLToPath } from "url";
import { env } from "../config/env.js";
import { sendEmail } from "./gmail.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

let templateCache: string | null = null;

function getTemplate(): string {
  if (templateCache) return templateCache;
  const templatePath = join(__dirname, "..", "templates", "email-base.html");
  templateCache = readFileSync(templatePath, "utf-8");
  return templateCache;
}

const localeCache = new Map<string, Record<string, string>>();

const SUPPORTED_LOCALES = [
  "tr", "en", "de", "fr", "es", "ar", "ru",
  "pt", "it", "ja", "ko", "zh", "nl", "pl", "sv", "hi",
];

function getEmailLocale(locale?: string): Record<string, string> {
  const loc = SUPPORTED_LOCALES.includes(locale ?? "") ? locale! : "en";
  if (localeCache.has(loc)) return localeCache.get(loc)!;
  try {
    const filePath = join(__dirname, "..", "locales", "emails", `${loc}.json`);
    const data = JSON.parse(readFileSync(filePath, "utf-8"));
    localeCache.set(loc, data);
    return data;
  } catch {
    if (loc !== "en") return getEmailLocale("en");
    throw new Error("English email locale file not found");
  }
}

function renderTemplate(
  strings: Record<string, string>,
  url: string,
  type: "verify" | "reset",
): string {
  const template = getTemplate();
  const prefix = type === "verify" ? "verify" : "reset";
  return template
    .replace(/\{\{TAGLINE\}\}/g, strings.tagline)
    .replace(/\{\{TITLE\}\}/g, strings[`${prefix}_title`])
    .replace(/\{\{BODY\}\}/g, strings[`${prefix}_body`])
    .replace(/\{\{BUTTON_TEXT\}\}/g, strings[`${prefix}_button`])
    .replace(/\{\{URL\}\}/g, url)
    .replace(/\{\{LINK_FALLBACK\}\}/g, strings.link_fallback)
    .replace(/\{\{FOOTER_IGNORE\}\}/g, strings.footer_ignore);
}

export async function sendVerificationEmail(
  to: string,
  token: string,
  locale?: string,
): Promise<void> {
  const strings = getEmailLocale(locale);
  const url = `${env.APP_URL}/api/v1/auth/verify-email?token=${token}`;
  const html = renderTemplate(strings, url, "verify");

  console.log(`[email] Sending verification email to ${to}...`);
  await sendEmail({
    to,
    subject: strings.verify_subject,
    html,
    text: `${strings.verify_title}\n\n${strings.verify_body}\n\n${url}`,
  });
  console.log(`[email] Verification email sent to ${to}`);
}

export async function sendPasswordResetEmail(
  to: string,
  token: string,
  locale?: string,
): Promise<void> {
  const strings = getEmailLocale(locale);
  const webLocale = SUPPORTED_LOCALES.includes(locale ?? "") ? locale! : "en";
  const url = `${env.WEB_URL}/${webLocale}/reset-password?token=${token}`;
  const html = renderTemplate(strings, url, "reset");

  console.log(`[email] Sending password reset email to ${to}...`);
  await sendEmail({
    to,
    subject: strings.reset_subject,
    html,
    text: `${strings.reset_title}\n\n${strings.reset_body}\n\n${url}`,
  });
  console.log(`[email] Password reset email sent to ${to}`);
}
```

- [ ] **Step 2: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add src/utils/email.ts
git commit -m "refactor(email): migrate email.ts from SMTP to Gmail API"
```

---

## Task 4: email.service.ts — Support ticket email'ini Gmail API'ye geçir

**Files:**
- Modify: `qulo-server/src/services/email.service.ts`

- [ ] **Step 1: Nodemailer'ı kaldır, gmail.ts kullan**

`src/services/email.service.ts` dosyasını şu şekilde yeniden yaz:

```typescript
import path from "path";
import { fileURLToPath } from "url";
import ejs from "ejs";
import { sendEmail } from "../utils/gmail.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

class EmailService {
  async sendTicketReply(
    to: string,
    subject: string,
    replyText: string,
    ticketId: string,
  ): Promise<void> {
    const templatePath = path.join(
      __dirname,
      "../admin/views/emails/ticket-reply.ejs",
    );
    const html = await ejs.renderFile(templatePath, {
      subject,
      replyText,
      ticketId,
    });

    await sendEmail({
      to,
      subject: `Re: ${subject} - Qulo Support`,
      html,
      text: `${subject}\n\n${replyText}\n\nTicket ID: ${ticketId}`,
    });
  }
}

export const emailService = new EmailService();
```

- [ ] **Step 2: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add src/services/email.service.ts
git commit -m "refactor(email): migrate email.service.ts from SMTP to Gmail API"
```

---

## Task 5: DB Migration — token_expires_at kolonu

**Files:**
- Create: `qulo-server/supabase/migrations/012_token_expires_at.sql`

- [ ] **Step 1: Migration dosyasını oluştur**

`supabase/migrations/012_token_expires_at.sql`:

```sql
-- Add token expiration column for email verification and password reset
ALTER TABLE users ADD COLUMN IF NOT EXISTS token_expires_at TIMESTAMPTZ;

-- Index for efficient expired token cleanup (optional future use)
CREATE INDEX IF NOT EXISTS idx_users_token_expires_at ON users (token_expires_at)
  WHERE token_expires_at IS NOT NULL;
```

- [ ] **Step 2: Migration'ı Supabase'de çalıştır**

Supabase MCP tool ile çalıştır:
```
execute_sql: ALTER TABLE users ADD COLUMN IF NOT EXISTS token_expires_at TIMESTAMPTZ;
execute_sql: CREATE INDEX IF NOT EXISTS idx_users_token_expires_at ON users (token_expires_at) WHERE token_expires_at IS NOT NULL;
```

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add supabase/migrations/012_token_expires_at.sql
git commit -m "feat(db): add token_expires_at column for token TTL"
```

---

## Task 6: auth.service.ts — Token TTL ekle

**Files:**
- Modify: `qulo-server/src/services/auth.service.ts`

- [ ] **Step 1: register metodu — verification token'a expires_at ekle**

`register` metodu içinde token oluşturulan yerde, `verify_token` yanına `token_expires_at` ekle:

Mevcut token kaydetme satırını bul (register içinde `verify_token: tokenHash` olan yeri) ve `token_expires_at` ekle:

```typescript
const expiresAt = new Date(Date.now() + 24 * 60 * 60 * 1000).toISOString(); // 24 hours

// update satırında:
.update({ verify_token: tokenHash, token_expires_at: expiresAt })
```

- [ ] **Step 2: forgotPassword metodu — reset token'a expires_at ekle**

`forgotPassword` metodu içinde token kaydetme satırını güncelle:

```typescript
const expiresAt = new Date(Date.now() + 60 * 60 * 1000).toISOString(); // 1 hour

await supabase
  .from("users")
  .update({ verify_token: tokenHash, token_expires_at: expiresAt })
  .eq("id", user.id);
```

- [ ] **Step 3: verifyEmail metodu — expiry kontrolü ekle**

`verifyEmail` metodunda token sorgusuna expiry kontrolü ekle:

```typescript
async verifyEmail(token: string) {
  const tokenHash = hashToken(token);

  const { data: user, error } = await supabase
    .from("users")
    .select("id, token_expires_at")
    .eq("verify_token", tokenHash)
    .eq("email_verified", false)
    .maybeSingle();

  if (error || !user) {
    throw Errors.INVALID_TOKEN();
  }

  // Check token expiration
  if (user.token_expires_at && new Date(user.token_expires_at) < new Date()) {
    throw Errors.TOKEN_EXPIRED();
  }

  const { error: updateError } = await supabase
    .from("users")
    .update({ email_verified: true, verify_token: null, token_expires_at: null })
    .eq("id", user.id);

  if (updateError) {
    throw Errors.SERVER_ERROR();
  }

  return { userId: user.id };
}
```

- [ ] **Step 4: resetPassword metodu — expiry kontrolü ekle**

```typescript
async resetPassword(token: string, password: string) {
  const tokenHash = hashToken(token);

  const { data: user, error } = await supabase
    .from("users")
    .select("id, token_expires_at")
    .eq("verify_token", tokenHash)
    .maybeSingle();

  if (error || !user) {
    throw Errors.INVALID_TOKEN();
  }

  // Check token expiration
  if (user.token_expires_at && new Date(user.token_expires_at) < new Date()) {
    throw Errors.TOKEN_EXPIRED();
  }

  const passwordHash = await hashPassword(password);

  await supabase
    .from("users")
    .update({ password_hash: passwordHash, verify_token: null, token_expires_at: null })
    .eq("id", user.id);

  // Delete all refresh tokens for this user
  await supabase
    .from("refresh_tokens")
    .delete()
    .eq("user_id", user.id);

  return { userId: user.id };
}
```

- [ ] **Step 5: TOKEN_EXPIRED error tanımını ekle**

Errors objesinde (`src/utils/errors.ts` veya tanımlandığı yer) yeni error ekle:

```typescript
TOKEN_EXPIRED: () => createError("TOKEN_EXPIRED", "Token has expired", 410),
```

- [ ] **Step 6: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add src/services/auth.service.ts src/utils/errors.ts
git commit -m "feat(auth): add token TTL with expiration checks"
```

---

## Task 7: auth.controller.ts — Verification redirect to quloapp.com

**Files:**
- Modify: `qulo-server/src/controllers/auth.controller.ts`

- [ ] **Step 1: verifyEmailHandler'ı redirect'e çevir**

`verifyEmailHandler` fonksiyonunu şu şekilde güncelle:

```typescript
export async function verifyEmailHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const { token } = req.query as { token: string };
    await authService.verifyEmail(token);

    const locale = detectLocale(req);
    res.redirect(302, `${env.WEB_URL}/${locale}/email-verified?status=success`);
  } catch (err: unknown) {
    const locale = detectLocale(req);
    const status = isTokenExpiredError(err) ? "expired" : "error";
    res.redirect(302, `${env.WEB_URL}/${locale}/email-verified?status=${status}`);
  }
}

function detectLocale(req: Request): string {
  const acceptLang = req.headers["accept-language"] || "";
  return acceptLang.includes("tr") ? "tr" : "en";
}

function isTokenExpiredError(err: unknown): boolean {
  return (err as { code?: string })?.code === "TOKEN_EXPIRED";
}
```

- [ ] **Step 2: `env` import'unu ekle (yoksa)**

Dosya başında env import'unun olduğundan emin ol:

```typescript
import { env } from "../config/env.js";
```

- [ ] **Step 3: buildVerifyHtml fonksiyonunu sil**

Artık kullanılmayan `buildVerifyHtml` fonksiyonunu dosyanın sonundan kaldır.

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add src/controllers/auth.controller.ts
git commit -m "refactor(auth): redirect email verification to quloapp.com"
```

---

## Task 8: Rate Limiting — forgotPassword limiter

**Files:**
- Modify: `qulo-server/src/middleware/rateLimit.ts`
- Modify: Auth routes file (forgot-password endpoint)

- [ ] **Step 1: forgotPasswordLimiter ekle**

`src/middleware/rateLimit.ts` dosyasına yeni limiter ekle:

```typescript
export const forgotPasswordLimiter = rateLimit({
  windowMs: 5 * 60 * 1000, // 5 minutes
  limit: 3,
  standardHeaders: true,
  legacyHeaders: false,
  message: rateLimitResponse,
});
```

- [ ] **Step 2: Route'a bağla**

Auth routes dosyasında (`src/routes/auth.routes.ts` veya benzeri) forgot-password endpoint'ine limiter ekle:

```typescript
import { forgotPasswordLimiter } from "../middleware/rateLimit.js";

router.post("/forgot-password", forgotPasswordLimiter, forgotPasswordHandler);
```

Not: Mevcut `authLimiter` zaten genel bir limiter. `forgotPasswordLimiter` onu override eder — daha sıkı (5dk'da 3 istek vs 1dk'da 5 istek).

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add src/middleware/rateLimit.ts src/routes/auth.routes.ts
git commit -m "feat(auth): add stricter rate limit for forgot-password"
```

---

## Task 9: Web — email-verified sayfası

**Files:**
- Create: `web/src/app/[locale]/email-verified/page.tsx`
- Modify: `web/src/lib/i18n/dictionaries/en.json`
- Modify: `web/src/lib/i18n/dictionaries/tr.json`

- [ ] **Step 1: i18n anahtarlarını ekle — en.json**

`en.json` dosyasına `emailVerified` bölümü ekle:

```json
"emailVerified": {
  "successTitle": "Email Verified!",
  "successDesc": "Your account has been successfully activated. You can return to the app.",
  "expiredTitle": "Link Expired",
  "expiredDesc": "This verification link has expired. Please request a new one from the app.",
  "errorTitle": "Invalid Link",
  "errorDesc": "This verification link is invalid.",
  "openApp": "Open App",
  "requestNew": "Request New Link"
}
```

- [ ] **Step 2: i18n anahtarlarını ekle — tr.json**

`tr.json` dosyasına `emailVerified` bölümü ekle:

```json
"emailVerified": {
  "successTitle": "E-posta Doğrulandı!",
  "successDesc": "Hesabın başarıyla aktifleştirildi. Uygulamaya dönebilirsin.",
  "expiredTitle": "Bağlantı Süresi Dolmuş",
  "expiredDesc": "Bu doğrulama bağlantısının süresi dolmuş. Lütfen uygulamadan yeni bir bağlantı talep et.",
  "errorTitle": "Geçersiz Bağlantı",
  "errorDesc": "Bu doğrulama bağlantısı geçersiz.",
  "openApp": "Uygulamayı Aç",
  "requestNew": "Yeni Bağlantı Talep Et"
}
```

- [ ] **Step 3: Diğer 14 locale dosyasına da emailVerified ekle**

Tüm locale dosyalarına (`de.json`, `fr.json`, `es.json`, `ar.json`, `ru.json`, `pt.json`, `it.json`, `ja.json`, `ko.json`, `zh.json`, `nl.json`, `pl.json`, `sv.json`, `hi.json`) İngilizce fallback olarak aynı `emailVerified` bölümünü ekle. Çeviri sonra yapılabilir.

- [ ] **Step 4: email-verified sayfasını oluştur**

`web/src/app/[locale]/email-verified/page.tsx`:

```tsx
"use client";

import { useSearchParams } from "next/navigation";
import { useTranslations } from "@/lib/i18n/useTranslations";

export default function EmailVerifiedPage() {
  const searchParams = useSearchParams();
  const status = searchParams.get("status") || "error";
  const t = useTranslations();
  const ev = t.emailVerified;

  const config: Record<string, { title: string; desc: string; icon: string; color: string; showAppButton: boolean }> = {
    success: {
      title: ev.successTitle,
      desc: ev.successDesc,
      icon: "✓",
      color: "#4CAF50",
      showAppButton: true,
    },
    expired: {
      title: ev.expiredTitle,
      desc: ev.expiredDesc,
      icon: "⏱",
      color: "#FF9800",
      showAppButton: false,
    },
    error: {
      title: ev.errorTitle,
      desc: ev.errorDesc,
      icon: "✕",
      color: "#F44336",
      showAppButton: false,
    },
  };

  const c = config[status] || config.error;

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-purple-50 via-white to-green-50 px-4">
      <div className="bg-white rounded-2xl p-10 max-w-md w-full text-center shadow-lg shadow-purple-200/30">
        <div
          className="w-16 h-16 rounded-full flex items-center justify-center text-white text-3xl font-bold mx-auto mb-6"
          style={{ backgroundColor: c.color }}
        >
          {c.icon}
        </div>
        <p className="text-purple-600 text-xs tracking-widest mb-2">QULO</p>
        <h1 className="text-2xl font-bold text-gray-800 mb-3">{c.title}</h1>
        <p className="text-gray-500 leading-relaxed mb-8">{c.desc}</p>
        {c.showAppButton && (
          <a
            href="qulo://"
            className="inline-block px-10 py-3 bg-gradient-to-r from-purple-600 to-purple-800 text-white rounded-xl font-semibold text-base shadow-md shadow-purple-400/30 hover:shadow-lg transition-shadow"
          >
            {ev.openApp}
          </a>
        )}
        <p className="mt-8 text-gray-300 text-xs">&copy; 2026 Qulo</p>
      </div>
    </div>
  );
}
```

Not: Bu dosyanın `useTranslations` import yolunu mevcut web projesinin pattern'ına göre ayarla. Mevcut `reset-password/page.tsx` dosyasındaki i18n kullanım şekline bak ve aynısını uygula.

- [ ] **Step 5: netlify.toml'a redirect ekle**

`netlify.toml` dosyasına email-verified sayfası için redirect rule ekle (mevcut pattern'a uygun):

```toml
[[redirects]]
  from = "/email-verified"
  to = "/tr/email-verified/"
  status = 302

[[redirects]]
  from = "/email-verified/"
  to = "/tr/email-verified/"
  status = 302
```

- [ ] **Step 6: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/web
git add src/app/\[locale\]/email-verified/page.tsx src/lib/i18n/dictionaries/*.json netlify.toml
git commit -m "feat(web): add email-verified page with success/expired/error states"
```

---

## Task 10: Cleanup — Kullanılmayan dosyaları kaldır

**Files:**
- Delete: `qulo-server/src/admin/views/email-verified.ejs` (artık quloapp.com'da)

- [ ] **Step 1: Eski email-verified.ejs'i sil**

```bash
rm /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server/src/admin/views/email-verified.ejs
```

- [ ] **Step 2: email-verified.ejs'e referans var mı kontrol et**

```bash
grep -r "email-verified" qulo-server/src/ --include="*.ts"
```

Eğer bir yerde render ediliyorsa o referansı da kaldır.

- [ ] **Step 3: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
git add -A
git commit -m "chore: remove unused email-verified.ejs template"
```

---

## Task 11: End-to-End Test — Manuel Doğrulama

- [ ] **Step 1: Local test — Gmail API bağlantısı**

Railway deploy öncesi local'de test et. `.env` dosyasına `GOOGLE_SERVICE_ACCOUNT_KEY` ve `EMAIL_FROM` ekle:

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulo-server
npx tsx -e "
import { sendEmail } from './src/utils/gmail.js';
sendEmail({
  to: '<kendi-email-adresin>',
  subject: 'Qulo Test Email',
  html: '<h1>Test</h1><p>Gmail API çalışıyor!</p>',
  text: 'Gmail API çalışıyor!'
}).then(id => console.log('Success:', id)).catch(err => console.error('Error:', err));
"
```

Expected: Email gelen kutusuna düşer, console'da `Success: <messageId>` görünür.

- [ ] **Step 2: Registration flow test**

Test kullanıcısıyla kayıt olup verification email'inin geldiğini doğrula.

- [ ] **Step 3: Password reset flow test**

Forgot password → email gelir → quloapp.com/en/reset-password?token=... → yeni şifre gir → başarılı.

- [ ] **Step 4: Email verification redirect test**

Verification linkine tıkla → quloapp.com/{locale}/email-verified?status=success sayfasına yönlendirildiğini doğrula.

- [ ] **Step 5: Token expiry test**

Expired token ile verify endpoint'ine istek at → quloapp.com/{locale}/email-verified?status=expired sayfasına yönlendirildiğini doğrula.

---

## Sıralama ve Bağımlılıklar

```
Task 0 (Google Cloud Setup) — kullanıcı ile birlikte, her zaman önce
    ↓
Task 1 (env.ts) → Task 2 (gmail.ts) → Task 3 (email.ts) → Task 4 (email.service.ts)
    ↓
Task 5 (DB migration) → Task 6 (auth.service.ts token TTL)
    ↓
Task 7 (auth.controller.ts redirect) ← Task 9 (web email-verified page)
    ↓
Task 8 (rate limiting)
    ↓
Task 10 (cleanup)
    ↓
Task 11 (E2E test)
```

Paralel çalışabilecek task'lar:
- Task 5 + Task 9 (DB migration ve web sayfası bağımsız)
- Task 1-4 (server email) ve Task 9 (web sayfası) paralel gidebilir
