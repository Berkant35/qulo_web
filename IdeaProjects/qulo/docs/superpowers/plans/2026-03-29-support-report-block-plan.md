# Support, Report & Block Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Qulo'ya destek ticket sistemi, gelişmiş report/block, soft-ban ve FAQ sayfası eklemek.

**Architecture:** Katmanlı yaklaşım — DB migration → Server endpoints → Web FAQ → Mobile UI. Mevcut pattern'lere %100 uyum.

**Tech Stack:** Supabase PostgreSQL, Node.js/Express/TypeScript, Next.js 14 (static), Flutter/Riverpod/Dio

**Review Kuralları:** Server tamamlandığında `/server-review`, Flutter tamamlandığında `/flutter-review` + `/simplify`, Web tamamlandığında `/web-security-review` + `/web-code-quality`

---

## File Structure

### Server (qulo-server/src/)
- **Create:** `services/email.service.ts` — Nodemailer wrapper (SMTP)
- **Create:** `routes/support-ticket.routes.ts` — Support ticket API routes
- **Create:** `controllers/support-ticket.controller.ts` — Request handlers
- **Create:** `services/support-ticket.service.ts` — Ticket CRUD logic
- **Create:** `validators/support-ticket.validator.ts` — Zod schemas
- **Create:** `admin/views/tickets.ejs` — Admin ticket list
- **Create:** `admin/views/ticket-detail.ejs` — Admin ticket detail + reply
- **Create:** `admin/views/blocks.ejs` — Admin block list
- **Create:** `admin/views/emails/ticket-reply.ejs` — Email template
- **Modify:** `middlewares/auth.middleware.ts` — Ban check
- **Modify:** `services/report.service.ts` — Category field
- **Modify:** `validators/report.validator.ts` — Category validation
- **Modify:** `controllers/report.controller.ts` — Category pass-through
- **Modify:** `routes/block.routes.ts` — GET /blocks list endpoint
- **Modify:** `controllers/block.controller.ts` — getBlockedUsers handler
- **Modify:** `services/block.service.ts` — getBlockedUsers with user info
- **Modify:** `admin/admin.routes.ts` — Ticket + block admin routes
- **Modify:** `admin/admin.controller.ts` — Ticket + block + ban handlers
- **Modify:** `admin/admin.service.ts` — Ticket + block + ban queries
- **Modify:** `index.ts` — Register support-ticket routes
- **Modify:** `utils/errors.ts` — New error codes

### Web (web/src/)
- **Create:** `app/[locale]/help/page.tsx` — FAQ/Help page
- **Modify:** `lib/i18n/dictionaries/tr.json` — Help page translations (TR)
- **Modify:** `lib/i18n/dictionaries/en.json` — Help page translations (EN)

### Mobile (qulov2/lib/)
- **Create:** `core/network/services/support_ticket_service.dart` — Retrofit API
- **Create:** `data/repositories/support_ticket_repository.dart` — Repository
- **Create:** `data/models/support_ticket_model.dart` — DTO model
- **Create:** `features/settings/screens/blocked_users_screen.dart` — Blocked users list
- **Create:** `features/settings/screens/my_tickets_screen.dart` — Ticket list
- **Create:** `features/settings/screens/create_ticket_screen.dart` — Ticket form
- **Create:** `features/chat/widgets/chat_popup_menu.dart` — Report/Block menu
- **Create:** `features/auth/screens/banned_screen.dart` — Ban notice
- **Create:** `features/profile_detail/widgets/report_category_sheet.dart` — Category picker
- **Modify:** `data/repositories/interfaces.dart` — ISupportTicketRepository
- **Modify:** `data/repositories/report_repository.dart` — Category param
- **Modify:** `core/network/services/report_service.dart` — Category in body
- **Modify:** `core/network/services/block_service.dart` — GET blocked users
- **Modify:** `data/repositories/block_repository.dart` — getBlockedUsers
- **Modify:** `providers/api_provider.dart` — New providers
- **Modify:** `features/settings/screens/settings_screen.dart` — New menu items
- **Modify:** `features/settings/mixins/settings_screen_mixin.dart` — New callbacks
- **Modify:** `features/chat/screens/chat_screen.dart` — PopupMenuButton
- **Modify:** `features/chat/mixins/chat_screen_mixin.dart` — Report/block logic
- **Modify:** `features/profile_detail/mixins/profile_detail_screen_mixin.dart` — Category support
- **Modify:** `providers/auth_provider.dart` — Ban check on login
- **Modify:** `core/l10n/translations/tr.dart` — New keys
- **Modify:** `core/l10n/translations/en.dart` — New keys

---

## Phase 1: Database

### Task 1: Supabase Migration — Ban Fields + Support Tickets

**Files:**
- Migration via Supabase MCP tool

- [ ] **Step 1: Add ban fields to users table**

```sql
ALTER TABLE users ADD COLUMN is_banned BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE users ADD COLUMN banned_at TIMESTAMPTZ;
ALTER TABLE users ADD COLUMN ban_reason TEXT;
```

Run via `mcp__claude_ai_Supabase__apply_migration` with project_id `vtntrtozgoyhjdvvurkj`.

- [ ] **Step 2: Create support_tickets table**

```sql
CREATE TYPE support_ticket_category AS ENUM ('ACCOUNT', 'TECHNICAL', 'BILLING', 'MATCH', 'OTHER');
CREATE TYPE support_ticket_status AS ENUM ('OPEN', 'IN_PROGRESS', 'RESOLVED', 'CLOSED');

CREATE TABLE support_tickets (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  subject TEXT NOT NULL,
  message TEXT NOT NULL,
  category support_ticket_category NOT NULL DEFAULT 'OTHER',
  status support_ticket_status NOT NULL DEFAULT 'OPEN',
  admin_reply TEXT,
  replied_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE support_tickets DISABLE ROW LEVEL SECURITY;
```

Run via `mcp__claude_ai_Supabase__apply_migration`.

- [ ] **Step 3: Verify tables**

```sql
SELECT column_name, data_type FROM information_schema.columns
WHERE table_name IN ('support_tickets') ORDER BY table_name, ordinal_position;

SELECT column_name FROM information_schema.columns
WHERE table_name = 'users' AND column_name IN ('is_banned', 'banned_at', 'ban_reason');
```

- [ ] **Step 4: Add migration file to repo**

Create: `qulo-server/supabase/migrations/012_support_ban_system.sql` with both SQL blocks above.

- [ ] **Step 5: Commit**

```bash
git add qulo-server/supabase/migrations/012_support_ban_system.sql
git commit -m "feat(db): add support_tickets table and user ban fields"
```

---

## Phase 2: Server

### Task 2: Email Service

**Files:**
- Create: `qulo-server/src/services/email.service.ts`
- Create: `qulo-server/src/admin/views/emails/ticket-reply.ejs`

- [ ] **Step 1: Create email service**

```typescript
// qulo-server/src/services/email.service.ts
import nodemailer from "nodemailer";
import path from "path";
import ejs from "ejs";
import { env } from "../utils/env";

class EmailService {
  private transporter: nodemailer.Transporter | null = null;

  private getTransporter(): nodemailer.Transporter {
    if (!this.transporter) {
      if (!env.SMTP_HOST) {
        // Dev mode: log only
        this.transporter = nodemailer.createTransport({ jsonTransport: true });
        return this.transporter;
      }
      this.transporter = nodemailer.createTransport({
        host: env.SMTP_HOST,
        port: Number(env.SMTP_PORT) || 587,
        secure: Number(env.SMTP_PORT) === 465,
        auth: {
          user: env.SMTP_USER,
          pass: env.SMTP_PASS,
        },
      });
    }
    return this.transporter;
  }

  async sendTicketReply(to: string, subject: string, replyText: string, ticketId: string): Promise<void> {
    const templatePath = path.join(__dirname, "../admin/views/emails/ticket-reply.ejs");
    const html = await ejs.renderFile(templatePath, { subject, replyText, ticketId });

    const info = await this.getTransporter().sendMail({
      from: env.SMTP_FROM || "noreply@quloapp.com",
      to,
      subject: `Re: ${subject} - Qulo Support`,
      html,
    });

    if (!env.SMTP_HOST) {
      console.log("[email] Dev mode - would send:", JSON.parse(info.message));
    }
  }
}

export const emailService = new EmailService();
```

- [ ] **Step 2: Create email template**

```ejs
<!-- qulo-server/src/admin/views/emails/ticket-reply.ejs -->
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; margin: 0; padding: 0; background: #f5f5f5; }
    .container { max-width: 560px; margin: 0 auto; padding: 24px; }
    .card { background: #ffffff; border-radius: 12px; padding: 32px; }
    .logo { text-align: center; margin-bottom: 24px; font-size: 28px; font-weight: 700; color: #BB86FC; }
    .subject { font-size: 18px; font-weight: 600; color: #333; margin-bottom: 16px; }
    .reply { font-size: 15px; color: #555; line-height: 1.6; white-space: pre-wrap; }
    .footer { text-align: center; margin-top: 24px; font-size: 13px; color: #999; }
    .ticket-id { font-size: 12px; color: #bbb; margin-top: 8px; }
  </style>
</head>
<body>
  <div class="container">
    <div class="card">
      <div class="logo">Qulo</div>
      <div class="subject"><%= subject %></div>
      <div class="reply"><%= replyText %></div>
      <div class="footer">
        Yanıtlamak için uygulamadan yeni bir destek talebi oluşturun.
        <div class="ticket-id">Ticket #<%= ticketId.substring(0, 8) %></div>
      </div>
    </div>
  </div>
</body>
</html>
```

- [ ] **Step 3: Add SMTP env vars to env.ts**

Modify `qulo-server/src/utils/env.ts` — add optional SMTP fields:

