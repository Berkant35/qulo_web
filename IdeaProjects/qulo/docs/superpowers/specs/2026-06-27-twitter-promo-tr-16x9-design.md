# Qulo Twitter Reklamı (TR, 16:9) — Tasarım Spec'i

**Tarih:** 2026-06-27
**Branch:** APP-1915
**Sahip:** Berkant Çalıkuşu
**Durum:** Brainstorming tamamlandı, implementation planı bekleniyor.

---

## 1. Genel Bakış

Qulo için **Türkçe**, **16:9 yatay**, **~30 saniyelik** resmi tanıtım videosu. Birincil dağıtım kanalı **Twitter/X**. Estetik: Qulo marka renk şifti (kaos/kırmızı → çözüm/yeşil), karanlık premium zemin, tek tek beliren tipografi + native uygulama UI animasyonları.

**Mesaj:** Tinder-tarzı sonsuz kaydırma kısır bir döngü; gerçek eşleşme vermiyor. Qulo, kişiyi *kaydırmadan* — **soru çözerek** — doğrulayan sistem. Türk kullanıcıların yaşadığı somut sorunları (evli çıkma, sonradan maço/ego) "doğru soru" mekaniğiyle eler.

**Kapanış mottosu (locked):** *"Doğru soru, doğru insan."*

**Üretim:** Tamamen **Remotion** (React → headless Chrome frame render → ffmpeg H.264 MP4). Veo/canlı çekim YOK; tüm görseller native React/SVG/CSS animasyon. **Türkçe seslendirme (ElevenLabs) + alt müzik.** Sessiz autoplay'de mesaj ekran yazılarıyla tam taşınır (Twitter autoplay muted'dır — yazılar zorunlu taşıyıcı).

---

## 2. Ürün Kararları (Locked)

| Karar | Lock |
|---|---|
| **Format** | 16:9 yatay, **1920×1080**, 30fps, H.264 MP4 |
| **Süre** | ~30.0 sn (900 frame @ 30fps) |
| **Dil** | Türkçe (ekran yazıları + VO) |
| **Birincil platform** | Twitter/X (resmi hesap postu) |
| **Üretim hattı** | Remotion (React=HTML → ffmpeg), config-driven sahne dizisi |
| **Ses** | Türkçe VO (ElevenLabs) + alt müzik track; SFX opsiyonel |
| **Mobil görünüm** | Native Remotion UI (PhoneFrame + QuizSolve/QuestionCreate/MatchCelebration), gerçek screenshot DEĞİL |
| **Kapanış mottosu** | "Doğru soru, doğru insan." |
| **CTA** | Qulo logo + motto + App Store & Google Play badge'leri |
| **Estetik** | Karanlık premium zemin, kaos→çözüm renk şifti (kırmızı→yeşil), tek tek beliren tipografi |

---

## 3. Marka & Tema Token'ları

Kaynak: `entertainment/qulo-tiktok-promos/src/theme.ts` token'ları yeni 16:9 projesine taşınır. Renkler aynı; yalnız `composition` ve `safeZone` 16:9 için yeniden tanımlanır.

```ts
colors: {
  bg:         '#0D0D0D',   // ana karanlık zemin
  surface:    '#1A1A1A',
  green:      '#69F0AE',   // Qulo yeşili — çözüm/eşleşme/tick
  purple:     '#BB86FC',   // Qulo moru — sub-accent, elmas
  danger:     '#CF6679',   // problem/kaos vurgusu (kırmızı)
  text:       '#FFFFFF',
  textMuted:  '#B0B0B0',
}
fonts.display: Poppins (400–900, @remotion/google-fonts) — Türkçe glyph desteği doğrulanacak
composition: { width: 1920, height: 1080, fps: 30 }
safeZone (16:9): { top: 80, bottom: 100, horizontal: 120 }  // Twitter UI minimal müdahale
```

**Türkçe tipografi notu:** Poppins Türkçe karakterleri (ç, ğ, ı, İ, ö, ş, ü) destekler; ilk render sonrası ı/İ ayrımı görsel kontrol edilecek. Sorun çıkarsa Inter veya Montserrat fallback.

**Marka asset'leri (kanonik, kopyalanmaz — referans):**
```
entertainment/qulo-tiktok-promos/public/  (logo/diamond burada)
entertainment/qulo-real-demo/assets/brand/qulo_logo.png, green_diamond.png
```
App Store / Google Play badge'leri resmi (Apple/Google marketing guideline) SVG/PNG olarak `public/brand/badges/` altına indirilecek.

---

## 4. Mimari Karar — İzole Yeni Proje

