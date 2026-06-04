# Qulo Full-App Intro TikTok Video — Design Spec

**Tarih:** 2026-06-04
**Branch:** APP-1915
**Statü:** Onaylı tasarım, implementation öncesi
**Sahibi:** Berkant
**Pipeline:** `entertainment/qulo-tiktok-promos/` (Remotion) → `marketing/tiktok/videos/`

## Amaç

Qulo'nun TikTok hesabındaki **ilk video** olarak tüm uygulamayı baştan sona anlatan, 2-2.5 dakikalık (140s), İngilizce, voiceover'lı bir tanıtım videosu üretmek. Hedef: dating-fatigued US/UK 22-30 kitlesini Qulo'nun "answer-to-match" mekanikasıyla tanıştırmak ve App Store/Play Store'a yönlendirmek.

Sonraki videolar için pipeline'ı sağlamlaştırmak ikincil hedef.

## Karar Özeti

| Parametre | Karar |
|-----------|-------|
| Süre | 140s (2:20) |
| Çözünürlük | 1080×1920 (9:16), 30fps |
| Dil | İngilizce |
| Format | Voiceover explainer (witty/sassy ton) |
| Ses kaynağı | ElevenLabs AI (Voice: Domi) |
| Hedef kitle | US/UK 22-30, dating-fatigued |
| Yaklaşım | "The Diagnosis" — problem teşhisi → çözüm reveal → 8 feature tour → CTA |
| Pipeline | Remotion (mevcut `qulo-tiktok-promos` projesi) |
| Yeni komponent | Sadece `GenericSwipeStack` (~40 satır) |
| Reuse | 16/17 mevcut komponent |

## Kısıtlar

### Marka çakma yasağı (kritik)