```typescript
SMTP_HOST: process.env.SMTP_HOST || "",
SMTP_PORT: process.env.SMTP_PORT || "587",
SMTP_USER: process.env.SMTP_USER || "",
SMTP_PASS: process.env.SMTP_PASS || "",
SMTP_FROM: process.env.SMTP_FROM || "noreply@quloapp.com",
```

- [ ] **Step 4: Commit**

```bash
git add qulo-server/src/services/email.service.ts qulo-server/src/admin/views/emails/ticket-reply.ejs qulo-server/src/utils/env.ts
git commit -m "feat(server): add email service with nodemailer"
```

---

### Task 3: Support Ticket CRUD

**Files:**
- Create: `qulo-server/src/validators/support-ticket.validator.ts`
- Create: `qulo-server/src/services/support-ticket.service.ts`
- Create: `qulo-server/src/controllers/support-ticket.controller.ts`
- Create: `qulo-server/src/routes/support-ticket.routes.ts`
- Modify: `qulo-server/src/index.ts`

- [ ] **Step 1: Create validator**

```typescript
// qulo-server/src/validators/support-ticket.validator.ts
import { z } from "zod";

export const createTicketSchema = z.object({
  subject: z.string().min(5).max(200),
  message: z.string().min(10).max(2000),
  category: z.enum(["ACCOUNT", "TECHNICAL", "BILLING", "MATCH", "OTHER"]),
});

export type CreateTicketInput = z.infer<typeof createTicketSchema>;
```

- [ ] **Step 2: Create service**

```typescript
// qulo-server/src/services/support-ticket.service.ts
import { supabase } from "../utils/supabase";
import { Errors } from "../utils/errors";

class SupportTicketService {
  async create(userId: string, subject: string, message: string, category: string) {
    const { data, error } = await supabase
      .from("support_tickets")
      .insert({ user_id: userId, subject, message, category })
      .select("id, subject, message, category, status, created_at")
      .single();

    if (error) throw Errors.SERVER_ERROR();
    return data;
  }

  async listByUser(userId: string) {
    const { data, error } = await supabase
      .from("support_tickets")
      .select("id, subject, category, status, admin_reply, replied_at, created_at")
      .eq("user_id", userId)
      .order("created_at", { ascending: false });

    if (error) throw Errors.SERVER_ERROR();
    return data ?? [];
  }

  async getById(ticketId: string, userId: string) {
    const { data, error } = await supabase
      .from("support_tickets")
      .select("*")
      .eq("id", ticketId)
      .eq("user_id", userId)
      .single();

    if (error) throw Errors.NOT_FOUND();
    return data;
  }
}

export const supportTicketService = new SupportTicketService();
```

- [ ] **Step 3: Create controller**

```typescript
// qulo-server/src/controllers/support-ticket.controller.ts
import { Request, Response, NextFunction } from "express";
import { supportTicketService } from "../services/support-ticket.service";
import { CreateTicketInput } from "../validators/support-ticket.validator";

export async function createTicketHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const { subject, message, category } = req.body as CreateTicketInput;
    const result = await supportTicketService.create(req.user!.userId, subject, message, category);
    res.status(201).json(result);
  } catch (err) {
    next(err);
  }
}

export async function listTicketsHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const result = await supportTicketService.listByUser(req.user!.userId);
    res.json(result);
  } catch (err) {
    next(err);
  }
}

export async function getTicketHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const result = await supportTicketService.getById(req.params.id, req.user!.userId);
    res.json(result);
  } catch (err) {
    next(err);
  }
}
```

- [ ] **Step 4: Create routes**

```typescript
// qulo-server/src/routes/support-ticket.routes.ts
import { Router } from "express";
import { authMiddleware } from "../middlewares/auth.middleware";
import { generalLimiter } from "../middlewares/rate-limit.middleware";
import { validate } from "../middlewares/validate.middleware";
import { createTicketSchema } from "../validators/support-ticket.validator";
import { createTicketHandler, listTicketsHandler, getTicketHandler } from "../controllers/support-ticket.controller";

const router = Router();
router.use(authMiddleware, generalLimiter);

router.post("/", validate(createTicketSchema), createTicketHandler);
router.get("/", listTicketsHandler);
router.get("/:id", getTicketHandler);

export default router;
```

- [ ] **Step 5: Register route in index.ts**

Add to `qulo-server/src/index.ts` alongside other routes:

```typescript
import supportTicketRoutes from "./routes/support-ticket.routes";
// ... existing route registrations
app.use("/api/v1/support-tickets", supportTicketRoutes);
```

- [ ] **Step 6: Commit**

```bash
git add qulo-server/src/validators/support-ticket.validator.ts qulo-server/src/services/support-ticket.service.ts qulo-server/src/controllers/support-ticket.controller.ts qulo-server/src/routes/support-ticket.routes.ts qulo-server/src/index.ts
git commit -m "feat(server): add support ticket CRUD endpoints"
```

---

### Task 4: Ban System

**Files:**
- Modify: `qulo-server/src/utils/errors.ts`
- Modify: `qulo-server/src/middlewares/auth.middleware.ts`
- Modify: `qulo-server/src/admin/admin.service.ts`
- Modify: `qulo-server/src/admin/admin.controller.ts`

- [ ] **Step 1: Add ACCOUNT_BANNED error**

Add to `qulo-server/src/utils/errors.ts` Errors object:

```typescript
ACCOUNT_BANNED: () => new AppError("ACCOUNT_BANNED", 403, "Your account has been suspended"),
```

- [ ] **Step 2: Add ban check to auth middleware**

Modify `qulo-server/src/middlewares/auth.middleware.ts` — after JWT verify and `req.user` set, add ban check:

```typescript
// After: req.user = { userId: decoded.sub };
// Add:
const { data: user } = await supabase
  .from("users")
  .select("is_banned")
  .eq("id", decoded.sub)
  .single();

if (user?.is_banned) {
  throw Errors.ACCOUNT_BANNED();
}
```

Import supabase at the top of the file.

- [ ] **Step 3: Add banUser/unbanUser to admin service**

Add to `qulo-server/src/admin/admin.service.ts`:

```typescript
async banUser(userId: string, reason: string) {
  // 1) Set ban flags
  const { error: banError } = await supabase
    .from("users")
    .update({ is_banned: true, banned_at: new Date().toISOString(), ban_reason: reason })
    .eq("id", userId);

  if (banError) throw Errors.SERVER_ERROR();

  // 2) Deactivate all matches
  await supabase
    .from("matches")
    .update({ is_active: false })
    .or(`user1_id.eq.${userId},user2_id.eq.${userId}`);
}

async unbanUser(userId: string) {
  const { error } = await supabase
    .from("users")
    .update({ is_banned: false, banned_at: null, ban_reason: null })
    .eq("id", userId);

  if (error) throw Errors.SERVER_ERROR();
}
```

- [ ] **Step 4: Update reportAction to use soft-ban**

Modify the `reportAction` method in `qulo-server/src/admin/admin.controller.ts`:

Find the ban block (where `ban_user` is handled) and replace hard-delete with soft-ban:

```typescript
// Replace delete user logic with:
if (req.body.ban_user === "1") {
  await this.adminService.banUser(report.reported_id, `Banned via report #${reportId}`);
}
```

- [ ] **Step 5: Commit**

```bash
git add qulo-server/src/utils/errors.ts qulo-server/src/middlewares/auth.middleware.ts qulo-server/src/admin/admin.service.ts qulo-server/src/admin/admin.controller.ts
git commit -m "feat(server): add soft-ban system with auth middleware check"
```

---

### Task 5: Report Category Improvement

**Files:**
- Modify: `qulo-server/src/validators/report.validator.ts`
- Modify: `qulo-server/src/services/report.service.ts`
- Modify: `qulo-server/src/controllers/report.controller.ts`

- [ ] **Step 1: Add category to validator**

Update `qulo-server/src/validators/report.validator.ts`:

```typescript
import { z } from "zod";

export const createReportSchema = z.object({
  reported_id: z.string().uuid(),
  reason: z.string().min(5).max(1000),
  category: z.enum([
    "INAPPROPRIATE_CONTENT", "FAKE_PROFILE", "SPAM", "HARASSMENT",
    "UNDERAGE", "SCAM", "OFFENSIVE_PHOTOS", "THREATENING",
    "IMPERSONATION", "OTHER",
  ]),
});

