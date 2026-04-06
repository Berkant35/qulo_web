# Skill Lifecycle System Design

**Tarih:** 2026-04-06
**Kapsam:** `/readyToQulo` + `/closeToQulo` + Skill Dashboard GUI

---

## 1. Problem

Her yeni Claude Code session'inda proje context'i sifirdan basliyor. Memory dosyalari var ama guncel feature haritasi, aktif branch durumu, businessCaseSkills tetikleme bilgisi her seferinde manuel kesfedilmek zorunda. Session sonunda da yapilan isler, ogrenilenler ve yeni skill ihtiyaclari kaybolabiliyor.

## 2. Cozum

Uc parcali bir skill lifecycle sistemi:

1. **`/readyToQulo`** — Session basi proje bilinc yuklemesi
2. **`/closeToQulo`** — Session sonu bilinc kaydi
3. **Skill Dashboard** — Local web GUI ile skill goruntuleme ve tetikleme

---

## 3. `/readyToQulo` — Session Basi Skill

### Tetikleme
- Manuel: `/readyToQulo`
- Session ortasinda tekrar cagrilabilir (branch degisimi, refresh)

### Calisma Akisi

**Adim 1: Dinamik Tarama (Paralel Subagent'lar)**

| Tarama | Kaynak | Cikarilacak Bilgi |
|--------|--------|-------------------|
| Mobile | `qulov2/lib/features/*/` glob | Feature listesi + dosya sayilari (screen, widget, mixin, provider) |
| Server | `qulo-server/src/routes/*.ts` + `services/*.ts` | Endpoint ve servis haritasi |
| Web | `web/src/app/` + `web/src/components/` | Sayfa ve component haritasi |
| Docs | `docs/superpowers/specs/` + `plans/` | Son spec/plan listesi |
| Git | Aktif branch, son 5 commit, uncommitted changes | Branch durumu |

**Adim 2: businessCaseSkills Kesfi**
- `.claude/skills/businessCaseSkills/` dizinini tarar
- Her skill dosyasinin frontmatter'indan `name`, `description`, trigger kosullarini ceker
- Mevcut skill listesini context'e yukler

**Adim 3: Hibrit Tetikleme**
- Git diff + aktif branch'e bakarak hangi businessCaseSkill'lerin ilgili oldugunu tespit eder
- Ilgili skill varsa kullaniciya sorar: "X degisikligi tespit ettim, Y skill'i calistirayim mi?"
- Tetikleme yoksa sessizce gecer

**Adim 4: Kisa Ozet Ciktisi**
```
Qulo'ya hazirim. 17 mobile feature, 19 server route, 3 web sayfa aktif.
4 businessCaseSkill yuklendi. Branch: APP-1915, son commit: [mesaj].
Ilgili tetikleme: yok.
```

---

## 4. `/closeToQulo` — Session Sonu Skill

### Tetikleme
- Manuel: `/closeToQulo`

### Calisma Akisi

**Adim 1: Session Diff Analizi**
- Session basindaki HEAD vs simdiki HEAD karsilastirir
- Degisen dosyalari kategorize eder: hangi feature'lar, hangi katmanlar etkilendi
- Tamamlanan ve yarim kalan isleri listeler

**Adim 2: businessCaseSkill Ihtiyac Analizi**
- Session'da yapilan degisiklikleri analiz eder
- Uc soru sorar:
  - "Bu degisiklik pattern'i tekrar edecek mi?" → evet ise yeni skill onerisi
  - "Mevcut skill'ler bu alani kapsiyor mu?" → hayir ise yeni skill onerisi
  - "Bir invariant/guard eksik mi?" → evet ise yeni guard skill onerisi
- Ornek: 3 kez manuel i18n sync → "i18n-guardian web tetikleme kurali eksik, ekleyelim mi?"

**Adim 3: Memory Guncelleme Onerisi**
- Session'da ogrenilenler: yeni bug pattern, mimari karar, kural degisikligi
- Kullaniciya sorar: "Sunlari memory'ye kaydetmemi ister misin?"
- Son karar kullanicida

**Adim 4: Kisa Ozet Ciktisi**
```
Session ozeti: 3 commit, chat + diamonds feature'lari etkilendi.
Yeni businessCaseSkill onerisi: yok.
Memory guncellemesi: 1 oneri var — [konu].
Yarim kalan is: referral client-side.
```

---

## 5. Skill Dashboard — Local Web GUI

### Teknik Yapi
```
tools/skill-dashboard/
├── server.js          ← Express mini server
├── index.html         ← Dashboard UI
└── package.json       ← Sadece express dependency
```

### Port
`17380` (garip, cakismayan)

### Ozellikler

**5.1 Dinamik Skill Tarama**
- Server basladiginda `.claude/skills/` ve `.claude/skills/businessCaseSkills/` dizinlerini tarar
- Her `.md` dosyasinin frontmatter'ini parse eder (name, description, triggers)
- Dosya degisikliklerinde otomatik yeniler (fs.watch)

**5.2 Dashboard UI**
- **Kart gorunumu:** Her skill bir kart — ad, aciklama, trigger kosullari, kategori (lifecycle / businessCase / review)
- **Akis diyagrami:** readyToQulo → [session] → businessCaseSkills → [session] → closeToQulo lifecycle akisi
- **Kategori gruplama:**
  - Lifecycle: readyToQulo, closeToQulo
  - Business Case: economy-impact, economy-watchdog, chat-flow-guard, i18n-guardian
  - Review: flutter-review, server-review, web-security-review, web-code-quality
  - Deploy: deploy-testflight, switch-env, dev-env-setup
  - Diger: tum diger skill'ler

**5.3 Calistir Butonu**
- Her kartta "Calistir" butonu
- POST `/api/run-skill` → `execFile('claude', ['-p', '/skillAdi'])` (shell injection korumasiz, execFile kullanilir)
- Calisma durumu UI'da gosterilir (running / done / error)

**5.4 API Endpoint'leri**
```
GET  /api/skills          → Tum skill listesi (parsed frontmatter)
POST /api/run-skill       → { skillName: string } → skill'i calistirir
GET  /                    → Dashboard HTML
```

### UI Tasarimi
- Koyu tema (proje ile uyumlu)
- Sol tarafta akis diyagrami (lifecycle flow)
- Sag tarafta skill kartlari (kategoriye gore gruplu)
- Responsive degil (sadece desktop, gelistirici araci)

---

## 6. Nasil Calisir (Kullanim Kilavuzu)

### Ilk Kurulum (Bir kere)
```bash
cd tools/skill-dashboard && npm install
```

### Dashboard'u Baslatma
```bash
cd tools/skill-dashboard && node server.js
# → http://localhost:17380 adresinde acilir
```

### Gunluk Akis
1. **Session basi:** Claude Code'da `/readyToQulo` yaz veya dashboard'dan "readyToQulo" kartinin "Calistir" butonuna bas
2. **Session boyunca:** Normal calis. businessCaseSkills otomatik tetiklenir (readyToQulo yukledigi kurallara gore)
3. **Session sonu:** `/closeToQulo` yaz veya dashboard'dan tetikle
4. **Dashboard:** Istedigin zaman `http://localhost:17380` adresinden tum skill'leri gor ve calistir

### Skill Ekleme
1. `.claude/skills/` veya `.claude/skills/businessCaseSkills/` altina yeni `.md` dosyasi ekle
2. Standart frontmatter kullan (name, description, triggers)
3. Dashboard otomatik kesfeder (fs.watch)

---

## 7. Kapsam Disi
- Dashboard authentication (local-only, gerek yok)
- Skill edit/create GUI (dosya sistemi uzerinden yapilir)
- Mobil responsive (sadece desktop)
- Skill calisma gecmisi/log (MVP disinda)
