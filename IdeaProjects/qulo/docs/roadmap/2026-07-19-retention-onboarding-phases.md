# Retention & Onboarding Faz Plani — Reklam Hazirligi

> Olusturulma: 2026-07-19 (PM session, keşif bulgulari koddan dogrulandi)
> Mevcut gelistirme surumu: **2.0.6** — Faz 1 bu surumle store'a gider; her faz bitiminde bir store surumu alinir (2.0.6 → 2.0.7 → 2.0.8 → 2.0.9).
> Ana hedef: Reklamdan gelen kullanicinin uygulamayi **anlamasi**, ilk 10 dakikada **deger gormesi** ve **geri gelmesi**. Uc problem: (1) mekanik anlatimi kayittan sonra geliyor, (2) kayit hunisi agir, (3) geri getirme mekanizmasi yok.

---

## Nasil Kullanilir (Loop Prompting Esaslari)

1. **Bir session = bir faz.** Yeni Claude session ac, ilgili fazin "Baslangic Prompt'u" blogunu aynen yapistir.
2. Session akisi her fazda ayni: `/readyToQulo` → **brainstorming** (kapsam netlesir) → **spec** (`docs/superpowers/specs/`) → onay → implement → review skill'leri → surum.
3. Faz bitmeden sonraki faza **gecilmez**. Faz biterse: bu dosyadaki fazin checkbox'larini isaretle + en alttaki **Faz Log**'a satir ekle (`/closeToQulo` bunu hatirlatir).
4. Bir faz yarim kaldiysa yeni session ayni fazin prompt'u + "Faz Log'daki son duruma bak" notuyla baslar.
5. Kapsam disi fikirler faza EKLENMEZ — bu dosyanin sonundaki **Backlog** bolumune not edilir.

---

## Ortak Baglam (tum fazlar icin gecerli)

**Proje:** Qulo — soru-cevap tabanli dating app (swipe DEGIL). Partner adayinin 2-10 sorusunu coz, hepsi dogruysa esles. Mobile: `qulov2/` (Flutter), Server: `qulo-server/` (Express/TS + Supabase), Web: `web/` (Next.js).

**Kesif bulgulari (2026-07-19, koddan dogrulanmis):**
- Onboarding carousel'i (5 sayfa, mekanik anlatimi iyi) kayit + profil kurulumundan SONRA aciliyor: `qulov2/lib/routing/app_routes.dart` `_checkOnboarding` (~satir 398). Atlanabilir, bir kez gosterilir, bitince paywall sheet'i (`premium_suggestion_sheet.dart`).
- E-posta kaydi 7 adim (`register_screen_mixin.dart`, totalSteps=7) + zorunlu e-posta dogrulama: login `EMAIL_NOT_VERIFIED` firlatir (`qulo-server/src/services/auth.service.ts` ~satir 149). Kayit otomatik login yapmaz.
- Social login butonlari SADECE login ekraninda (`qulov2/lib/features/auth/widgets/social_login_buttons.dart`), register'da yok. Social login e-posta dogrulamayi atlar.
- Profil setup gate (skip edilemez): 1 foto + 2 soru + gender pref (`profile_setup_screen.dart`, `AppConstants.minQuestions=2`). Soru icin 3 yol: Sihirli Doldur (AI), Hemen Ata (`POST /users/me/quick-assign-questions`), manuel.
- Discover gorunurluk filtresi (aday tarafi): email_verified + lat/lng + min 2 soru + min 1 foto + dil eslesmesi (strict, fallback YOK) + radius (default 100km) (`qulo-server/src/services/matching.service.ts` discover(), satir 57-307). "7 gun aktiflik" HARD FILTRE DEGIL — sadece scoring.
- Olcek riski: aday sorgusu sirasiz `.limit(50)` (`matching.service.ts:130`) — DB buyuyunce yakin adaylar listeye girmeyebilir → bos discover.
- Re-engagement YOK: D1/D3/D7 push cron'u yok. Sadece olay-tetikli push (`notification.service.ts`: new_message, new_match, ...) + 24s inaktife match e-postasi (`match-email.service.ts`) + manuel admin kampanyasi (`campaign.service.ts` + `segment.service.ts`, `last_active_days` segmenti mevcut). Cron'lar: `src/cron/index.ts` (sadece presence + analytics).
- Fake korumasi zayif: foto moderasyonu yok (multer 5MB jpg/png), report sadece tabloya insert (`report.service.ts`), otomatik ban yok, cihaz kontrolu yok.
- Ekonomi saglam: quiz cozmek bedava, profil tamamlama milestone'lari toplam 100 mor elmas + %100'de 24s boost (`user.service.ts` ~505-529). AI soru havuzu: `ai_question_bank` tablosu (canli LLM yok, `ai-suggest.service.ts`).