export type CreateReportInput = z.infer<typeof createReportSchema>;
```

- [ ] **Step 2: Add category to service**

Update `report.service.ts` `create` method — add `category` parameter to insert:

```typescript
async create(reporterId: string, reportedId: string, reason: string, category: string) {
  const { data, error } = await supabase
    .from("reports")
    .insert({ reporter_id: reporterId, reported_id: reportedId, reason, category })
    .select("id, reporter_id, reported_id, reason, category, created_at")
    .single();

  if (error) throw Errors.SERVER_ERROR();
  return data;
}
```

- [ ] **Step 3: Pass category in controller**

Update `report.controller.ts`:

```typescript
const { reported_id, reason, category } = req.body as CreateReportInput;
const result = await reportService.create(req.user!.userId, reported_id, reason, category);
```

- [ ] **Step 4: Commit**

```bash
git add qulo-server/src/validators/report.validator.ts qulo-server/src/services/report.service.ts qulo-server/src/controllers/report.controller.ts
git commit -m "feat(server): add category field to report endpoint"
```

---

### Task 6: Block List Endpoint

**Files:**
- Modify: `qulo-server/src/services/block.service.ts`
- Modify: `qulo-server/src/controllers/block.controller.ts`
- Modify: `qulo-server/src/routes/block.routes.ts`

- [ ] **Step 1: Add getBlockedUsers to service**

Add to `qulo-server/src/services/block.service.ts`:

```typescript
async getBlockedUsers(blockerId: string) {
  const { data: blocks, error } = await supabase
    .from("blocks")
    .select("id, blocked_id, created_at")
    .eq("blocker_id", blockerId)
    .order("created_at", { ascending: false });

  if (error) throw Errors.SERVER_ERROR();
  if (!blocks || blocks.length === 0) return [];

  // Fetch user info for each blocked user
  const blockedIds = blocks.map((b) => b.blocked_id);
  const { data: users } = await supabase
    .from("users")
    .select("id, name, photos")
    .in("id", blockedIds);

  const userMap = new Map((users ?? []).map((u) => [u.id, u]));

  return blocks.map((b) => ({
    id: b.id,
    blocked_at: b.created_at,
    user: userMap.get(b.blocked_id) ?? { id: b.blocked_id, name: "Unknown", photos: [] },
  }));
}
```

- [ ] **Step 2: Add handler to controller**

Add to `qulo-server/src/controllers/block.controller.ts`:

```typescript
export async function getBlockedUsersHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const result = await blockService.getBlockedUsers(req.user!.userId);
    res.json(result);
  } catch (err) {
    next(err);
  }
}
```

- [ ] **Step 3: Add GET route**

Add to `qulo-server/src/routes/block.routes.ts`:

```typescript
import { blockUserHandler, unblockUserHandler, getBlockedUsersHandler } from "../controllers/block.controller";
// ...
router.get("/", getBlockedUsersHandler);
```

- [ ] **Step 4: Commit**

```bash
git add qulo-server/src/services/block.service.ts qulo-server/src/controllers/block.controller.ts qulo-server/src/routes/block.routes.ts
git commit -m "feat(server): add GET /blocks endpoint for blocked users list"
```

---

### Task 7: Admin Ticket Pages

**Files:**
- Modify: `qulo-server/src/admin/admin.service.ts`
- Modify: `qulo-server/src/admin/admin.controller.ts`
- Modify: `qulo-server/src/admin/admin.routes.ts`
- Create: `qulo-server/src/admin/views/tickets.ejs`
- Create: `qulo-server/src/admin/views/ticket-detail.ejs`

- [ ] **Step 1: Add ticket queries to admin service**

Add to `qulo-server/src/admin/admin.service.ts`:

```typescript
async getTickets(page: number, limit: number, status?: string) {
  let query = supabase
    .from("support_tickets")
    .select("*, users!support_tickets_user_id_fkey(name, email)", { count: "exact" })
    .order("created_at", { ascending: false })
    .range((page - 1) * limit, page * limit - 1);

  if (status) {
    query = query.eq("status", status);
  }

  const { data, error, count } = await query;
  if (error) throw Errors.SERVER_ERROR();
  return { tickets: data ?? [], total: count ?? 0 };
}

async getTicketDetail(ticketId: string) {
  const { data, error } = await supabase
    .from("support_tickets")
    .select("*, users!support_tickets_user_id_fkey(id, name, email, photos)")
    .eq("id", ticketId)
    .single();

  if (error) throw Errors.NOT_FOUND();
  return data;
}

async replyToTicket(ticketId: string, reply: string) {
  const { data, error } = await supabase
    .from("support_tickets")
    .update({
      admin_reply: reply,
      replied_at: new Date().toISOString(),
      status: "RESOLVED",
      updated_at: new Date().toISOString(),
    })
    .eq("id", ticketId)
    .select("*, users!support_tickets_user_id_fkey(email)")
    .single();

  if (error) throw Errors.SERVER_ERROR();
  return data;
}
```

- [ ] **Step 2: Add ticket handlers to admin controller**

Add to `qulo-server/src/admin/admin.controller.ts`:

```typescript
async tickets(req: Request, res: Response) {
  try {
    const page = parseInt(req.query.page as string) || 1;
    const status = req.query.status as string | undefined;
    const { tickets, total } = await this.adminService.getTickets(page, 20, status);
    const totalPages = Math.ceil(total / 20);
    res.render("tickets", { tickets, page, totalPages, status: status || "", csrfToken: req.csrfToken?.() });
  } catch (err) {
    res.status(500).send("Error loading tickets");
  }
}

async ticketDetail(req: Request, res: Response) {
  try {
    const ticket = await this.adminService.getTicketDetail(req.params.id);
    res.render("ticket-detail", { ticket, csrfToken: req.csrfToken?.() });
  } catch (err) {
    res.status(404).send("Ticket not found");
  }
}

async ticketReply(req: Request, res: Response) {
  try {
    const { reply } = req.body;
    const ticket = await this.adminService.replyToTicket(req.params.id, reply);

    // Send email
    if (ticket.users?.email) {
      await emailService.sendTicketReply(ticket.users.email, ticket.subject, reply, ticket.id);
    }

    res.redirect(`/admin/tickets/${req.params.id}`);
  } catch (err) {
    res.status(500).send("Error replying to ticket");
  }
}
```

Import emailService at top: `import { emailService } from "../services/email.service";`

- [ ] **Step 3: Add admin routes**

Add to `qulo-server/src/admin/admin.routes.ts`:

```typescript
router.get("/tickets", (req, res) => adminController.tickets(req, res));
router.get("/tickets/:id", (req, res) => adminController.ticketDetail(req, res));
router.post("/tickets/:id/reply", csrfValidate, (req, res) => adminController.ticketReply(req, res));
```

- [ ] **Step 4: Create tickets.ejs view**

Create `qulo-server/src/admin/views/tickets.ejs`:

```ejs
<%- include('partials/header', { title: 'Support Tickets' }) %>

<div class="container mx-auto px-4 py-6">
  <h1 class="text-2xl font-bold mb-4">Support Tickets</h1>

  <!-- Status Filter -->
  <form method="GET" class="mb-4 flex gap-2">
    <select name="status" class="border rounded px-3 py-2">
      <option value="">All Status</option>
      <option value="OPEN" <%= status === 'OPEN' ? 'selected' : '' %>>Open</option>
      <option value="IN_PROGRESS" <%= status === 'IN_PROGRESS' ? 'selected' : '' %>>In Progress</option>
      <option value="RESOLVED" <%= status === 'RESOLVED' ? 'selected' : '' %>>Resolved</option>
      <option value="CLOSED" <%= status === 'CLOSED' ? 'selected' : '' %>>Closed</option>
    </select>
    <button type="submit" class="bg-purple-600 text-white px-4 py-2 rounded">Filter</button>
  </form>

  <!-- Ticket Table -->
  <table class="w-full border-collapse bg-white shadow rounded">
    <thead>
      <tr class="bg-gray-100">
        <th class="p-3 text-left">User</th>
        <th class="p-3 text-left">Subject</th>
        <th class="p-3 text-left">Category</th>
        <th class="p-3 text-left">Status</th>
        <th class="p-3 text-left">Date</th>
        <th class="p-3 text-left">Action</th>
      </tr>
    </thead>
    <tbody>
      <% tickets.forEach(ticket => { %>
      <tr class="border-t">
        <td class="p-3"><%= ticket.users?.name || 'Unknown' %></td>
        <td class="p-3"><%= ticket.subject %></td>
        <td class="p-3"><span class="badge"><%= ticket.category %></span></td>
        <td class="p-3">
          <span class="badge badge-<%= ticket.status.toLowerCase() %>"><%= ticket.status %></span>
        </td>
        <td class="p-3"><%= new Date(ticket.created_at).toLocaleDateString() %></td>
        <td class="p-3"><a href="/admin/tickets/<%= ticket.id %>" class="text-purple-600">Detail</a></td>
      </tr>
      <% }) %>
    </tbody>
  </table>

  <!-- Pagination -->
  <div class="flex justify-center gap-2 mt-4">
    <% for (let i = 1; i <= totalPages; i++) { %>
      <a href="?page=<%= i %>&status=<%= status %>"
         class="px-3 py-1 rounded <%= i === page ? 'bg-purple-600 text-white' : 'bg-gray-200' %>">
        <%= i %>
      </a>
    <% } %>
  </div>
</div>

<%- include('partials/footer') %>
```

- [ ] **Step 5: Create ticket-detail.ejs view**

Create `qulo-server/src/admin/views/ticket-detail.ejs`:

```ejs
<%- include('partials/header', { title: 'Ticket Detail' }) %>

<div class="container mx-auto px-4 py-6">
  <a href="/admin/tickets" class="text-purple-600 mb-4 inline-block">&larr; Back to Tickets</a>

  <div class="grid grid-cols-2 gap-6">
    <!-- User Info -->
    <div class="bg-white rounded shadow p-6">
      <h2 class="text-lg font-bold mb-3">User</h2>
      <p><strong>Name:</strong> <%= ticket.users?.name || 'Unknown' %></p>
      <p><strong>Email:</strong> <%= ticket.users?.email || 'N/A' %></p>
      <p><strong>ID:</strong> <%= ticket.user_id %></p>
    </div>

    <!-- Ticket Info -->
    <div class="bg-white rounded shadow p-6">
      <h2 class="text-lg font-bold mb-3">Ticket</h2>
      <p><strong>Status:</strong> <span class="badge badge-<%= ticket.status.toLowerCase() %>"><%= ticket.status %></span></p>
      <p><strong>Category:</strong> <%= ticket.category %></p>
      <p><strong>Created:</strong> <%= new Date(ticket.created_at).toLocaleString() %></p>
    </div>
  </div>

  <!-- Subject & Message -->
  <div class="bg-white rounded shadow p-6 mt-6">
    <h2 class="text-lg font-bold mb-2"><%= ticket.subject %></h2>
    <p class="whitespace-pre-wrap text-gray-700"><%= ticket.message %></p>
  </div>

  <!-- Existing Reply -->
  <% if (ticket.admin_reply) { %>
  <div class="bg-green-50 rounded shadow p-6 mt-6">
    <h2 class="text-lg font-bold mb-2 text-green-700">Admin Reply</h2>
    <p class="whitespace-pre-wrap"><%= ticket.admin_reply %></p>
    <p class="text-sm text-gray-500 mt-2">Replied: <%= new Date(ticket.replied_at).toLocaleString() %></p>
  </div>
  <% } %>

  <!-- Reply Form -->
  <% if (!ticket.admin_reply) { %>
  <div class="bg-white rounded shadow p-6 mt-6">
    <h2 class="text-lg font-bold mb-3">Reply</h2>
    <form method="POST" action="/admin/tickets/<%= ticket.id %>/reply">
      <input type="hidden" name="_csrf" value="<%= csrfToken %>">
      <textarea name="reply" rows="5" required minlength="10"
        class="w-full border rounded p-3 mb-4" placeholder="Write your reply..."></textarea>
      <button type="submit" class="bg-purple-600 text-white px-6 py-2 rounded">
        Send Reply (Email)
      </button>
    </form>
  </div>
  <% } %>
