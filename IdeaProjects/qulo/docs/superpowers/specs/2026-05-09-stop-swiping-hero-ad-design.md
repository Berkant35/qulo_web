# Stop Swiping Hero Ad — Design Spec

**Tarih:** 2026-05-09
**Branch:** APP-1915
**Sahip:** Berkant Çalıkuşu
**Durum:** Brainstorming tamamlandı, implementation planı bekleniyor.

---

## 1. Genel Bakış

Qulo için sıfırdan üretilen 15 saniyelik **hero reklam videosu**. Birincil dağıtım Instagram Reels + TikTok (9:16 portrait, İngilizce, international). Estetik: **A24 cinematic realism + Qulo brand renk şifti (cool→warm)**. Production hibrit: **Veo 3 Pro** (oyuncu/sahne) + **Remotion** (kart efekti, transition, end card, audio mix). Audio: **ElevenLabs** (VO + Music).

Mesaj: **"Stop swiping. Start solving."** — anti-swipe manifestosu. Kişisel bir manifesto: kurucunun karşı çıktığı swipe culture'a görsel-duygusal cevap.

Kalp metafor: **"The card that got away."** Kullanıcının swipe edip görmediği kart, aslında onun mükemmel match'iydi. Audience bunu görür, kullanıcı görmez. Qulo bu "kaçırma"yı sorularla engelleyen sistem olarak konumlanır.

---

## 2. Ürün Kararları (Locked)

| Karar | Lock |
|---|---|
| **Hook / Tagline** | "Stop swiping. Start solving." |
| **Format** | 9:16 portrait, 15.0sn, 30fps, H.264 MP4 |
| **Birincil platform** | Instagram Reels + TikTok |
| **Dil** | İngilizce (international, accent-neutral) |
| **Estetik** | A24 cinematic realism + Qulo cool→warm brand renk şifti |
| **Audio kimliği** | Spoken Word VO (ElevenLabs female, mid-30s, husky-warm) + iki-bölümlü cinematic-to-soft-beat müzik (ElevenLabs Music) |
| **Yapı** | Slow burn → Release, 4 shot + 1 micro-beat |
| **Production** | Hibrit: Veo 3 Pro (oyuncu/mekan) + Remotion (VFX, transition, end card, mix) |
| **Karakter tutarlılığı** | Veo 3 Pro image-to-video reference (1 kadın + 1 erkek portresi) |
| **CTA** | Minimal: logo + tagline + qulo.app (no app store badges) |

---

## 3. Storyboard ve VO

### 3.1 VO Script (final, ~12 kelime)

> *"We swipe. We scroll. We swipe. And the one we needed... drifts away. Stop swiping. Start solving."*

### 3.2 Shot Timeline

| Süre (s) | Sahne | İçerik | Audio |
|---|---|---|---|
| 0.0–3.0 | **Shot 1 — Numb Swipe** | Yatakta kadın, mavi telefon ışığı yüzünde, mekanik swipe, dead eyes, anamorphic lens flare, 35mm grain | "We swipe. We scroll. We swipe." + cinematic indie piano |
| 3.0–6.5 | **Shot 2 — The Card Drifts** | Aynı swipe ile kart fiziksel olarak telefondan fırlar; kartın üstünde gülümseyen sıcak gözlü adam; kart partikül gibi dağılır, kaybolur. Kadın hiç görmedi; audience gördü. | "And the one we needed..." + piano build, low strings drone |
| 6.5–7.0 | **Pause Beat (köprü)** | Kadının parmağı havada donar, kaşı hafifçe çatılır; bilinçli görmüyor ama hissediyor — "bir şey kaçtı" | "...drifts away." (kelime + duygu eşleşir) + müzik tutuş |
| 7.0–11.0 | **Shot 3 — Conscious Shift** | Time ellipsis (lighting değişir); aynı kadın dik oturuyor, niyetli; Qulo'yu kasıtlı açar; soruları okuyor, **cevap veriyor** (swipe etmiyor); cool mavi → warm yeşil renk geçişi yüzüne yansır | Sessizlik (VO yok) + soft beat girişi (Bonobo-lite), warm pad |
| 11.0–13.5 | **Shot 4 — Recognition** | Match bildirimi titreşir; açar — Shot 2'deki **aynı adam**, soruları çözmüş; bu sefer kaybolmadı; hafif gülümseme, derin nefes | "Stop swiping. Start solving." + müzik zirve |
| 13.5–15.0 | **End Card** | Qulo logo (yeşil elmas mikro-parıltı), altında "Stop swiping. Start solving.", en altta "qulo.app", 1.5sn statik | Müzik fade out |

### 3.3 VO Timing Map