Mevcut `qulo-tiktok-promos` projesi **9:16 + İngilizce** kısıtlarına kilitli (businessCaseSkill `qulo-tiktok-promo.md` "Türkçe yasak, 9:16 zorunlu" der). Bu Türkçe/16:9 işi o kısıtları kirletmemeli.

**Karar:** Yeni kardeş Remotion projesi:
```
entertainment/qulo-twitter-tr/
```
- Theme token'ları kopyalanıp 16:9'a uyarlanır (renkler aynı, boyut/safe-zone farklı).
- İlgili bileşenler `qulo-tiktok-promos/src/components/`'ten **kopyalanıp landscape'e uyarlanır** (mevcut bileşenler portrait boyutlara gömülü — fork zorunlu, in-place değişiklik 9:16 videoları bozar).
- Config-driven sahne dizisi pattern'i (`TikTokPromo` + `configs/`) birebir benimsenir → tek `QuloTwitterAd` composition, sahneler config'ten okunur.

**Bileşen yeniden-kullanım haritası (kaynak → 16:9 uyarlaması):**

| Yeni sahne | Kaynak bileşen | Uyarlama |
|---|---|---|
| S1 uçuşan kartlar | `TinderMock` + `DriftingCard` | Landscape grid, kartlar yatay eksende savrulur, kırmızı ✕ overlay |
| S2 soru ekranları | `HookScene` + `CaptionTrack` | Yatay büyük tipografi, tek tek reveal |
| S3 Qulo reveal | yeni `BrainNetwork` (SVG) + `QuizSolve` | Beyin/nöron line-up animasyonu yeni; tick'ler QuizSolve'tan |
| S3/S5 telefon | `PhoneFrame` + `QuizSolve`/`QuestionCreate` | PhoneFrame landscape kompozisyonda yana yerleştirilir |
| S4 problem akışı | `StatsGrid`/`ProcessStep` mantığı | Yeni `ProblemFlow`: kırmızı cümle → yeşil tick eleme |
| S5 eşleşme | `MatchCelebration` + `DiamondBurst` | Landscape merkez pop + elmas burst |
| S6 kapanış | `CTAScene` | Logo + motto + store badge'leri (yeni badge asset'leri) |
| Altyazı | `CaptionTrack` | VO ile senkron Türkçe altyazı (opsiyonel görsel katman) |

---

## 5. Storyboard ve VO (30 sn = 900 frame @ 30fps)

| Süre (s) | Frame | Sahne | İçerik | VO (TR) |
|---|---|---|---|---|
| 0.0–4.0 | 0–120 | **S1 — Boş Kaos** | Tinder-tarzı kartlar yatay eksende sağa-sola savrulur, üst üste, hızlanarak. Her kartta sönük kırmızı ✕. Ortada eşleşme boşluğu. Yazı tek tek: "Yüzlerce kart." → "Sıfır gerçek eşleşme." | "Sağa kaydır. Sola kaydır. Sağa, sola…" |
| 4.0–9.0 | 120–270 | **S2 — İki Soru** | Kartlar donar, karanlığa çekilir. Büyük tipografi tek tek belirir. | "Bu kısır döngüden sıkılmadınız mı?" → "Kriterlerinize gerçekten uyan birini nasıl bulursunuz?" |
| 9.0–15.0 | 270–450 | **S3 — Qulo Doğuşu** | Qulo logo + yeşil elmas parıltısı. Beyin/nöron line-up'ları birbirine bağlanır (zihinsel uyum). PhoneFrame içinde sorular tek tek yeşil tick alır. | "Qulo geldi. Artık kaydırmıyorsun — çözüyorsun." + "Sorunu sor. Çözen eşleşir." |
| 15.0–23.0 | 450–690 | **S4 — Problem Akışı (hype)** | Ritmik. Kırmızı problem cümlesi ekrana vurur → üstüne yeşil tick + sönme. 3 problem ardı ardına. | "Sevgili sandığın evli çıktı." / "İlk buluşmada centilmen, sonra maço." / "Egosuz sanmıştın… değilmiş." → "Qulo'da hepsi tek bir doğru soruyla elenir." |
| 23.0–27.0 | 690–810 | **S5 — Çözüm Anı** | PhoneFrame: tüm tick'ler yeşil → MATCH pop'u + yeşil/mor elmas burst. | "Doğru soruyu soran, doğru insanı bulur." |
| 27.0–30.0 | 810–900 | **S6 — Kapanış** | Qulo logo ortada + motto + App Store & Google Play badge'leri (statik 1.5sn tutuş). | "Doğru soru, doğru insan. Qulo." |