</div>

<%- include('partials/footer') %>
```

- [ ] **Step 6: Commit**

```bash
git add qulo-server/src/admin/admin.service.ts qulo-server/src/admin/admin.controller.ts qulo-server/src/admin/admin.routes.ts qulo-server/src/admin/views/tickets.ejs qulo-server/src/admin/views/ticket-detail.ejs
git commit -m "feat(server): add admin ticket management pages"
```

---

### Task 8: Admin Blocks Page

**Files:**
- Modify: `qulo-server/src/admin/admin.service.ts`
- Modify: `qulo-server/src/admin/admin.controller.ts`
- Modify: `qulo-server/src/admin/admin.routes.ts`
- Create: `qulo-server/src/admin/views/blocks.ejs`

- [ ] **Step 1: Add getBlocks to admin service**

Add to `qulo-server/src/admin/admin.service.ts`:

```typescript
async getBlocks(page: number, limit: number) {
  const { data, error, count } = await supabase
    .from("blocks")
    .select("id, blocker_id, blocked_id, created_at", { count: "exact" })
    .order("created_at", { ascending: false })
    .range((page - 1) * limit, page * limit - 1);

  if (error) throw Errors.SERVER_ERROR();

  // Fetch user names
  const userIds = new Set<string>();
  (data ?? []).forEach((b) => { userIds.add(b.blocker_id); userIds.add(b.blocked_id); });
  const { data: users } = await supabase
    .from("users")
    .select("id, name, email")
    .in("id", Array.from(userIds));

  const userMap = new Map((users ?? []).map((u) => [u.id, u]));

  const blocks = (data ?? []).map((b) => ({
    ...b,
    blocker: userMap.get(b.blocker_id),
    blocked: userMap.get(b.blocked_id),
  }));

  return { blocks, total: count ?? 0 };
}
```

- [ ] **Step 2: Add blocks handler to admin controller**

```typescript
async blocks(req: Request, res: Response) {
  try {
    const page = parseInt(req.query.page as string) || 1;
    const { blocks, total } = await this.adminService.getBlocks(page, 20);
    const totalPages = Math.ceil(total / 20);
    res.render("blocks", { blocks, page, totalPages });
  } catch (err) {
    res.status(500).send("Error loading blocks");
  }
}
```

- [ ] **Step 3: Add admin route**

```typescript
router.get("/blocks", (req, res) => adminController.blocks(req, res));
```

- [ ] **Step 4: Create blocks.ejs view**

Create `qulo-server/src/admin/views/blocks.ejs`:

```ejs
<%- include('partials/header', { title: 'Blocks' }) %>

<div class="container mx-auto px-4 py-6">
  <h1 class="text-2xl font-bold mb-4">User Blocks</h1>

  <table class="w-full border-collapse bg-white shadow rounded">
    <thead>
      <tr class="bg-gray-100">
        <th class="p-3 text-left">Blocker</th>
        <th class="p-3 text-left">Blocked</th>
        <th class="p-3 text-left">Date</th>
      </tr>
    </thead>
    <tbody>
      <% blocks.forEach(block => { %>
      <tr class="border-t">
        <td class="p-3"><%= block.blocker?.name || block.blocker_id %><br><small class="text-gray-500"><%= block.blocker?.email || '' %></small></td>
        <td class="p-3"><%= block.blocked?.name || block.blocked_id %><br><small class="text-gray-500"><%= block.blocked?.email || '' %></small></td>
        <td class="p-3"><%= new Date(block.created_at).toLocaleDateString() %></td>
      </tr>
      <% }) %>
    </tbody>
  </table>

  <div class="flex justify-center gap-2 mt-4">
    <% for (let i = 1; i <= totalPages; i++) { %>
      <a href="?page=<%= i %>"
         class="px-3 py-1 rounded <%= i === page ? 'bg-purple-600 text-white' : 'bg-gray-200' %>">
        <%= i %>
      </a>
    <% } %>
  </div>
</div>

<%- include('partials/footer') %>
```

- [ ] **Step 5: Commit**

```bash
git add qulo-server/src/admin/admin.service.ts qulo-server/src/admin/admin.controller.ts qulo-server/src/admin/admin.routes.ts qulo-server/src/admin/views/blocks.ejs
git commit -m "feat(server): add admin blocks management page"
```

- [ ] **Step 6: Run /server-review**

Server phase tamamlandı. Server review skill'ini çalıştır.

---

## Phase 3: Web

### Task 9: FAQ / Help Page

**Files:**
- Create: `web/src/app/[locale]/help/page.tsx`
- Modify: `web/src/lib/i18n/dictionaries/tr.json`
- Modify: `web/src/lib/i18n/dictionaries/en.json`

- [ ] **Step 1: Add translations**

Add to `web/src/lib/i18n/dictionaries/tr.json`:

```json
"help": {
  "title": "Yardım Merkezi",
  "subtitle": "Sık sorulan sorular ve destek",
  "categories": {
    "account": "Hesap & Giriş",
    "matching": "Eşleşme & Sorular",
    "diamonds": "Elmas & Premium",
    "security": "Güvenlik & Gizlilik",
    "technical": "Teknik Sorunlar"
  },
  "faq": {
    "account_reset_password_q": "Şifremi nasıl sıfırlarım?",
    "account_reset_password_a": "Giriş ekranında 'Şifremi Unuttum' butonuna tıklayın. Email adresinize bir sıfırlama bağlantısı gönderilecektir.",
    "account_delete_q": "Hesabımı nasıl silebilirim?",
    "account_delete_a": "Ayarlar > Hesabı Sil bölümünden hesabınızı kalıcı olarak silebilirsiniz. Bu işlem geri alınamaz.",
    "account_banned_q": "Hesabım askıya alındı, ne yapmalıyım?",
    "account_banned_a": "Hesabınız topluluk kurallarını ihlal ettiği için askıya alınmış olabilir. Detaylı bilgi için support@quloapp.com adresine yazın.",
    "matching_how_q": "Eşleşme nasıl çalışır?",
    "matching_how_a": "Sorular oluşturun, diğer kullanıcılar sorularınızı çözsün. Doğru cevaplar eşleşme sağlar. Ne kadar çok soru oluşturursanız, o kadar çok eşleşme şansınız olur.",
    "matching_questions_q": "Soru nasıl oluşturulur?",
    "matching_questions_a": "Ana ekrandan '+' butonuna tıklayın. 2 ile 10 arasında soru ekleyin, her soruya 4 seçenek girin ve doğru cevabı işaretleyin.",
    "diamonds_what_q": "Elmaslar ne işe yarar?",
    "diamonds_what_a": "Yeşil elmaslar güçleri kullanmak için, mor elmaslar özel özellikleri açmak için kullanılır. Yeşil elmasları sorularınız çözüldüğünde kazanırsınız.",
    "diamonds_buy_q": "Elmas nasıl satın alınır?",
    "diamonds_buy_a": "Profil ekranındaki elmas simgesine tıklayarak mor elmas paketlerini satın alabilirsiniz.",
    "security_block_q": "Birini nasıl engellerim?",
    "security_block_a": "Kullanıcının profilinde veya sohbet ekranında üç nokta menüsünden 'Engelle' seçeneğini kullanın. Engellenen kullanıcı sizi göremez ve mesaj gönderemez.",
    "security_report_q": "Birini nasıl bildiririm?",
    "security_report_a": "Kullanıcının profilinde veya sohbet ekranında üç nokta menüsünden 'Bildir' seçeneğini kullanın. Bildirmeniz ekibimiz tarafından incelenecektir.",
    "security_data_q": "Verilerim güvende mi?",
    "security_data_a": "Tüm verileriniz şifreli olarak saklanır. Gizlilik politikamızı incelemek için ayarlar ekranından erişebilirsiniz.",
    "technical_connection_q": "Bağlantı sorunu yaşıyorum",
    "technical_connection_a": "İnternet bağlantınızı kontrol edin. Sorun devam ederse uygulamayı kapatıp tekrar açın. WiFi ve mobil veri arasında geçiş yapmayı deneyin.",
    "technical_notification_q": "Bildirimler gelmiyor",
    "technical_notification_a": "Telefon ayarlarından Qulo için bildirimlerin açık olduğunu kontrol edin. Uygulama içi ayarlardan bildirim tercihlerinizi düzenleyebilirsiniz."
  },
  "still_need_help": "Sorunun hâlâ çözülmedi mi?",
  "still_need_help_desc": "Uygulamadan destek talebi oluşturabilir veya bize email gönderebilirsiniz.",
  "contact_email": "support@quloapp.com",
  "open_app": "Uygulamayı Aç"
}
```

- [ ] **Step 2: Add English translations**

Add to `web/src/lib/i18n/dictionaries/en.json`:

```json
"help": {
  "title": "Help Center",
  "subtitle": "Frequently asked questions and support",
  "categories": {
    "account": "Account & Login",
    "matching": "Matching & Questions",
    "diamonds": "Diamonds & Premium",
    "security": "Security & Privacy",
    "technical": "Technical Issues"
  },
  "faq": {
    "account_reset_password_q": "How do I reset my password?",
    "account_reset_password_a": "Tap 'Forgot Password' on the login screen. A reset link will be sent to your email address.",
    "account_delete_q": "How do I delete my account?",
    "account_delete_a": "Go to Settings > Delete Account to permanently delete your account. This action cannot be undone.",
    "account_banned_q": "My account is suspended, what should I do?",
    "account_banned_a": "Your account may have been suspended for violating community guidelines. Contact support@quloapp.com for details.",
    "matching_how_q": "How does matching work?",
    "matching_how_a": "Create questions for others to solve. Correct answers lead to matches. The more questions you create, the more chances you have to match.",
    "matching_questions_q": "How do I create a question?",
    "matching_questions_a": "Tap the '+' button on the main screen. Add 2 to 10 questions, enter 4 options for each, and mark the correct answer.",
    "diamonds_what_q": "What are diamonds for?",
    "diamonds_what_a": "Green diamonds are used for powers, purple diamonds unlock special features. You earn green diamonds when your questions are solved.",
    "diamonds_buy_q": "How do I buy diamonds?",
    "diamonds_buy_a": "Tap the diamond icon on your profile to purchase purple diamond packs.",
    "security_block_q": "How do I block someone?",
    "security_block_a": "Use the three-dot menu on a user's profile or in the chat screen and select 'Block'. Blocked users cannot see you or send messages.",
    "security_report_q": "How do I report someone?",
    "security_report_a": "Use the three-dot menu on a user's profile or in the chat screen and select 'Report'. Your report will be reviewed by our team.",
    "security_data_q": "Is my data safe?",
    "security_data_a": "All your data is stored encrypted. You can review our privacy policy from the settings screen.",
    "technical_connection_q": "I'm having connection issues",
    "technical_connection_a": "Check your internet connection. If the issue persists, close and reopen the app. Try switching between WiFi and mobile data.",
    "technical_notification_q": "I'm not receiving notifications",
    "technical_notification_a": "Check that notifications are enabled for Qulo in your phone settings. You can also manage notification preferences in the app settings."
  },
  "still_need_help": "Still need help?",
  "still_need_help_desc": "You can create a support ticket from the app or send us an email.",
  "contact_email": "support@quloapp.com",
  "open_app": "Open App"
}
```

- [ ] **Step 3: Create help page**

Create `web/src/app/[locale]/help/page.tsx`:

```tsx
"use client";