| Saniye | Söylenen | Sahne |
|---|---|---|
| 0.5 | "We swipe." | Shot 1 |
| 1.5 | "We scroll." | Shot 1 |
| 2.5 | "We swipe." | Shot 1 |
| 4.0 | "And the one we needed..." | Shot 2 |
| 6.7 | "...drifts away." | Pause Beat |
| 11.5 | "Stop swiping." | Shot 4 |
| 12.5 | "Start solving." | Shot 4 / End card |

7.0–11.0 saniye aralığı kasıtlı sessiz (mod değişimi sözle değil görsel ritimle taşınır).

---

## 4. Audio Tasarımı

### 4.1 Voiceover (ElevenLabs)

- **Voice profili:** Female, mid-30s, husky-warm, accent-neutral US/UK, pacing yavaş ve düşünceli
- **Stil:** Şiirsel teslim; her cümle sonunda doğal nefes; "drifts away" cümlesi micro-pause sonrası söylenir
- **Voice settings (öneri):** stability 0.5, similarity 0.75, style 0.4 (denenecek; ilk render'dan sonra ayarlanır)
- **Output:** `public/audio/vo_en_final.mp3`, 15sn'lik silence-padded mono 44.1kHz

### 4.2 Müzik (ElevenLabs Music)

İki-bölümlü tek track, 15sn:

- **Bölüm 1 (0-7s):** Cinematic indie piano + low strings drone, melancholic. Tempo 70bpm, A minor. "Past Lives" / Ennio Morricone-lite vibe.
- **Bridge (~6.5-7s):** Pause beat ile eşleşen tutuş — single sustained note, müzikal nefes.
- **Bölüm 2 (7-15s):** Soft beat girer (kick + soft snap), warm pad katmanı, Bonobo-lite. Tempo aynı kalır (cross-rhythm), key A minor → A major modülasyon (cool→warm hissinin ses karşılığı). Final 1.5sn fade out.

- **Output:** `public/audio/music_15s_arc.mp3`, stereo 44.1kHz
- **Fallback:** Tek prompt'la sonuç zayıf çıkarsa iki ayrı 8sn track + Remotion'da crossfade.

### 4.3 SFX

- Shot 1: muffled bedroom ambient, parmak swipe-flick (subtle, real)
- Shot 2: swoosh (kart fırlama) → ethereal disintegration (whoosh + soft glass shimmer)
- Shot 3: niyetli tap sound (dampened, premium tıklama)
- Shot 4: notification chime (mute olabilir; opsiyonel — müzik öne çıksın)
- Tüm SFX -18dB civarında, müzik ve VO'nun altında

---

## 5. Görsel Dil

### 5.1 Cinematography

- **Lens:** Anamorphic (2.39:1 horizontal squeeze hissi, ama crop 9:16); shallow DOF (f/1.8-2.8)
- **Lighting:** Shot 1-2: cool, single window/phone-glow practical; Shot 3-4: warm, golden hour / lamp practical
- **Texture:** 35mm film grain (Remotion overlay), subtle gate weave
- **Color grade:** Shot 1-2: deep teal shadows, desaturated mid-tones; Shot 3-4: warm highlights (orange-yellow), Qulo green/purple accents

### 5.2 Renk Paleti (Brand)

- **Qulo Green:** `#1FCB7E` (yeşil elmas accent, Shot 3 başında ve end card'ta)
- **Qulo Purple:** `#7B5CFA` (sub-accent, end card'ta)
- **Cool grade (Shot 1-2):** `#0F1A2E` (deep teal), `#3A4A66` (mid), `#6F86A8` (highlight)
- **Warm grade (Shot 3-4):** `#1F1308` (deep brown), `#5A3F1E` (mid), `#E8B070` (highlight)
- **End card BG:** `#0D0D0D` (mevcut Qulo theme)

### 5.3 Tipografi

- **Font:** Poppins (300-900 weights) — Remotion google-fonts'tan yükleniyor (mevcut workflow ile aynı)
- **End card hierarchy:**
  - Logo: Qulo brand logo (SVG)
  - Tagline ("Stop swiping. Start solving."): Poppins 600, ~52px, letter-spacing -0.5px, white
  - Domain ("qulo.app"): Poppins 400, ~24px, opacity 0.6, white

---

## 6. Production Pipeline

### 6.1 Prompt Bank (Veo 3 Pro)

Her shot için ayrı prompt dosyası `prompts/veo3-shot{N}.md`. Prompt template:

```
[Style] A24 cinematic realism, anamorphic lens, 35mm film grain, shallow depth of field
[Setting] {sahne tanımı}
[Subject] {oyuncu + reference image}
[Action] {hareket}
[Lighting] {ışık}
[Color] {grade}
[Camera] {kamera hareketi, kompozisyon}
[Duration] {target sn}
[Negative] CGI look, oversaturated, smooth skin, fashion ad, music video
```

Her prompt için **3 retry hedeflenir**, en iyi sonuç seçilir. Beklenen toplam Veo gen: 4 shot × 3 retry = ~12 generation. Karakter tutarlılığı için reference image (Veo 3 Pro image-to-video) zorunlu.

### 6.2 Remotion Composition

- 9:16 (1080×1920), 30fps, 450 frame total
- Her shot ayrı `<Sequence>`; Veo MP4'leri `<Video>` ile mount edilir; üstüne overlay'ler
- Drift card efekti (Shot 2): Veo video'da kadın + telefon; üstüne Remotion `<DriftingCard>` component (SVG/CSS animation, partikül ile yok olur)
- Color shift overlay (Shot 3): cool→warm CSS gradient mask, opacity animation
- Notification UI (Shot 4): pure Remotion mockup overlay (Qulo notification component)
- End card: pure Remotion (logo SVG + Poppins text + brand color animation)

### 6.3 Render

- `npm run render:master` → `out/qulo-stop-swiping-15s-9x16.mp4` (1080×1920, H.264, 30fps, ~25Mbps)
- `npm run render:short` → `out/qulo-stop-swiping-6s-9x16.mp4` (opsiyonel — Shot 1-2 + end card kısa kesim, sosyal hook için)

---

## 7. Klasör Yapısı

```
entertainment/qulo-stop-swiping/
  src/
    StopSwipingAd.tsx                   # ana composition (15sn, 9:16)
    Root.tsx                            # registerRoot
    schema.ts                           # composition props + scene timings
    index.ts
    scenes/
      Shot1NumbSwipe.tsx
      Shot2CardDrifts.tsx
      PauseBeat.tsx
      Shot3ConsciousShift.tsx
      Shot4Recognition.tsx
      EndCard.tsx
    components/
      DriftingCard.tsx                  # uçan kart + partikül effect
      ColorShiftOverlay.tsx             # cool→warm grade overlay
      QuloLogo.tsx                      # animated logo
      FilmGrain.tsx                     # 35mm grain overlay
      NotificationUI.tsx                # Shot 4 match bildirimi
    theme.ts                            # renk paleti, font settings
  public/
    veo/
      shot1_numb_swipe_v1.mp4
      shot2_card_drifts_v1.mp4
      shot3_conscious_shift_v1.mp4
      shot4_recognition_v1.mp4
    audio/
      vo_en_final.mp3
      music_15s_arc.mp3
    refs/
      female_lead_portrait.png
      male_match_portrait.png
    brand/
      qulo_logo.svg
      green_diamond.svg                 # entertainment/'tan taşınacak
      purple_diamond.svg                # entertainment/'tan taşınacak
  prompts/
    veo3-shot1.md
    veo3-shot2.md
    veo3-shot3.md
    veo3-shot4.md
    elevenlabs-vo.md
    elevenlabs-music.md
    references.md                       # portre üretimi için MJ/DALL-E prompt'ları
  out/
    .gitkeep                            # render outputs git-ignored
  package.json
  tsconfig.json
  README.md                             # workflow özeti
  .gitignore                            # node_modules, out/, *.mp4 (büyük asset'ler)
```

---

## 8. Paralel İş Bölümü (User vs Agent)

| Aşama | Kullanıcı (Berkant) | Agent (Claude) |
|---|---|---|
| 0 — Spec | Onay ver | Spec yaz, commit |
| 1 — Cleanup | Onay ver | `git rm` eski dosyalar, yeni iskelet kur |
| 2 — Reference portraits | 2 portre üret (kadın + erkek), `public/refs/`'e koy | Exact prompt + yerleşim talimatı |
| 3 — Veo 3 shot'ları | 4 shot generate, `public/veo/`'a koy | Final prompt + retry stratejisi |
| 4 — ElevenLabs VO | VO generate, `public/audio/`'ya koy | Voice ID + settings + cümle ayrımı |
| 5 — ElevenLabs Music | Music generate, `public/audio/`'ya koy | Music prompt + structure breakdown |
| 6 — Composition | (bekle) | Remotion sahnelerini kodla, VFX, color shift, end card |
| 7 — İlk render | Output izle, geri bildirim | `npm run render:master`, MP4 üret |
| 8 — Iterasyon | Zayıf shot/VO geri bildirimi | Prompt revize, composition fine-tune |

Her aşama checkpoint'li — biri tamamlanmadan diğerine geçilmez.

---

## 9. Cleanup Planı (Aşama 1)

### 9.1 Silinecek

- `entertainment/qulo-promo/` (klasör tümü, eski 30sn promo + node_modules + out/)
- `entertainment/video-template-1.html`
- `entertainment/video-template-2.html`
- `entertainment/voiceover_en_1.mp3`
- `entertainment/bgm.mp3`
- `entertainment/bgm2.mp3`
- `entertainment/elevenlabs2.mp3`
- `entertainment/CHANGELOG`
- `entertainment/CHANGELOG.zip`
- `QuloVideoRedesign/` (klasör tümü)

### 9.2 Yeni klasöre taşınacak (asset re-use)

- `entertainment/green_diamond.svg` → `entertainment/qulo-stop-swiping/public/brand/green_diamond.svg`
- `entertainment/purple_diamond.svg` → `entertainment/qulo-stop-swiping/public/brand/purple_diamond.svg`
- `entertainment/qulo_splash.svg` → `entertainment/qulo-stop-swiping/public/brand/qulo_logo.svg` (rename)

### 9.3 Silinecek (eski ikonlar, yeni projede kullanılmıyor)

- `entertainment/green_diamond_slide_left.svg`, `green_diamond_slide_right.svg`
- `entertainment/purple_diamond_slide_left.svg`, `purple_diamond_slide_right.svg`
- `entertainment/ic_clock.svg`, `ic_compass_filled.svg`, `ic_crown.svg`, `ic_fast_forward.svg`, `ic_fire.svg`, `ic_gem.svg`, `ic_heart_filled.svg`, `ic_lightbulb.svg`, `ic_oracle.svg`, `ic_plane.svg`, `ic_skip_forward.svg`, `ic_split.svg`, `ic_target.svg`, `ic_zap.svg`

### 9.4 Dokunulmayacak

- `mobile-sidebar-open.png`, `mobile-sidebar-test.png` (root, ilgisiz başka bağlam)
- `entertainment/` klasörü kendisi (boş kalmayacak — yeni proje içinde olacak)

### 9.5 Silme akışı

Tüm silmeler **tek commit** halinde: `chore(video): wipe legacy promo assets, init stop-swiping ad workspace`. Geri alınabilirlik git history'de garanti.

---

## 10. Riskler ve Mitigasyonlar

| Risk | Olasılık | Etki | Mitigasyon |
|---|---|---|---|
| Veo 3 karakter tutarlılığı (Shot 2 adam ≠ Shot 4 adam) | Orta | Yüksek | Image-to-video reference + 3 retry per shot + "kıyafet farkı zaten hikayeye uyar" kabul stratejisi |
| Veo 3 kart-fırlama efekti zayıf | Yüksek | Orta | Hibrit yaklaşım: Veo sadece oyuncu+telefon, kart efekti Remotion composite |
| ElevenLabs Music tek-prompt'la iki-bölümlü track tutmaz | Orta | Düşük | Fallback: 2 ayrı 8sn track, Remotion crossfade |
| ElevenLabs VO accent tutarsız | Düşük | Orta | Voice ID kilidi, settings standardize, ilk render'dan sonra fine-tune |
| 15sn'ye sığmama (over-edit) | Orta | Düşük | Shot süreleri esnek, iterasyonda 1.5sn'ye kadar shot kısaltılabilir |
| Render boyutu büyük (Git LFS gerekir mi) | Düşük | Düşük | `out/` ve büyük .mp4'ler `.gitignore`'da; ham asset'ler `public/`'te ama her biri <50MB |

---

## 11. Başarı Kriterleri

- [ ] 15sn final master MP4 export edilebilir, ses+görüntü senkronize
- [ ] İlk 1.5sn'de hook (numb swipe + ilk VO kelimeleri) izleyiciyi tutar
- [ ] Shot 2'deki "drift card" momenti audience'a duygusal olarak çarpar (test: 5 kişiye gizli izlet, "ne hissettin" sorusunda "üzgün/kayıp/kaçırılmış" anahtar kelimeleri çıkar)
- [ ] Shot 3-4 geçişi nedensel hissettirir, "neden Qulo açtı" sorusu izleyicide oluşmaz
- [ ] End card 1.5sn'de mesajı kapatır, izleyici "qulo.app" domain'ini görür
- [ ] Master'dan 6sn kısa kesim çıkarılabilir (sosyal hook reuse)
- [ ] Cleanup commit sonrası `entertainment/` sadece yeni `qulo-stop-swiping/` projesini içerir

---

## 12. Sıradaki Adım

Bu spec onaylandıktan sonra **writing-plans** skill'i ile implementation plan oluşturulacak. Plan, paralel iş bölümünü (Bölüm 8) birim birim aşamalara açacak.

**Out of scope (bu spec'te değil):**

- App Store / Google Play preview video (farklı format, store kuralları, ayrı spec gerekir)
- TR / lokalize versiyon (international EN master ilk; sonra ayrı VO + end card text gen)
- Long-form (30sn+) versiyon
- Paid ad creative variants (A/B test thumbnails, çoklu hook varyantları)