**Degismez kurallar (her fazda):**
- Localization ZORUNLU: hardcode string yasak, yeni her key 16 dilde eklenir (i18n-guardian skill).
- Widget/page sadece UI orchestration — logic mixin'de. Screen max ~200 satir. Raw Scaffold yerine AppScaffold.
- Ekonomiye dokunan is (paywall, elmas, boost) oncesi `/economy-impact` calistirilir.
- Chat/mesajlasma akisina dokunan is oncesi chat-flow-guard calistirilir.
- Review: Flutter → `/flutter-review`, server → `/server-review`. `dart analyze` sifir hata.
- Dokunulan dosyada kural ihlali/refactor varsa ayni PR'da duzelt (loop refactor).
- Mobile push: qulov2 main'e, server push: Railway auto-deploy (clean build), migration: Supabase MCP.

---

## FAZ 1 — Huni Hizli Tamiri + Olcum Altyapisi → v2.0.6

**Neden ilk:** Reklam oncesi en ucuz/en yuksek kaldiracli tamirler + funnel olcumu baslamali ki sonraki fazlarin etkisi olculebilsin. Buyuk yeniden tasarim YOK — mevcut parcalarin yerini/sirasini degistiriyoruz.

**Kapsam (in):**
- [x] 1.1 **Funnel analytics event'leri**: kayit adim-adim (step_1..7), e-posta dogrulama tamamlama, social login secimi, profil setup gate (foto/soru/tercih ayri ayri), carousel sayfa ilerleme/skip, ilk discover goruntuleme, ilk quiz baslatma/bitirme. Server'da `POST /analytics/track` mevcut — mobile'daki mevcut kullanim keşfedilip ayni pattern'le genisletilecek.
- [x] 1.2 **Social-first auth**: Google/Apple butonlari register akisina da eklenir (veya auth landing social-first yeniden duzenlenir). Amac: reklam trafigi 1 dokunusla girsin.
- [x] 1.3 **Carousel'i one al**: 5 sayfalik "Qulo nasil calisir" carousel'i ilk acilista, AUTH'TAN ONCE gosterilir. Edge case: sayfa 5 dil secimi authenticated API'ye yaziyor olabilir (`PUT /me/languages`) — auth oncesi secim local tutulup kayit sonrasi gonderilmeli (brainstorming'de cozulecek).
- [x] 1.4 **Paywall ertelemesi**: carousel sonu premium sheet kaldirilir; ilk eslesme SONRASINA (veya D1'e) tasinir. `/economy-impact` zorunlu.

**Kapsam disi (out):** Pre-signup bilgi toplama ve kayit adimlarinin yeniden dagitimi (Faz 2), server discover degisiklikleri (Faz 3), moderasyon (Faz 4).

**DoD:** dart analyze sifir + /flutter-review temiz + funnel event'leri test cihazinda dogrulanmis (server'a dustugu goruldu) + carousel yeni konumda cihazda test + 2.0.6 build TestFlight'ta.

**Kaba efor:** 1-2 gun.

### Baslangic Prompt'u (Faz 1)

```
/readyToQulo

Faz 1'i baslatiyoruz: docs/roadmap/2026-07-19-retention-onboarding-phases.md dosyasini oku — "Ortak Baglam" ve "FAZ 1" bolumleri bu isin tek kaynagi. Faz Log'da onceki yarim is var mi kontrol et.

Hedef (v2.0.6): reklam oncesi huni tamiri — (1.1) funnel analytics event'leri, (1.2) social-first register, (1.3) onboarding carousel'ini auth oncesine alma (dil secimi sayfasinin local-persist edge case'i dahil), (1.4) carousel sonu paywall'inin ilk eslesme sonrasina ertelenmesi (/economy-impact calistir).

Brainstorming ile basla: her madde icin tasarim kararlarini netlestir (ozellikle 1.3 dil secimi local persist akisi ve 1.4 paywall'in yeni tetik noktasi), sonra spec yaz ve onayimi al. Implementasyonda dosya bazli kesif yapmadan once roadmap'teki "Kesif bulgulari" yollarini kullan. Kapsam disi fikir cikarsa roadmap Backlog'una not et, faza ekleme. Bitince: cihaz testi talimatlarini ver, Faz Log'u doldur, 2.0.6 surum hazirligini yap.
```

---

## FAZ 2 — Onboarding v3 "Tanisma Oyunu" → v2.0.7

**Neden:** "Insanlar uygulamayi anlamiyor" sorununun kalici cozumu. Bilgi toplamayi form olarak degil, kayittan ONCE soru uretimine bagli bir tanisma oyunu olarak kurgula. Kullanici yatirim yapar (chip secimleri) → karsiliginda AI sorulari hazirlanir → kaydolmasi icin somut sebep olusur (Duolingo pattern: commitment before signup).

**Kapsam (in):**
- [ ] 2.1 **Interaktif demo**: acilista ornek bir soruyu kullaniciya GERCEKTEN cozdur (anlatma, yasat). Dogru cevapta mini kutlama + "iste eslesme boyle olur".
- [ ] 2.2 **"Seni taniyalim" adimlari (pre-signup)**: cinsiyet, tercih, dogum tarihi + ilgi alanlari + 2-3 yasam tarzi chip'i. TAMAMI tap-select (yazi yazdirma yok). Hassas kategori (din, etnik koken vb.) YOK.
- [ ] 2.3 **AI soru preview (aha-moment)**: secimlere gore `ai_question_bank`'ten 3-4 soru blur'lu/preview gosterilir: "Sana ozel sorular hazir". Server isi: anonim/pre-auth suggest endpoint'i (rate limit ZORUNLU — abuse yuzeyi) veya bank'in salt-okunur public alt kumesi. Brainstorming'de karar.
- [ ] 2.4 **Social-first kayit en sonda**: "Kaydol, sorularin yayinlansin". Pre-signup veriler local persist → kayit basarisinda toplu gonderim. Kayit adimlari pre-signup'ta toplananlarla DEDUPE edilir (ayni soru iki kez sorulmaz — mevcut 7 adim eriyip dagitilir).
- [ ] 2.5 **E-posta dogrulama bandi gevsetme**: login gate kaldirilir (`EMAIL_NOT_VERIFIED` login engeli), app'e giris serbest; discover GORUNURLUK filtresi olarak kalir (server filtresi zaten mevcut). App ici "e-postani dogrula → gorunur ol" banner'i eklenir.
- [ ] 2.6 **Profil setup gate sadelesmesi**: sorular pre-signup'ta hazirlandigi icin gate'te kalan: foto + soru onayi/yayini. "Hemen Ata"/"Sihirli Doldur" yollari korunur (fallback).

**Kapsam disi (out):** Discover/matching server degisiklikleri (Faz 3), yeni ekonomi odulleri (istenirse Backlog).

**Riskler/karar noktalari (brainstorming gundemi):** anonim suggest abuse korumasi; pre-signup state makinesi (kapat-ac senaryolari); dogrulama banner'inin gorunurluk baskisi dengesi; A/B ihtiyaci (minimum: Faz 1 funnel event'leriyle oncesi/sonrasi kiyas).