import { useTranslations } from "next-intl";
import { useState } from "react";
import { Navbar } from "@/components/shared/Navbar";

interface FaqItem {
  question: string;
  answer: string;
}

interface FaqCategory {
  key: string;
  label: string;
  items: FaqItem[];
}

export default function HelpPage() {
  const t = useTranslations("help");
  const [openIndex, setOpenIndex] = useState<string | null>(null);

  const categories: FaqCategory[] = [
    {
      key: "account",
      label: t("categories.account"),
      items: [
        { question: t("faq.account_reset_password_q"), answer: t("faq.account_reset_password_a") },
        { question: t("faq.account_delete_q"), answer: t("faq.account_delete_a") },
        { question: t("faq.account_banned_q"), answer: t("faq.account_banned_a") },
      ],
    },
    {
      key: "matching",
      label: t("categories.matching"),
      items: [
        { question: t("faq.matching_how_q"), answer: t("faq.matching_how_a") },
        { question: t("faq.matching_questions_q"), answer: t("faq.matching_questions_a") },
      ],
    },
    {
      key: "diamonds",
      label: t("categories.diamonds"),
      items: [
        { question: t("faq.diamonds_what_q"), answer: t("faq.diamonds_what_a") },
        { question: t("faq.diamonds_buy_q"), answer: t("faq.diamonds_buy_a") },
      ],
    },
    {
      key: "security",
      label: t("categories.security"),
      items: [
        { question: t("faq.security_block_q"), answer: t("faq.security_block_a") },
        { question: t("faq.security_report_q"), answer: t("faq.security_report_a") },
        { question: t("faq.security_data_q"), answer: t("faq.security_data_a") },
      ],
    },
    {
      key: "technical",
      label: t("categories.technical"),
      items: [
        { question: t("faq.technical_connection_q"), answer: t("faq.technical_connection_a") },
        { question: t("faq.technical_notification_q"), answer: t("faq.technical_notification_a") },
      ],
    },
  ];

  const toggleItem = (id: string) => {
    setOpenIndex(openIndex === id ? null : id);
  };

  return (
    <>
      <Navbar />
      <main className="pt-24 pb-20 px-6">
        <div className="max-w-2xl mx-auto">
          {/* Header */}
          <h1 className="text-3xl font-bold text-qulo-text-primary mb-2">{t("title")}</h1>
          <p className="text-qulo-text-secondary mb-10">{t("subtitle")}</p>

          {/* FAQ Categories */}
          {categories.map((category) => (
            <div key={category.key} className="mb-8">
              <h2 className="text-xl font-semibold text-qulo-purple mb-4">{category.label}</h2>
              <div className="space-y-2">
                {category.items.map((item, idx) => {
                  const itemId = `${category.key}-${idx}`;
                  const isOpen = openIndex === itemId;
                  return (
                    <div
                      key={itemId}
                      className="bg-qulo-bg-card rounded-lg border border-qulo-bg-surface overflow-hidden"
                    >
                      <button
                        onClick={() => toggleItem(itemId)}
                        className="w-full text-left px-5 py-4 flex items-center justify-between hover:bg-qulo-bg-surface transition-colors"
                      >
                        <span className="text-qulo-text-primary font-medium">{item.question}</span>
                        <svg
                          className={`w-5 h-5 text-qulo-text-muted transition-transform ${isOpen ? "rotate-180" : ""}`}
                          fill="none"
                          viewBox="0 0 24 24"
                          stroke="currentColor"
                        >
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                        </svg>
                      </button>
                      {isOpen && (
                        <div className="px-5 pb-4 text-qulo-text-secondary leading-relaxed">
                          {item.answer}
                        </div>
                      )}
                    </div>
                  );
                })}
              </div>
            </div>
          ))}

          {/* Still Need Help */}
          <div className="mt-12 bg-qulo-bg-card rounded-xl border border-qulo-bg-surface p-8 text-center">
            <h2 className="text-xl font-semibold text-qulo-text-primary mb-2">{t("still_need_help")}</h2>
            <p className="text-qulo-text-secondary mb-6">{t("still_need_help_desc")}</p>
            <a
              href={`mailto:${t("contact_email")}`}
              className="inline-block bg-qulo-purple text-white font-medium px-6 py-3 rounded-lg hover:bg-qulo-purple-dark transition-colors"
            >
              {t("contact_email")}
            </a>
          </div>
        </div>
      </main>
    </>
  );
}
```

- [ ] **Step 4: Commit**

```bash
git add web/src/app/[locale]/help/page.tsx web/src/lib/i18n/dictionaries/tr.json web/src/lib/i18n/dictionaries/en.json
git commit -m "feat(web): add FAQ/help center page"
```

- [ ] **Step 5: Run /web-security-review + /web-code-quality**

Web phase tamamlandı. Web review skill'lerini çalıştır.

---

## Phase 4: Mobile

### Task 10: Support Ticket Service & Repository

**Files:**
- Create: `qulov2/lib/core/network/services/support_ticket_service.dart`
- Create: `qulov2/lib/data/models/support_ticket_model.dart`
- Create: `qulov2/lib/data/repositories/support_ticket_repository.dart`
- Modify: `qulov2/lib/data/repositories/interfaces.dart`
- Modify: `qulov2/lib/providers/api_provider.dart`

- [ ] **Step 1: Create model**

```dart
// qulov2/lib/data/models/support_ticket_model.dart
class SupportTicketModel {
  final String id;
  final String subject;
  final String category;
  final String status;
  final String message;
  final String? adminReply;
  final DateTime? repliedAt;
  final DateTime createdAt;

  const SupportTicketModel({
    required this.id,
    required this.subject,
    required this.category,
    required this.status,
    required this.message,
    this.adminReply,
    this.repliedAt,
    required this.createdAt,
  });

