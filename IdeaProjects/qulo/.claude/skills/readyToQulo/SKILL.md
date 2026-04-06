---
name: readyToQulo
description: |
  Qulo proje bilinc yukleyici. Session basinda veya istenen anda calistirilir.
  Projenin 3 katmanini (mobile/server/web) dinamik tarar, feature haritasi cikarir,
  businessCaseSkills kesfeder ve ilgili olanlari hibrit tetikler.
  Tetikleyiciler: '/readyToQulo', 'session basla', 'projeyi tara', 'context yukle', 'hazirlan'
---

# readyToQulo — Proje Bilinc Yukleyici

Session basinda veya istenen anda calistirilir. Projenin guncel durumunu tarar, context'e yukler ve ilgili businessCaseSkills'leri tespit eder.

## Calisma Akisi

### Adim 1: Dinamik Tarama

3 paralel Explore subagent dispatch et:

**Subagent 1 — Mobile + Server + Web Tarama:**

```
Qulo projesini tara ve kisa ozet cikar:

1. MOBILE: qulov2/lib/features/ altindaki tum klasorleri listele.
   Her feature icin: klasor adi + icindeki .dart dosya sayisi (screens, widgets, mixins ayri say)

2. SERVER: qulo-server/src/routes/*.ts dosyalarini listele.
   Her route dosyasinin adini ve icindeki HTTP method+path pairlerini cikar.
   qulo-server/src/services/*.ts dosyalarini listele (sadece dosya adlari).

3. WEB: web/src/app/ altindaki sayfa yapisini listele (page.tsx, layout.tsx dosyalari).
   web/src/components/ altindaki component dosyalarini say.

Ciktiyi su formatta ver:
## Mobile Features (N adet)
- feature_adi: X screen, Y widget, Z mixin

## Server Routes (N adet)
- route_adi: GET /path, POST /path ...

## Server Services (N adet)
- service_adi.ts

## Web Pages (N adet)
- /path → page.tsx

## Web Components (N adet)
- component_adi.tsx
```

**Subagent 2 — Docs + Git Tarama:**

```
Qulo projesinin dokumantasyon ve git durumunu tara:

1. docs/superpowers/specs/ altindaki dosyalari listele (sadece dosya adlari, tarihe gore sirali, son 5 yeterli)
2. docs/superpowers/plans/ altindaki dosyalari listele (sadece dosya adlari, son 5 yeterli)
3. Git: aktif branch adi, son 5 commit (oneline), uncommitted changes ozeti (git status --short)

Ciktiyi su formatta ver:
## Son Spec'ler
- dosya_adi.md

## Son Planlar
- dosya_adi.md

## Git Durumu
- Branch: X
- Son commitler: ...
- Degisiklikler: ...
```

**Subagent 3 — businessCaseSkills Kesfi:**

```
.claude/skills/businessCaseSkills/ dizinindeki tum .md dosyalarini oku.
Her dosyanin frontmatter'indan name ve description alanlarini cikar.

Ciktiyi su formatta ver:
## Aktif businessCaseSkills (N adet)
- skill_adi: aciklama (trigger: ...)
```

### Adim 2: Hibrit Tetikleme Kontrolu

Subagent sonuclari geldikten sonra:

1. Git diff'teki degisen dosyalari kontrol et
2. Her businessCaseSkill'in trigger kosullarini degisen dosyalarla karsilastir:
   - economy-impact / economy-watchdog: diamond, power, subscription, IAP, economy config dosyalari
   - chat-flow-guard: chat, message, realtime dosyalari
   - i18n-guardian: translation, locale, i18n dosyalari
3. Eslesme varsa kullaniciya sor: "X dosyalarinda degisiklik var, Y skill'i calistirayim mi?"
4. Eslesme yoksa sessizce gec

### Adim 3: Kisa Ozet Ciktisi

Tum subagent sonuclarini birlestirip tek satirlik ozet ver:

```
Qulo'ya hazirim. [N] mobile feature, [M] server route, [K] web sayfa aktif.
[L] businessCaseSkill yuklendi. Branch: [branch], son commit: [mesaj].
Ilgili tetikleme: [varsa liste / yoksa "yok"].
```

Context'e yuklenen bilgiler session boyunca gecerli — tekrar taramaya gerek yok (branch degisimi haric).

## Tekrar Cagirma

Session ortasinda /readyToQulo tekrar cagrilirsa ayni akisi bastan calistirir. Bu durumda "Qulo context yenilendi." ile basla.