**DoD:** dart analyze sifir + /flutter-review + /server-review (yeni endpoint) + i18n-guardian (cok sayida yeni key, 16 dil) + pre-signup→kayit→discover akisi cihazda ucta uca test + funnel event'leri yeni akisi kapsiyor + 2.0.7 TestFlight'ta.

**Kaba efor:** 3-5 gun (en buyuk faz).

### Baslangic Prompt'u (Faz 2)

```
/readyToQulo

Faz 2'yi baslatiyoruz: docs/roadmap/2026-07-19-retention-onboarding-phases.md oku — "Ortak Baglam" + "FAZ 2" tek kaynak. Faz Log'dan Faz 1'in bittigini ve varsa notlarini kontrol et (Faz 1 funnel event'leri bu fazin olcum temelidir).

Hedef (v2.0.7): Onboarding v3 "Tanisma Oyunu" — (2.1) interaktif demo soru, (2.2) pre-signup tap-select taniyalim adimlari, (2.3) AI soru preview + anonim suggest endpoint karari, (2.4) social-first kayit en sonda + local persist + adim dedupe, (2.5) e-posta dogrulama login gate'inin kaldirilip discover-gorunurluk bandina cekilmesi, (2.6) profil setup gate sadelesmesi.

Brainstorming ile basla — roadmap'teki "Riskler/karar noktalari" listesi brainstorming gundemidir; her birine karar verip spec'e yaz, onayimi al. Mobile + server degisiklikleri tek spec'te, is sirasi: server endpoint → mobile akis. i18n-guardian'i unutma (yeni key sayisi yuksek). Kapsam disi fikirler roadmap Backlog'una. Bitince: ucta uca test talimati, Faz Log, 2.0.7 surum hazirligi.
```