  factory SupportTicketModel.fromJson(Map<String, dynamic> json) {
    return SupportTicketModel(
      id: json['id'] as String,
      subject: json['subject'] as String,
      category: json['category'] as String,
      status: json['status'] as String,
      message: json['message'] ?? '',
      adminReply: json['admin_reply'] as String?,
      repliedAt: json['replied_at'] != null ? DateTime.parse(json['replied_at']) : null,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
```

- [ ] **Step 2: Create Retrofit service**

```dart
// qulov2/lib/core/network/services/support_ticket_service.dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'support_ticket_service.g.dart';

@RestApi()
abstract class SupportTicketService {
  factory SupportTicketService(Dio dio) = _SupportTicketService;

  @POST('/support-tickets')
  Future<dynamic> createTicket(@Body() Map<String, dynamic> data);

  @GET('/support-tickets')
  Future<List<dynamic>> getMyTickets();

  @GET('/support-tickets/{id}')
  Future<dynamic> getTicket(@Path('id') String id);
}
```

- [ ] **Step 3: Run code generation**

```bash
cd qulov2 && dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 4: Create repository**

```dart
// qulov2/lib/data/repositories/support_ticket_repository.dart
import 'package:dio/dio.dart';
import '../models/support_ticket_model.dart';
import '../../core/network/result.dart';
import '../../core/network/services/support_ticket_service.dart';
import 'interfaces.dart';

class SupportTicketRepository implements ISupportTicketRepository {
  final SupportTicketService _service;
  SupportTicketRepository(this._service);

  @override
  Future<Result<SupportTicketModel>> createTicket({
    required String subject,
    required String message,
    required String category,
  }) async {
    try {
      final response = await _service.createTicket({
        'subject': subject,
        'message': message,
        'category': category,
      });
      return Success(SupportTicketModel.fromJson(response));
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }

  @override
  Future<Result<List<SupportTicketModel>>> getMyTickets() async {
    try {
      final response = await _service.getMyTickets();
      final tickets = response.map((e) => SupportTicketModel.fromJson(e)).toList();
      return Success(tickets);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }

  @override
  Future<Result<SupportTicketModel>> getTicket(String id) async {
    try {
      final response = await _service.getTicket(id);
      return Success(SupportTicketModel.fromJson(response));
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }
}
```

- [ ] **Step 5: Add interface**

Add to `qulov2/lib/data/repositories/interfaces.dart`:

```dart
abstract class ISupportTicketRepository {
  Future<Result<SupportTicketModel>> createTicket({
    required String subject,
    required String message,
    required String category,
  });
  Future<Result<List<SupportTicketModel>>> getMyTickets();
  Future<Result<SupportTicketModel>> getTicket(String id);
}
```

Import the model at top.

- [ ] **Step 6: Register providers**

Add to `qulov2/lib/providers/api_provider.dart`:

```dart
final supportTicketServiceProvider = Provider<SupportTicketService>(
  (ref) => SupportTicketService(ref.read(networkManagerProvider).dio),
);

final supportTicketRepositoryProvider = Provider<SupportTicketRepository>(
  (ref) => SupportTicketRepository(ref.read(supportTicketServiceProvider)),
);
```

- [ ] **Step 7: Commit**

```bash
git add qulov2/lib/core/network/services/support_ticket_service.dart qulov2/lib/core/network/services/support_ticket_service.g.dart qulov2/lib/data/models/support_ticket_model.dart qulov2/lib/data/repositories/support_ticket_repository.dart qulov2/lib/data/repositories/interfaces.dart qulov2/lib/providers/api_provider.dart
git commit -m "feat(mobile): add support ticket service, repository & model"
```

---

### Task 11: Block Service — Get Blocked Users

**Files:**
- Modify: `qulov2/lib/core/network/services/block_service.dart`
- Modify: `qulov2/lib/data/repositories/block_repository.dart`
- Modify: `qulov2/lib/data/repositories/interfaces.dart`

- [ ] **Step 1: Add GET to block service**

Add to `block_service.dart`:

```dart
@GET('/blocks')
Future<List<dynamic>> getBlockedUsers();
```

- [ ] **Step 2: Run code generation**

```bash
cd qulov2 && dart run build_runner build --delete-conflicting-outputs
```

- [ ] **Step 3: Add to repository**

Add to `block_repository.dart`:

```dart
@override
Future<Result<List<Map<String, dynamic>>>> getBlockedUsers() async {
  try {
    final response = await _service.getBlockedUsers();
    return Success(response.cast<Map<String, dynamic>>());
  } on DioException catch (e) {
    return Failure(e.toAppFailure());
  }
}
```

Add interface method to `interfaces.dart`:

```dart
// In IBlockRepository:
Future<Result<List<Map<String, dynamic>>>> getBlockedUsers();
```

- [ ] **Step 4: Commit**

```bash
git add qulov2/lib/core/network/services/block_service.dart qulov2/lib/core/network/services/block_service.g.dart qulov2/lib/data/repositories/block_repository.dart qulov2/lib/data/repositories/interfaces.dart
git commit -m "feat(mobile): add blocked users list to block service"
```

---

### Task 12: Report Category UI

**Files:**
- Create: `qulov2/lib/features/profile_detail/widgets/report_category_sheet.dart`
- Modify: `qulov2/lib/core/network/services/report_service.dart`
- Modify: `qulov2/lib/data/repositories/report_repository.dart`
- Modify: `qulov2/lib/features/profile_detail/mixins/profile_detail_screen_mixin.dart`

- [ ] **Step 1: Update report service**

Update `report_service.dart` — body already sends Map, no change needed. The `category` field will be added to the body map in the repository.

- [ ] **Step 2: Update report repository**

Modify `report_repository.dart` `createReport` method:

```dart
@override
Future<Result<void>> createReport({
  required String reportedId,
  required String reason,
  required String category,
  String? description,
}) async {
  try {
    await _service.createReport({
      'reported_id': reportedId,
      'reason': reason,
      'category': category,
      if (description != null) 'description': description,
    });
    return const Success(null);
  } on DioException catch (e) {
    return Failure(e.toAppFailure());
  }
}
```

Update interface in `interfaces.dart` too — add `required String category` param.

- [ ] **Step 3: Create category sheet widget**

```dart
// qulov2/lib/features/profile_detail/widgets/report_category_sheet.dart
import 'package:flutter/material.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/theme/app_spacing.dart';

class ReportCategorySheet extends StatelessWidget {
  final void Function(String category) onSelected;

  const ReportCategorySheet({super.key, required this.onSelected});

  static const _categories = [
    ('INAPPROPRIATE_CONTENT', 'report_cat_inappropriate'),
    ('FAKE_PROFILE', 'report_cat_fake'),
    ('SPAM', 'report_cat_spam'),
    ('HARASSMENT', 'report_cat_harassment'),
    ('UNDERAGE', 'report_cat_underage'),
    ('SCAM', 'report_cat_scam'),
    ('OFFENSIVE_PHOTOS', 'report_cat_offensive_photos'),
    ('THREATENING', 'report_cat_threatening'),
    ('IMPERSONATION', 'report_cat_impersonation'),
    ('OTHER', 'report_cat_other'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: AppSpacing.sm, bottom: AppSpacing.md),
            decoration: BoxDecoration(
              color: context.appColors.textSecondary.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text(
              context.tr('report_select_category'),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final (value, labelKey) = _categories[index];
                return ListTile(
                  title: Text(context.tr(labelKey)),
                  onTap: () {
                    Navigator.pop(context);
                    onSelected(value);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 4: Update profile detail mixin**

Modify `_showReportDialog` in `profile_detail_screen_mixin.dart` to be a two-step flow:

```dart
void _showReportDialog() {
  // Step 1: Show category picker
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusLg)),
    ),
    builder: (_) => ReportCategorySheet(
      onSelected: (category) => _showReportReasonDialog(category),
    ),
  );
}

void _showReportReasonDialog(String category) {
  final nav = ref.read(navigationServiceProvider);
  final controller = TextEditingController();
  final isOther = category == 'OTHER';

  nav.showAppDialog(
    CustomDialog(
      name: 'report_reason',
      builder: (ctx) => AlertDialog(
        title: Text(context.tr('report_reason_title')),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: context.tr(isOther ? 'report_reason_required' : 'report_reason_optional'),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => nav.closeOverlay(),
            child: Text(context.tr('cancel')),
          ),
          FilledButton(
            onPressed: () async {
              final reason = controller.text.trim();
              if (isOther && reason.isEmpty) return; // OTHER requires reason
              nav.closeOverlay();
              await ref.read(reportRepositoryProvider).createReport(
                reportedId: widget.userId,
                reason: reason.isNotEmpty ? reason : category,
                category: category,
              );
              controller.dispose();
            },
            child: Text(context.tr('report')),
          ),
        ],
      ),
    ),
  );
}
```

Import `ReportCategorySheet` at top.

- [ ] **Step 5: Commit**

```bash
git add qulov2/lib/features/profile_detail/widgets/report_category_sheet.dart qulov2/lib/features/profile_detail/mixins/profile_detail_screen_mixin.dart qulov2/lib/data/repositories/report_repository.dart qulov2/lib/data/repositories/interfaces.dart
git commit -m "feat(mobile): add report category selection flow"
```

---

### Task 13: Chat Popup Menu (Report/Block)

**Files:**
- Create: `qulov2/lib/features/chat/widgets/chat_popup_menu.dart`
- Modify: `qulov2/lib/features/chat/screens/chat_screen.dart`
- Modify: `qulov2/lib/features/chat/mixins/chat_screen_mixin.dart`

- [ ] **Step 1: Create popup menu widget**

```dart
// qulov2/lib/features/chat/widgets/chat_popup_menu.dart
import 'package:flutter/material.dart';
import '../../../core/extensions/context_extensions.dart';

class ChatPopupMenu extends StatelessWidget {
  final VoidCallback onReport;
  final VoidCallback onBlock;
  final VoidCallback? onUnmatch;
  final VoidCallback? onMediaDisable;
  final bool mediaEnabled;

  const ChatPopupMenu({
    super.key,
    required this.onReport,
    required this.onBlock,
    this.onUnmatch,
    this.onMediaDisable,
    this.mediaEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        switch (value) {
          case 'report':
            onReport();
          case 'block':
            onBlock();
          case 'unmatch':
            onUnmatch?.call();
          case 'disable_media':
            onMediaDisable?.call();
        }
      },
      itemBuilder: (context) => [
        if (mediaEnabled && onMediaDisable != null)
          PopupMenuItem(
            value: 'disable_media',
            child: Row(
              children: [
                Icon(Icons.image_not_supported, size: 20, color: context.appColors.textSecondary),
                const SizedBox(width: 12),
                Text(context.tr('disable_media')),
              ],
            ),
          ),
        if (onUnmatch != null)
          PopupMenuItem(
            value: 'unmatch',
            child: Row(
              children: [
                Icon(Icons.heart_broken, size: 20, color: context.appColors.warning),
                const SizedBox(width: 12),
                Text(context.tr('unmatch')),
              ],
            ),
          ),
        PopupMenuItem(
          value: 'report',
          child: Row(
            children: [
              Icon(Icons.flag_outlined, size: 20, color: context.appColors.warning),
              const SizedBox(width: 12),
              Text(context.tr('report')),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'block',
          child: Row(
            children: [
              Icon(Icons.block, size: 20, color: context.appColors.error),
              const SizedBox(width: 12),
              Text(context.tr('block')),
            ],
          ),
        ),
      ],
    );
  }
}
```

- [ ] **Step 2: Add report/block logic to chat mixin**

Add to `chat_screen_mixin.dart`:

```dart
void onChatReport() {
  AnalyticsManager.instance.logEvent(AnalyticsEvents.chatReport, params: {'matchId': widget.matchId});
  _showChatReportCategorySheet();
}

void _showChatReportCategorySheet() {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusLg)),
    ),
    builder: (_) => ReportCategorySheet(
      onSelected: (category) => _showChatReportReasonDialog(category),
    ),
  );
}

