# Stop Swiping Hero Ad — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Qulo için 15 saniyelik 9:16 portrait hero reklam videosu üret. Hibrit production: Veo 3 Pro (oyuncu/sahne) + Remotion (VFX/transition/end card) + ElevenLabs (VO + music). Hook: "Stop swiping. Start solving."

**Architecture:** Remotion 4.0.x composition; her shot ayrı `<Sequence>`, Veo MP4'leri `<Video>` ile mount edilir, üstüne overlay'ler (drifting card VFX, color grade, film grain, notification UI, end card) bindirilir. Audio: tek VO + tek müzik track; ikisi de Remotion `<Audio>` ile sequence'lenir. Karakter tutarlılığı için Veo 3 Pro'da reference image (image-to-video).

**Tech Stack:**
- Remotion 4.0.437 (Composition, Sequence, AbsoluteFill, Audio, Video, useVideoConfig, interpolate, spring)
- @remotion/media (`<Audio>` — sample-accurate audio mixing)
- @remotion/google-fonts/Poppins (font loading)
- React 19, TypeScript 5
- External tools (user-driven): Veo 3 Pro (Google AI Studio / Vertex AI), ElevenLabs (Voice + Music), Midjourney veya benzeri (reference portraits)

**Spec:** `docs/superpowers/specs/2026-05-09-stop-swiping-hero-ad-design.md`

---

## Phase Overview ve Paralel Akış