---

## FAZ 3 — Cold Start & Re-engagement → v2.0.8

**Neden:** Reklam aninda ayni sehirden toplu gelis olacak. Bos discover sessiz olum; ilk gun eslesemeyen kullaniciyi geri cagiran mekanizma yok. Bu faz agirlikla SERVER isi.

**Kapsam (in):**
- [ ] 3.1 **D1/D3/D7 re-engagement push cron'u**: kayit sonrasi eslesmesi olmayan / inaktif kullaniciya otomatik push. Mevcut `campaign.service.ts` + `segment.service.ts` (`last_active_days`) altyapisi uzerine `src/cron/index.ts`'e cron. Icerik tonu: basit, gundelik (analitik jargon yasak). Push locale sync mevcut — kullanici dilinde gider. Frekans tavani + opt-out (notification preferences mevcut) zorunlu.
- [ ] 3.2 **Bos discover fallback**: radius icinde aday yoksa otomatik kademeli radius genisletme (orn. 100→250→500) veya server'dan "genislet" onerisi. Strict dil filtresi fallback'i de degerlendirilir (orn. bos listede dil kosulunu gevset + rozetle). Karar brainstorming'de.
- [ ] 3.3 **`.limit(50)` olcek fix'i**: aday cekimi mesafe-oncelikli hale getirilir (bounding box / earthdistance / PostGIS — mevcut Supabase yetenegine gore secim). Hedef: DB buyudugunde yakin adaylar listeye kesin girsin.
- [ ] 3.4 **Mobile es**: yeni push tiplerinin deep link'leri + bos discover'in yeni fallback UX'i (mevcut `discover_empty_state.dart` uzerine).

**Kapsam disi (out):** Yeni matching skoru/algoritma revizyonu (Backlog), moderasyon (Faz 4).

**DoD:** /server-review temiz + cron staging'de calisir dogrulandi (test segmentiyle) + push test cihazina dustu + bos discover fallback'i radius disi konumla test edildi + discover sorgu performansi olculdu (buyuk seed ile) + migration'lar Supabase MCP ile + 2.0.8 TestFlight'ta.

**Kaba efor:** 2-3 gun.

### Baslangic Prompt'u (Faz 3)

```
/readyToQulo

Faz 3'u baslatiyoruz: docs/roadmap/2026-07-19-retention-onboarding-phases.md oku — "Ortak Baglam" + "FAZ 3" tek kaynak. Faz Log'dan onceki fazlarin durumunu kontrol et.

Hedef (v2.0.8): cold start + geri getirme — (3.1) D1/D3/D7 push cron'u (campaign+segment altyapisi uzerine, frekans tavani + opt-out sart), (3.2) bos discover'da kademeli radius/dil fallback karari ve uygulamasi, (3.3) matching.service.ts'teki sirasiz .limit(50) aday cekiminin mesafe-oncelikli hale getirilmesi, (3.4) mobile deep link + bos discover UX esleri.

Brainstorming ile basla: push icerik/timing kurgusu (basit ton), fallback stratejisi ve limit fix'inin teknik secenegi (bounding box vs PostGIS) burada kararlastirilir. Ekonomiye dokunan push tesviki onerilirse /economy-impact calistir. Server isleri once, mobile es sonra. Bitince: staging cron dogrulamasi + push cihaz testi talimati, Faz Log, 2.0.8 surum hazirligi.
```

---

## FAZ 4 — Trust & Safety (Fake/AI Profil Kalkani) → v2.0.9

**Neden:** Reklamla gorunurluk artinca fake/bot/uygunsuz icerik yuzeyi acilir. Su an: foto moderasyonu yok, report sadece kayit tutuyor, otomatik aksiyon yok, social login aninda verified.