void _showChatReportReasonDialog(String category) {
  final nav = ref.read(navigationServiceProvider);
  final controller = TextEditingController();
  final isOther = category == 'OTHER';

  // Get the other user's ID from match
  final match = ref.read(matchListProvider).valueOrNull
      ?.firstWhere((m) => m.matchId == widget.matchId, orElse: () => throw StateError(''));
  final targetUserId = match?.user.id;
  if (targetUserId == null) return;

  nav.showAppDialog(
    CustomDialog(
      name: 'chat_report_reason',
      builder: (ctx) => AlertDialog(
        title: Text(context.tr('report_reason_title')),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: context.tr(isOther ? 'report_reason_required' : 'report_reason_optional'),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(onPressed: () => nav.closeOverlay(), child: Text(context.tr('cancel'))),
          FilledButton(
            onPressed: () async {
              final reason = controller.text.trim();
              if (isOther && reason.isEmpty) return;
              nav.closeOverlay();
              await ref.read(reportRepositoryProvider).createReport(
                reportedId: targetUserId,
                reason: reason.isNotEmpty ? reason : category,
                category: category,
              );
              controller.dispose();
            },
            child: Text(context.tr('report')),
          ),
        ],
      ),
    ),
  );
}

void onChatBlock() {
  final nav = ref.read(navigationServiceProvider);
  final match = ref.read(matchListProvider).valueOrNull
      ?.firstWhere((m) => m.matchId == widget.matchId, orElse: () => throw StateError(''));
  final targetUserId = match?.user.id;
  if (targetUserId == null) return;

  AnalyticsManager.instance.logEvent(AnalyticsEvents.chatBlock, params: {'matchId': widget.matchId});

  nav.showAppDialog<bool>(
    ConfirmDialog(
      name: 'chat_block_user',
      title: context.tr('block_user_title'),
      message: context.tr('block_user_message'),
      confirmText: context.tr('block'),
      cancelText: context.tr('cancel'),
      isDestructive: true,
    ),
  ).then((confirmed) async {
    if (confirmed != true) return;
    await ref.read(blockRepositoryProvider).blockUser(targetUserId);
    if (mounted) {
      ref.read(navigationServiceProvider).pop();
    }
  });
}
```

Import `ReportCategorySheet` and `reportRepositoryProvider`, `blockRepositoryProvider`.

- [ ] **Step 3: Replace ChatAppBarActions in chat screen**

In `chat_screen.dart`, replace the `actions` in AppBar:

```dart
actions: [
  ChatPopupMenu(
    mediaEnabled: mediaEnabled,
    onReport: onChatReport,
    onBlock: onChatBlock,
    onUnmatch: confirmUnmatch,
    onMediaDisable: mediaEnabled ? handleDisableMedia : null,
  ),
],
```

Import `ChatPopupMenu`. Remove or keep `ChatAppBarActions` import depending on whether it was used elsewhere.

- [ ] **Step 4: Commit**

```bash
git add qulov2/lib/features/chat/widgets/chat_popup_menu.dart qulov2/lib/features/chat/screens/chat_screen.dart qulov2/lib/features/chat/mixins/chat_screen_mixin.dart
git commit -m "feat(mobile): add report/block popup menu to chat screen"
```

---

### Task 14: Blocked Users Screen

**Files:**
- Create: `qulov2/lib/features/settings/screens/blocked_users_screen.dart`

- [ ] **Step 1: Create screen**

```dart
// qulov2/lib/features/settings/screens/blocked_users_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../providers/api_provider.dart';

final _blockedUsersProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final result = await ref.read(blockRepositoryProvider).getBlockedUsers();
  return result.when(
    success: (data) => data,
    failure: (_) => <Map<String, dynamic>>[],
  );
});

class BlockedUsersScreen extends ConsumerWidget {
  const BlockedUsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockedUsers = ref.watch(_blockedUsersProvider);

