# Retention & Onboarding Faz Plani — Reklam Hazirligi

> Olusturulma: 2026-07-19 (PM session, keşif bulgulari koddan dogrulandi)
> **Guncelleme 2026-08-01:** Faz 1 (2.0.6) yayinda, 1.5 haftalik olcum yapildi → **Faz 2 degistirildi**
> (Onboarding v3 ertelendi, yerine **Eslesme Motoru**). Gerekce: Faz Log 2026-08-01 satiri.
> Ayrica **Meta reklam hesabi 2026-07-27'de kalici banlandi** → "reklam oncesi hazirlik"
> aciliyeti dustu, trafik organik (gunde 1-3 kayit); oncelik artik mevcut az trafikten
> maksimum deger cikarmak.
> Surum zinciri: Faz 1 = **2.0.6** (yayinda) → Faz 2 = 2.0.7 → Faz 3 = 2.0.8 → Faz 4 = 2.0.9.
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

## FAZ 2 — Eslesme Motoru (Quiz Gecilebilirligi) → v2.0.7

> **2026-08-01'de yeniden onceliklendirildi.** Faz 1 sonrasi prod olcumu, sirayi degistirdi:
> onboarding sorunu cozuldu, darbogaz quiz'e kaydi. Eski Faz 2 (Onboarding v3 "Tanisma
> Oyunu") **ERTELENDI** — detay ve gerekce icin bkz. "Ertelenen: Onboarding v3" bolumu.

**Neden (2026-08-01 prod olcumu, 1.5 hafta yayinda):**
- **Onboarding cozuldu:** `app_confusing` silme nedeni 3 → **0**. Aktivasyon %44 → **%70**
  (2+ soru %57→%90, foto %54→%80). Faz 1 isini yapti.