- TikTok'a yüklenen video TikTok'u veya başka platformu (IG, YouTube vb.) eleştiremez/anmaz
- Rakip dating app'leri (Tinder, Bumble, Hinge, Match, OkCupid vb.) isim olarak veya UI mock'u olarak gösterilemez
- `TinderMock` komponenti bu projede **kullanılmaz**
- "Swipe" verb olarak OK (Qulo'nun antitezi) — marka adı değil

Detay: `memory/feedback_marketing_no_brand_attacks.md`

### Teknik kısıtlar

- Remotion `PromoConfig` tek `audioTrack` slot kabul ediyor → VO + BGM + SFX **render öncesi premix**
- TikTok safe zone: top 220px, bottom 320px — kritik text 1080×1380 center band içinde
- Audio: original sound (trending audio overlay'i değil) — VO + BGM premix

## Sahne Akışı

140s @ 30fps = 4200 frame. 12 sahne.

| # | Frame | Süre | Sahne | Ana komponentler | VO ana cümle |
|---|-------|------|-------|------------------|--------------|
| 1 | 0-120 | 4s | Cold open | `PhoneFrame` + `GenericSwipeStack` + `DriftingCard` bg | "Be honest. Months on a dating app. Met no one." |
| 2 | 120-300 | 6s | Ghost loop | `GenericSwipeStack` ghost mode + `ChatBubble` mood:ghost | "You match. They ghost. ... Forever loop. Sound familiar?" |
| 3 | 300-480 | 6s | Reveal | `HookScene` + Qulo logo + `DiamondBurst` large | "But there's a new app. You don't swipe. You solve." |
| 4 | 480-900 | 14s | Discover | `QuloDiscoverCard` (Maya, 3 questions) + `QuestionPill` | "It's called Qulo. ... read her three questions." |
| 5 | 900-1650 | 25s | Solve 3 questions | `QuizSolve`×3 + `AnswerFeedback`×3 + `QuestionPill`×3 + mikro `DiamondBurst`×3 + streak counter | "Answer all three. ... earned something most apps never made you earn." |
| 6 | 1650-1950 | 10s | Match earned | `MatchCelebration` + huge `DiamondBurst` + `StatsGrid` (3/3, +5💎) | "Boom. Three for three. ... earned five diamonds too." |
| 7 | 1950-2340 | 13s | Chat substantive | `TimeOfDay` evening + `ChatBubble` thread + `QuestionPill` | "Now you actually talk. ... the match handed you the script." |
| 8 | 2340-2790 | 15s | Create your own | `QuestionCreate` typewriter + `QuestionPill` 'Your filter' | "Build your own three questions ... boring ones never make it through." |
| 9 | 2790-3090 | 10s | AI helps | `QuestionCreate` aiSuggested + `QuestionPill` '✨ AI' + mikro `DiamondBurst` | "Qulo's AI reads your profile and writes three questions in your voice." |
| 10 | 3090-3540 | 15s | Diamond Economy | `DiamondBurst` continuous + `StatsGrid` infographic + `ProcessStep` | "Earn diamonds. Spend thirty on a boost. A whole economy." |
| 11 | 3540-3840 | 10s | Why this works | `StatsGrid` large + `ProcessStep` + `TimeOfDay` week-transition | "No empty chats. No guessing. Just real questions, real answers, real matches." |
| 12 | 3840-4200 | 12s | CTA finale | `CTAScene` + finale `DiamondBurst` | "Stop swiping. Start matching. Qulo — free on iOS and Android. Link in bio. Go earn one." |

## Tam VO Scripti

```
[Sahne 1 — 0-4s]
Be honest. Months on a dating app. Met no one.

[Sahne 2 — 4-10s]
You match. They ghost. You match. They ghost. [...] Forever loop. Sound familiar?

[Sahne 3 — 10-16s]
But there's a new app. You don't swipe. [...] You solve.

[Sahne 4 — 16-30s]
It's called Qulo. You open it, see someone interesting — but instead of swiping, you read her three questions. The ones she wrote to filter people exactly like you.

[Sahne 5 — 30-55s]
Answer all three. Get them right. Pineapple on pizza? You better know her answer. Mountains or beach? Don't guess. Last red-flag question? Nail it. Get one wrong — game over, no match. Get all three? You just earned something most apps never made you earn.

[Sahne 6 — 55-65s]
Boom. Three for three. Match unlocked. You didn't swipe your way in — you earned it. And yeah, you just earned five diamonds too.

[Sahne 7 — 65-78s]
Now you actually talk. About something real. "Pineapple on pizza? Bold take." She just opened with that. No "hey," no awkward opener — the match handed you the script.

[Sahne 8 — 78-93s]
Now your turn. Build your own three questions — the filter only people who actually get you will pass. Want only mountain people? Make question two impossible for beach people. The boring ones never make it through.

[Sahne 9 — 93-103s]
Stuck for ideas? Tap once. Qulo's AI reads your profile and writes three questions in your voice. Done in two seconds.

[Sahne 10 — 103-118s]
Here's the fun part. When someone solves your questions, you earn green diamonds. Spend thirty on a boost — thirty minutes of priority placement, and suddenly everyone interesting is solving yours. A whole economy.

[Sahne 11 — 118-128s]
No empty chats. No guessing if they actually like you. No effort wasted on people who'd ghost anyway. Just real questions, real answers, real matches.

[Sahne 12 — 128-140s]
So stop swiping. Start matching. Qulo is free, on iOS and Android right now. Link in bio. [...] Go earn one.
```

~312 kelime, ~140 wpm conversational pace.

## Komponent Envanteri

### Reuse (16 mevcut komponent)

`CaptionTrack` (×12, tüm sahneler), `DiamondBurst` (×7), `QuestionPill` (×6), `StatsGrid` (×3), `ProcessStep` (×2), `TimeOfDay` (×2), `PhoneFrame`, `DriftingCard`, `HookScene`, `QuloDiscoverCard`, `QuizSolve`, `AnswerFeedback`, `MatchCelebration`, `ChatBubble`, `QuestionCreate`, `CTAScene`.

### Yeni (1 komponent)

**`GenericSwipeStack.tsx`** — markasız stilize swipe stack. Silüet figürler, brand-renksiz pastel paleti (Tinder/Bumble/Hinge çağrışımı yok). `count`, `ghostMode`, `brand: 'neutral'` props'ları. ~40 satır kod.

### Yasaklı

**`TinderMock`** — bu projede kullanılmaz (marka çakma yasağı).

### types.ts genişletmesi

```typescript
export type SceneComponent =
  | 'HookScene' | 'StatsGrid' | 'ProcessStep' | 'DriftingCard'
  | 'QuestionPill' | 'DiamondBurst' | 'CTAScene' | 'PhoneFrame'
  | 'TinderMock' | 'QuloDiscoverCard' | 'QuestionCreate' | 'QuizSolve'
  | 'AnswerFeedback' | 'MatchCelebration' | 'ChatBubble' | 'TimeOfDay'
  | 'GenericSwipeStack';  // YENİ
```

### Mevcut komponentlere eklenecek prop varyantları

- `HookScene` → `logoReveal: boolean`
- `DiamondBurst` → `scale: 'micro'|'large'|'huge'|'continuous'|'finale'`, `dual: boolean`, `color: 'green'|'purple'|'mixed'|'flow'`
- `QuestionPill` → `accent: boolean`, `urgent: boolean`
- `StatsGrid` → `compact|infographic|large` varyantları
- `QuizSolve` → `showTimer: boolean`, `options: string[]`, `correctIndex: number`
- `ChatBubble` → `mood: 'normal'|'ghost'`, `thread: Array<{text, fromMe, startFrame}>`
- `QuestionCreate` → `aiSuggested: boolean`, `typewriter: boolean`
- `MatchCelebration` → `score: string`, `diamondsEarned: number`
- `TimeOfDay` → `time: 'evening'|'week-transition'`, `subtle: boolean`
- `ProcessStep` → `compact: boolean`, `labelAbove: boolean`
- `CTAScene` → `showBadges: boolean`

## Ses Üretim Pipeline'ı

### 1. VO — ElevenLabs

| Parametre | Değer |
|-----------|-------|
| Voice | Domi (`AZnzlk1XvdvUeBnXmlld`) |
| Model | `eleven_multilingual_v2` |
| Stability | 0.45 |
| Similarity Boost | 0.75 |
| Style | 0.55 |
| Speed | 1.05x |
| Output | `mp3_44100_192` |
| Hedef süre | 130-135s (5-10s buffer pause + ducking için) |

**Script:** tek string olarak gönderilir, `[Sahne X]` marker'ları temizlenir, `[...]` pause'ları doğal nokta + tire ile değiştirilir.

### 2. BGM — Suno AI (önerilen)

Prompt: `"Modern pop-electronic instrumental, 140 BPM, sub-bass and claps and playful synth arps, slight minor-key tension in first 10 seconds, big drop at 0:10, upbeat confident through middle, closing hit at 2:08, fully instrumental, no vocals, no lyrics, royalty-free style"`

- Süre: 2:20 (140s + 5s fade buffer)
- Format: MP3 stereo 320kbps
- LUFS: -22 (premix öncesi headroom)
- Fallback: Epidemic Sound, Artlist, YouTube Audio Library

### 3. SFX (Freesound CC0)

| Olay | Süre | Sayı |
|------|------|------|
| `diamond_ting.mp3` | 150ms | 9 kullanım |
| `match_chime.mp3` | 800ms | 1 |
| `correct_ding.mp3` | 200ms | 3 |
| `swoosh.mp3` | 400ms | 4 |
| `type_tap.mp3` | 80ms | ~12 |
| `ghost_silence.mp3` | 2s | 1 |

### 4. Premix — ffmpeg sidechain ducking

```bash
ffmpeg -i vo.mp3 -i bgm.mp3 \
  -filter_complex "
    [1:a]volume=0.7[bgm_pre];
    [bgm_pre][0:a]sidechaincompress=threshold=0.05:ratio=8:attack=20:release=400[bgm_ducked];
    [bgm_ducked][0:a]amix=inputs=2:duration=longest[mix]
  " \
  -map "[mix]" stage1.mp3
# SFX overlay → adelay + amix
# Loudness normalize → loudnorm=I=-16:TP=-1:LRA=11
```

Final: `public/audio/qulo-full-app-intro-mix.mp3` (140s, -16 LUFS, -1 dBTP).

## Dosya Yapısı

```
entertainment/qulo-tiktok-promos/
├── public/audio/
│   ├── raw/
│   │   ├── vo.mp3                              # ElevenLabs (gitignored)
│   │   ├── bgm.mp3                             # Suno (gitignored)
│   │   └── sfx/                                # CC0, commit'lenebilir
│   └── qulo-full-app-intro-mix.mp3             # FINAL master (gitignored)
├── scripts/
│   ├── generate-vo.ts                          # YENİ
│   └── mix-audio.sh                            # YENİ
├── src/
│   ├── components/GenericSwipeStack.tsx        # YENİ ~40 satır
│   ├── configs/full-app-intro.config.ts        # YENİ (140s scene timeline)
│   ├── configs/index.ts                        # REGISTRY güncelleme
│   └── types.ts                                # GenericSwipeStack ekle
├── package.json                                # build:full-app-intro script
└── out/qulo-full-app-intro.mp4                 # render çıktı
↓
marketing/tiktok/
├── videos/qulo-full-app-intro.mp4              # publish hedefi
├── captions/full-app-intro.md                  # YENİ (hashtag + caption)
└── uploaded/2026-06-04-full-app-intro.md       # YENİ (upload sonrası kayıt)
```

## Build Pipeline

```bash
cd entertainment/qulo-tiktok-promos
npm run build:full-app-intro
# Pipeline: gen:vo → mix-audio → render → publish (cp to marketing/)
# Süre: 8-12 dakika
```

`package.json` scripts:
```json
{
  "scripts": {
    "build:full-app-intro": "npm run gen:vo && bash scripts/mix-audio.sh && npm run render:full-app-intro && npm run publish:full-app-intro",
    "gen:vo": "tsx scripts/generate-vo.ts",
    "render:full-app-intro": "remotion render src/index.ts Promo-full-app-intro out/qulo-full-app-intro.mp4 --concurrency=4",
    "publish:full-app-intro": "cp out/qulo-full-app-intro.mp4 ../../marketing/tiktok/videos/"
  }
}
```

## QA Checklist

### Teknik
- [ ] `ffprobe` → 1080×1920, 30fps, 140.00s ±0.1s
- [ ] LUFS integrated = -16 ±1, peak = -1 dBTP veya altı
- [ ] MP4 boyut < 30MB (TikTok upload limit 287MB ama küçük dosya önemli)

### İçerik
- [ ] Hook ilk 2s'de viewer'ı yakalıyor mu? (test: 5 kişiye 2s göster, ne hissettiklerini sor)
- [ ] Caption okunabilir mi (safe zone içi)?
- [ ] Brand çakma denetimi: hiçbir frame'de Tinder/Bumble/Hinge çağrışımı yok
- [ ] TikTok mention yok (VO + caption + on-screen text)
- [ ] Audio sync (match, diamond burst frame-perfect)
- [ ] Logo bütünlüğü (sahne 3 + sahne 12)
- [ ] SFX volume kulağı tırmalamıyor

### Marketing
- [ ] Caption + hashtag dosyası `marketing/tiktok/captions/full-app-intro.md` hazır
- [ ] Cover frame önerisi (11s, logo reveal) Editor için belirlenmiş
- [ ] Upload sonrası URL kaydı planı net

## Lisans & Telif

| Kaynak | Lisans | Aksiyon |
|--------|--------|---------|
| ElevenLabs VO | Paid plan ticari kullanım | API key güvenli sakla |
| Suno BGM | Pro plan ticari | Pro plan upgrade gerekli |
| Freesound SFX | CC0 tercih (attribution gereksiz) | Sadece CC0 kullan |

## Tahmini Süre & Maliyet

| Adım | Süre | Maliyet |
|------|------|---------|
| Yeni komponent + config (one-time) | 2-3 saat | - |
| ElevenLabs VO gen | 30s | $0.03 |
| Suno BGM gen | 2dk | $10/ay (Pro) |
| SFX kürasyon (one-time) | 30dk | $0 (CC0) |
| ffmpeg premix | 10s | $0 |
| Remotion render | 5-10dk | $0 |
| QA + tweak | 10-20dk | - |
| Upload | 5dk | - |
| **TOPLAM ilk video** | **~4-5 saat** | **~$10** |
| Sonraki videolar | ~15-20dk | $0.03 |

## Risk Noktaları

| Risk | Olasılık | Etki | Mitigation |
|------|----------|------|------------|
| ElevenLabs VO süresi 130-135s dışı | Orta | Caption timing kayar | Speed prop ayarla (0.95-1.10), re-gen |
| Suno erişim yok | Düşük | BGM gecikme | Epidemic Sound fallback |
| Komponent prop varyantları breaking change | Orta | Mevcut video'lar bozulur | Backwards-compat: yeni prop'lar opsiyonel, defaults eski davranış |
| Remotion render OOM | Düşük | Render fail | `--concurrency=2`, `--quality=80` |
| TikTok upload reddediliyor (audio not original) | Düşük | Re-render gerek | Sadece VO ile re-render, trending audio TikTok'ta ekle |
| MatchCelebration 10s'lik akış için yetersiz | Orta | Sahne 6 boşluk hisseder | 5s celebration + 5s `StatsGrid` overlap stratejisi |

## Açık Sorular / Sonraki Adımlar

1. **Suno Pro plan yoksa:** Epidemic Sound trial mi açılacak, yoksa YouTube Audio Library generic track mi?
2. **Voice tercihi:** Domi varsayılan ama kullanıcı `Rachel` veya `Bella` denemek isterse Bölüm 4'te değiştirilir.
3. **Cover frame seçimi:** 11s Qulo logo reveal varsayılan; alternatif 56s "Match unlocked" celebration.
4. **Upload timing:** prime time (US/UK 18:00-21:00 EST) önerildi, kullanıcı kararıyla netleşir.
5. **Sonraki video pipeline'ı:** Bu video başarı kanıtlarsa, "How to write your first question" gibi educational/UGC çağrı video'ları aynı pipeline ile üretilir.

## İlgili Dokümanlar

- `entertainment/qulo-tiktok-promos/README.md` — Pipeline conventions
- `marketing/tiktok/README.md` — Output klasör yapısı
- `memory/feedback_marketing_no_brand_attacks.md` — Marka çakma kuralı
- `docs/superpowers/specs/2026-05-09-stop-swiping-hero-ad-design.md` — Önceki hero ad design