### 5.1 Ekran Metinleri (locked, TR)

- **S1:** "Yüzlerce kart." · "Sıfır gerçek eşleşme."
- **S2:** "Bu kısır döngüden sıkılmadınız mı?" · "Kriterlerinize gerçekten uyan birini nasıl bulursunuz?"
- **S3:** "Qulo geldi." · "Kaydırma. Çöz." · "Sorunu sor. Çözen eşleşir."
- **S4 (problemler, kırmızı→yeşil tick):**
  - "Sevgili sandığın **evli** çıktı." ✓
  - "İlk buluşmada centilmen, sonra **maço**." ✓
  - "Egosuz sanmıştın… **değilmiş**." ✓
  - kapanış vuruşu: "Hepsi tek bir doğru soruyla elenir."
- **S5:** "Eşleşme!" (MATCH pop)
- **S6:** Logo + "Doğru soru, doğru insan." + store badge'leri

### 5.2 VO Timing Map (yaklaşık)

| Saniye | Söylenen |
|---|---|
| 0.5 / 1.5 / 2.5 | "Sağa kaydır." / "Sola kaydır." / "Sağa, sola…" |
| 4.5 | "Bu kısır döngüden sıkılmadınız mı?" |
| 6.8 | "Kriterlerinize gerçekten uyan birini nasıl bulursunuz?" |
| 9.5 | "Qulo geldi. Artık kaydırmıyorsun — çözüyorsun." |
| 12.5 | "Sorunu sor. Çözen eşleşir." |
| 15.5 / 17.5 / 19.5 | 3 problem cümlesi |
| 21.5 | "Qulo'da hepsi tek bir doğru soruyla elenir." |
| 24.0 | "Doğru soruyu soran, doğru insanı bulur." |
| 28.0 | "Doğru soru, doğru insan. Qulo." |

İlk render sonrası VO uzunluğuna göre sahne frame'leri ±15 frame ayarlanır (config'ten, kod değişmeden).

---

## 6. Ses Tasarımı