- **Yeni 1 numarali silme nedeni: `few_matches`** (son 11 gunun 5 geri bildiriminin 4'u).
- **Cevap dogruluk orani %35** (106 cevabin 37'si) — 4 sikta rastgele tahmin %25.
  Sorular pratikte tahmin edilemez → 2 soruluk quiz'de eslesme sansi ~%12
  (gercek: 83 oturumda 8 COMPLETED = %9.6).
- **67/67 FAILED yanlis cevaptan** (timeout kaynakli fail YOK; ort. 11 sn'de bitiyor).
- **Guc kullanimi 0 oturum** — kasada 2000+ mor elmas atil. Sebep koddan dogrulandi:
  `power_bar.dart:46-59` guc butonlarini **envantere** bagliyor, envanteri dolduran tek
  yol `exchange.buyPower`; hicbir yerde starter guc verilmiyor → herkes 6 gri ikonla
  basliyor. Server zaten "envanter yoksa elmasla ode" yolunu destekliyor
  (`quiz.service.ts:278-302`) ve chat guc bari bunu **dogru** yapiyor
  (`chat_question_power_bar.dart:65-67`) — kisit tamamen client kaynakli.
- **1 yanlis = kalici elenme:** quiz oncesi LIKE swipe'i yaziliyor
  (`discover_card_view.dart:248-262`), `swipes` satiri hic silinmiyor, free tier
  `dailyUndos: 0` → kaybedilen profil discover'da **bir daha asla** cikmiyor.

**Kapsam (in):**
- [ ] 2.1 **Guc kilidini ac (en kucuk is, en buyuk etki):** quiz `PowerBar`'da envanter
      kosulunu kaldir — envanter yoksa **dogrudan elmasla kullan** (server hazir), buton
      altina **etiket + fiyat** ekle, gri/disabled gorunumu kaldir. `quiz_no_power` olu
      string'i sil (bos-guc durumu artik yok).
      **DUZELTME (2026-08-01, koddan):** chat "dogru yapan referans" DEGIL — sadece fiyati
      dogru *gosteriyor*, `solve_chat_question_screen_mixin.dart:169-189` tap'i ayni
      envanter kapisiyla *engelliyor*. Yani chat daha kotu: fiyat yaziyor, ucret almiyor.
      → **Chat de kapsama alindi** (kullanici karari), ayni guard silinir + ayni hata
      yonetimi. Sonuc: sunucudaki "envanter yoksa elmasla ode" yolu prod'da HIC execute
      edilmemis — cihaz testinde ozellikle kanitlanacak.
- [ ] 2.2 **Rescue fiyat bug'i — CIFT bug (2026-08-01 dogrulamasi):** (a) UI carpani
      uygulamiyor (`quiz_screen_mixin.dart:390-397`), `questionCountMultipliers[2]=0.5`
      oldugu icin 2 soruluk quizde tam **2x** gosteriyor. (b) Rescue `powers.base_cost`
      (`quiz.service.ts:756`), normal guc kullanimi `config.powerCosts` (:281) okuyor —
      **kaynak ayrisimi**. Cozum: server `sessionPowerCosts(totalQuestions)` yardimcisi,
      uc cagri noktasi (answer, rescue, `/quiz/start` yaniti) ona baglanir; client hic
      hesap yapmaz, `getPowerCost()` silinir. Migration 021 dogruladi: SKIP 20 / SKIP_ALL 60
      icin `base_cost == purpleCost` → rescue'yu config'e tasimak **fiyat-notr**.
- [ ] 2.2b **SKIP_ALL durustluk kurali:** 2 soruluk quizde 2xSKIP=20 vs SKIP_ALL=30 —
      ayni sonuc, %50 daha pahali (carpan sadelesir; SKIP_ALL ancak 4+ soruda kazaniyor).
      Kural: `skipAllCost < kalanSoruSayisi × skipCost` ise goster. Config fiyati DEGISMEZ.
- [ ] 2.1b **Starter guc paketi:** yeni kullaniciya (e-posta + sosyal, iki `insert`
      noktasi) **2x ORACLE** envantere. Mor elmas DEGIL envanter gucu — fungible degil,
      kapali uclu arz, mor ekonomisini hic degistirmiyor. Mevcut kullanicilara backfill YOK.
      Gecme sansi %12 → ~%49 (0.7²) — sans yukselir, eslesme satin alinmaz.
- [ ] 2.1c **Cift-ucretlendirme korumasi (2.1'in ON KOSULU):** chat-flow-guard BLOCKER
      dondurdu — hicbir katmanda "bu guc bu soruda kullanildi" kontrolu yok. Envanter
      kapisi bu deligi kapatiyormus; kapi kalkinca ust sinir kullanici bakiyesi oluyor.
      Server otorite (chat: mevcut `powers_used`; quiz: migration 036
      `quiz_sessions.current_q_powers`, `incrementCurrentQ`'da sifirlanir) + client UX.
      Yeni kod: `POWER_ALREADY_USED` (409). TIME_EXTEND soru basina 1 kez.
- [x] 2.3 **IPTAL** (2026-08-01, kullanici karari): *"basarisizsa basarisizdir, bunu
      bozmak istemiyorum."* Ertelenmedi — iptal edildi, mekanigin ozu korunuyor.
      Terk vakasina da (quiz'e girip hic cevap vermeden cikma) dokunulmuyor: quiz'e
      dokundugun an taahhut sayiliyor.
- [ ] 2.4 **Soru zorluk rehberligi:** soru olustururken sik kalite kontrolu (4 sikin ayni
      olmamasi) — mobilde inline hata + server'da Zod refine. Zorlugu **tesvik eden** copy
      ("Google'da bulunmasin", 3 key x 16 dil) dengeli metne cevrilir: "seni taniyan birinin
      bilebilecegi". **Sadece yeni/duzenlenen sorular** (kullanici karari) — mevcut 186 soruya
      retroaktif uygulama ve dusuk basari orani proaktif uyarisi Backlog'a.
      **Loop refactor:** ayni dosyalarda controller listener'i hic yok
      (`question_create_bottom_bar.dart`, `question_step_answers.dart`) → yazarken ne onizleme
      ne "Ileri" butonu guncelleniyor; bu duzelmeden inline hata da calismaz.
- [ ] 2.5 **Guc hunisi enstrumantasyonu:** `quiz_power_tap`, `quiz_power_used`
      (source: inventory|diamond), `quiz_power_failed`, `quiz_rescue_shown/accepted/declined`
      + paywall `trigger: 'quiz_power'`. Chat 2.1 kapsamina girdigi icin ayni alti event
      `chat_power_*` / `chat_rescue_*` olarak da eklenir.
      (`quiz_power_sheet_opened` konusuz kaldi — sheet quiz/chat'ten cikiyor.)
      **Loop refactor:** `quiz_complete` (non-first) `onRescue` + `_handleSessionTransition`
      COMPLETED yollarinda fire etmiyor (Faz 1 backlog'u) → duzeltilir.

**Kapsam disi (out):** Eslesme→sohbet koprusu ve icebreaker (Faz 3'e alindi) · server
`expires_at` duvar-saati refactor'u (Backlog — guc/rescue kullanimi artinca izlenmeli) ·
HALF fiyat inversiyonu (Backlog, chat ekonomisini de etkiler) · 2.3 ve terk vakasi (IPTAL).

**Kararlar (2026-08-01 brainstorming'de verildi):**
- 2.3 modeli → **IPTAL**, mekanik korunuyor.
- 2.1 ekonomi → yeni **fungible** arz YOK; starter paket envanter gucu (2x ORACLE),
  sadece yeni kullanicilara. Ekonomi etkisi YUKSEK (8) — detay economy_impact_log.md.
- 2.1 kapsami → chat de dahil (chat referans degil, ayni sekilde bozuk).
- 2.4 kapsami → sadece yeni/duzenlenen sorular.
- SKIP_ALL → config fiyati degismez, gorunurluk kurali eklenir.

**Spec:** `docs/superpowers/specs/2026-08-01-faz2-eslesme-motoru-design.md`

**DoD:** dart analyze sifir + npm build temiz + /flutter-review + /server-review +
chat-flow-guard (yeniden) + i18n-guardian + migration 036 uygulandi +
**cihazda kanit: envanter 0 iken elmasla guc kullanildi, elmas dustu, hedefe yesil gitti**
(bu sunucu yolu hic calismamis) + ayni guce iki kez basinca ikinci sefer ucret alinmiyor +
rescue fiyati UI=server + 2 soruluk quizde SKIP_ALL gorunmuyor + yeni kullanicida 2 ORACLE
rozeti, mevcutta yok + yeni event'ler Firebase'e dustu + 2.0.7 TestFlight'ta.

**Kaba efor:** 3-4 gun (2.1c ve chat ayagi eklendi).

### Baslangic Prompt'u (Faz 2 — Eslesme Motoru)

```
/readyToQulo

Faz 2'yi baslatiyoruz: docs/roadmap/2026-07-19-retention-onboarding-phases.md oku —
"Ortak Baglam" + "FAZ 2 — Eslesme Motoru" tek kaynak. Faz Log'dan Faz 1'in sonucunu oku
(bu faz o olcumun sonucu olarak yeniden onceliklendirildi; eski Faz 2 Onboarding v3 ERTELENDI).

Hedef (v2.0.7): quiz gecilebilirligi — (2.1) quiz PowerBar'i chat versiyonuyla simetrik yap
(envanter yoksa elmasla dogrudan kullan + etiket/fiyat goster), (2.2) rescue fiyatinin UI'da
2x gosterilmesi bug'i, (2.3) FAILED sonrasi profilin kalici kaybolmasina ikinci sans,
(2.4) soru olustururken zorluk rehberligi + sik kalite kontrolu, (2.5) guc hunisi analytics
event'leri.

Brainstorming ile basla: 2.3'un modeli (swipe silme / cooldown / 1 yanlis hakki) ve 2.1'in
ekonomi etkisi burada kararlastirilir — /economy-impact ZORUNLU. Kod tarafinda kesif yapmadan
once roadmap'teki dosya:satir referanslarini kullan (power_bar.dart:46-59,
quiz.service.ts:278-302, chat_question_power_bar.dart:65-67 dogru yapan referans).
Bitince: cihaz testi talimati, Faz Log, 2.0.7 surum hazirligi.
```

---

## ERTELENEN — Onboarding v3 "Tanisma Oyunu"

**Durum:** 2026-08-01'de **ertelendi**. Sebep: cozmeyi hedefledigi sorun (kullanicinin
uygulamayi anlamamasi) Faz 1 ile olculebilir sekilde kapandi — `app_confusing` silme nedeni
3 → 0, aktivasyon %44 → %70, post-Faz1 kohortta e-posta dogrulama %100 (social-first landing
sayesinde 2.5 maddesi de konusuz kaldi). Su anki darbogaz quiz; trafik de dusuk (Meta bani →
organik gunde 1-3 kayit), yani buyuk bir onboarding yeniden yazimi simdi olculemez.

**Ne zaman geri gelir:** trafik geri geldiginde (Google Ads / organik olcek) veya aktivasyon
orani tekrar dustugunde. Asagidaki kapsam oldugu gibi saklandi.

**Saklanan kapsam (in):**
- [ ] 2.1 **Interaktif demo**: acilista ornek bir soruyu kullaniciya GERCEKTEN cozdur (anlatma, yasat). Dogru cevapta mini kutlama + "iste eslesme boyle olur".
- [ ] 2.2 **"Seni taniyalim" adimlari (pre-signup)**: cinsiyet, tercih, dogum tarihi + ilgi alanlari + 2-3 yasam tarzi chip'i. TAMAMI tap-select (yazi yazdirma yok). Hassas kategori (din, etnik koken vb.) YOK.
- [ ] 2.3 **AI soru preview (aha-moment)**: secimlere gore `ai_question_bank`'ten 3-4 soru blur'lu/preview gosterilir: "Sana ozel sorular hazir". Server isi: anonim/pre-auth suggest endpoint'i (rate limit ZORUNLU — abuse yuzeyi) veya bank'in salt-okunur public alt kumesi. Brainstorming'de karar.
- [ ] 2.4 **Social-first kayit en sonda**: "Kaydol, sorularin yayinlansin". Pre-signup veriler local persist → kayit basarisinda toplu gonderim. Kayit adimlari pre-signup'ta toplananlarla DEDUPE edilir (ayni soru iki kez sorulmaz — mevcut 7 adim eriyip dagitilir).
- [ ] 2.5 **E-posta dogrulama bandi gevsetme**: login gate kaldirilir (`EMAIL_NOT_VERIFIED` login engeli), app'e giris serbest; discover GORUNURLUK filtresi olarak kalir (server filtresi zaten mevcut). App ici "e-postani dogrula → gorunur ol" banner'i eklenir.
- [ ] 2.6 **Profil setup gate sadelesmesi**: sorular pre-signup'ta hazirlandigi icin gate'te kalan: foto + soru onayi/yayini. "Hemen Ata"/"Sihirli Doldur" yollari korunur (fallback).

**Kapsam disi (out):** Discover/matching server degisiklikleri (Faz 3), yeni ekonomi odulleri (istenirse Backlog).

**Riskler/karar noktalari (brainstorming gundemi):** anonim suggest abuse korumasi; pre-signup state makinesi (kapat-ac senaryolari); dogrulama banner'inin gorunurluk baskisi dengesi; A/B ihtiyaci (minimum: Faz 1 funnel event'leriyle oncesi/sonrasi kiyas).

**Not (2026-08-01):** 2.5 (e-posta dogrulama gevsetme) post-Faz1 kohortta konusuz kaldi —
social-first landing sonrasi e-posta dogrulama orani %100. Geri gelirse kapsam gozden gecirilmeli.

---

## FAZ 3 — Cold Start & Re-engagement → v2.0.8

**Neden:** Reklam aninda ayni sehirden toplu gelis olacak. Bos discover sessiz olum; ilk gun eslesemeyen kullaniciyi geri cagiran mekanizma yok. Bu faz agirlikla SERVER isi.

**Kapsam (in):**
- [ ] 3.1 **D1/D3/D7 re-engagement push cron'u**: kayit sonrasi eslesmesi olmayan / inaktif kullaniciya otomatik push. Mevcut `campaign.service.ts` + `segment.service.ts` (`last_active_days`) altyapisi uzerine `src/cron/index.ts`'e cron. Icerik tonu: basit, gundelik (analitik jargon yasak). Push locale sync mevcut — kullanici dilinde gider. Frekans tavani + opt-out (notification preferences mevcut) zorunlu.
- [ ] 3.2 **Bos discover fallback**: radius icinde aday yoksa otomatik kademeli radius genisletme (orn. 100→250→500) veya server'dan "genislet" onerisi. Strict dil filtresi fallback'i de degerlendirilir (orn. bos listede dil kosulunu gevset + rozetle). Karar brainstorming'de.
- [ ] 3.3 **`.limit(50)` olcek fix'i**: aday cekimi mesafe-oncelikli hale getirilir (bounding box / earthdistance / PostGIS — mevcut Supabase yetenegine gore secim). Hedef: DB buyudugunde yakin adaylar listeye kesin girsin.
- [ ] 3.4 **Mobile es**: yeni push tiplerinin deep link'leri + bos discover'in yeni fallback UX'i (mevcut `discover_empty_state.dart` uzerine).
- [ ] 3.5 **Eslesme → sohbet koprusu** (2026-08-01'de Faz 2'den tasindi): prod'da 8 eslesmenin
      sadece 1'i sohbete dondu. (a) Celebration'daki "Mesaj Gonder" **chat'e gitmiyor** —
      `quiz_screen_mixin.dart:399-402` paywall + `/matches` listesine gonderiyor; `matchId`
      zaten elde, dogrudan chat'e derin baglanti kurulacak, paywall cikisa alinacak.
      (b) Bos sohbet ekrani tek satir soluk "Merhaba de!" (`chat_message_list.dart:41-48`) —
      icebreaker chip'leri eklenecek (quiz ozeti + ilgi alanlarindan uretilir; `QuizSummaryCard`
      zaten var ama CTA'siz). (c) `new_match` push'lari `/matches`'a gidiyor, chat'e derin
      baglanti verilecek + "24 saattir mesaj atmadin" hatirlatmasi 3.1 cron'una eklenecek.

**Kapsam disi (out):** Yeni matching skoru/algoritma revizyonu (Backlog), moderasyon (Faz 4).

**DoD:** /server-review temiz + cron staging'de calisir dogrulandi (test segmentiyle) + push test cihazina dustu + bos discover fallback'i radius disi konumla test edildi + discover sorgu performansi olculdu (buyuk seed ile) + migration'lar Supabase MCP ile + 2.0.8 TestFlight'ta.

**Kaba efor:** 2-3 gun.

### Baslangic Prompt'u (Faz 3)

```
/readyToQulo

Faz 3'u baslatiyoruz: docs/roadmap/2026-07-19-retention-onboarding-phases.md oku — "Ortak Baglam" + "FAZ 3" tek kaynak. Faz Log'dan onceki fazlarin durumunu kontrol et.

Hedef (v2.0.8): cold start + geri getirme — (3.1) D1/D3/D7 push cron'u (campaign+segment altyapisi uzerine, frekans tavani + opt-out sart), (3.2) bos discover'da kademeli radius/dil fallback karari ve uygulamasi, (3.3) matching.service.ts'teki sirasiz .limit(50) aday cekiminin mesafe-oncelikli hale getirilmesi, (3.4) mobile deep link + bos discover UX esleri, (3.5) eslesme→sohbet koprusu (celebration'dan dogrudan chat, icebreaker chip'leri, push deep link + mesajsiz eslesme hatirlatmasi).

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

- (2026-08-01 quiz taramasi) **Server `expires_at` duvar-saati**: oturum butcesi
  `sum(time_limit)+10sn` (2 soruda 70sn) ve client pause'lari (rescue dialogu, guc sheet'i,
  coach mark) bunu durdurmuyor; `TIME_EXTEND` gucu `expires_at`'i uzatmiyor. Su an fail
  sebebi degil (67/67 yanlis cevap) ama Faz 2 ile guc/rescue kullanimi artinca patlar.
- (2026-08-01 quiz taramasi) **Mobilde `TIME_UP`/`SESSION_NOT_FOUND`/`ALREADY_ANSWERED`
  ele alinmiyor** (grep: 0 sonuc) → server'da FAILED olmus oturumda kullanici sessizce kilitli
  kalabiliyor, sonuc ekrani gormeden.
- (2026-08-01 quiz taramasi) **Zombi oturumlar**: `confirmExit` `fail()` cagirmiyor →
  terk edilen oturum sonsuza dek IN_PROGRESS (prod'da 8 adet, hepsi suresi dolmus) ve
  hedefin soru duzenlemesini bloke ediyor (`pending-change.service.ts:5-12`). Temizlik cron'u yok.
- (2026-08-01 quiz taramasi) Olu kod/string: `quiz_result_dialog.dart` (290 satir) hic import
  edilmiyor · `quiz_no_power` 20+ dile cevrilmis ama kullanilmiyor ·
  `AnswerFeedbackOverlay.correctAnswerText` hic gecirilmiyor (kullanici dogru cevabi hic
  gormuyor) · `powerStatMap`'te `ORACLE` yerine `COPY` yazili, Kahin istatistigi sayilmiyor
  (`quiz.service.ts:673`).
- (2026-08-01 Faz 2 brainstorming) **KRITIK — chat kalici kilitlenmesi:** `submitGiveUp` →
  `handleTimeout` DB'ye hicbir sey yazmiyor → `has_chat_lock` sorusu sonsuza dek
  `answered_option IS NULL` kaliyor → sohbet kilitli (`chat.service.ts:155-163`).
  Faz 2 yeni bir giris yolu ekliyor: bakiyesiz kullanici POWER_UNBLOCK'a basar →
  INSUFFICIENT_DIAMONDS → paywall → satin alamaz → "Pes et" → chat kalici kilitli.
- (2026-08-01) **HALF fiyat inversiyonu:** ORACLE 5 mora %70 (`accuracy_rate` 0.7),
  HALF 10 mora %50. Iki kati fiyata daha kotu sonuc — rasyonel oyuncu HALF almaz.
  Chat'i de etkiledigi icin ayri karar.
- (2026-08-01) **Ucuz guclerde yesil odul 0'a yuvarlaniyor:** `floor(3 × 0.30) = 0` →
  ORACLE/TIME_EXTEND kullaniminda hedef hic yesil kazanmiyor. "Sorularim cozulurse
  kazanirim" vaadi 2 soruluk quizde fiilen calismiyor.
- (2026-08-01) **POWER_BLOCK/UNBLOCK config drift'i:** migration 019 `base_cost` 40/50,
  migration 021 `powerCosts` 15/15. Hangisinin gecerli oldugu kod yoluna gore degisiyor.
- (2026-08-01) **Yesil sink daralmasi:** `PowerPurchaseSheet` quiz+chat'ten cikiyor —
  yesilin ana harcama kanali. Ayni anda yesil uretimi artiyor. 2.5 verisiyle yeniden bak.
- (2026-08-01) `stats_copy_used` kolonunun `stats_oracle_used` olarak yeniden adlandirilmasi
  (Faz 2'de sadece `powerStatMap` anahtari `COPY`→`ORACLE` duzeltiliyor, kolon adi legacy kaliyor).
- (2026-08-01) Mevcut sorulara dusuk basari orani proaktif uyarisi (2.4'ten cikarildi).
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
| 2026-08-01 | Faz 1 | 📊 **Yayin sonrasi olcum (1.5 hafta)** | 2.0.6 | **BASARILI.** Aktivasyon %44→**%70** (2+ soru %57→90, foto %54→80, e-posta dogrulama %90→100). `app_confusing` silme nedeni **3→0**. Ilk 3 abone geldi. **AMA:** gun-0 silme %37→%50, D1 geri donus %15.6→**%0**, ort. omur 1.5→0 gun; yeni 1 numarali silme nedeni **`few_matches`**. Kohort kucuk (10 kayit — Meta bani sonrasi trafik gunde 1-3). Sonuc: onboarding cozuldu, darbogaz **quiz'e** kaydi → Faz 2 yeniden onceliklendirildi (Onboarding v3 ertelendi, yerine Eslesme Motoru). |