**Kapsam (in):**
- [ ] 4.1 **Foto upload moderasyonu**: upload aninda NSFW/uygunsuz icerik taramasi (Google Vision SafeSearch vs AWS Rekognition — maliyet/latency kiyasi brainstorming'de). Supheli foto: reddet veya insan onayina dusur.
- [ ] 4.2 **Report threshold → auto-flag**: N benzersiz report'ta hesap otomatik "supheli" isaretlenir (discover'dan gecici cikarma / shadow limit). Esik ve aksiyon brainstorming'de; yanlis-pozitif itiraz yolu dusunulur.
- [ ] 4.3 **Admin flag kuyrugu**: flaglenen hesap/fotolarin admin panelde listesi + onay/ban aksiyonu (mevcut deletion-feedback admin sayfasi pattern'i yeniden kullanilir).
- [ ] 4.4 **Kayit abuse sinyalleri (hafif)**: ayni IP'den kayit yogunlugu izleme + social login instant-verified bypass'inin degerlendirilmesi. Agir cihaz parmak izi / captcha bu fazda YOK (Backlog).

**Kapsam disi (out):** Selfie/liveness dogrulama rozeti (buyuk is — Backlog'da dursun, ileride guven rozeti olarak ekonomiyle baglanabilir).

**DoD:** /server-review + guvenlik gozuyle review (owasp-security skill degerlendirilir) + moderasyon akisi ucta uca test (temiz foto gecer, test NSFW reddedilir) + auto-flag esigi test + admin kuyrugu calisir + 2.0.9 TestFlight'ta.

**Kaba efor:** 2-3 gun.

### Baslangic Prompt'u (Faz 4)

```
/readyToQulo

Faz 4'u baslatiyoruz: docs/roadmap/2026-07-19-retention-onboarding-phases.md oku — "Ortak Baglam" + "FAZ 4" tek kaynak. Faz Log'dan onceki fazlarin durumunu kontrol et.

Hedef (v2.0.9): fake/AI profil kalkani — (4.1) foto upload NSFW moderasyonu (Vision vs Rekognition karari), (4.2) report threshold ile auto-flag + discover'dan gecici cikarma, (4.3) admin flag kuyrugu (deletion-feedback admin pattern'i yeniden kullan), (4.4) hafif kayit abuse sinyalleri + social login instant-verified degerlendirmesi.

Brainstorming ile basla: moderasyon saglayici secimi (maliyet/latency), auto-flag esigi ve aksiyonu, yanlis-pozitif itiraz akisi burada kararlastirilir; spec'e yaz, onayimi al. Server agirlikli — /server-review + owasp-security ile dogrula. Selfie/liveness dogrulama KAPSAM DISI (Backlog). Bitince: moderasyon ucta uca test talimati, Faz Log, 2.0.9 surum hazirligi.
```

---

## Backlog (fazlara girmeyen, sohbette dogan fikirler)
- (Faz 1 review) `quiz_screen_mixin.dart` 488 satir (limit 300) — pre-existing tech borc; domain sub-mixin'lere bolunmeli (Faz 1 sadece ~48 satir ekledi, bloat degil).
- (Faz 1 review) `quizComplete` (non-first) event'i `onRescue` + `_handleSessionTransition` COMPLETED path'lerinde fire etmiyor — pre-existing instrumentation gap; `first_quiz_complete` Faz 1'de tum path'lere yayildi ama non-first quizComplete hala eksik.
- (Faz 1 review) `onboardingV2Skip` event param'i `paramFromPage` (page adi) kullaniyor; dashboard `step_index` bekliyorsa param semantigi netlestirilebilir.
- (Faz 1 review) `AnalyticsEvents.onboardingV2PremiumShown` sabiti artik kullanilmiyor (olu kod) — temizlenebilir.

- Selfie/liveness foto dogrulama + "dogrulanmis profil" rozeti (ekonomi/guven baglantili buyuk is)
- Streak / gunluk gorev / badge genisletmesi (retention gamification)
- Haftalik rapor cron + AI oneri cache doldurma (eski backlog — hala gecerli)
- Discover'da kullanilmayan `discover_question_gate.dart` olu kod temizligi (kucuk, uygun bir faza binebilir)
- Matching algoritmasi skor revizyonu (quiz completion rate hala 0 geciyor)
- A/B test altyapisi (funnel event'leri yeterli olgunluga gelince)

## Faz Log

| Tarih | Faz | Durum | Surum | Not |
|---|---|---|---|---|
| 2026-07-19 | Faz 1 | ✅ Kod tamam (cihaz testi + TestFlight bekliyor) | 2.0.6 | 8 task SDD ile; final whole-branch review CRITICAL carousel-bypass + dil-kaybi bug'larini yakaladi (fix 0fcafa8). Sosyal-first landing, carousel pre-auth, dil local-persist+flush, paywall ilk-eslesme, hibrit funnel. Backlog: quizComplete rescue/power coverage, quiz_mixin 488 satir, olu sabit, skip param. |