### 6.1 Voiceover (ElevenLabs)
- **Profil:** Türkçe, erkek veya kadın (ilk render'da iki ses denenir), kendinden emin/sıcak ton, orta tempo.
- **Stil:** S1-S2 sorgulayıcı/yorgun; S3-S6 kararlı/çözüm odaklı.
- **Output:** `public/audio/vo_tr_final.mp3` — 30sn silence-padded.
- **Türkçe telaffuz kontrolü:** "kaydır", "eşleşme", "çözen" gibi kelimeler ilk render'da dinlenip ayarlanır.

### 6.2 Müzik
- **Yapı:** İki bölümlü tek track. Bölüm 1 (0–9s): gergin/melankolik, kaos hissi. Geçiş (~9s): yükseliş. Bölüm 2 (9–30s): enerjik/hype, çözüm momentumu. Son 1.5sn fade out.
- **Kaynak:** `entertainment/assets/` altındaki hazır mp3'ler değerlendirilir; uymazsa ElevenLabs Music.
- **Output:** `public/audio/music_30s.mp3`.

### 6.3 SFX (opsiyonel, hafif)
- S1 kart savrulma swoosh'ları, S3/S5 tick "tık" sesi, S5 match chime, S4 problem "vuruş" sesi. Hepsi VO/müziğin altında (-18dB).

---

## 7. Klasör Yapısı

```
entertainment/qulo-twitter-tr/
  src/
    index.ts
    Root.tsx                      # QuloTwitterAd composition (1920×1080, 900 frame)
    QuloTwitterAd.tsx             # config-driven sahne oynatıcı
    theme.ts                      # 16:9 token'lar (renkler tiktok'tan, boyut yeni)
    types.ts
    configs/
      twitter-tr.config.ts        # sahne timeline (start/duration/props)
    scenes/
      S1ChaosCards.tsx
      S2Questions.tsx
      S3QuloReveal.tsx
      S4ProblemFlow.tsx
      S5MatchMoment.tsx
      S6Closing.tsx
    components/                   # tiktok'tan fork + landscape uyarlama
      TinderMockLandscape.tsx
      DriftingCard.tsx
      BrainNetwork.tsx            # YENİ — nöron/line-up SVG animasyonu
      PhoneFrame.tsx
      QuizSolve.tsx
      QuestionCreate.tsx
      MatchCelebration.tsx
      DiamondBurst.tsx
      ProblemFlow.tsx             # YENİ — kırmızı cümle → yeşil tick
      CaptionTrack.tsx
      StoreBadges.tsx             # YENİ — App Store + Google Play badge satırı
  public/
    audio/ vo_tr_final.mp3, music_30s.mp3
    brand/ qulo_logo.(svg|png), green_diamond, purple_diamond
    brand/badges/ app_store_tr.svg, google_play_tr.png
  out/                           # render çıktısı, .gitignore
    qulo-twitter-tr-30s-16x9.mp4
  prompts/
    elevenlabs-vo-tr.md
    elevenlabs-music.md
  package.json                   # tiktok package.json baz alınır (Remotion 4.x)
  tsconfig.json
  README.md
  .gitignore                     # node_modules, out/, *.mp4
```

---

## 8. Render

- `npm run studio` → Remotion Studio canlı önizleme (her sahne tek tek doğrulanır)
- `npm run render` → `npx remotion render src/index.ts QuloTwitterAd out/qulo-twitter-tr-30s-16x9.mp4`
- Çıktı doğrulama: dosya var, boyut > 2MB, süre ~30sn, fps 30, çözünürlük 1920×1080, ses+görüntü senkron.

---

## 9. İş Bölümü (User vs Agent)

| Aşama | Kullanıcı (Berkant) | Agent (Claude) |
|---|---|---|
| 0 — Spec | Onay ver | Spec yaz, commit |
| 1 — İskelet | (bekle) | Yeni proje kur, theme+config+Root, `npm install` |
| 2 — Sahne bileşenleri | (bekle) | 6 sahne + fork edilen/yeni bileşenleri kodla |
| 3 — Sessiz önizleme | Studio'da izle, geri bildirim | İlk render (VO/müzik olmadan), timing ayarı |
| 4 — VO | ElevenLabs ile TR VO üret → `public/audio/` | Exact VO script + voice ID + ayar önerisi |
| 5 — Müzik | Track seç/üret → `public/audio/` | Müzik prompt/seçim, mix notu |
| 6 — Final render | Çıktıyı izle, geri bildirim | Ses mount + final render MP4 |
| 7 — İterasyon | Zayıf sahne geri bildirimi | Config/komponent fine-tune |

Her aşama checkpoint'li — biri tamamlanmadan diğerine geçilmez.

---

## 10. Riskler ve Mitigasyonlar

| Risk | Olasılık | Etki | Mitigasyon |
|---|---|---|---|
| Poppins Türkçe ı/İ render sorunu | Orta | Orta | İlk render'da görsel kontrol; Inter/Montserrat fallback |
| 16:9 bileşen forklarının portrait mantığını taşıması | Orta | Orta | Layout sabitlerini theme.composition'dan oku, hardcode etme |
| 30sn'ye sığmama (over-edit) | Orta | Düşük | Sahne süreleri config'ten esnek, ±15 frame ayar |
| Türkçe VO telaffuz/ton zayıf | Orta | Orta | İki ses dene, ilk render'dan sonra fine-tune |
| Store badge marka guideline ihlali | Düşük | Orta | Apple/Google resmi badge asset'leri + boşluk kuralı |
| `entertainment/` git LFS gereksinimi | Düşük | Düşük | out/ ve *.mp4 .gitignore'da; public asset'ler <10MB |

---

## 11. Başarı Kriterleri

- [ ] 30sn final MP4 (1920×1080, H.264, 30fps) export edilebilir, ses+görüntü senkron
- [ ] İlk 3sn'de hook (uçuşan kartlar + ✕) scroll'u durdurur
- [ ] Sessiz autoplay'de (ses kapalı) mesaj yalnız ekran yazılarıyla tam anlaşılır
- [ ] S3'te Qulo reveal + tick'lenen sorular "çözerek eşleşme" mekaniğini net anlatır
- [ ] S4'te 3 Türk problemi → yeşil tick eleme ritmik ve vurucu
- [ ] S6'da motto "Doğru soru, doğru insan." + store badge'leri okunur
- [ ] Twitter upload formatı uyumlu (16:9, MP4 H.264, <512MB, <140sn)

---

## 12. Sıradaki Adım

Bu spec onaylandıktan sonra **writing-plans** skill'i ile implementation plan oluşturulacak. Plan, Bölüm 9'daki iş bölümünü birim aşamalara açacak.

**Out of scope (bu spec'te değil):**
- 9:16 / TikTok versiyonu (mevcut `qulo-tiktok-promo` skill'i kapsar)
- İngilizce/uluslararası versiyon
- App Store / Google Play preview video (farklı format + store kuralları)
- Paid ad A/B varyantları, çoklu hook
- Canlı çekim / Veo entegrasyonu (bu video tamamen native Remotion)