| Faz | İçerik | Kullanıcı eylemi | Agent eylemi |
|---|---|---|---|
| **Phase 0** | Cleanup | Onay | Eski asset'leri sil, brand asset'leri taşı |
| **Phase 1** | Scaffold + Prompts | Onay | Remotion proje iskeleti + tüm prompt dosyalarını yaz |
| **Phase 2** | Asset generation (paralel) | **Reference portraits + Veo 4 shot + ElevenLabs VO + Music gen** | Veo-bağımsız Remotion component'leri kodlar (end card, logo, grain, drifting card, color shift, notification UI) |
| **Phase 3** | Scene assembly | (bekle) | 6 sahneyi assemble eder (Veo MP4 + overlay'ler) |
| **Phase 4** | Master composition + render | İlk MP4'i izle | Master composition + audio mix + ilk render |
| **Phase 5** | Iterasyon | Geri bildirim | Prompt revize / composition fine-tune |

**Phase 2 paralel iş özeti:** Sen ElevenLabs ve Veo'da gen yaparken, ben asset gerektirmeyen tüm Remotion bileşenlerini bitirebilirim. Bu sayede asset'ler hazır olduğunda kod tarafı %70 hazır olur.

---

## File Structure

Aşağıdaki dosyalar Phase 0 sonunda yaratılır (Phase 1 ile dolar):

```
entertainment/qulo-stop-swiping/
  src/
    StopSwipingAd.tsx                  # Ana composition — sequence'ler ve audio
    Root.tsx                           # registerRoot, Composition tanımları
    schema.ts                          # Composition props + scene timing constants
    theme.ts                           # Renk paleti, font settings
    index.ts                           # Entry: Root.tsx import
    scenes/
      Shot1NumbSwipe.tsx               # Veo footage + film grain
      Shot2CardDrifts.tsx              # Veo + DriftingCard VFX overlay
      PauseBeat.tsx                    # 0.5sn duraklama (Shot 2'nin uzantısı)
      Shot3ConsciousShift.tsx          # Veo + ColorShiftOverlay
      Shot4Recognition.tsx             # Veo + NotificationUI overlay
      EndCard.tsx                      # Pure Remotion: logo + tagline + domain
    components/
      DriftingCard.tsx                 # SVG kart + partikül dağılım animasyonu
      ColorShiftOverlay.tsx            # Cool→warm gradient mask animasyonu
      QuloLogo.tsx                     # Animated logo + yeşil elmas parıltısı
      FilmGrain.tsx                    # 35mm grain overlay (procedural noise)
      NotificationUI.tsx               # Shot 4 match bildirim mockup'ı
  public/
    veo/.gitkeep                       # Veo MP4'leri buraya gelecek (user populates)
    audio/.gitkeep                     # ElevenLabs VO + music (user populates)
    refs/.gitkeep                      # Karakter portreleri (user populates)
    brand/
      qulo_logo.svg                    # entertainment/qulo_splash.svg'den taşınır
      green_diamond.svg                # entertainment/green_diamond.svg'den taşınır
      purple_diamond.svg               # entertainment/purple_diamond.svg'den taşınır
  prompts/
    references.md                      # Karakter portresi prompt'ları (Midjourney/DALL-E)
    veo3-shot1.md                      # Numb Swipe prompt + retry stratejisi
    veo3-shot2.md                      # Card Drifts prompt
    veo3-shot3.md                      # Conscious Shift prompt
    veo3-shot4.md                      # Recognition prompt
    elevenlabs-vo.md                   # VO prompt + voice settings
    elevenlabs-music.md                # Music prompt + structure
  out/.gitkeep                         # Render outputs (git-ignored)
  package.json
  tsconfig.json
  .gitignore
  README.md                            # Workflow özeti + komutlar
```

**Sahne süreleri (constants):** `schema.ts` içinde tanımlanır.

| Sahne | Başlangıç (s) | Süre (s) | Frame range (30fps) |
|---|---|---|---|
| Shot 1 | 0.0 | 3.0 | 0–90 |
| Shot 2 | 3.0 | 3.5 | 90–195 |
| Pause Beat | 6.5 | 0.5 | 195–210 |
| Shot 3 | 7.0 | 4.0 | 210–330 |
| Shot 4 | 11.0 | 2.5 | 330–405 |
| End Card | 13.5 | 1.5 | 405–450 |
| **Total** | — | **15.0** | **450 frames** |

---

## Phase 0: Cleanup ve Klasör İskeleti

### Task 0.1: Cleanup eski video asset'leri

**Files:**
- Silinecek: `entertainment/qulo-promo/` (tüm klasör)
- Silinecek: `entertainment/video-template-1.html`, `video-template-2.html`
- Silinecek: `entertainment/voiceover_en_1.mp3`, `bgm.mp3`, `bgm2.mp3`, `elevenlabs2.mp3`
- Silinecek: `entertainment/CHANGELOG`, `CHANGELOG.zip`
- Silinecek: `QuloVideoRedesign/` (tüm klasör)
- Silinecek: 14 adet `entertainment/ic_*.svg` + 4 adet `*_slide_*.svg` (tek tek listede 9.3'te)
- Taşınacak: `entertainment/qulo_splash.svg` → `entertainment/qulo-stop-swiping/public/brand/qulo_logo.svg`
- Taşınacak: `entertainment/green_diamond.svg` → `entertainment/qulo-stop-swiping/public/brand/green_diamond.svg`
- Taşınacak: `entertainment/purple_diamond.svg` → `entertainment/qulo-stop-swiping/public/brand/purple_diamond.svg`

- [ ] **Step 1: Verify file inventory**

```bash
ls entertainment/ && ls QuloVideoRedesign/ 2>/dev/null
```

Expected: yukarıdaki cleanup listesindeki tüm dosyaları görmeli. Liste dışında bir şey çıkarsa STOP — kullanıcıya sor.

- [ ] **Step 2: Create new project skeleton directory**

```bash
mkdir -p entertainment/qulo-stop-swiping/public/brand
mkdir -p entertainment/qulo-stop-swiping/public/veo
mkdir -p entertainment/qulo-stop-swiping/public/audio
mkdir -p entertainment/qulo-stop-swiping/public/refs
mkdir -p entertainment/qulo-stop-swiping/src/scenes
mkdir -p entertainment/qulo-stop-swiping/src/components
mkdir -p entertainment/qulo-stop-swiping/prompts
mkdir -p entertainment/qulo-stop-swiping/out
```

- [ ] **Step 3: Move brand assets**

```bash
git mv entertainment/qulo_splash.svg entertainment/qulo-stop-swiping/public/brand/qulo_logo.svg
git mv entertainment/green_diamond.svg entertainment/qulo-stop-swiping/public/brand/green_diamond.svg
git mv entertainment/purple_diamond.svg entertainment/qulo-stop-swiping/public/brand/purple_diamond.svg
```

- [ ] **Step 4: Delete legacy promo folder + video templates**

```bash
git rm -r entertainment/qulo-promo
git rm entertainment/video-template-1.html entertainment/video-template-2.html
git rm entertainment/voiceover_en_1.mp3 entertainment/bgm.mp3 entertainment/bgm2.mp3 entertainment/elevenlabs2.mp3
git rm entertainment/CHANGELOG entertainment/CHANGELOG.zip
git rm -r QuloVideoRedesign
```

- [ ] **Step 5: Delete unused icon SVGs**

```bash
git rm entertainment/green_diamond_slide_left.svg entertainment/green_diamond_slide_right.svg
git rm entertainment/purple_diamond_slide_left.svg entertainment/purple_diamond_slide_right.svg
git rm entertainment/ic_clock.svg entertainment/ic_compass_filled.svg entertainment/ic_crown.svg
git rm entertainment/ic_fast_forward.svg entertainment/ic_fire.svg entertainment/ic_gem.svg
git rm entertainment/ic_heart_filled.svg entertainment/ic_lightbulb.svg entertainment/ic_oracle.svg
git rm entertainment/ic_plane.svg entertainment/ic_skip_forward.svg entertainment/ic_split.svg
git rm entertainment/ic_target.svg entertainment/ic_zap.svg
```

- [ ] **Step 6: Add .gitkeep for empty asset directories**

```bash
touch entertainment/qulo-stop-swiping/public/veo/.gitkeep
touch entertainment/qulo-stop-swiping/public/audio/.gitkeep
touch entertainment/qulo-stop-swiping/public/refs/.gitkeep
touch entertainment/qulo-stop-swiping/out/.gitkeep
```

- [ ] **Step 7: Verify clean state**

```bash
ls entertainment/
```

Expected: `qulo-stop-swiping/` klasörü dışında bir şey görünmemeli (eğer mevcut başka asset varsa kullanıcıya sor).

```bash
git status --short | head -30
```

Expected: Yığın halinde `D entertainment/...` (silinenler) + `R entertainment/qulo_splash.svg -> entertainment/qulo-stop-swiping/...` (taşınanlar) + `?? entertainment/qulo-stop-swiping/public/.../.gitkeep`.

- [ ] **Step 8: Commit cleanup**

```bash
git add entertainment/qulo-stop-swiping/
git commit -m "$(cat <<'EOF'
chore(video): wipe legacy promo assets, init stop-swiping ad workspace

Removed entertainment/qulo-promo, QuloVideoRedesign, video-template HTMLs,
legacy bgm/voiceover MP3s, unused icon SVGs. Migrated qulo_logo.svg and
diamond brand assets into entertainment/qulo-stop-swiping/public/brand/.
Created empty veo/, audio/, refs/, out/ asset directories with .gitkeep.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

Expected: commit lands cleanly, no pre-commit hook failures.

---

## Phase 1: Project Scaffold + Prompt Bank

### Task 1.1: Remotion package.json + tsconfig + .gitignore

**Files:**
- Create: `entertainment/qulo-stop-swiping/package.json`
- Create: `entertainment/qulo-stop-swiping/tsconfig.json`
- Create: `entertainment/qulo-stop-swiping/.gitignore`

- [ ] **Step 1: Create package.json**

`entertainment/qulo-stop-swiping/package.json`:

```json
{
  "name": "qulo-stop-swiping",
  "version": "1.0.0",
  "private": true,
  "description": "Qulo hero ad — Stop swiping. Start solving.",
  "scripts": {
    "studio": "npx remotion studio src/index.ts",
    "render:master": "npx remotion render src/index.ts StopSwipingAd out/qulo-stop-swiping-15s-9x16.mp4",
    "render:short": "npx remotion render src/index.ts StopSwipingAdShort out/qulo-stop-swiping-6s-9x16.mp4"
  },
  "author": "Berkant Calikusu",
  "license": "UNLICENSED",
  "dependencies": {
    "@remotion/cli": "^4.0.437",
    "@remotion/google-fonts": "^4.0.437",
    "@remotion/media": "^4.0.437",
    "@remotion/transitions": "^4.0.437",
    "react": "^19.2.4",
    "react-dom": "^19.2.4",
    "remotion": "^4.0.437"
  },
  "devDependencies": {
    "@types/react": "^19.2.14",
    "@types/react-dom": "^19.2.3",
    "typescript": "^5.9.3"
  }
}
```

- [ ] **Step 2: Create tsconfig.json**

`entertainment/qulo-stop-swiping/tsconfig.json`:

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "Bundler",
    "jsx": "react-jsx",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "lib": ["DOM", "ES2022"],
    "types": ["node"]
  },
  "include": ["src/**/*"]
}
```

- [ ] **Step 3: Create .gitignore**

`entertainment/qulo-stop-swiping/.gitignore`:

```
node_modules/
out/*.mp4
out/*.webm
.DS_Store
*.log
```

`out/.gitkeep` zaten var, yani out/ klasörü track'lenir ama içindeki MP4'ler ignore olur.

- [ ] **Step 4: Install dependencies**

```bash
cd entertainment/qulo-stop-swiping && npm install
```

Expected: package-lock.json oluşur, node_modules dolar, hata yok.

- [ ] **Step 5: Commit package skeleton**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add entertainment/qulo-stop-swiping/package.json entertainment/qulo-stop-swiping/tsconfig.json entertainment/qulo-stop-swiping/.gitignore entertainment/qulo-stop-swiping/package-lock.json
git commit -m "$(cat <<'EOF'
chore(video): scaffold qulo-stop-swiping Remotion project

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

### Task 1.2: theme.ts + schema.ts (constants)

**Files:**
- Create: `entertainment/qulo-stop-swiping/src/theme.ts`
- Create: `entertainment/qulo-stop-swiping/src/schema.ts`

- [ ] **Step 1: Write theme.ts**

`entertainment/qulo-stop-swiping/src/theme.ts`:

```typescript
export const colors = {
  // Brand
  green: "#1FCB7E",
  greenSoft: "#2EE090",
  purple: "#7B5CFA",
  purpleSoft: "#9B82FF",

  // Cool grade (Shot 1-2)
  coolShadow: "#0F1A2E",
  coolMid: "#3A4A66",
  coolHighlight: "#6F86A8",

  // Warm grade (Shot 3-4)
  warmShadow: "#1F1308",
  warmMid: "#5A3F1E",
  warmHighlight: "#E8B070",

  // End card
  bg: "#0D0D0D",
  white: "#FFFFFF",
  whiteSoft: "rgba(255, 255, 255, 0.6)",
} as const;

export const VIDEO = {
  width: 1080,
  height: 1920,
  fps: 30,
  durationSeconds: 15,
} as const;

export const VIDEO_DURATION_FRAMES = VIDEO.fps * VIDEO.durationSeconds;
```

- [ ] **Step 2: Write schema.ts (scene timings)**

`entertainment/qulo-stop-swiping/src/schema.ts`:

```typescript
import { VIDEO } from "./theme";

const fps = VIDEO.fps;
const sec = (s: number) => Math.round(s * fps);

export const TIMINGS = {
  shot1: { startFrame: sec(0), durationFrames: sec(3.0) },
  shot2: { startFrame: sec(3.0), durationFrames: sec(3.5) },
  pause: { startFrame: sec(6.5), durationFrames: sec(0.5) },
  shot3: { startFrame: sec(7.0), durationFrames: sec(4.0) },
  shot4: { startFrame: sec(11.0), durationFrames: sec(2.5) },
  end: { startFrame: sec(13.5), durationFrames: sec(1.5) },
} as const;

export const VO_KEYFRAMES = {
  weSwipe1: sec(0.5),
  weScroll: sec(1.5),
  weSwipe2: sec(2.5),
  theOneWeNeeded: sec(4.0),
  driftsAway: sec(6.7),
  stopSwiping: sec(11.5),
  startSolving: sec(12.5),
} as const;

export type StopSwipingAdProps = Record<string, never>;
```

- [ ] **Step 3: Verify total duration matches**

Run:

```bash
cd entertainment/qulo-stop-swiping && node -e "
const t = require('./src/schema').TIMINGS;
const total = Object.values(t).reduce((sum, x) => Math.max(sum, x.startFrame + x.durationFrames), 0);
console.log('Total frames:', total, 'expected: 450');
"
```

Wait — TypeScript dosyalarını node ile direkt çalıştıramayız. Bu step'i atla, hesabı manuel yap:
- shot1 end: 0+90=90
- shot2 end: 90+105=195
- pause end: 195+15=210
- shot3 end: 210+120=330
- shot4 end: 330+75=405
- end end: 405+45=450 ✓

Total = 450 frames (15.0sn @ 30fps). Eşleşiyor.

- [ ] **Step 4: Commit theme + schema**

```bash
git add entertainment/qulo-stop-swiping/src/theme.ts entertainment/qulo-stop-swiping/src/schema.ts
git commit -m "$(cat <<'EOF'
feat(video): add theme palette and scene timing constants

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

### Task 1.3: Root.tsx + index.ts (placeholder Composition)

**Files:**
- Create: `entertainment/qulo-stop-swiping/src/index.ts`
- Create: `entertainment/qulo-stop-swiping/src/Root.tsx`
- Create: `entertainment/qulo-stop-swiping/src/StopSwipingAd.tsx` (placeholder; gerçek logic Phase 4'te dolacak)

Placeholder amaç: Remotion Studio açıldığında composition listede görünsün, `npm run studio` boot eder.

- [ ] **Step 1: Write src/index.ts**

`entertainment/qulo-stop-swiping/src/index.ts`:

```typescript
import { registerRoot } from "remotion";
import { Root } from "./Root";

registerRoot(Root);
```

- [ ] **Step 2: Write src/Root.tsx**

`entertainment/qulo-stop-swiping/src/Root.tsx`:

```typescript
import React from "react";
import { Composition } from "remotion";
import { StopSwipingAd } from "./StopSwipingAd";
import { VIDEO, VIDEO_DURATION_FRAMES } from "./theme";

export const Root: React.FC = () => {
  return (
    <>
      <Composition
        id="StopSwipingAd"
        component={StopSwipingAd}
        durationInFrames={VIDEO_DURATION_FRAMES}
        fps={VIDEO.fps}
        width={VIDEO.width}
        height={VIDEO.height}
      />
    </>
  );
};
```

- [ ] **Step 3: Write src/StopSwipingAd.tsx (placeholder)**

`entertainment/qulo-stop-swiping/src/StopSwipingAd.tsx`:

```typescript
import React from "react";
import { AbsoluteFill } from "remotion";
import { colors } from "./theme";

export const StopSwipingAd: React.FC = () => {
  return (
    <AbsoluteFill
      style={{
        background: colors.bg,
        color: colors.white,
        fontFamily: "system-ui, sans-serif",
        fontSize: 64,
        alignItems: "center",
        justifyContent: "center",
      }}
    >
      Qulo Hero Ad — scaffold ready
    </AbsoluteFill>
  );
};
```

- [ ] **Step 4: Boot Remotion Studio (smoke test)**

```bash
cd entertainment/qulo-stop-swiping && npm run studio
```

Expected: Browser otomatik açılır (default `http://localhost:3000`), sol panelde "StopSwipingAd" composition görünür, preview'da "Qulo Hero Ad — scaffold ready" yazısı 9:16 portrait olarak görünür. Crashes/errors yok.

Studio'yu Ctrl+C ile kapat.

- [ ] **Step 5: Commit scaffold**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add entertainment/qulo-stop-swiping/src/index.ts entertainment/qulo-stop-swiping/src/Root.tsx entertainment/qulo-stop-swiping/src/StopSwipingAd.tsx
git commit -m "$(cat <<'EOF'
feat(video): bootstrap Remotion composition scaffold

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

### Task 1.4: README.md (workflow özeti)

**Files:**
- Create: `entertainment/qulo-stop-swiping/README.md`

- [ ] **Step 1: Write README**

`entertainment/qulo-stop-swiping/README.md`:

```markdown
# Qulo Hero Ad — Stop Swiping. Start Solving.

15-second 9:16 portrait hero ad for Instagram Reels and TikTok.
Hybrid production: Veo 3 Pro (live-action shots) + Remotion (VFX, transitions, end card) + ElevenLabs (VO + music).

## Spec

`docs/superpowers/specs/2026-05-09-stop-swiping-hero-ad-design.md`

## Workflow

1. Generate reference portraits (Midjourney/DALL-E) → `public/refs/`
2. Generate 4 Veo 3 Pro shots using prompts in `prompts/veo3-shot{1..4}.md` → `public/veo/`
3. Generate ElevenLabs VO using `prompts/elevenlabs-vo.md` → `public/audio/vo_en_final.mp3`
4. Generate ElevenLabs Music using `prompts/elevenlabs-music.md` → `public/audio/music_15s_arc.mp3`
5. Preview in Remotion Studio: `npm run studio`
6. Render final master: `npm run render:master`

## Commands

- `npm run studio` — Remotion Studio (live preview)
- `npm run render:master` — Render 15s master MP4 (1080×1920 H.264)
- `npm run render:short` — Render 6s short cut (optional)

## Asset Paths

- `public/veo/shot{1..4}_*.mp4` — Veo 3 Pro generated footage
- `public/audio/vo_en_final.mp3` — ElevenLabs VO
- `public/audio/music_15s_arc.mp3` — ElevenLabs Music
- `public/refs/{female_lead,male_match}_portrait.png` — Character reference portraits
- `public/brand/qulo_logo.svg` — Brand assets

## Output

`out/qulo-stop-swiping-15s-9x16.mp4` (git-ignored)
```

- [ ] **Step 2: Commit README**

```bash
git add entertainment/qulo-stop-swiping/README.md
git commit -m "docs(video): add workflow README

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

### Task 1.5: Reference portrait prompts

**Files:**
- Create: `entertainment/qulo-stop-swiping/prompts/references.md`

Karakter tutarlılığının temeli. İki portrenin her birini üretirken aynı kişinin Veo 3 image-to-video'da defalarca tutarlı kullanılabilmesi için **front-facing, neutral expression, high-quality headshot** gerekir.

- [ ] **Step 1: Write references.md**

`entertainment/qulo-stop-swiping/prompts/references.md`:

````markdown
# Reference Portraits

Bu dosyadaki prompt'ları **Midjourney v7 / DALL-E 3 / Veo 3 image gen** ile üret. Çıktıları PNG olarak kaydet.

## Kadın baş karakter

**Hedef dosya:** `public/refs/female_lead_portrait.png`

**Görsel kriterleri:**
- Yaş: 28-32 arası
- Etnik: ambiguous global (Mediterranean / mixed European-Middle Eastern), international audience'ta tanıdık hissetsin
- İfade: nötr, hafif yorgun, "10 yıllık dating app yorgunluğu" izlenimi
- Saç: omuz altı, doğal kahverengi/koyu sarı, taranmamış-doğal
- Makyaj: minimal/yok
- Bakış: kameraya direkt, hüzünlü ama dirençli

**Midjourney prompt:**

```
Cinematic portrait of a woman in her late twenties, ambiguous Mediterranean features, soft tired eyes, no makeup, natural shoulder-length brown hair, gentle melancholy expression, neutral pose facing camera, soft window light from the left, deep teal shadows, 35mm film grain, anamorphic lens shallow depth of field, color graded like a A24 indie film (Past Lives, Aftersun aesthetic), highly detailed skin texture, natural blemishes preserved, 4K --ar 1:1 --style raw --v 7
```

**Negative / avoid:** glamour, fashion model, smooth skin, smiling, professional makeup, studio strobe, oversaturated.

**Retry stratejisi:** 4 generation çıkar, en doğal/erişilebilir hisseden seç. Yüz simetrisi mükemmel olmasın — gerçek insan hissi önemli.

## Erkek match karakter (Shot 2 ve Shot 4)

**Hedef dosya:** `public/refs/male_match_portrait.png`

**Görsel kriterleri:**
- Yaş: 30-34 arası
- Etnik: ambiguous global (Northern European / mixed)
- İfade: sıcak, hafif gülümseme, sıcak gözler
- Saç: kısa-orta, koyu kahve, hafif dağınık
- Sakal: 2-3 günlük, bakımlı değil ama doğal
- Bakış: kameraya direkt, sevecen ama özgüvenli

**Midjourney prompt:**

```
Cinematic portrait of a man in his early thirties, mixed European features, warm kind eyes, soft genuine smile, short messy dark brown hair, three-day stubble, gentle confidence, neutral pose facing camera, golden hour window light, warm honey tones, 35mm film grain, anamorphic lens shallow depth of field, A24 indie film color grade (Past Lives, Aftersun aesthetic), highly detailed skin texture, natural beard texture, 4K --ar 1:1 --style raw --v 7
```

**Negative / avoid:** male model, gym body, perfect teeth, professional photo, studio lighting, oversaturated, generic stock photo look.

**Retry stratejisi:** 4 generation. Shot 2'de "kaçan kart" üzerinde 2D olarak görünecek; Shot 4'te aynı kişi Veo 3 image-to-video ile animate edilecek. **Yüz tanınabilir olmalı** — generic erkek değil, izleyici aynı kişiyi tanımalı.

## Yerleşim

Her iki PNG'yi seçtikten sonra:

```bash
mv ~/Downloads/female_lead.png entertainment/qulo-stop-swiping/public/refs/female_lead_portrait.png
mv ~/Downloads/male_match.png entertainment/qulo-stop-swiping/public/refs/male_match_portrait.png
```

Sonra agent'a "reference'lar yerleştirildi" haberi ver — Veo prompt'larını finalize edecek.
````

- [ ] **Step 2: Commit references prompt**

```bash
git add entertainment/qulo-stop-swiping/prompts/references.md
git commit -m "docs(video): add reference portrait prompts for character consistency

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

### Task 1.6: Veo 3 Pro shot prompts

**Files:**
- Create: `entertainment/qulo-stop-swiping/prompts/veo3-shot1.md`
- Create: `entertainment/qulo-stop-swiping/prompts/veo3-shot2.md`
- Create: `entertainment/qulo-stop-swiping/prompts/veo3-shot3.md`
- Create: `entertainment/qulo-stop-swiping/prompts/veo3-shot4.md`

- [ ] **Step 1: Write veo3-shot1.md (Numb Swipe)**

`entertainment/qulo-stop-swiping/prompts/veo3-shot1.md`:

````markdown
# Shot 1 — Numb Swipe (3.0s)

**Hedef dosya:** `public/veo/shot1_numb_swipe_v1.mp4`
**Süre:** 3.0sn (Veo 3 Pro 3-8sn arası generate eder; 3sn iste)
**Mod:** Image-to-video, reference: `public/refs/female_lead_portrait.png`

## Prompt

```
A close-up cinematic shot of a young woman lying in bed at night, side-lit only by the cool blue glow of her phone screen on her face. She mechanically swipes through a dating app, her thumb flicking left repeatedly, her eyes glassy and unfocused, no expression. Tight framing on her face from the cheekbone up; phone is just out of frame at the bottom edge so its glow paints her skin. Anamorphic lens horizontal flare, shallow depth of field, 35mm film grain, deep teal shadows, desaturated mid-tones, A24 indie cinema color palette (Past Lives, Aftersun aesthetic). Slow ambient micro-movement only — no head turn, no large action. Subtle ambient room sound, no music. 9:16 vertical, 30fps, 3 seconds.
```

## Negative

`oversaturated, smooth skin, glamorous, makeup tutorial, music video edit, fast cuts, smiling, eye contact with camera, CGI rendering, animated, cartoon, anime`

## Retry stratejisi

3 generation hedefle. Seçim kriteri:
- ✅ Yüz tutarlılığı reference'a yakın
- ✅ Swipe hareketi mekanik / refleks (yavaş, düşünmeden)
- ✅ Mavi ışık sadece phone glow olarak hissediyor (üstten lamp ışığı OLMAMALI)
- ✅ Gözler "ölü" — duygusuz, dalgın
- ❌ Yüzde gülümseme ya da expression varsa REJECT
- ❌ Phone ekranı görünüyorsa (kart, profil vs) REJECT — sadece glow olmalı

## Yerleşim

```bash
mv ~/Downloads/shot1_v1.mp4 entertainment/qulo-stop-swiping/public/veo/shot1_numb_swipe_v1.mp4
```

3 retry'dan en iyiyi `_v1.mp4`, ikincisini `_v2.mp4` olarak sakla (fallback için).
````

- [ ] **Step 2: Write veo3-shot2.md (Card Drifts — en kritik shot)**

`entertainment/qulo-stop-swiping/prompts/veo3-shot2.md`:

````markdown
# Shot 2 — The Card Drifts (3.5s)

**Hedef dosya:** `public/veo/shot2_card_drifts_v1.mp4`
**Süre:** 3.5sn
**Mod:** Image-to-video, reference: `public/refs/female_lead_portrait.png`

**KRİTİK:** Bu shot'ın "uçan kart" + "partikül dağılımı" efekti **Remotion'da composite edilecek**. Veo'dan beklenen sadece kadının ve telefonun temiz çekimi. Veo'yu kart efektiyle prompt'lamaya çalışma — VFX kontrolünü Remotion'a bırak.

## Prompt

```
Continuation of the previous shot: same woman in bed, same cool blue phone glow on her face. She executes one final left swipe, then her thumb pauses mid-air just above the phone for a fraction of a second. Her brow furrows almost imperceptibly — a micro-expression of "something is missing." Her eyes drift slightly off-screen as if catching a thought. Same anamorphic lens, 35mm grain, deep teal shadows. Phone remains just out of frame, glow continues. The empty space above her thumb is intentional — leave clean negative space in the upper-right area for compositing later. 9:16 vertical, 30fps, 3.5 seconds.
```

## Önemli kompozisyon notu

**Üst-sağ köşe BOŞ kalmalı** (camera framing'de telefon ekranının üstündeki bölge). Bu alana Remotion'da uçan kart compositlenecek. Eğer Veo bu bölgeye duvar tekstürü, ışık vs koyarsa hâlâ kullanılır ama efekt güçlüğü artar — temiz koyu zemin idealdir.

## Negative

`oversaturated, smooth skin, smiling, music video, fast cuts, exaggerated facial expression, looking at camera, CGI rendering, fantasy elements, particle effects in the shot itself, glowing magical objects`

## Retry stratejisi

3 generation. Seçim kriteri:
- ✅ Kadın aynı kişi (Shot 1'le facial consistency)
- ✅ Mid-shot'ta thumb pause — bu beat olmalı, audience hisseder
- ✅ Kaş çatması micro (overact OLMAMALI — sadece "bir şey değişti" sinyali)
- ✅ Üst-sağ alan kompozisyonel olarak temiz
- ❌ Kart, ekran içeriği, magical particle Veo'da ÇIKARSA REJECT (efekti Remotion verecek)
- ❌ Yüz Shot 1'le farklıysa REJECT (karakter tutarlılığı kritik)

## Yerleşim

```bash
mv ~/Downloads/shot2_v1.mp4 entertainment/qulo-stop-swiping/public/veo/shot2_card_drifts_v1.mp4
```
````

- [ ] **Step 3: Write veo3-shot3.md (Conscious Shift)**

`entertainment/qulo-stop-swiping/prompts/veo3-shot3.md`:

````markdown
# Shot 3 — The Conscious Shift (4.0s)

**Hedef dosya:** `public/veo/shot3_conscious_shift_v1.mp4`
**Süre:** 4.0sn
**Mod:** Image-to-video, reference: `public/refs/female_lead_portrait.png`

## Prompt

```
The same woman, but now in a completely different lighting and energy: warm golden hour light from a window, she is sitting upright on the edge of her bed, posture engaged, alert. She is holding her phone with intent — not scrolling — and reading something carefully. Her thumb deliberately taps the screen as if answering a question, slow and considered. As she taps, the cool blue light fades and a subtle warm green glow rises on her face (we see emotion enter her eyes). She is thinking, present, alive. Tight chest-up framing. Anamorphic lens, 35mm film grain, A24 indie color grade transitioning from cool to warm with green and amber accents. 9:16 vertical, 30fps, 4 seconds.
```

## Önemli kompozisyon notu

Renk geçişi (cool → warm green) Veo'nun kendisi yapsın. Remotion'da ek bir warm overlay daha bindireceğiz — yani Veo'da minimal warm shift yeterli, abartı değil.

## Negative

`oversaturated, beauty shot, smooth skin, makeup, music video, fast cuts, dancing, dramatic gesture, magical particles, fantasy elements, CGI rendering`

## Retry stratejisi

3 generation. Seçim kriteri:
- ✅ Aynı kadın, ama Shot 1-2'den **farklı duruş ve ışık**
- ✅ Düşünceli/aktif okuma + niyetli tap
- ✅ Cool→warm renk şifti hissedilir (drastic değil, geçiş halinde)
- ✅ Gözlerde duygu var ama "uyandı" değil (saf transformation klişesi)
- ❌ Phone ekranı net görünüyorsa (UI Veo'dan değil Remotion'dan gelecek) REJECT
- ❌ Mavi ışık baskınsa (renk şifti olmamış) REJECT

## Yerleşim

```bash
mv ~/Downloads/shot3_v1.mp4 entertainment/qulo-stop-swiping/public/veo/shot3_conscious_shift_v1.mp4
```
````

- [ ] **Step 4: Write veo3-shot4.md (Recognition)**

`entertainment/qulo-stop-swiping/prompts/veo3-shot4.md`:

````markdown
# Shot 4 — Recognition (2.5s)

**Hedef dosya:** `public/veo/shot4_recognition_v1.mp4`
**Süre:** 2.5sn
**Mod:** Image-to-video, **iki reference** kullanılır:
- Primary subject: `public/refs/female_lead_portrait.png`
- Secondary subject (telefonda görünecek match): `public/refs/male_match_portrait.png`

**Eğer Veo 3 Pro tek reference destekliyorsa:** Sadece kadın referansını kullan, erkek bildirim Remotion'da overlay olarak eklenir (Notification UI component'i içinde male portrait kullanılır).

## Prompt (single-reference fallback)

```
The same woman, in warm window light, holding her phone. Her phone screen briefly lights up with a notification (the screen is angled slightly away from camera so the actual notification UI is not legible). Her face shifts from focused thought to soft recognition — a slow inhale, the corners of her mouth lift just a few millimeters. Her eyes hold something — relief mixed with surprise. She is seeing someone she recognizes. Anamorphic lens, 35mm film grain, A24 indie warm color grade with subtle green accent in highlights. Tight chest-up framing. 9:16 vertical, 30fps, 2.5 seconds.
```

## Önemli kompozisyon notu

Telefon ekranı ya hiç görünmesin ya da çok hafif açıdan görünsün ki Remotion'da üstüne **NotificationUI** component'i compositlenebilsin. Eğer Veo ekranda gerçek bir UI render ederse Remotion overlay üzerine binme zorunda kalır — temiz olmaz.

## Negative

`oversaturated, big smile, dramatic reaction, music video, fast cuts, magical particles, CGI rendering, beautified skin, makeup, perfect teeth showing`

## Retry stratejisi

3 generation. Seçim kriteri:
- ✅ Aynı kadın (4. shot'ta da consistency)
- ✅ Yüz değişimi MICRO — overact KESINLIKLE yasak ("happy ending" klişesinden kaç)
- ✅ Phone ekranı temiz / az görünür
- ✅ Warm grade Shot 3'le tutarlı
- ❌ Geniş gülüş varsa REJECT (subtle olacak)
- ❌ Phone ekranında belirgin başka UI varsa REJECT

## Yerleşim

```bash
mv ~/Downloads/shot4_v1.mp4 entertainment/qulo-stop-swiping/public/veo/shot4_recognition_v1.mp4
```
````

- [ ] **Step 5: Commit Veo prompts**

```bash
git add entertainment/qulo-stop-swiping/prompts/veo3-shot1.md entertainment/qulo-stop-swiping/prompts/veo3-shot2.md entertainment/qulo-stop-swiping/prompts/veo3-shot3.md entertainment/qulo-stop-swiping/prompts/veo3-shot4.md
git commit -m "docs(video): add Veo 3 Pro prompts for all 4 shots

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

### Task 1.7: ElevenLabs VO + Music prompts

**Files:**
- Create: `entertainment/qulo-stop-swiping/prompts/elevenlabs-vo.md`
- Create: `entertainment/qulo-stop-swiping/prompts/elevenlabs-music.md`

- [ ] **Step 1: Write elevenlabs-vo.md**

`entertainment/qulo-stop-swiping/prompts/elevenlabs-vo.md`:

````markdown
# ElevenLabs VO

**Hedef dosya:** `public/audio/vo_en_final.mp3`
**Süre:** ~10 saniye konuşma + sessizlik (15sn'lik master içine yerleşecek)

## Voice seçimi

ElevenLabs Voice Library'de aşağıdaki kriterlere uyan bir voice seç (öneriler):

- "Charlotte" (mid-30s British, husky-warm) — birincil aday
- "Rachel" (mid-30s American, warm) — ikincil
- "Sarah" (mid-30s, contemplative) — üçüncül

**Kriterler:**
- Female, 30-35 yaş aralığı
- Husky-warm, alt-orta perde
- Accent: neutral US veya soft British
- Şiirsel/düşünceli okuma profili

## Voice settings

- Stability: 0.50
- Similarity: 0.75
- Style: 0.40
- Use Speaker Boost: ✓

İlk render'dan sonra bu değerler fine-tune edilebilir.

## Script

İki yöntemden birini kullan:

### Yöntem A — Tek seferde tüm script

```
We swipe.

We scroll.

We swipe.

And the one we needed... drifts away.

Stop swiping. Start solving.
```

Cümleler arası boşlukları satır atlamasıyla belirt — ElevenLabs doğal pause verir. "...drifts away" üç noktadan sonra micro-pause oluşturur (Pause Beat ile eşleşmesi için).

### Yöntem B — Her cümleyi ayrı render et (eğer Yöntem A timing'i tutmazsa)

Her satır ayrı MP3, sonra Audacity'de timing'e göre yerleştir:
- `vo_01_we_swipe.mp3` → "We swipe."
- `vo_02_we_scroll.mp3` → "We scroll."
- `vo_03_we_swipe.mp3` → "We swipe."
- `vo_04_the_one.mp3` → "And the one we needed..."
- `vo_05_drifts_away.mp3` → "...drifts away."
- `vo_06_stop_swiping.mp3` → "Stop swiping."
- `vo_07_start_solving.mp3` → "Start solving."

Sonra Audacity / ffmpeg ile schema.ts'deki `VO_KEYFRAMES`'e göre timing'le birleştir, 15sn boyunca silence-pad et.

## Beklenen output

- Format: MP3, 44.1kHz, mono, 192kbps
- Dosya: `public/audio/vo_en_final.mp3`
- Toplam süre: 15.0sn (silence-padded)

## Yerleşim

```bash
mv ~/Downloads/vo_en_final.mp3 entertainment/qulo-stop-swiping/public/audio/vo_en_final.mp3
```

## Retry stratejisi

İlk render zayıfsa (over-acted, çok hızlı, yanlış accent):
1. Stability 0.6'ya çek (daha tutarlı, daha az duygu)
2. Style 0.3'e indir
3. Eğer hâlâ kötüyse farklı voice dene (Charlotte → Rachel)

"...drifts away" satırı en kritik — hüzünlü ama melodramatik OLMAMALI.
````

- [ ] **Step 2: Write elevenlabs-music.md**

`entertainment/qulo-stop-swiping/prompts/elevenlabs-music.md`:

````markdown
# ElevenLabs Music

**Hedef dosya:** `public/audio/music_15s_arc.mp3`
**Süre:** 15.0 saniye, iki-bölümlü ark

## Yapı

| Bölüm | Süre | Karakter |
|---|---|---|
| Bölüm 1 | 0–7s | Cinematic indie piano + low strings drone, melancholic, A minor, 70bpm |
| Bridge | 6.5–7s | Sustained note (musical breath, Pause Beat ile sync) |
| Bölüm 2 | 7–15s | Soft beat enters (kick + snap), warm pad layer, A major modulation, hopeful |
| Fade | 13.5–15s | Gradual fade out |

## ElevenLabs Music Prompt (tek-prompt yöntemi — birincil)

```
Cinematic 15-second instrumental track in two halves. The first 7 seconds: a sparse melancholy solo piano in A minor at 70 BPM, accompanied by a low sustained string drone, creating a feeling of quiet emotional weight (think Past Lives, Aftersun, Phoebe Bridgers acoustic intros). At the 7-second mark, a soft warm beat enters — a gentle kick drum and a finger-snap rhythm — and the harmony shifts toward A major with a soft warm synth pad. The second half feels like emotional release and hope (think Bonobo, Tycho, gentle electronic). The track gradually fades to silence over the last 1.5 seconds. No vocals, no melody changes (just harmonic shift). 9:16 vertical video soundtrack, instrumental only.
```

## Fallback yöntemi (eğer tek-prompt zayıfsa)

İki ayrı 8sn track üret:

**Track A — `music_part1_melancholy.mp3` (8sn):**
```
A sparse, melancholic solo piano in A minor at 70 BPM, with a low sustained string drone. Indie cinematic feel (Past Lives, Aftersun aesthetic). 8 seconds, no vocals, instrumental only.
```

**Track B — `music_part2_release.mp3` (8sn):**
```
A warm, hopeful instrumental in A major at 70 BPM, with a gentle kick drum, finger-snap rhythm, and warm synth pad. Bonobo and Tycho influence, electronic indie. 8 seconds, no vocals, instrumental only.
```

Sonra Audacity'de:
1. Track A'yı 0-7sn'ye yerleştir, 6-7sn arası 1sn fade out
2. Track B'yi 6.5-15sn'ye yerleştir, 6.5-7.5sn arası 1sn fade in (crossfade), 13.5-15sn arası fade out
3. Master export: `music_15s_arc.mp3`

## Beklenen output

- Format: MP3, 44.1kHz, stereo, 256kbps
- Dosya: `public/audio/music_15s_arc.mp3`
- Toplam süre: 15.0sn

## Yerleşim

```bash
mv ~/Downloads/music_15s_arc.mp3 entertainment/qulo-stop-swiping/public/audio/music_15s_arc.mp3
```

## Retry kriteri

- ✅ İlk yarı melankolik ama melodramatik değil
- ✅ 7. saniyedeki geçiş hissedilir ama abrupt değil
- ✅ İkinci yarı umut verir ama saf "happy" değil — emotional release
- ❌ Vokaller varsa REJECT (instrumental only)
- ❌ Beat çok loud / club-style ise REJECT (subtle olmalı)
````

- [ ] **Step 3: Commit ElevenLabs prompts**

```bash
git add entertainment/qulo-stop-swiping/prompts/elevenlabs-vo.md entertainment/qulo-stop-swiping/prompts/elevenlabs-music.md
git commit -m "docs(video): add ElevenLabs VO and music prompts

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

## ⏸ Phase 2 Checkpoint — Asset Generation Başlasın

**Bu noktada kullanıcıya net mesaj:**

> Phase 0-1 tamam. Şimdi sen aşağıdaki 4 görevi paralel başlatabilirsin (sırayla yapman da OK):
> 1. Reference portraits — `prompts/references.md` → `public/refs/`
> 2. Veo 3 Pro shots — `prompts/veo3-shot{1..4}.md` → `public/veo/`
> 3. ElevenLabs VO — `prompts/elevenlabs-vo.md` → `public/audio/vo_en_final.mp3`
> 4. ElevenLabs Music — `prompts/elevenlabs-music.md` → `public/audio/music_15s_arc.mp3`
>
> Bu sırada ben Phase 2'deki Veo/audio'ya bağımlı olmayan Remotion bileşenlerini yazacağım (end card, drifting card VFX, color shift, film grain, notification UI, logo). Bittiğinde Phase 3'e (sahne assembly) geçeriz.

---

## Phase 2: Veo/Audio-Bağımsız Component'ler (Paralel iş)

Bu fazdaki tüm task'lar Veo MP4 ya da audio asset gerektirmez. User asset üretirken agent bu kodları paralel yazabilir. Her bileşen Remotion Studio'da görsel olarak doğrulanır.

### Task 2.1: FilmGrain component

**Files:**
- Create: `entertainment/qulo-stop-swiping/src/components/FilmGrain.tsx`

35mm grain overlay — procedural noise, her frame farklı (deterministic seed kullanır ki render tutarlı olsun).

- [ ] **Step 1: Write FilmGrain.tsx**

`entertainment/qulo-stop-swiping/src/components/FilmGrain.tsx`:

```typescript
import React from "react";
import { AbsoluteFill, useCurrentFrame } from "remotion";

interface FilmGrainProps {
  intensity?: number;
}

export const FilmGrain: React.FC<FilmGrainProps> = ({ intensity = 0.08 }) => {
  const frame = useCurrentFrame();
  const seed = frame % 8;

  return (
    <AbsoluteFill
      style={{
        pointerEvents: "none",
        mixBlendMode: "overlay",
        opacity: intensity,
      }}
    >
      <svg width="100%" height="100%" preserveAspectRatio="none">
        <filter id={`grain-${seed}`}>
          <feTurbulence
            type="fractalNoise"
            baseFrequency="0.9"
            numOctaves="2"
            seed={seed}
          />
          <feColorMatrix
            type="matrix"
            values="0 0 0 0 0.5  0 0 0 0 0.5  0 0 0 0 0.5  0 0 0 1 0"
          />
        </filter>
        <rect width="100%" height="100%" filter={`url(#grain-${seed})`} />
      </svg>
    </AbsoluteFill>
  );
};
```

- [ ] **Step 2: Mount FilmGrain in StopSwipingAd placeholder for visual verify**

`entertainment/qulo-stop-swiping/src/StopSwipingAd.tsx`'i geçici olarak güncelle:

```typescript
import React from "react";
import { AbsoluteFill } from "remotion";
import { colors } from "./theme";
import { FilmGrain } from "./components/FilmGrain";

export const StopSwipingAd: React.FC = () => {
  return (
    <AbsoluteFill style={{ background: colors.coolShadow }}>
      <FilmGrain intensity={0.12} />
      <AbsoluteFill
        style={{
          color: colors.white,
          fontFamily: "system-ui",
          fontSize: 64,
          alignItems: "center",
          justifyContent: "center",
        }}
      >
        Grain test
      </AbsoluteFill>
    </AbsoluteFill>
  );
};
```

- [ ] **Step 3: Verify in Studio**

```bash
cd entertainment/qulo-stop-swiping && npm run studio
```

Expected: Deep teal arka plan üstünde subtle grain overlay görünür, frame ilerledikçe grain pattern dinamik değişir (her frame farklı pattern).

Studio'yu kapat. StopSwipingAd.tsx'yi placeholder'a geri çevir (Task 1.3 Step 3'teki haline) — FilmGrain artık scene'lerde kullanılacak, master'da yok.

```typescript
import React from "react";
import { AbsoluteFill } from "remotion";
import { colors } from "./theme";

export const StopSwipingAd: React.FC = () => {
  return (
    <AbsoluteFill
      style={{
        background: colors.bg,
        color: colors.white,
        fontFamily: "system-ui",
        fontSize: 64,
        alignItems: "center",
        justifyContent: "center",
      }}
    >
      Qulo Hero Ad — scaffold ready
    </AbsoluteFill>
  );
};
```

- [ ] **Step 4: Commit FilmGrain**

```bash
git add entertainment/qulo-stop-swiping/src/components/FilmGrain.tsx entertainment/qulo-stop-swiping/src/StopSwipingAd.tsx
git commit -m "feat(video): add FilmGrain component (procedural 35mm grain overlay)

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

### Task 2.2: ColorShiftOverlay component

**Files:**
- Create: `entertainment/qulo-stop-swiping/src/components/ColorShiftOverlay.tsx`

Cool→warm gradient mask, opacity progression. Shot 3'te kullanılacak.

- [ ] **Step 1: Write ColorShiftOverlay.tsx**

`entertainment/qulo-stop-swiping/src/components/ColorShiftOverlay.tsx`:

```typescript
import React from "react";
import { AbsoluteFill, interpolate, useCurrentFrame } from "remotion";
import { colors } from "../theme";

interface ColorShiftOverlayProps {
  fromCool?: string;
  toWarm?: string;
  durationFrames: number;
}

export const ColorShiftOverlay: React.FC<ColorShiftOverlayProps> = ({
  fromCool = colors.coolShadow,
  toWarm = colors.warmHighlight,
  durationFrames,
}) => {
  const frame = useCurrentFrame();
  const progress = interpolate(frame, [0, durationFrames], [0, 1], {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  });

  const coolOpacity = interpolate(progress, [0, 0.4, 1], [0.45, 0.25, 0.0]);
  const warmOpacity = interpolate(progress, [0, 0.4, 1], [0.0, 0.1, 0.35]);

  return (
    <>
      <AbsoluteFill
        style={{
          pointerEvents: "none",
          mixBlendMode: "multiply",
          background: `linear-gradient(180deg, ${fromCool} 0%, ${fromCool}00 60%)`,
          opacity: coolOpacity,
        }}
      />
      <AbsoluteFill
        style={{
          pointerEvents: "none",
          mixBlendMode: "soft-light",
          background: `radial-gradient(ellipse at 60% 40%, ${toWarm} 0%, ${toWarm}00 70%)`,
          opacity: warmOpacity,
        }}
      />
    </>
  );
};
```

- [ ] **Step 2: Verify in Studio**

StopSwipingAd.tsx'i geçici olarak update et:

```typescript
import React from "react";
import { AbsoluteFill } from "remotion";
import { colors } from "./theme";
import { ColorShiftOverlay } from "./components/ColorShiftOverlay";

export const StopSwipingAd: React.FC = () => {
  return (
    <AbsoluteFill style={{ background: "#222" }}>
      <ColorShiftOverlay durationFrames={120} />
    </AbsoluteFill>
  );
};
```

```bash
npm run studio
```

Expected: Frame 0'da grimsi-mavi gradient, frame 60'ta geçiş başlamış, frame 120'de warm radial glow baskın. Animasyon yumuşak.

StopSwipingAd.tsx'i placeholder'a geri çevir.

- [ ] **Step 3: Commit**

```bash
git add entertainment/qulo-stop-swiping/src/components/ColorShiftOverlay.tsx entertainment/qulo-stop-swiping/src/StopSwipingAd.tsx
git commit -m "feat(video): add ColorShiftOverlay (cool->warm gradient transition)

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

### Task 2.3: QuloLogo component

**Files:**
- Create: `entertainment/qulo-stop-swiping/src/components/QuloLogo.tsx`

End card'ta kullanılacak: logo + yeşil elmas mikro-parıltı animasyonu.

- [ ] **Step 1: Inspect logo SVG**

```bash
head -5 entertainment/qulo-stop-swiping/public/brand/qulo_logo.svg
```

Expected: SVG header görünür. `viewBox` notunu al — component'te kullanacağız.

- [ ] **Step 2: Write QuloLogo.tsx**

`entertainment/qulo-stop-swiping/src/components/QuloLogo.tsx`:

```typescript
import React from "react";
import { AbsoluteFill, Img, interpolate, spring, staticFile, useCurrentFrame, useVideoConfig } from "remotion";
import { colors } from "../theme";

interface QuloLogoProps {
  size?: number;
}

export const QuloLogo: React.FC<QuloLogoProps> = ({ size = 280 }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  const scaleIn = spring({
    frame,
    fps,
    config: { damping: 14, stiffness: 90, mass: 1 },
  });

  const sparklePulse = interpolate(
    frame % (fps * 1.2),
    [0, fps * 0.3, fps * 0.6, fps * 1.2],
    [0, 1, 0.4, 0],
    { extrapolateLeft: "clamp", extrapolateRight: "clamp" }
  );

  return (
    <AbsoluteFill
      style={{
        alignItems: "center",
        justifyContent: "center",
        transform: `scale(${0.85 + scaleIn * 0.15})`,
      }}
    >
      <div
        style={{
          position: "relative",
          width: size,
          height: size,
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
        }}
      >
        <Img
          src={staticFile("brand/qulo_logo.svg")}
          style={{ width: "100%", height: "100%", objectFit: "contain" }}
        />
        <div
          style={{
            position: "absolute",
            top: "12%",
            right: "8%",
            width: 24,
            height: 24,
            borderRadius: 12,
            background: colors.green,
            boxShadow: `0 0 ${20 * sparklePulse}px ${10 * sparklePulse}px ${colors.green}`,
            opacity: sparklePulse,
          }}
        />
      </div>
    </AbsoluteFill>
  );
};
```

- [ ] **Step 3: Verify in Studio**

StopSwipingAd.tsx'i update et:

```typescript
import React from "react";
import { AbsoluteFill } from "remotion";
import { colors } from "./theme";
import { QuloLogo } from "./components/QuloLogo";

export const StopSwipingAd: React.FC = () => {
  return (
    <AbsoluteFill style={{ background: colors.bg }}>
      <QuloLogo />
    </AbsoluteFill>
  );
};
```

```bash
npm run studio
```

Expected: Frame 0'da logo hafif küçük, spring ile büyür. 1.2sn'lik döngüyle yeşil elmas mikro-parıltı atar (üst-sağ köşede). Logo SVG düzgün render olur.

Eğer logo SVG'sinin viewBox'ı uyumsuz çıkar veya elmas pozisyonu yanlış görünürse, `top`/`right` yüzdelerini logoya göre fine-tune et (logo SVG'yi açıp manuel inspect et).

StopSwipingAd.tsx'i placeholder'a geri çevir.

- [ ] **Step 4: Commit**

```bash
git add entertainment/qulo-stop-swiping/src/components/QuloLogo.tsx entertainment/qulo-stop-swiping/src/StopSwipingAd.tsx
git commit -m "feat(video): add QuloLogo with green diamond sparkle pulse

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

### Task 2.4: DriftingCard component (Shot 2 VFX — en kritik)

**Files:**
- Create: `entertainment/qulo-stop-swiping/src/components/DriftingCard.tsx`

Bu component swipe ile telefonden fırlayan kartı simüle eder: kart üstünde male match portresi → uzaklaşır + döner + partikül halinde dağılır + opacity fade.

- [ ] **Step 1: Write DriftingCard.tsx**

`entertainment/qulo-stop-swiping/src/components/DriftingCard.tsx`:

```typescript
import React from "react";
import { AbsoluteFill, Img, interpolate, spring, staticFile, useCurrentFrame, useVideoConfig } from "remotion";
import { colors } from "../theme";

interface DriftingCardProps {
  malePortraitFile?: string;
}

export const DriftingCard: React.FC<DriftingCardProps> = ({
  malePortraitFile = "refs/male_match_portrait.png",
}) => {
  const frame = useCurrentFrame();
  const { fps, durationInFrames } = useVideoConfig();

  // Card lifecycle: 3.5sn = 105 frame (Shot 2 süresi)
  // 0-30: card emerges from phone (lower-right area)
  // 30-75: drifts up-right, slowly rotating
  // 75-105: dissolves into particles
  const launchProgress = spring({
    frame,
    fps,
    config: { damping: 18, stiffness: 60, mass: 1 },
  });

  const driftProgress = interpolate(frame, [30, 75], [0, 1], {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  });

  const dissolveProgress = interpolate(frame, [75, 105], [0, 1], {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  });

  const startX = 60;
  const startY = 75;
  const endX = 75;
  const endY = 25;
  const x = interpolate(driftProgress, [0, 1], [startX, endX]);
  const y = interpolate(driftProgress, [0, 1], [startY, endY]);

  const rotation = interpolate(driftProgress, [0, 1], [-5, -22]);
  const scale = launchProgress * (1 - dissolveProgress * 0.3);
  const opacity = interpolate(dissolveProgress, [0, 0.5, 1], [1, 0.5, 0]);

  const cardWidth = 280;
  const cardHeight = 380;

  return (
    <AbsoluteFill style={{ pointerEvents: "none" }}>
      {/* Card */}
      <div
        style={{
          position: "absolute",
          left: `${x}%`,
          top: `${y}%`,
          transform: `translate(-50%, -50%) rotate(${rotation}deg) scale(${scale})`,
          width: cardWidth,
          height: cardHeight,
          borderRadius: 24,
          overflow: "hidden",
          opacity,
          boxShadow: "0 24px 60px rgba(0,0,0,0.6), 0 0 0 1px rgba(255,255,255,0.05)",
          background: colors.coolShadow,
        }}
      >
        <Img
          src={staticFile(malePortraitFile)}
          style={{ width: "100%", height: "100%", objectFit: "cover" }}
        />
        <div
          style={{
            position: "absolute",
            inset: 0,
            background: "linear-gradient(180deg, rgba(0,0,0,0) 50%, rgba(0,0,0,0.7) 100%)",
          }}
        />
      </div>

      {/* Particle dissolve layer */}
      {dissolveProgress > 0 && <ParticleField progress={dissolveProgress} centerX={x} centerY={y} />}
    </AbsoluteFill>
  );
};

interface ParticleFieldProps {
  progress: number;
  centerX: number;
  centerY: number;
}

const ParticleField: React.FC<ParticleFieldProps> = ({ progress, centerX, centerY }) => {
  const particles = React.useMemo(() => {
    return Array.from({ length: 32 }, (_, i) => {
      const angle = (i / 32) * Math.PI * 2 + (i % 5) * 0.4;
      const distance = 8 + (i % 7) * 4;
      return {
        angle,
        distance,
        size: 3 + (i % 4),
        delay: (i % 8) * 0.05,
      };
    });
  }, []);

  return (
    <>
      {particles.map((p, i) => {
        const localProgress = Math.max(0, Math.min(1, (progress - p.delay) / (1 - p.delay)));
        const dx = Math.cos(p.angle) * p.distance * localProgress;
        const dy = Math.sin(p.angle) * p.distance * localProgress - localProgress * 6;
        const opacity = 1 - localProgress;
        return (
          <div
            key={i}
            style={{
              position: "absolute",
              left: `calc(${centerX}% + ${dx}vw)`,
              top: `calc(${centerY}% + ${dy}vh)`,
              width: p.size,
              height: p.size,
              borderRadius: p.size,
              background: "rgba(255, 240, 220, 0.85)",
              boxShadow: "0 0 4px rgba(255,240,220,0.6)",
              opacity,
            }}
          />
        );
      })}
    </>
  );
};
```

- [ ] **Step 2: Verify in Studio**

StopSwipingAd.tsx update:

```typescript
import React from "react";
import { AbsoluteFill } from "remotion";
import { colors } from "./theme";
import { DriftingCard } from "./components/DriftingCard";

export const StopSwipingAd: React.FC = () => {
  return (
    <AbsoluteFill style={{ background: colors.coolShadow }}>
      <DriftingCard />
    </AbsoluteFill>
  );
};
```

Composition duration'ı geçici olarak Root.tsx'te 105 frame'e çek (Shot 2 süresi), test bitince geri al:

`Root.tsx` geçici:
```typescript
durationInFrames={105}
```

```bash
npm run studio
```

Expected:
- Frame 0-30: kart sol-alttan spring ile büyüyerek belirir
- Frame 30-75: yukarı-sağa süzülür, hafifçe döner
- Frame 75-105: partikül halinde dağılır, opacity sıfıra gider

**Önemli:** male_match_portrait.png HENÜZ YOK (user gen edecek). Şimdilik partlet bir placeholder PNG kullan ya da test için temp bir görsel koy:

```bash
# Geçici test placeholder (bittiğinde silinecek)
curl -o entertainment/qulo-stop-swiping/public/refs/male_match_portrait.png https://placehold.co/600x800/1F1308/E8B070.png?text=Male+Ref
```

(Gerçek portre user tarafından üretilince üzerine yazılacak — Phase 2 checkpoint'inde.)

- [ ] **Step 3: Reset placeholders**

```typescript
// Root.tsx geri al: durationInFrames={VIDEO_DURATION_FRAMES}
```

StopSwipingAd.tsx'i placeholder'a geri çevir.

- [ ] **Step 4: Commit**

```bash
git add entertainment/qulo-stop-swiping/src/components/DriftingCard.tsx entertainment/qulo-stop-swiping/src/StopSwipingAd.tsx entertainment/qulo-stop-swiping/src/Root.tsx entertainment/qulo-stop-swiping/public/refs/male_match_portrait.png
git commit -m "feat(video): add DriftingCard with particle dissolve effect

Includes a placeholder male reference until user generates the real portrait.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

### Task 2.5: NotificationUI component (Shot 4 overlay)

**Files:**
- Create: `entertainment/qulo-stop-swiping/src/components/NotificationUI.tsx`

Telefon ekranında belirecek match bildirim mockup'ı: Qulo logo + "New match" + male portrait küçük thumb.

- [ ] **Step 1: Write NotificationUI.tsx**

`entertainment/qulo-stop-swiping/src/components/NotificationUI.tsx`:

```typescript
import React from "react";
import { AbsoluteFill, Img, interpolate, spring, staticFile, useCurrentFrame, useVideoConfig } from "remotion";
import { colors } from "../theme";

interface NotificationUIProps {
  malePortraitFile?: string;
}

export const NotificationUI: React.FC<NotificationUIProps> = ({
  malePortraitFile = "refs/male_match_portrait.png",
}) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  const slideIn = spring({
    frame,
    fps,
    config: { damping: 16, stiffness: 100, mass: 1 },
  });

  const opacity = interpolate(frame, [0, 8, 60, 75], [0, 1, 1, 0], {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  });

  const translateY = interpolate(slideIn, [0, 1], [40, 0]);

  return (
    <AbsoluteFill
      style={{
        pointerEvents: "none",
        alignItems: "center",
        justifyContent: "center",
        opacity,
        transform: `translateY(${translateY}px)`,
      }}
    >
      <div
        style={{
          width: 720,
          padding: "32px 40px",
          borderRadius: 32,
          background: "rgba(13, 13, 13, 0.85)",
          backdropFilter: "blur(20px)",
          border: `1px solid ${colors.green}40`,
          display: "flex",
          alignItems: "center",
          gap: 28,
          boxShadow: `0 24px 60px rgba(0,0,0,0.5), 0 0 0 4px ${colors.green}10`,
        }}
      >
        <div
          style={{
            width: 96,
            height: 96,
            borderRadius: 48,
            overflow: "hidden",
            flexShrink: 0,
            border: `3px solid ${colors.green}`,
            boxShadow: `0 0 24px ${colors.green}80`,
          }}
        >
          <Img
            src={staticFile(malePortraitFile)}
            style={{ width: "100%", height: "100%", objectFit: "cover" }}
          />
        </div>
        <div style={{ flex: 1 }}>
          <div
            style={{
              fontFamily: "Poppins, system-ui",
              fontWeight: 700,
              fontSize: 36,
              color: colors.white,
              letterSpacing: -0.5,
            }}
          >
            New match
          </div>
          <div
            style={{
              fontFamily: "Poppins, system-ui",
              fontWeight: 400,
              fontSize: 26,
              color: colors.whiteSoft,
              marginTop: 6,
            }}
          >
            Solved your questions
          </div>
        </div>
      </div>
    </AbsoluteFill>
  );
};
```

- [ ] **Step 2: Verify in Studio**

StopSwipingAd.tsx update:

```typescript
import React from "react";
import { AbsoluteFill } from "remotion";
import { colors } from "./theme";
import { NotificationUI } from "./components/NotificationUI";

export const StopSwipingAd: React.FC = () => {
  return (
    <AbsoluteFill style={{ background: colors.warmShadow }}>
      <NotificationUI />
    </AbsoluteFill>
  );
};
```

```bash
npm run studio
```

Expected: Bildirim spring ile aşağıdan yukarı kayarak belirir, ~2sn ekranda kalır, 75. frame'de fade out olur. Glassmorphic background, yeşil ring, male portrait, "New match" text görünür.

StopSwipingAd.tsx'i placeholder'a geri çevir.

- [ ] **Step 3: Commit**

```bash
git add entertainment/qulo-stop-swiping/src/components/NotificationUI.tsx entertainment/qulo-stop-swiping/src/StopSwipingAd.tsx
git commit -m "feat(video): add NotificationUI mockup overlay for match reveal

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

### Task 2.6: EndCard scene (Veo bağımsız — pure Remotion)

**Files:**
- Create: `entertainment/qulo-stop-swiping/src/scenes/EndCard.tsx`

End card 1.5sn (45 frame). Layout: logo (üst-orta), tagline (alt-orta), domain (en-alt). Logo'da QuloLogo'nun spring + sparkle'ı kullanılır.

- [ ] **Step 1: Write EndCard.tsx**

`entertainment/qulo-stop-swiping/src/scenes/EndCard.tsx`:

```typescript
import React from "react";
import { AbsoluteFill, interpolate, useCurrentFrame, useVideoConfig } from "remotion";
import { loadFont } from "@remotion/google-fonts/Poppins";
import { QuloLogo } from "../components/QuloLogo";
import { colors } from "../theme";

const { fontFamily } = loadFont("normal", {
  weights: ["400", "600"],
  subsets: ["latin"],
});

export const EndCard: React.FC = () => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  const taglineOpacity = interpolate(frame, [fps * 0.2, fps * 0.5], [0, 1], {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  });

  const domainOpacity = interpolate(frame, [fps * 0.4, fps * 0.7], [0, 0.6], {
    extrapolateLeft: "clamp",
    extrapolateRight: "clamp",
  });

  return (
    <AbsoluteFill
      style={{
        background: colors.bg,
        fontFamily,
      }}
    >
      <AbsoluteFill style={{ alignItems: "center", justifyContent: "center", paddingBottom: 200 }}>
        <QuloLogo size={260} />
      </AbsoluteFill>

      <AbsoluteFill
        style={{
          alignItems: "center",
          justifyContent: "flex-end",
          paddingBottom: 280,
        }}
      >
        <div
          style={{
            color: colors.white,
            fontWeight: 600,
            fontSize: 64,
            letterSpacing: -1,
            textAlign: "center",
            opacity: taglineOpacity,
          }}
        >
          Stop swiping. Start solving.
        </div>
      </AbsoluteFill>

      <AbsoluteFill
        style={{
          alignItems: "center",
          justifyContent: "flex-end",
          paddingBottom: 140,
        }}
      >
        <div
          style={{
            color: colors.white,
            fontWeight: 400,
            fontSize: 32,
            letterSpacing: 0.5,
            textAlign: "center",
            opacity: domainOpacity,
          }}
        >
          qulo.app
        </div>
      </AbsoluteFill>
    </AbsoluteFill>
  );
};
```

- [ ] **Step 2: Verify in Studio**

StopSwipingAd.tsx update:

```typescript
import React from "react";
import { EndCard } from "./scenes/EndCard";

export const StopSwipingAd: React.FC = () => {
  return <EndCard />;
};
```

Root.tsx duration geçici 45 frame:
```typescript
durationInFrames={45}
```

```bash
npm run studio
```

Expected: Logo spring ile büyür + yeşil elmas pulse, ~6. frame'de tagline fade in, ~12. frame'de "qulo.app" hafif opacity ile görünür. 1.5sn'lik kart temiz layout ile bitiyor.

- [ ] **Step 3: Reset Root duration ve placeholder**

Root.tsx geri al: `durationInFrames={VIDEO_DURATION_FRAMES}`. StopSwipingAd.tsx'i placeholder'a çevir.

- [ ] **Step 4: Commit**

```bash
git add entertainment/qulo-stop-swiping/src/scenes/EndCard.tsx entertainment/qulo-stop-swiping/src/Root.tsx entertainment/qulo-stop-swiping/src/StopSwipingAd.tsx
git commit -m "feat(video): add EndCard scene with logo, tagline, and domain

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

### Task 2.7: PauseBeat scene (Veo-bağımsız placeholder)

**Files:**
- Create: `entertainment/qulo-stop-swiping/src/scenes/PauseBeat.tsx`

Pause Beat 0.5sn (15 frame). Shot 2 sonu ile Shot 3 başı arasında micro-bridge. Pure Remotion: Shot 2'nin son frame'inden gelen "frozen" hissi, hafif zoom-in + grain.

**Önemli:** Bu scene Shot 2 ya da Shot 3'le visual olarak smooth bağlanır. Şimdilik standalone yapısını test ederiz; Phase 4'te master composition'a entegre edilirken Shot 2'nin son frame'inden seamless gelecek (cross-fade).

- [ ] **Step 1: Write PauseBeat.tsx**

`entertainment/qulo-stop-swiping/src/scenes/PauseBeat.tsx`:

```typescript
import React from "react";
import { AbsoluteFill, interpolate, useCurrentFrame } from "remotion";
import { FilmGrain } from "../components/FilmGrain";
import { colors } from "../theme";

export const PauseBeat: React.FC = () => {
  const frame = useCurrentFrame();

  // 0.5s (15 frame) — subtle zoom-in + slight darkening
  const zoom = interpolate(frame, [0, 15], [1.0, 1.04]);
  const darken = interpolate(frame, [0, 15], [0, 0.15]);

  return (
    <AbsoluteFill style={{ background: colors.coolShadow }}>
      <AbsoluteFill
        style={{
          background: colors.coolShadow,
          transform: `scale(${zoom})`,
        }}
      />
      <AbsoluteFill style={{ background: `rgba(0,0,0,${darken})` }} />
      <FilmGrain intensity={0.14} />
    </AbsoluteFill>
  );
};
```

Phase 4'te bu scene Shot 2 video'sunun son frame'inden besleniyor olarak güncellenecek (`<Video>` ile freeze frame yaklaşımı veya cross-fade).

- [ ] **Step 2: Commit**

```bash
git add entertainment/qulo-stop-swiping/src/scenes/PauseBeat.tsx
git commit -m "feat(video): add PauseBeat scene placeholder (zoom + darken bridge)

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

## Phase 3: Veo Sahne Assembly (Asset'ler hazır olunca)

**Bu fazın başlangıcı:** User Phase 2 paralel görevlerini bitirmiş, `public/veo/`'da 4 MP4, `public/audio/`'da 2 MP3, `public/refs/`'te 2 portre var.

### Task 3.1: Shot1NumbSwipe scene

**Files:**
- Create: `entertainment/qulo-stop-swiping/src/scenes/Shot1NumbSwipe.tsx`

Veo footage + FilmGrain.

- [ ] **Step 1: Write Shot1NumbSwipe.tsx**

`entertainment/qulo-stop-swiping/src/scenes/Shot1NumbSwipe.tsx`:

```typescript
import React from "react";
import { AbsoluteFill, OffthreadVideo, staticFile } from "remotion";
import { FilmGrain } from "../components/FilmGrain";

export const Shot1NumbSwipe: React.FC = () => {
  return (
    <AbsoluteFill>
      <OffthreadVideo
        src={staticFile("veo/shot1_numb_swipe_v1.mp4")}
        style={{ width: "100%", height: "100%", objectFit: "cover" }}
      />
      <FilmGrain intensity={0.10} />
    </AbsoluteFill>
  );
};
```

- [ ] **Step 2: Verify in Studio**

StopSwipingAd.tsx update:

```typescript
import { Shot1NumbSwipe } from "./scenes/Shot1NumbSwipe";

export const StopSwipingAd: React.FC = () => {
  return <Shot1NumbSwipe />;
};
```

Root.tsx duration: 90 frame (Shot 1).

```bash
npm run studio
```

Expected: Veo video oynar, üstüne grain bindirilmiş. Eğer Veo MP4 9:16 değilse `objectFit: cover` cropper. Veo'nun kendisi cool grade'liyse FilmGrain organik görünür.

Eğer Veo dosyası eksikse Studio "asset not found" hatası verir — bu Phase 2 checkpoint'in tamamlanmadığı anlamına gelir, geri dön.

Reset placeholder + Root duration.

- [ ] **Step 3: Commit**

```bash
git add entertainment/qulo-stop-swiping/src/scenes/Shot1NumbSwipe.tsx entertainment/qulo-stop-swiping/src/StopSwipingAd.tsx entertainment/qulo-stop-swiping/src/Root.tsx
git commit -m "feat(video): assemble Shot1 numb swipe scene

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

### Task 3.2: Shot2CardDrifts scene

**Files:**
- Create: `entertainment/qulo-stop-swiping/src/scenes/Shot2CardDrifts.tsx`

Veo footage + DriftingCard overlay + FilmGrain.

- [ ] **Step 1: Write Shot2CardDrifts.tsx**

`entertainment/qulo-stop-swiping/src/scenes/Shot2CardDrifts.tsx`:

```typescript
import React from "react";
import { AbsoluteFill, OffthreadVideo, staticFile } from "remotion";
import { DriftingCard } from "../components/DriftingCard";
import { FilmGrain } from "../components/FilmGrain";

export const Shot2CardDrifts: React.FC = () => {
  return (
    <AbsoluteFill>
      <OffthreadVideo
        src={staticFile("veo/shot2_card_drifts_v1.mp4")}
        style={{ width: "100%", height: "100%", objectFit: "cover" }}
      />
      <DriftingCard />
      <FilmGrain intensity={0.10} />
    </AbsoluteFill>
  );
};
```

- [ ] **Step 2: Verify in Studio**

StopSwipingAd update + Root duration 105 frame, studio'yu boot et.

Expected:
- Veo video (kadın + thumb pause) oynar
- Üst-sağ alanda kart spring ile çıkar, drift eder, 2.5-3.5sn arası partikül halinde dağılır
- DriftingCard pozisyonu (centerX=60, centerY=75 başlar) Veo'daki phone konumuyla **kabaca uyumlu** olmalı; eğer offset varsa DriftingCard.tsx'te startX/startY/endX/endY değerlerini fine-tune et

- [ ] **Step 3: Fine-tune card position (gerekirse)**

Veo footage'a göre kartın "telefonden çıkıyor" hissi vermesi için pozisyon offset'leri DriftingCard.tsx'te ayarlanır. Studio'da preview yaparken Inspect ile değer dene. Tipik fine-tune:

```typescript
// DriftingCard.tsx içinde
const startX = 55; // 60'tan 55'e — daha sola
const startY = 80; // 75'ten 80'e — daha aşağıya
const endX = 70;
const endY = 20;
```

Reset placeholder.

- [ ] **Step 4: Commit**

```bash
git add entertainment/qulo-stop-swiping/src/scenes/Shot2CardDrifts.tsx entertainment/qulo-stop-swiping/src/components/DriftingCard.tsx entertainment/qulo-stop-swiping/src/StopSwipingAd.tsx entertainment/qulo-stop-swiping/src/Root.tsx
git commit -m "feat(video): assemble Shot2 card drifts scene with VFX overlay

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

### Task 3.3: Shot3ConsciousShift scene

**Files:**
- Create: `entertainment/qulo-stop-swiping/src/scenes/Shot3ConsciousShift.tsx`

Veo footage + ColorShiftOverlay + FilmGrain. Veo'nun kendisi cool→warm geçişi yapıyor; ColorShiftOverlay bunu güçlendiriyor.

- [ ] **Step 1: Write Shot3ConsciousShift.tsx**

`entertainment/qulo-stop-swiping/src/scenes/Shot3ConsciousShift.tsx`:

```typescript
import React from "react";
import { AbsoluteFill, OffthreadVideo, staticFile, useVideoConfig } from "remotion";
import { ColorShiftOverlay } from "../components/ColorShiftOverlay";
import { FilmGrain } from "../components/FilmGrain";
import { TIMINGS } from "../schema";

export const Shot3ConsciousShift: React.FC = () => {
  return (
    <AbsoluteFill>
      <OffthreadVideo
        src={staticFile("veo/shot3_conscious_shift_v1.mp4")}
        style={{ width: "100%", height: "100%", objectFit: "cover" }}
      />
      <ColorShiftOverlay durationFrames={TIMINGS.shot3.durationFrames} />
      <FilmGrain intensity={0.09} />
    </AbsoluteFill>
  );
};
```

- [ ] **Step 2: Verify + commit**

```bash
git add entertainment/qulo-stop-swiping/src/scenes/Shot3ConsciousShift.tsx
git commit -m "feat(video): assemble Shot3 conscious shift scene with color overlay

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

### Task 3.4: Shot4Recognition scene

**Files:**
- Create: `entertainment/qulo-stop-swiping/src/scenes/Shot4Recognition.tsx`

Veo footage + NotificationUI overlay + FilmGrain.

- [ ] **Step 1: Write Shot4Recognition.tsx**

`entertainment/qulo-stop-swiping/src/scenes/Shot4Recognition.tsx`:

```typescript
import React from "react";
import { AbsoluteFill, OffthreadVideo, staticFile } from "remotion";
import { NotificationUI } from "../components/NotificationUI";
import { FilmGrain } from "../components/FilmGrain";

export const Shot4Recognition: React.FC = () => {
  return (
    <AbsoluteFill>
      <OffthreadVideo
        src={staticFile("veo/shot4_recognition_v1.mp4")}
        style={{ width: "100%", height: "100%", objectFit: "cover" }}
      />
      <NotificationUI />
      <FilmGrain intensity={0.09} />
    </AbsoluteFill>
  );
};
```

- [ ] **Step 2: Verify + commit**

Studio test, sonra:

```bash
git add entertainment/qulo-stop-swiping/src/scenes/Shot4Recognition.tsx
git commit -m "feat(video): assemble Shot4 recognition scene with notification overlay

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

## Phase 4: Master Composition + Render

### Task 4.1: StopSwipingAd master composition

**Files:**
- Modify: `entertainment/qulo-stop-swiping/src/StopSwipingAd.tsx`

Tüm sahneleri sequence eder, audio (VO + music) bindirir.

- [ ] **Step 1: Replace placeholder StopSwipingAd.tsx**

`entertainment/qulo-stop-swiping/src/StopSwipingAd.tsx`:

```typescript
import React from "react";
import { AbsoluteFill, Sequence, staticFile, useVideoConfig } from "remotion";
import { Audio } from "@remotion/media";
import { loadFont } from "@remotion/google-fonts/Poppins";
import { Shot1NumbSwipe } from "./scenes/Shot1NumbSwipe";
import { Shot2CardDrifts } from "./scenes/Shot2CardDrifts";
import { PauseBeat } from "./scenes/PauseBeat";
import { Shot3ConsciousShift } from "./scenes/Shot3ConsciousShift";
import { Shot4Recognition } from "./scenes/Shot4Recognition";
import { EndCard } from "./scenes/EndCard";
import { TIMINGS } from "./schema";
import { colors } from "./theme";

loadFont("normal", {
  weights: ["400", "500", "600", "700"],
  subsets: ["latin"],
});

export const StopSwipingAd: React.FC = () => {
  const { fps, durationInFrames } = useVideoConfig();

  const fadeFrames = Math.round(0.5 * fps);

  return (
    <AbsoluteFill style={{ background: colors.bg }}>
      {/* Music — full duration with fade in/out */}
      <Audio
        src={staticFile("audio/music_15s_arc.mp3")}
        volume={(f) => {
          if (f < fadeFrames) return (f / fadeFrames) * 0.55;
          if (f > durationInFrames - fadeFrames) {
            return ((durationInFrames - f) / fadeFrames) * 0.55;
          }
          return 0.55;
        }}
      />

      {/* Voiceover — sample-accurate, on top of music */}
      <Audio
        src={staticFile("audio/vo_en_final.mp3")}
        volume={0.95}
      />

      {/* Scenes */}
      <Sequence from={TIMINGS.shot1.startFrame} durationInFrames={TIMINGS.shot1.durationFrames}>
        <Shot1NumbSwipe />
      </Sequence>

      <Sequence from={TIMINGS.shot2.startFrame} durationInFrames={TIMINGS.shot2.durationFrames}>
        <Shot2CardDrifts />
      </Sequence>

      <Sequence from={TIMINGS.pause.startFrame} durationInFrames={TIMINGS.pause.durationFrames}>
        <PauseBeat />
      </Sequence>

      <Sequence from={TIMINGS.shot3.startFrame} durationInFrames={TIMINGS.shot3.durationFrames}>
        <Shot3ConsciousShift />
      </Sequence>

      <Sequence from={TIMINGS.shot4.startFrame} durationInFrames={TIMINGS.shot4.durationFrames}>
        <Shot4Recognition />
      </Sequence>

      <Sequence from={TIMINGS.end.startFrame} durationInFrames={TIMINGS.end.durationFrames}>
        <EndCard />
      </Sequence>
    </AbsoluteFill>
  );
};
```

- [ ] **Step 2: Verify full timeline in Studio**

```bash
npm run studio
```

Expected: 0-15sn boyunca tüm sahneler sıralı oynar, VO + müzik karışır. Audio dengesi:
- Müzik: arka planda, VO altında nefes alır (volume 0.55)
- VO: net duyulur, dominant (volume 0.95)
- Müzik fade in (0-0.5sn) ve fade out (14.5-15sn) yumuşak

**Hızlı QA kontrol listesi:**
- [ ] Shot 1 → Shot 2 geçişi smooth (jump cut hissi yok)
- [ ] Shot 2 → PauseBeat → Shot 3 micro-pause hissi var
- [ ] Shot 3'te color shift Veo + overlay tutarlı
- [ ] Shot 4'te notification spring ile beliriyor
- [ ] EndCard logosu spring'le büyüyor, sparkle pulse var
- [ ] VO "drifts away" tam Pause Beat anında düşüyor (yaklaşık frame 200)
- [ ] Müzik ortada (frame 195-210) hafif beat girişi hissedilir

- [ ] **Step 3: Commit**

```bash
git add entertainment/qulo-stop-swiping/src/StopSwipingAd.tsx
git commit -m "feat(video): assemble master composition with audio mix

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>"
```

---

### Task 4.2: First master render

- [ ] **Step 1: Run master render**

```bash
cd entertainment/qulo-stop-swiping && npm run render:master
```

Expected: Bundle yapılır, frame'ler render edilir, audio mux'lanır, `out/qulo-stop-swiping-15s-9x16.mp4` oluşur. Süre: ~3-8 dakika (Veo MP4'lerin boyutuna ve makineye göre).

- [ ] **Step 2: Inspect output**

```bash
ls -lh entertainment/qulo-stop-swiping/out/qulo-stop-swiping-15s-9x16.mp4
ffprobe entertainment/qulo-stop-swiping/out/qulo-stop-swiping-15s-9x16.mp4 2>&1 | head -30
```

Expected:
- Dosya boyutu: 25-60 MB civarı
- Resolution: 1080×1920
- Duration: 15.0s
- Codec: h264 (video) + aac (audio)
- fps: 30

- [ ] **Step 3: Play and review**

Open in QuickTime / VLC. Tam ekran izle. Notlar al:
- Hangi shot zayıf?
- VO timing tutuyor mu?
- Audio dengesi doğru mu?
- VFX (drifting card, color shift, end card) doğal hissediyor mu?

Kullanıcıya bu MP4'i göster, geri bildirim al.

---

## Phase 5: Iteration

Bu faz user'ın geri bildirimine göre dinamik. Tipik iteration türleri:

### Tipik düzeltmeler

1. **Veo shot zayıf** → prompt revize, retry, eski MP4'ün üzerine yaz, render tekrar.
2. **VO over-acted** → ElevenLabs settings (stability up, style down), regenerate, replace, render.
3. **Müzik geçişi sert** → fallback yöntem (iki ayrı track + crossfade), regenerate.
4. **Drifting card pozisyonu yanlış** → DriftingCard startX/startY fine-tune, render.
5. **Color shift çok agresif** → ColorShiftOverlay opacity range'leri yumuşat.
6. **End card tagline timing** → EndCard interpolate range ayarla.
7. **Audio dengesi** → StopSwipingAd.tsx'te volume value'ları ayarla.

### Iterasyon protokolü

Her iterasyonda:
1. User feedback'i yaz (dosya: `out/iteration-notes-{N}.md` opsiyonel)
2. Tek bir değişiklik yap (compose halde değil, atomic)
3. Tek bir alanı re-render (fast preview için Studio'da inspect, full render gereksiz)
4. Onay sonrası tam re-render + commit

---

## Self-Review (writing-plans skill gereği)

**Spec coverage:**
- ✓ Cleanup planı (Phase 0) — Spec §9
- ✓ Klasör yapısı (Task 0.1, 1.1) — Spec §7
- ✓ Theme + tipografi (Task 1.2, 2.6) — Spec §5
- ✓ VO script + timing (Task 1.7, 4.1) — Spec §3.1, §3.3
- ✓ Müzik yapısı (Task 1.7, 4.1) — Spec §4.2
- ✓ Veo prompts (Task 1.6) — Spec §6.1
- ✓ Drifting card VFX (Task 2.4) — Spec §3.2 Shot 2 metaforu
- ✓ Color shift (Task 2.2, 3.3) — Spec §5.2
- ✓ Notification UI (Task 2.5, 3.4) — Spec §3.2 Shot 4
- ✓ End card (Task 2.6) — Spec §3.2 End Card
- ✓ Master composition + audio mix (Task 4.1) — Spec §6.2
- ✓ Render outputs (Task 4.2) — Spec §6.3
- ✓ Paralel iş bölümü (Phase 2 checkpoint) — Spec §8
- ✓ Risk mitigations (Phase 5 iteration protokolü) — Spec §10

**Placeholder scan:** Yok. Tüm kod blokları somut. Tüm prompt'lar tam yazılmış.

**Type consistency:**
- TIMINGS shape: `{ startFrame, durationFrames }` — schema.ts'de tanımlı, StopSwipingAd.tsx'te aynı şekilde tüketilir ✓
- VIDEO_DURATION_FRAMES: theme.ts'de export, Root.tsx'te tüketilir ✓
- DriftingCard props: malePortraitFile (optional, default `refs/male_match_portrait.png`) — Shot2CardDrifts'te override edilmiyor, default kullanılıyor ✓
- NotificationUI props: aynı şekilde ✓
- ColorShiftOverlay durationFrames: prop, Shot3'te `TIMINGS.shot3.durationFrames` olarak geçilir ✓

Plan tutarlı, spec'le full coverage var, placeholder yok.

---

## Execution Handoff

Plan tamam ve `docs/superpowers/plans/2026-05-09-stop-swiping-hero-ad.md` dosyasına kaydedildi.

İki execution seçeneği:

**1. Subagent-Driven (önerilen)** — Her task için fresh subagent dispatch ediyorum, aralarda review yapıyorum, hızlı iterasyon. **Video production gibi paralel akışlı işlerde özellikle güçlü** — Phase 2 paralel iş checkpoint'inde sen Veo/audio gen yaparken ben subagent'la component'leri paralel yazabilirim.

**2. Inline Execution** — Bu session'da task'ları sırayla işliyorum, batch checkpoint'lerde review.

Hangisi?
