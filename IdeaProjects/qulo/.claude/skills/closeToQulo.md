---
name: closeToQulo
description: |
  Qulo session kapanis skill'i. Session sonunda calistirilir.
  Yapilan degisiklikleri analiz eder, yeni businessCaseSkill ihtiyacini tespit eder,
  memory guncelleme onerileri sunar.
  Tetikleyiciler: '/closeToQulo', 'session bitir', 'kapanis', 'session ozeti', 'ne yaptik'
---

# closeToQulo — Session Kapanis Skill'i

Session sonunda calistirilir. Yapilan isleri analiz eder, yeni skill ihtiyaclarini tespit eder ve memory guncelleme onerileri sunar.

## Calisma Akisi

### Adim 1: Session Diff Analizi

Bir Explore subagent dispatch et:

```
Qulo projesinde bu session'da yapilan degisiklikleri analiz et:

1. Son 24 saatteki commit'leri listele: git log --oneline --since="24 hours ago"
   (Session uzunlugu bilinmediginden son 24 saat yeterli)

2. Bu commit'lerde degisen dosyalari listele: git diff --stat HEAD~N (commit sayisi kadar)

3. Degisen dosyalari kategorize et:
   - qulov2/lib/features/X/ → "Mobile: X feature"
   - qulo-server/src/routes/ veya services/ → "Server: Y modulu"
   - web/src/ → "Web: Z sayfasi"
   - .claude/skills/ → "Skill: W"
   - docs/ → "Docs: V"

4. Tamamlanmis gorunen isler: commit mesajlarindan cikar (feat:, fix:, refactor: prefix'leri)
5. Yarim kalan isler: uncommitted changes + TODO/FIXME iceren satirlar

Ciktiyi su formatta ver:
## Etkilenen Alanlar
- [kategori]: [detay]

## Tamamlanan Isler
- [commit mesaji]

## Yarim Kalan Isler
- [dosya/alan]: [aciklama]
```

### Adim 2: businessCaseSkill Ihtiyac Analizi

Session diff sonuclarini al ve su kontrolleri yap:

1. **Pattern tespiti:** Ayni tipte dosyalar birden fazla kez degistiyse (ornek: 3 farkli feature'da i18n key ekleme) → "Bu pattern icin otomatik guard skill olusturulabilir"

2. **Kapsam kontrolu:** Degisen alanlari mevcut businessCaseSkills ile karsilastir:
   - economy-impact: diamond, power, subscription, IAP dosyalari
   - economy-watchdog: economy config dosyalari
   - chat-flow-guard: chat, message, realtime dosyalari
   - i18n-guardian: translation, locale, i18n dosyalari
   Degisen dosyalar hicbir skill'in kapsamina girmiyorsa → "Bu alan icin yeni guard skill olusturulabilir: [oneri]"

3. **Invariant kontrolu:** Degisiklikler mevcut kurallari etkiliyorsa → "Yeni invariant guard onerisi: [detay]"

Her oneri icin kullaniciya sor — otomatik olusturma.

### Adim 3: Memory Guncelleme Onerisi

Session'da ogrenilebilecek seyleri tespit et:
1. Yeni bug fix pattern'leri (fix: commit'lerinden)
2. Mimari kararlar (yeni dosya/klasor yapisi degisiklikleri)
3. Yeni kurallar (CLAUDE.md veya skill degisiklikleri)

Tespit edilen her sey icin kullaniciya sor:
"Sunlari memory'ye kaydetmemi ister misin?"
Son karar kullanicida — onay olmadan memory'ye yazma.

### Adim 4: Kisa Ozet Ciktisi

```
Session ozeti: [N] commit, [X, Y] feature'lari etkilendi.
Yeni businessCaseSkill onerisi: [varsa / yok].
Memory guncellemesi: [N] oneri var.
Yarim kalan is: [varsa liste / yok].
```
