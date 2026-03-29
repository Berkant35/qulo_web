# Support, Report & Block Sistemi — Tasarım Dokümanı

## Tarih: 2026-03-29
## Yaklaşım: Katmanlı (DB → Server → Web → Mobile)

---

## 1. Genel Bakış

Qulo dating app'e eksik olan destek (support), gelişmiş bildirme (report), engelleme (block) ve ban sistemi ekleniyor. Üç katman etkilenir: server (qulo-server), web (FAQ/yardım merkezi), mobile (qulov2).

### Mevcut Durum
- **Report:** Server endpoint + admin panel + mobile UI mevcut. Kategori enum'u DB'de var ama server/mobile'da kullanılmıyor.
- **Block:** Server endpoint + mobile repository mevcut. `blocks` tablosu DB'de var (migration'da tanımlı değil ama çalışıyor). Match deaktive side-effect mevcut.
- **Support:** Hiç yok.
- **Ban:** Admin panelde "Ban & Resolve" hard-delete yapıyor. Soft-ban mekanizması yok.

### Hedef
- Destek ticket sistemi (in-app form + admin panel + email yanıt)
- FAQ/yardım merkezi (web sayfası, mobile'dan WebView)
- Report'a kategori seçimi ekleme
- Block sonrası tam izolasyon (chat gizleme, profil erişim engeli)
- Soft-ban sistemi (is_banned flag, login engeli, geri alınabilir)
- Chat ekranında report/block erişimi
- Engellenen kullanıcılar yönetim ekranı

---

## 2. Veritabanı (Supabase Migration)

### 2.1 `users` tablosuna ban alanları
```sql
ALTER TABLE users ADD COLUMN is_banned BOOLEAN NOT NULL DEFAULT false;
ALTER TABLE users ADD COLUMN banned_at TIMESTAMPTZ;
ALTER TABLE users ADD COLUMN ban_reason TEXT;
```

### 2.2 `support_tickets` tablosu
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

### 2.3 Dokunulmayacak tablolar
- `blocks` — Zaten mevcut (id, blocker_id, blocked_id, created_at)
- `reports.category` — Zaten mevcut (report_category enum)

---

## 3. Server Tarafı (qulo-server)

### 3.1 Ban Sistemi

**Auth middleware güncellemesi:**
- `auth.middleware.ts` — Token doğrulandıktan sonra `is_banned` kontrolü
- Banned ise `403 Forbidden` + `{ code: 'ACCOUNT_BANNED', message: 'Your account has been suspended' }`

**Admin service:**
- `banUser(userId, reason)` — `is_banned=true`, `banned_at=now()`, `ban_reason=reason`, tüm aktif match'leri deaktive et
- `unbanUser(userId)` — `is_banned=false`, `banned_at=null`, `ban_reason=null`
- Mevcut "Ban & Resolve" butonu artık hard-delete yerine soft-ban çağırır

### 3.2 Block İyileştirme

**block.service.ts güncellemesi:**
- `block()` sonrası ek side-effect: chat mesajlarını gizlemek için `hidden_chats` veya mevcut match deaktive yeterli (chat listesi match üzerinden çalışıyorsa, deaktive match = chat gizli)

### 3.3 Report İyileştirme

**report.validator.ts:**
- `category` alanı eklenir (report_category enum, zorunlu)

**report.service.ts:**
- `create(reporterId, reportedId, reason, category)` — category parametresi INSERT'e eklenir

### 3.4 Support Ticket Endpoint'leri

**Yeni route:** `/api/v1/support-tickets`

| Method | Path | Auth | Açıklama |
|--------|------|------|----------|
| POST | `/api/v1/support-tickets` | JWT | Ticket oluştur |
| GET | `/api/v1/support-tickets` | JWT | Kendi ticket'larını listele |
| GET | `/api/v1/support-tickets/:id` | JWT | Ticket detayı |

**Yeni dosyalar:**
- `src/routes/support-ticket.routes.ts`
- `src/controllers/support-ticket.controller.ts`
- `src/services/support-ticket.service.ts`
- `src/validators/support-ticket.validator.ts`

**Validator:**
```typescript
createTicketSchema = {
  subject: string (min 5, max 200),
  message: string (min 10, max 2000),
  category: enum ('ACCOUNT', 'TECHNICAL', 'BILLING', 'MATCH', 'OTHER')
}
```

### 3.5 Block Listesi Endpoint (Yeni)

| Method | Path | Auth | Açıklama |
|--------|------|------|----------|
| GET | `/api/v1/blocks` | JWT | Engellenen kullanıcı listesi (user info ile) |

### 3.6 Admin Ticket Yönetimi

**Yeni admin route'ları:**

| Method | Path | Auth | Açıklama |
|--------|------|------|----------|
| GET | `/admin/tickets` | Session | Ticket listesi (status filter, pagination) |
| GET | `/admin/tickets/:id` | Session | Ticket detayı |
| POST | `/admin/tickets/:id/reply` | Session | Email ile yanıt + status güncelle |

**Yeni admin view'lar:**
- `src/admin/views/tickets.ejs` — Ticket listesi
- `src/admin/views/ticket-detail.ejs` — Ticket detayı + yanıt formu

### 3.7 Admin Block Sayfası

| Method | Path | Auth | Açıklama |
|--------|------|------|----------|
| GET | `/admin/blocks` | Session | Block listesi (pagination, arama) |

**Yeni admin view:**
- `src/admin/views/blocks.ejs`

---

## 4. Web Tarafı (FAQ / Yardım Merkezi)

### 4.1 Konum
- Qulo web projesi içinde `/help` route'u
- Mobile'dan WebView ile açılacak

### 4.2 FAQ Yapısı
Accordion/collapse kategorileri:
1. **Hesap & Giriş** — Şifre sıfırlama, hesap silme, ban durumu
2. **Eşleşme & Sorular** — Nasıl çalışır, soru oluşturma, discover
3. **Elmas & Premium** — Satın alma, iade, güçler
4. **Güvenlik & Gizlilik** — Engelleme, bildirme, veri silme
5. **Teknik Sorunlar** — Bağlantı, bildirim, konum

### 4.3 Destek Formu
- FAQ sayfasının altında "Sorunun hâlâ çözülmedi mi?" bölümü
- Authenticated kullanıcı: ticket formu (subject, category dropdown, message textarea) → `POST /api/v1/support-tickets`
- Unauthenticated kullanıcı: sadece iletişim email adresi gösterilir

### 4.4 Çoklu Dil
- Mevcut web i18n altyapısı (TR + EN)

---

## 5. Mobile Tarafı (Flutter)

### 5.1 Chat Ekranında Report/Block
- Chat AppBar'da `PopupMenuButton` (üç nokta menüsü)
- "Bildir" ve "Engelle" seçenekleri
- Mevcut `profile_detail_screen_mixin.dart` logic'i yeniden kullanılır (ortak utility veya shared mixin)

### 5.2 Block Sonrası Tam İzolasyon
- Match deaktive: server zaten yapıyor
- Chat listesinden gizleme: deaktive match = chat listesinde görünmez (match üzerinden çalışıyorsa)
- Profil erişim engeli: profil detaya gitmeye çalışırsa "Bu kullanıcı engellendi" mesajı
- Discover filtreleme: zaten mevcut

### 5.3 Engellenen Kullanıcılar Yönetimi
- **Konum:** Ayarlar ekranında "Engellenen Kullanıcılar" satırı
- **Yeni ekran:** `features/settings/screens/blocked_users_screen.dart`
- Liste: kullanıcı adı + avatar + "Engeli Kaldır" butonu
- `GET /api/v1/blocks` endpoint'ini kullanır

### 5.4 Report Kategori Seçimi
- Mevcut text dialog yerine iki adımlı flow:
  1. Kategori seçimi (chip veya radio list) — zorunlu
  2. Açıklama text field — OTHER kategorisinde zorunlu, diğerlerinde opsiyonel

### 5.5 Destek Erişimi
- **Ayarlar ekranında:** "Yardım & Destek" satırı → WebView ile `/help` açılır
- **Destek Taleplerim ekranı:** `features/settings/screens/my_tickets_screen.dart` — ticket listesi (status badge: Açık/İnceleniyor/Çözüldü/Kapatıldı)

### 5.6 Ban Durumu Ekranı
- Login response'da `is_banned` kontrolü (403 + ACCOUNT_BANNED code)
- Özel ekran: "Hesabınız askıya alındı" + ban sebebi + destek email adresi
- Otomatik logout

---

## 6. Email Sistemi

### 6.1 Altyapı
- `nodemailer` ile SMTP entegrasyonu
- Railway env vars: `SMTP_HOST`, `SMTP_PORT`, `SMTP_USER`, `SMTP_PASS`, `SMTP_FROM`
- Development'ta email gönderilmez, console'a log'lanır

### 6.2 Email Template
- `src/admin/views/emails/ticket-reply.ejs`
- Qulo logosu + ticket subject + admin yanıtı + "Yanıtlamak için uygulamadan yeni ticket açın" notu
- Responsive HTML email

---

## 7. Yeni API Endpoint Özeti

| Method | Path | Auth | Modül |
|--------|------|------|-------|
| POST | `/api/v1/support-tickets` | JWT | Support |
| GET | `/api/v1/support-tickets` | JWT | Support |
| GET | `/api/v1/support-tickets/:id` | JWT | Support |
| GET | `/api/v1/blocks` | JWT | Block |
| GET | `/admin/tickets` | Session | Admin |
| GET | `/admin/tickets/:id` | Session | Admin |
| POST | `/admin/tickets/:id/reply` | Session | Admin |
| GET | `/admin/blocks` | Session | Admin |

**Güncellenen endpoint'ler:**
| Method | Path | Değişiklik |
|--------|------|-----------|
| POST | `/api/v1/reports` | `category` alanı eklendi |
| POST | `/admin/reports/:id/action` | Ban artık soft-delete |

---

## 8. Yeni Dosya Listesi

### Server
- `src/routes/support-ticket.routes.ts`
- `src/controllers/support-ticket.controller.ts`
- `src/services/support-ticket.service.ts`
- `src/validators/support-ticket.validator.ts`
- `src/services/email.service.ts`
- `src/admin/views/tickets.ejs`
- `src/admin/views/ticket-detail.ejs`
- `src/admin/views/blocks.ejs`
- `src/admin/views/emails/ticket-reply.ejs`

### Mobile
- `features/settings/screens/blocked_users_screen.dart`
- `features/settings/screens/my_tickets_screen.dart`
- `features/chat/widgets/chat_popup_menu.dart`

### Web
- `app/[locale]/help/page.tsx` (veya mevcut yapıya uygun)

---

## 9. Review Kuralları
- Server geliştirmesi sonrası → `/server-review` (SOLID + Security)
- Flutter geliştirmesi sonrası → `/flutter-review` + `/simplify`
- Web geliştirmesi sonrası → `/web-security-review` + `/web-code-quality`