    return AppScaffold(
      title: context.tr('blocked_users'),
      body: blockedUsers.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(child: Text(context.tr('error_generic'))),
        data: (users) {
          if (users.isEmpty) {
            return Center(
              child: Text(
                context.tr('no_blocked_users'),
                style: TextStyle(color: context.appColors.textSecondary),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final item = users[index];
              final user = item['user'] as Map<String, dynamic>? ?? {};
              final name = user['name'] as String? ?? 'Unknown';
              final photos = (user['photos'] as List?) ?? [];
              final photoUrl = photos.isNotEmpty ? photos.first as String? : null;

              return Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
                    child: photoUrl == null ? const Icon(Icons.person) : null,
                  ),
                  title: Text(name),
                  trailing: TextButton(
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(context.tr('unblock_confirm_title')),
                          content: Text(context.tr('unblock_confirm_message')),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context, false), child: Text(context.tr('cancel'))),
                            FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(context.tr('unblock'))),
                          ],
                        ),
                      );
                      if (confirmed == true) {
                        final userId = user['id'] as String;
                        await ref.read(blockRepositoryProvider).unblockUser(userId);
                        ref.invalidate(_blockedUsersProvider);
                      }
                    },
                    child: Text(
                      context.tr('unblock'),
                      style: TextStyle(color: context.appColors.error),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add qulov2/lib/features/settings/screens/blocked_users_screen.dart
git commit -m "feat(mobile): add blocked users management screen"
```

---

### Task 15: My Tickets & Create Ticket Screens

**Files:**
- Create: `qulov2/lib/features/settings/screens/my_tickets_screen.dart`
- Create: `qulov2/lib/features/settings/screens/create_ticket_screen.dart`

- [ ] **Step 1: Create my tickets screen**

```dart
// qulov2/lib/features/settings/screens/my_tickets_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../data/models/support_ticket_model.dart';
import '../../../providers/api_provider.dart';
import 'create_ticket_screen.dart';

final _myTicketsProvider = FutureProvider<List<SupportTicketModel>>((ref) async {
  final result = await ref.read(supportTicketRepositoryProvider).getMyTickets();
  return result.when(
    success: (data) => data,
    failure: (_) => <SupportTicketModel>[],
  );
});

class MyTicketsScreen extends ConsumerWidget {
  const MyTicketsScreen({super.key});

  Color _statusColor(String status, BuildContext context) {
    return switch (status) {
      'OPEN' => context.appColors.warning,
      'IN_PROGRESS' => Colors.blue,
      'RESOLVED' => context.appColors.success,
      'CLOSED' => context.appColors.textMuted,
      _ => context.appColors.textSecondary,
    };
  }

  String _statusLabel(String status, BuildContext context) {
    return switch (status) {
      'OPEN' => context.tr('ticket_status_open'),
      'IN_PROGRESS' => context.tr('ticket_status_in_progress'),
      'RESOLVED' => context.tr('ticket_status_resolved'),
      'CLOSED' => context.tr('ticket_status_closed'),
      _ => status,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tickets = ref.watch(_myTicketsProvider);

    return AppScaffold(
      title: context.tr('my_tickets'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateTicketScreen()));
            ref.invalidate(_myTicketsProvider);
          },
        ),
      ],
      body: tickets.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(child: Text(context.tr('error_generic'))),
        data: (list) {
          if (list.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.support_agent, size: 64, color: context.appColors.textMuted),
                  const SizedBox(height: AppSpacing.md),
                  Text(context.tr('no_tickets'), style: TextStyle(color: context.appColors.textSecondary)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final ticket = list[index];
              return Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: ListTile(
                  title: Text(ticket.subject, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text(
                    ticket.adminReply != null ? context.tr('ticket_replied') : ticket.category,
                    style: TextStyle(
                      color: ticket.adminReply != null ? context.appColors.success : context.appColors.textSecondary,
                    ),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _statusColor(ticket.status, context).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _statusLabel(ticket.status, context),
                      style: TextStyle(fontSize: 12, color: _statusColor(ticket.status, context), fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
```

- [ ] **Step 2: Create ticket form screen**

```dart
// qulov2/lib/features/settings/screens/create_ticket_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../providers/api_provider.dart';

class CreateTicketScreen extends ConsumerStatefulWidget {
  const CreateTicketScreen({super.key});

  @override
  ConsumerState<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends ConsumerState<CreateTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  String _category = 'OTHER';
  bool _isSubmitting = false;

  static const _categories = ['ACCOUNT', 'TECHNICAL', 'BILLING', 'MATCH', 'OTHER'];

  @override
  void dispose() {
    _subjectCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);

    final result = await ref.read(supportTicketRepositoryProvider).createTicket(
      subject: _subjectCtrl.text.trim(),
      message: _messageCtrl.text.trim(),
      category: _category,
    );

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    result.when(
      success: (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.tr('ticket_created_success'))),
        );
        Navigator.pop(context);
      },
      failure: (f) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.tr('error_generic'))),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: context.tr('create_ticket'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            // Category
            Text(context.tr('ticket_category'), style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: AppSpacing.xs),
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _categories.map((c) => DropdownMenuItem(
                value: c,
                child: Text(context.tr('ticket_cat_${c.toLowerCase()}')),
              )).toList(),
              onChanged: (v) => setState(() => _category = v!),
            ),
            const SizedBox(height: AppSpacing.md),

            // Subject
            Text(context.tr('ticket_subject'), style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: AppSpacing.xs),
            TextFormField(
              controller: _subjectCtrl,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: context.tr('ticket_subject_hint'),
              ),
              validator: (v) => (v == null || v.trim().length < 5) ? context.tr('ticket_subject_error') : null,
            ),
            const SizedBox(height: AppSpacing.md),

            // Message
            Text(context.tr('ticket_message'), style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: AppSpacing.xs),
            TextFormField(
              controller: _messageCtrl,
              maxLines: 6,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: context.tr('ticket_message_hint'),
              ),
              validator: (v) => (v == null || v.trim().length < 10) ? context.tr('ticket_message_error') : null,
            ),
            const SizedBox(height: AppSpacing.xl),

            // Submit
            FilledButton(
              onPressed: _isSubmitting ? null : _submit,
              child: _isSubmitting
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(context.tr('submit')),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: Commit**

```bash
git add qulov2/lib/features/settings/screens/my_tickets_screen.dart qulov2/lib/features/settings/screens/create_ticket_screen.dart
git commit -m "feat(mobile): add my tickets and create ticket screens"
```

---

### Task 16: Settings Screen Integration + Help WebView

**Files:**
- Modify: `qulov2/lib/features/settings/screens/settings_screen.dart`
- Modify: `qulov2/lib/features/settings/mixins/settings_screen_mixin.dart`

- [ ] **Step 1: Add callbacks to settings mixin**

Add to `settings_screen_mixin.dart`:

```dart
void onBlockedUsers() {
  ref.read(navigationServiceProvider).push(const BlockedUsersScreen());
}

void onMyTickets() {
  ref.read(navigationServiceProvider).push(const MyTicketsScreen());
}

void onHelp() {
  final locale = ref.read(localeProvider).languageCode;
  final url = '${Env.webBaseUrl}/$locale/help';
  ref.read(navigationServiceProvider).push(
    LegalWebViewScreen(title: context.tr('help_support'), url: url),
  );
}
```

Add necessary imports.

- [ ] **Step 2: Add tiles to settings screen**

Add to `settings_screen.dart` ListView children, before the logout tile:

```dart
const SizedBox(height: AppSpacing.sm),
SettingsActionTile(
  icon: Icons.block,
  title: context.tr('blocked_users'),
  onTap: onBlockedUsers,
),
SettingsActionTile(
  icon: Icons.support_agent,
  title: context.tr('my_tickets'),
  onTap: onMyTickets,
),
SettingsActionTile(
  icon: Icons.help_outline,
  title: context.tr('help_support'),
  onTap: onHelp,
),
```

- [ ] **Step 3: Commit**

```bash
git add qulov2/lib/features/settings/screens/settings_screen.dart qulov2/lib/features/settings/mixins/settings_screen_mixin.dart
git commit -m "feat(mobile): add blocked users, tickets & help to settings"
```

---

### Task 17: Ban Screen + Auth Check

**Files:**
- Create: `qulov2/lib/features/auth/screens/banned_screen.dart`
- Modify: `qulov2/lib/providers/auth_provider.dart`

- [ ] **Step 1: Create banned screen**

```dart
// qulov2/lib/features/auth/screens/banned_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../providers/auth_provider.dart';

class BannedScreen extends ConsumerWidget {
  const BannedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.gpp_bad, size: 80, color: context.appColors.error),
              const SizedBox(height: AppSpacing.lg),
              Text(
                context.tr('account_banned_title'),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                context.tr('account_banned_message'),
                style: TextStyle(color: context.appColors.textSecondary, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'support@quloapp.com',
                style: TextStyle(color: context.appColors.primary, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: AppSpacing.xl),
              FilledButton(
                onPressed: () => ref.read(authProvider.notifier).logout(),
                child: Text(context.tr('logout')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Handle ACCOUNT_BANNED in auth provider**

In `auth_provider.dart`, update the login error handling:

```dart
// In login() method, in the Failure case:
case Failure(:final failure):
  if (failure is ServerFailure && failure.code == 'ACCOUNT_BANNED') {
    state = state.copyWith(isLoading: false, failure: failure, status: AuthStatus.banned);
  } else {
    state = state.copyWith(isLoading: false, failure: failure);
  }
```

Add `banned` to `AuthStatus` enum:

```dart
enum AuthStatus { initial, authenticated, unauthenticated, banned }
```

In the app router/navigation, when `AuthStatus.banned` → navigate to `BannedScreen`.

- [ ] **Step 3: Commit**

```bash
git add qulov2/lib/features/auth/screens/banned_screen.dart qulov2/lib/providers/auth_provider.dart
git commit -m "feat(mobile): add banned screen and auth ban detection"
```

---

### Task 18: Localization Keys

**Files:**
- Modify: `qulov2/lib/core/l10n/translations/tr.dart`
- Modify: `qulov2/lib/core/l10n/translations/en.dart`

- [ ] **Step 1: Add Turkish translation keys**

Add to `tr.dart` translations map:

```dart
// Report categories
'report_select_category': 'Bildirme Nedeni Seçin',
'report_cat_inappropriate': 'Uygunsuz İçerik',
'report_cat_fake': 'Sahte Profil',
'report_cat_spam': 'Spam',
'report_cat_harassment': 'Taciz',
'report_cat_underage': 'Yaş Altı',
'report_cat_scam': 'Dolandırıcılık',
'report_cat_offensive_photos': 'Uygunsuz Fotoğraflar',
'report_cat_threatening': 'Tehdit',
'report_cat_impersonation': 'Kimliğe Bürünme',
'report_cat_other': 'Diğer',
'report_reason_title': 'Açıklama',
'report_reason_optional': 'Opsiyonel açıklama ekleyin...',
'report_reason_required': 'Lütfen detaylı açıklama yazın...',

// Block
'blocked_users': 'Engellenen Kullanıcılar',
'no_blocked_users': 'Engellenen kullanıcı yok',
'unblock': 'Engeli Kaldır',
'unblock_confirm_title': 'Engeli Kaldır',
'unblock_confirm_message': 'Bu kullanıcının engelini kaldırmak istediğinize emin misiniz?',

// Support tickets
'my_tickets': 'Destek Taleplerim',
'no_tickets': 'Henüz destek talebiniz yok',
'create_ticket': 'Destek Talebi Oluştur',
'ticket_created_success': 'Destek talebiniz oluşturuldu',
'ticket_replied': 'Yanıtlandı',
'ticket_category': 'Kategori',
'ticket_subject': 'Konu',
'ticket_subject_hint': 'Sorununuzu kısaca özetleyin',
'ticket_subject_error': 'Konu en az 5 karakter olmalı',
'ticket_message': 'Mesaj',
'ticket_message_hint': 'Sorununuzu detaylı açıklayın',
'ticket_message_error': 'Mesaj en az 10 karakter olmalı',
'ticket_cat_account': 'Hesap',
'ticket_cat_technical': 'Teknik',
'ticket_cat_billing': 'Ödeme',
'ticket_cat_match': 'Eşleşme',
'ticket_cat_other': 'Diğer',
'ticket_status_open': 'Açık',
'ticket_status_in_progress': 'İnceleniyor',
'ticket_status_resolved': 'Çözüldü',
'ticket_status_closed': 'Kapatıldı',

// Help
'help_support': 'Yardım & Destek',

// Ban
'account_banned_title': 'Hesabınız Askıya Alındı',
'account_banned_message': 'Hesabınız topluluk kurallarını ihlal ettiği için askıya alınmıştır. Detaylı bilgi için bize ulaşın.',
```

- [ ] **Step 2: Add English translation keys**

Add to `en.dart` translations map:

```dart
// Report categories
'report_select_category': 'Select Report Reason',
'report_cat_inappropriate': 'Inappropriate Content',
'report_cat_fake': 'Fake Profile',
'report_cat_spam': 'Spam',
'report_cat_harassment': 'Harassment',
'report_cat_underage': 'Underage',
'report_cat_scam': 'Scam',
'report_cat_offensive_photos': 'Offensive Photos',
'report_cat_threatening': 'Threatening',
'report_cat_impersonation': 'Impersonation',
'report_cat_other': 'Other',
'report_reason_title': 'Description',
'report_reason_optional': 'Add optional description...',
'report_reason_required': 'Please write a detailed description...',

// Block
'blocked_users': 'Blocked Users',
'no_blocked_users': 'No blocked users',
'unblock': 'Unblock',
'unblock_confirm_title': 'Unblock',
'unblock_confirm_message': 'Are you sure you want to unblock this user?',

// Support tickets
'my_tickets': 'My Support Tickets',
'no_tickets': 'No support tickets yet',
'create_ticket': 'Create Support Ticket',
'ticket_created_success': 'Your support ticket has been created',
'ticket_replied': 'Replied',
'ticket_category': 'Category',
'ticket_subject': 'Subject',
'ticket_subject_hint': 'Briefly describe your issue',
'ticket_subject_error': 'Subject must be at least 5 characters',
'ticket_message': 'Message',
'ticket_message_hint': 'Describe your issue in detail',
'ticket_message_error': 'Message must be at least 10 characters',
'ticket_cat_account': 'Account',
'ticket_cat_technical': 'Technical',
'ticket_cat_billing': 'Billing',
'ticket_cat_match': 'Match',
'ticket_cat_other': 'Other',
'ticket_status_open': 'Open',
'ticket_status_in_progress': 'In Progress',
'ticket_status_resolved': 'Resolved',
'ticket_status_closed': 'Closed',

// Help
'help_support': 'Help & Support',

// Ban
'account_banned_title': 'Account Suspended',
'account_banned_message': 'Your account has been suspended for violating community guidelines. Contact us for details.',
```

- [ ] **Step 3: Commit**

```bash
git add qulov2/lib/core/l10n/translations/tr.dart qulov2/lib/core/l10n/translations/en.dart
git commit -m "feat(mobile): add localization keys for support, report & block"
```

- [ ] **Step 4: Run /flutter-review + /simplify**

Mobile phase tamamlandı. Flutter review skill'lerini çalıştır.

---

## Summary

| Phase | Tasks | Commits |
|-------|-------|---------|
| DB | 1 | 1 |
| Server | 2-8 | 6 |
| Web | 9 | 1 |
| Mobile | 10-18 | 8 |
| **Total** | **18** | **16** |

Review checkpoints:
- After Task 8: `/server-review`
- After Task 9: `/web-security-review` + `/web-code-quality`
- After Task 18: `/flutter-review` + `/simplify`
