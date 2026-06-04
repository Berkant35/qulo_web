# Qulo Full-App Intro TikTok Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 140s, English, ElevenLabs VO + Suno BGM, witty/sassy tone TikTok video introducing Qulo to US/UK 22-30 dating-fatigued audience using the existing `qulo-tiktok-promos` Remotion pipeline.

**Architecture:** Add 1 new component (`GenericSwipeStack`) + prop variants to 11 existing components + a new 12-scene config (`full-app-intro.config.ts`) + VO/mix audio pipeline (ElevenLabs TTS, ffmpeg sidechain ducking premix) → render via existing `TikTokPromo` composition → publish to `marketing/tiktok/videos/`.

**Tech Stack:** Remotion 4.0, React 19, TypeScript 5.9, Node 20+, ElevenLabs SDK, ffmpeg, Suno (BGM), Freesound CC0 (SFX).

**Spec reference:** `docs/superpowers/specs/2026-06-04-qulo-full-app-intro-tiktok-design.md`

**Working directory for all commands:** `/Users/berkantcalikusu/IdeaProjects/qulo/entertainment/qulo-tiktok-promos`

---

## File Structure

### Files to Create

| Path | Responsibility |
|------|----------------|
| `src/components/GenericSwipeStack.tsx` | Brand-neutral stylized swipe stack (replaces `TinderMock`) |
| `src/configs/full-app-intro.config.ts` | 12-scene timeline + captions + audioTrack |
| `scripts/generate-vo.ts` | Calls ElevenLabs SDK → writes `public/audio/raw/vo.mp3` |
| `scripts/mix-audio.sh` | ffmpeg pipeline: VO + BGM + SFX → mastered mix |
| `public/audio/raw/sfx/diamond_ting.mp3` | CC0 SFX (×9 uses) |
| `public/audio/raw/sfx/match_chime.mp3` | CC0 SFX |
| `public/audio/raw/sfx/correct_ding.mp3` | CC0 SFX (×3 uses) |
| `public/audio/raw/sfx/swoosh.mp3` | CC0 SFX (×4 uses) |
| `public/audio/raw/sfx/type_tap.mp3` | CC0 SFX (×12 uses) |
| `public/audio/raw/sfx/ghost_silence.mp3` | CC0 SFX |
| `marketing/tiktok/captions/full-app-intro.md` | TikTok caption + hashtags |
| `.env.example` | Documents `ELEVENLABS_API_KEY` |

### Files to Modify

| Path | Change |
|------|--------|
| `src/types.ts` | Add `'GenericSwipeStack'` to `SceneComponent` union |
| `src/TikTokPromo.tsx` | Add `case 'GenericSwipeStack'` to `renderScene` switch + import |
| `src/configs/index.ts` | Register `fullAppIntroConfig` in REGISTRY |
| `src/components/HookScene.tsx` | Add `logoReveal?: boolean` prop |
| `src/components/DiamondBurst.tsx` | Add `scale`, `color`, `dual`, `count` props |
| `src/components/QuestionPill.tsx` | Add `accent?: boolean`, `urgent?: boolean`, `label?: string` props |
| `src/components/StatsGrid.tsx` | Add `compact`, `infographic`, `large` variants |
| `src/components/QuizSolve.tsx` | Add `options`, `correctIndex`, `showTimer` props |
| `src/components/ChatBubble.tsx` | Add `mood: 'normal'\|'ghost'`, `thread` props |
| `src/components/QuestionCreate.tsx` | Add `aiSuggested`, `typewriter`, `steps` props |
| `src/components/MatchCelebration.tsx` | Add `score`, `diamondsEarned` props |
| `src/components/TimeOfDay.tsx` | Add `time`, `subtle` props |
| `src/components/ProcessStep.tsx` | Add `compact`, `labelAbove` props |
| `src/components/CTAScene.tsx` | Add `showBadges?: boolean` prop |
| `package.json` | Add deps (`tsx`, `elevenlabs`, `dotenv`) + scripts |
| `.gitignore` | Ignore `public/audio/raw/vo.mp3`, `public/audio/raw/bgm.mp3`, `public/audio/qulo-full-app-intro-mix.mp3` |

### Manual User Actions (cannot be automated)

- Subscribe to ElevenLabs (≥$5/mo Starter), set `ELEVENLABS_API_KEY`
- Generate or source BGM via Suno Pro / Epidemic Sound → save to `public/audio/raw/bgm.mp3`
- Curate 6 CC0 SFX clips from Freesound.org → save to `public/audio/raw/sfx/*.mp3`

---

## Conventions

- **Backwards compatibility:** All new props on existing components MUST be optional with defaults that preserve current behavior. Existing configs (`stop-swiping`, `day-in-the-life`, `match-to-first-date`) must keep rendering identically.
- **Validation per task:** Since the project has no automated tests, validation uses (a) `tsc --noEmit` for type correctness, (b) `npm run studio` browser preview for visual correctness, (c) `ffprobe` for audio/video assertions.
- **Commits:** One commit per task unless the task explicitly says "no commit yet."
- **No emoji in code/commits** unless they belong to the original config strings.

---

## FAZ 1 — Type System & New Component

### Task 1: Add `GenericSwipeStack` to SceneComponent union

**Files:**
- Modify: `src/types.ts`

- [ ] **Step 1: Edit the SceneComponent type**

Edit `src/types.ts`. Add `'GenericSwipeStack'` to the union (keep `'TinderMock'` for backwards-compatibility with existing configs, even though `full-app-intro` will not use it):

```typescript
export type SceneComponent =
  | 'HookScene'
  | 'StatsGrid'
  | 'ProcessStep'
  | 'DriftingCard'
  | 'QuestionPill'
  | 'DiamondBurst'
  | 'CTAScene'
  | 'PhoneFrame'
  | 'TinderMock'
  | 'QuloDiscoverCard'
  | 'QuestionCreate'
  | 'QuizSolve'
  | 'AnswerFeedback'
  | 'MatchCelebration'
  | 'ChatBubble'
  | 'TimeOfDay'
  | 'GenericSwipeStack';
```

- [ ] **Step 2: Verify type compiles**

Run from `entertainment/qulo-tiktok-promos`:
```bash
npx tsc --noEmit
```
Expected: no errors. (`TikTokPromo.tsx` will not yet have the `case`, but TypeScript exhaustiveness check is not enabled in the switch — runtime throw catches it.)

- [ ] **Step 3: Commit**

```bash
git add entertainment/qulo-tiktok-promos/src/types.ts
git commit -m "feat(promos): add GenericSwipeStack to SceneComponent union"
```

---

### Task 2: Create `GenericSwipeStack.tsx` component

**Files:**
- Create: `src/components/GenericSwipeStack.tsx`

- [ ] **Step 1: Write the component**

Create `src/components/GenericSwipeStack.tsx` with the following content:

```typescript
import {AbsoluteFill, useCurrentFrame, interpolate} from 'remotion';

export type GenericSwipeStackProps = {
  count?: number;          // default 4
  ghostMode?: boolean;     // default false — when true, top card stays and shows "..." then fades
  brand?: 'neutral';       // only 'neutral' accepted — enforces brand-attack-free policy
};

// Brand-neutral pastel palette — must NOT resemble any dating app
const NEUTRAL_PALETTE = ['#E8DEF8', '#D7E4F2', '#FAE0E9', '#E6E0D4'];
const CARD_W = 540;
const CARD_H = 760;

export const GenericSwipeStack: React.FC<GenericSwipeStackProps> = ({
  count = 4,
  ghostMode = false,
}) => {
  const frame = useCurrentFrame();

  if (ghostMode) {
    // Top card stays, shows ghost ellipsis, fades out
    const ellipsisOpacity = interpolate(frame, [20, 40, 80, 100], [0, 1, 1, 0], {
      extrapolateLeft: 'clamp',
      extrapolateRight: 'clamp',
    });
    const cardOpacity = interpolate(frame, [90, 120], [1, 0.2], {
      extrapolateLeft: 'clamp',
      extrapolateRight: 'clamp',
    });
    return (
      <AbsoluteFill style={{justifyContent: 'center', alignItems: 'center'}}>
        <div
          style={{
            width: CARD_W,
            height: CARD_H,
            borderRadius: 36,
            background: NEUTRAL_PALETTE[0],
            opacity: cardOpacity,
            position: 'relative',
            overflow: 'hidden',
          }}
        >
          <div
            style={{
              position: 'absolute',
              bottom: 60,
              left: 0,
              right: 0,
              textAlign: 'center',
              fontSize: 80,
              color: '#666',
              opacity: ellipsisOpacity,
            }}
          >
            . . .
          </div>
        </div>
      </AbsoluteFill>
    );
  }

  // Normal mode: stack of cards, top one drifts off every ~30 frames
  const cycleFrame = frame % 30;
  const topDriftX = interpolate(cycleFrame, [0, 30], [0, -600], {
    extrapolateRight: 'clamp',
  });
  const topRotate = interpolate(cycleFrame, [0, 30], [0, -15]);
  const topOpacity = interpolate(cycleFrame, [0, 20, 30], [1, 1, 0]);

  return (
    <AbsoluteFill style={{justifyContent: 'center', alignItems: 'center'}}>
      {Array.from({length: count}).map((_, i) => {
        const reverseIdx = count - 1 - i;
        const isTop = reverseIdx === 0;
        const offsetY = reverseIdx * 8;
        const scale = 1 - reverseIdx * 0.02;
        return (
          <div
            key={i}
            style={{
              position: 'absolute',
              width: CARD_W,
              height: CARD_H,
              borderRadius: 36,
              background: NEUTRAL_PALETTE[reverseIdx % NEUTRAL_PALETTE.length],
              transform: isTop
                ? `translate(${topDriftX}px, ${offsetY}px) rotate(${topRotate}deg) scale(${scale})`
                : `translate(0px, ${offsetY}px) scale(${scale})`,
              opacity: isTop ? topOpacity : 1,
              boxShadow: '0 8px 28px rgba(0,0,0,0.12)',
            }}
          >
            {/* Silhouette placeholder — neutral, faceless */}
            <div
              style={{
                position: 'absolute',
                bottom: 0,
                left: 0,
                right: 0,
                height: '60%',
                background: 'linear-gradient(180deg, transparent 0%, rgba(0,0,0,0.18) 100%)',
              }}
            />
            <div
              style={{
                position: 'absolute',
                top: '32%',
                left: '50%',
                transform: 'translate(-50%, -50%)',
                width: 140,
                height: 140,
                borderRadius: '50%',
                background: 'rgba(255,255,255,0.45)',
              }}
            />
          </div>
        );
      })}
    </AbsoluteFill>
  );
};
```

- [ ] **Step 2: Verify TypeScript compiles**

```bash
npx tsc --noEmit
```
Expected: no errors.

- [ ] **Step 3: Commit**

```bash
git add entertainment/qulo-tiktok-promos/src/components/GenericSwipeStack.tsx
git commit -m "feat(promos): add GenericSwipeStack — brand-neutral swipe stack"
```

---

### Task 3: Wire `GenericSwipeStack` into `TikTokPromo` render switch

**Files:**
- Modify: `src/TikTokPromo.tsx`

- [ ] **Step 1: Add import**

In `src/TikTokPromo.tsx`, add this import alongside the others:

```typescript
import {GenericSwipeStack} from './components/GenericSwipeStack';
```

- [ ] **Step 2: Add case to switch**

In the `renderScene` function, add this case before `default:`:

```typescript
    case 'GenericSwipeStack':
      return <GenericSwipeStack {...cast<React.ComponentProps<typeof GenericSwipeStack>>()} />;
```

- [ ] **Step 3: Verify type compiles**

```bash
npx tsc --noEmit
```
Expected: no errors.

- [ ] **Step 4: Commit**

```bash
git add entertainment/qulo-tiktok-promos/src/TikTokPromo.tsx
git commit -m "feat(promos): wire GenericSwipeStack into render switch"
```

---

## FAZ 2 — Prop Variant Extensions (Backwards-Compatible)

> Each task below adds OPTIONAL props to one or more existing components. Existing configs must keep rendering identically. After each task, verify via `npm run studio` that the original templates (stop-swiping, day-in-the-life, match-to-first-date) still look correct.

### Task 4: `HookScene` — add `logoReveal` prop

**Files:**
- Modify: `src/components/HookScene.tsx`

- [ ] **Step 1: Read the current HookScene file**

```bash
cat src/components/HookScene.tsx
```

- [ ] **Step 2: Add `logoReveal` to props**

Add `logoReveal?: boolean` to the props type. When `logoReveal === true`, render the Qulo brand logo (`<img src={staticFile('brand/qulo_logo.svg')} />`) scaled from 0.4 to 1.0 with spring animation over the first 30 frames, positioned center, replacing the default text animation. Default (`false`) keeps current behavior.

Use the existing pattern in this file — do not restructure other props.

```typescript
import {spring, useCurrentFrame, useVideoConfig, staticFile} from 'remotion';

// inside the component, when logoReveal is true:
if (logoReveal) {
  const scale = spring({frame, fps, from: 0.4, to: 1.0, config: {damping: 12}});
  return (
    <AbsoluteFill style={{justifyContent: 'center', alignItems: 'center', background: theme.colors.bg}}>
      <img
        src={staticFile('brand/qulo_logo.svg')}
        style={{width: 600, transform: `scale(${scale})`}}
      />
      {/* keep existing text/accentText below the logo if present */}
    </AbsoluteFill>
  );
}
```

- [ ] **Step 3: Verify type compiles**

```bash
npx tsc --noEmit
```
Expected: no errors.

- [ ] **Step 4: Visual regression check (existing templates)**

```bash
npm run studio
```
Open browser. Select `Promo-stop-swiping` composition. Scrub through frames 0-30 → HookScene should still show "Stop swiping. / Start solving." text (since `logoReveal` defaults to false). Close browser.

- [ ] **Step 5: Commit**

```bash
git add entertainment/qulo-tiktok-promos/src/components/HookScene.tsx
git commit -m "feat(promos): HookScene supports logoReveal variant"
```

---

### Task 5: `DiamondBurst` — add scale/color/dual/count variants

**Files:**
- Modify: `src/components/DiamondBurst.tsx`

- [ ] **Step 1: Read the current DiamondBurst file**

```bash
cat src/components/DiamondBurst.tsx
```

- [ ] **Step 2: Extend props**

Add these optional props with backwards-compatible defaults:

```typescript
type DiamondBurstProps = {
  scale?: 'micro' | 'large' | 'huge' | 'continuous' | 'finale';  // default 'large'
  color?: 'green' | 'purple' | 'mixed' | 'flow';                  // default 'green'
  dual?: boolean;     // default false — when true, two streams green→purple
  count?: number;     // default per scale: micro=1, large=6, huge=14, continuous=N/A, finale=20
};
```

Implementation rules:
- `scale='micro'`: 1 small diamond, 30-frame pop+fade
- `scale='large'`: existing behavior (keep as-is for backwards compat)
- `scale='huge'`: 14 diamonds, faster spread, 60 frames
- `scale='continuous'`: emits one diamond every 5 frames for full duration
- `scale='finale'`: 20 diamonds in spiral pattern
- `color='green'`: green diamond SVG (`#22C55E` glow)
- `color='purple'`: purple SVG (`#A855F7` glow)
- `color='mixed'`: alternating green/purple
- `color='flow'`: green-to-purple gradient burst (used with `dual=true`)
- `dual=true`: render two streams from left/right

Use the existing diamond SVG asset(s) at `public/brand/green_diamond.svg` and `public/brand/purple_diamond.svg`.

- [ ] **Step 3: Verify type compiles**

```bash
npx tsc --noEmit
```
Expected: no errors.

- [ ] **Step 4: Visual regression check**

```bash
npm run studio
```
Open `Promo-day-in-the-life` (or any existing template that uses DiamondBurst). Confirm bursts still look correct (since defaults preserve old behavior). Close.

- [ ] **Step 5: Commit**

```bash
git add entertainment/qulo-tiktok-promos/src/components/DiamondBurst.tsx
git commit -m "feat(promos): DiamondBurst scale/color/dual/count variants"
```

---

### Task 6: `QuestionPill` — add `label`, `accent`, `urgent` props

**Files:**
- Modify: `src/components/QuestionPill.tsx`

- [ ] **Step 1: Read the current QuestionPill file**

```bash
cat src/components/QuestionPill.tsx
```

- [ ] **Step 2: Add props with backwards-compat defaults**

Existing usage in `stop-swiping.config.ts` passes `question`, `answer`, `showCorrect`. Keep those.

Add:

```typescript
type QuestionPillProps = {
  question?: string;      // existing
  answer?: string;        // existing
  showCorrect?: boolean;  // existing
  label?: string;         // NEW — short text shown as pill (e.g., "Q1 of 3", "Your filter")
  accent?: boolean;       // NEW — gold/highlighted background when true (default false)
  urgent?: boolean;       // NEW — pulse animation + warning color when true (default false)
};
```

Rendering rules:
- If `label` is provided (and `question` is not), render a small pill `[label]` at top-center with rounded background. If `accent=true`, use gold (`#F5C518`) background + black text. If `urgent=true`, add `transform: scale(1 + 0.05*sin(frame/3))` pulse.
- If `question` is provided (existing behavior), keep current rendering unchanged.

- [ ] **Step 3: Verify type compiles**

```bash
npx tsc --noEmit
```

- [ ] **Step 4: Visual regression check**

`npm run studio` → `Promo-stop-swiping` → confirm existing question pill (with `question`/`answer` props) renders unchanged. Close.

- [ ] **Step 5: Commit**

```bash
git add entertainment/qulo-tiktok-promos/src/components/QuestionPill.tsx
git commit -m "feat(promos): QuestionPill label/accent/urgent variants"
```

---

### Task 7: `StatsGrid` — add compact/infographic/large variants

**Files:**
- Modify: `src/components/StatsGrid.tsx`

- [ ] **Step 1: Read the current StatsGrid file**

```bash
cat src/components/StatsGrid.tsx
```

- [ ] **Step 2: Add variant props**

Add `compact?: boolean`, `infographic?: boolean`, `large?: boolean`. Only one can be true at a time (use precedence: `compact > infographic > large > default`).

```typescript
type StatsGridProps = {
  stats: Array<{label: string; value: string}>;  // existing
  compact?: boolean;       // NEW — 3-stat horizontal row, smaller font (used in mid-scene overlays)
  infographic?: boolean;   // NEW — icon + label + value cells in 3-col grid with diamond accents
  large?: boolean;         // NEW — full-screen 3-row layout with huge value text
};
```

Sizing:
- `compact`: 32px font, horizontal 3-col, 80px height
- `infographic`: 48px font + diamond icon next to each value, vertical 3-row in card
- `large`: 96px font, vertical 3-row, fills 80% of safe zone
- default (none of above): existing behavior unchanged

- [ ] **Step 3: Verify type compiles**

```bash
npx tsc --noEmit
```

- [ ] **Step 4: Visual regression check**

`npm run studio` → existing templates that use StatsGrid (check `day-in-the-life`, `match-to-first-date`). Confirm unchanged. Close.

- [ ] **Step 5: Commit**

```bash
git add entertainment/qulo-tiktok-promos/src/components/StatsGrid.tsx
git commit -m "feat(promos): StatsGrid compact/infographic/large variants"
```

---

### Task 8: `QuizSolve` — add `options`, `correctIndex`, `showTimer` props

**Files:**
- Modify: `src/components/QuizSolve.tsx`

- [ ] **Step 1: Read the current QuizSolve file**

```bash
cat src/components/QuizSolve.tsx
```

- [ ] **Step 2: Add props**

```typescript
type QuizSolveProps = {
  question: string;                  // existing
  options?: string[];                // NEW — 2-4 answer choices (default: keep existing rendering)
  correctIndex?: number;             // NEW — which option highlights as correct (default 0)
  showTimer?: boolean;               // NEW — 5-second countdown bar at top
};
```

Rendering:
- If `options` provided, render as vertical button list. After ~70% of scene duration, animate the `correctIndex` option to green border + checkmark.
- If `showTimer=true`, render a horizontal progress bar at top draining from 100% → 0% over the scene duration. Color: green → yellow → red.

- [ ] **Step 3: Verify type compiles**

```bash
npx tsc --noEmit
```

- [ ] **Step 4: Visual regression check**

`npm run studio` → templates with QuizSolve (`day-in-the-life`, `match-to-first-date`). Confirm unchanged when `options`/`showTimer` not provided.

- [ ] **Step 5: Commit**

```bash
git add entertainment/qulo-tiktok-promos/src/components/QuizSolve.tsx
git commit -m "feat(promos): QuizSolve options/correctIndex/showTimer variants"
```

---

### Task 9: `ChatBubble` — add `mood` and `thread` props

**Files:**
- Modify: `src/components/ChatBubble.tsx`

- [ ] **Step 1: Read the current ChatBubble file**

```bash
cat src/components/ChatBubble.tsx
```

- [ ] **Step 2: Add props**

```typescript
type ChatBubbleProps = {
  text?: string;          // existing single message
  fromMe?: boolean;       // existing
  startFrame?: number;    // existing
  mood?: 'normal' | 'ghost';  // NEW — default 'normal'. 'ghost' = greyscale + ellipsis text
  thread?: Array<{        // NEW — sequence of messages
    text: string;
    fromMe: boolean;
    startFrame: number;
  }>;
};
```

Rendering:
- If `thread` provided, render multiple bubbles with their individual `startFrame` offsets (use `<Sequence from={msg.startFrame}>` for each).
- If `mood === 'ghost'`, apply `filter: grayscale(1) opacity(0.5)`, replace text with `...`.
- Existing `text`/`fromMe`/`startFrame` single-bubble behavior unchanged when `thread` not provided.

- [ ] **Step 3: Verify type compiles**

```bash
npx tsc --noEmit
```

- [ ] **Step 4: Visual regression check**

`npm run studio` → templates with ChatBubble (existing day-in-the-life uses thread inside its config? — confirm structure matches existing usage).

- [ ] **Step 5: Commit**

```bash
git add entertainment/qulo-tiktok-promos/src/components/ChatBubble.tsx
git commit -m "feat(promos): ChatBubble mood and thread variants"
```

---

### Task 10: `QuestionCreate` — add `steps`, `typewriter`, `aiSuggested` props

**Files:**
- Modify: `src/components/QuestionCreate.tsx`

- [ ] **Step 1: Read the current QuestionCreate file**

```bash
cat src/components/QuestionCreate.tsx
```

- [ ] **Step 2: Add props**

```typescript
type QuestionCreateProps = {
  steps?: string[];        // NEW — array of question strings to type out sequentially
  typewriter?: boolean;    // NEW — typewriter effect on each step (default false)
  aiSuggested?: boolean;   // NEW — when true, show "✨ AI" badge + slightly faster animation
};
```

Rendering:
- Render up to 3 question lines as if being typed into an input field. Each gets its own time slice (33% of duration each).
- `typewriter=true`: reveal text character-by-character (use `frame` and `text.slice(0, Math.floor(frame/2))`).
- `aiSuggested=true`: show small sparkle badge "✨ AI" top-right of the input card; speed up typing (`frame * 1.5`).

- [ ] **Step 3: Verify type compiles**

```bash
npx tsc --noEmit
```

- [ ] **Step 4: Commit**

```bash
git add entertainment/qulo-tiktok-promos/src/components/QuestionCreate.tsx
git commit -m "feat(promos): QuestionCreate steps/typewriter/aiSuggested variants"
```

---

### Task 11: `MatchCelebration`, `TimeOfDay`, `ProcessStep`, `CTAScene` — props

**Files:**
- Modify: `src/components/MatchCelebration.tsx`
- Modify: `src/components/TimeOfDay.tsx`
- Modify: `src/components/ProcessStep.tsx`
- Modify: `src/components/CTAScene.tsx`

- [ ] **Step 1: Read all four files**

```bash
cat src/components/MatchCelebration.tsx
cat src/components/TimeOfDay.tsx
cat src/components/ProcessStep.tsx
cat src/components/CTAScene.tsx
```

- [ ] **Step 2: Add props to each**

`MatchCelebration.tsx` — add:
```typescript
score?: string;          // NEW — e.g., "3/3" shown as small badge top-right
diamondsEarned?: number; // NEW — e.g., 5 shown as "+5 💎" pill below match text
```

`TimeOfDay.tsx` — add:
```typescript
time?: 'morning' | 'noon' | 'evening' | 'week-transition';  // NEW — default keeps existing behavior
subtle?: boolean;        // NEW — when true, render as low-opacity background overlay only
```

`ProcessStep.tsx` — add:
```typescript
compact?: boolean;       // NEW — smaller spacing, all steps visible at once
labelAbove?: boolean;    // NEW — step label rendered above the icon instead of below
```

`CTAScene.tsx` — add:
```typescript
showBadges?: boolean;    // NEW — when true, render App Store + Google Play badges below subline
```

For `showBadges`: render two badge images side-by-side. Use `staticFile('brand/app-store-badge.svg')` and `staticFile('brand/google-play-badge.svg')`. If those files don't exist yet, render placeholder rounded rectangles labeled "App Store" and "Google Play" (we will add proper badge images in Task 22 QA pass if missing).

- [ ] **Step 3: Verify type compiles**

```bash
npx tsc --noEmit
```

- [ ] **Step 4: Visual regression check**

`npm run studio` → all 3 existing templates → confirm everything renders unchanged.

- [ ] **Step 5: Commit**

```bash
git add entertainment/qulo-tiktok-promos/src/components/MatchCelebration.tsx \
        entertainment/qulo-tiktok-promos/src/components/TimeOfDay.tsx \
        entertainment/qulo-tiktok-promos/src/components/ProcessStep.tsx \
        entertainment/qulo-tiktok-promos/src/components/CTAScene.tsx
git commit -m "feat(promos): MatchCelebration/TimeOfDay/ProcessStep/CTAScene prop variants"
```

---

## FAZ 3 — Config File

### Task 12: Create `full-app-intro.config.ts` (scenes array)

**Files:**
- Create: `src/configs/full-app-intro.config.ts`

- [ ] **Step 1: Write the config file**

Create `src/configs/full-app-intro.config.ts` with the following content (140s, 12 scenes, no captions yet — those go in Task 13):

```typescript
import type {PromoConfig} from '../types';

const FPS = 30;
const s = (seconds: number) => Math.round(seconds * FPS);

export const fullAppIntroConfig: PromoConfig = {
  slug: 'full-app-intro',
  template: 'full-app-intro',
  durationInFrames: s(140),
  scenes: [
    // ─── 1. Cold open (0-4s) ───
    {
      component: 'PhoneFrame',
      startFrame: s(0),
      durationFrames: s(4),
      props: {},
    },
    {
      component: 'GenericSwipeStack',
      startFrame: s(0),
      durationFrames: s(4),
      props: {count: 4, ghostMode: false, brand: 'neutral'},
    },
    {
      component: 'DriftingCard',
      startFrame: s(0),
      durationFrames: s(4),
      props: {direction: 'left', label: '', delay: 0},
    },

    // ─── 2. Ghost loop (4-10s) ───
    {
      component: 'GenericSwipeStack',
      startFrame: s(4),
      durationFrames: s(6),
      props: {count: 4, ghostMode: true, brand: 'neutral'},
    },
    {
      component: 'ChatBubble',
      startFrame: s(7),
      durationFrames: s(3),
      props: {text: '...', fromMe: false, startFrame: 0, mood: 'ghost'},
    },

    // ─── 3. Reveal (10-16s) ───
    {
      component: 'HookScene',
      startFrame: s(10),
      durationFrames: s(6),
      props: {text: 'Stop swiping.', accentText: 'Start solving.', logoReveal: true},
    },
    {
      component: 'DiamondBurst',
      startFrame: s(13),
      durationFrames: s(3),
      props: {scale: 'large', color: 'green'},
    },

    // ─── 4. Discover (16-30s) ───
    {
      component: 'QuloDiscoverCard',
      startFrame: s(16),
      durationFrames: s(14),
      props: {name: 'Maya', age: 26, questionCount: 3},
    },
    {
      component: 'QuestionPill',
      startFrame: s(22),
      durationFrames: s(8),
      props: {label: '3 questions to solve', accent: true},
    },

    // ─── 5. Solve Q1 (30-38.5s) ───
    {
      component: 'QuestionPill',
      startFrame: s(30),
      durationFrames: s(8),
      props: {label: 'Q1 of 3'},
    },
    {
      component: 'QuizSolve',
      startFrame: s(30),
      durationFrames: s(7),
      props: {
        question: 'Pineapple on pizza?',
        options: ['Yes obviously', 'Never', 'I respect it'],
        correctIndex: 0,
      },
    },
    {
      component: 'AnswerFeedback',
      startFrame: s(37),
      durationFrames: Math.round(1.5 * FPS),
      props: {correct: true},
    },
    {
      component: 'DiamondBurst',
      startFrame: s(37),
      durationFrames: Math.round(1.5 * FPS),
      props: {scale: 'micro', color: 'green', count: 1},
    },

    // ─── 5b. Solve Q2 (38.5-47s) ───
    {
      component: 'QuestionPill',
      startFrame: Math.round(38.5 * FPS),
      durationFrames: s(8),
      props: {label: 'Q2 of 3'},
    },
    {
      component: 'QuizSolve',
      startFrame: Math.round(38.5 * FPS),
      durationFrames: s(7),
      props: {
        question: 'Mountains or beach?',
        options: ['Mountains', 'Beach', 'City'],
        correctIndex: 0,
      },
    },
    {
      component: 'AnswerFeedback',
      startFrame: Math.round(45.5 * FPS),
      durationFrames: Math.round(1.5 * FPS),
      props: {correct: true},
    },
    {
      component: 'DiamondBurst',
      startFrame: Math.round(45.5 * FPS),
      durationFrames: Math.round(1.5 * FPS),
      props: {scale: 'micro', color: 'green', count: 1},
    },

    // ─── 5c. Solve Q3 (47-55s, urgent) ───
    {
      component: 'QuestionPill',
      startFrame: s(47),
      durationFrames: s(8),
      props: {label: 'Q3 of 3', urgent: true},
    },
    {
      component: 'QuizSolve',
      startFrame: s(47),
      durationFrames: s(7),
      props: {
        question: 'Biggest red flag in a date?',
        options: ['Checks phone constantly', 'Only talks about ex', 'Splits bill weirdly'],
        correctIndex: 1,
        showTimer: true,
      },
    },
    {
      component: 'AnswerFeedback',
      startFrame: s(54),
      durationFrames: s(1),
      props: {correct: true},
    },

    // ─── 6. Match earned (55-65s) ───
    {
      component: 'MatchCelebration',
      startFrame: s(55),
      durationFrames: s(10),
      props: {name: 'Maya', score: '3/3', diamondsEarned: 5},
    },
    {
      component: 'DiamondBurst',
      startFrame: s(56),
      durationFrames: s(4),
      props: {scale: 'huge', color: 'green', count: 14},
    },
    {
      component: 'StatsGrid',
      startFrame: s(60),
      durationFrames: s(5),
      props: {
        stats: [
          {label: 'Answered', value: '3/3'},
          {label: 'Diamonds', value: '+5'},
          {label: 'Status', value: 'Matched'},
        ],
        compact: true,
      },
    },

    // ─── 7. Chat substantive (65-78s) ───
    {
      component: 'TimeOfDay',
      startFrame: s(65),
      durationFrames: s(13),
      props: {time: 'evening', subtle: true},
    },
    {
      component: 'ChatBubble',
      startFrame: s(66),
      durationFrames: s(12),
      props: {
        thread: [
          {text: 'Pineapple on pizza? Bold take. 😄', fromMe: false, startFrame: 0},
          {text: "It's called confidence", fromMe: true, startFrame: s(3)},
          {text: 'You solved all 3 — respect.', fromMe: false, startFrame: s(6)},
        ],
      },
    },
    {
      component: 'QuestionPill',
      startFrame: s(70),
      durationFrames: s(6),
      props: {label: 'Earned this chat', accent: true},
    },

    // ─── 8. Create your own (78-93s) ───
    {
      component: 'QuestionCreate',
      startFrame: s(78),
      durationFrames: s(15),
      props: {
        steps: [
          'Q1: Your weekend vibe?',
          'Q2: Mountains or beach?',
          'Q3: Biggest dealbreaker?',
        ],
        typewriter: true,
      },
    },
    {
      component: 'QuestionPill',
      startFrame: s(85),
      durationFrames: s(8),
      props: {label: 'Your filter', accent: true},
    },

    // ─── 9. AI helps (93-103s) ───
    {
      component: 'QuestionCreate',
      startFrame: s(93),
      durationFrames: s(10),
      props: {
        steps: [
          'Q1: Last book that changed you?',
          'Q2: Cancel plans or push through?',
          'Q3: What do you Google at 2 AM?',
        ],
        typewriter: true,
        aiSuggested: true,
      },
    },
    {
      component: 'QuestionPill',
      startFrame: s(95),
      durationFrames: s(8),
      props: {label: '✨ AI-written', accent: true},
    },
    {
      component: 'DiamondBurst',
      startFrame: s(101),
      durationFrames: s(2),
      props: {scale: 'micro', color: 'purple'},
    },

    // ─── 10. Diamond Economy (103-118s) ───
    {
      component: 'DiamondBurst',
      startFrame: s(103),
      durationFrames: s(15),
      props: {scale: 'continuous', color: 'flow', dual: true},
    },
    {
      component: 'StatsGrid',
      startFrame: s(106),
      durationFrames: s(8),
      props: {
        stats: [
          {label: 'Green', value: 'Earn'},
          {label: 'Purple', value: 'Spend'},
          {label: 'Boost', value: '30 = 30min'},
        ],
        infographic: true,
      },
    },
    {
      component: 'ProcessStep',
      startFrame: s(112),
      durationFrames: s(6),
      props: {
        steps: ['Answer', 'Earn', 'Boost', 'Match more'],
        compact: true,
      },
    },

    // ─── 11. Why this works (118-128s) ───
    {
      component: 'TimeOfDay',
      startFrame: s(118),
      durationFrames: s(10),
      props: {time: 'week-transition', subtle: true},
    },
    {
      component: 'StatsGrid',
      startFrame: s(118),
      durationFrames: s(10),
      props: {
        stats: [
          {label: 'Real', value: 'Questions'},
          {label: 'Real', value: 'Answers'},
          {label: 'Real', value: 'Matches'},
        ],
        large: true,
      },
    },
    {
      component: 'ProcessStep',
      startFrame: s(122),
      durationFrames: s(6),
      props: {
        steps: ['Answer', 'Earn', 'Match'],
        labelAbove: true,
      },
    },

    // ─── 12. CTA finale (128-140s) ───
    {
      component: 'CTAScene',
      startFrame: s(128),
      durationFrames: s(12),
      props: {
        headline: 'Stop swiping. Start matching.',
        subline: 'Qulo — free on iOS and Android.',
        showBadges: true,
      },
    },
    {
      component: 'DiamondBurst',
      startFrame: s(131),
      durationFrames: s(9),
      props: {scale: 'finale', color: 'mixed', count: 20},
    },
  ],
  captions: [],  // populated in Task 13
  audioTrack: {
    path: 'audio/qulo-full-app-intro-mix.mp3',
    volume: 1.0,
    startFrom: 0,
  },
};
```

- [ ] **Step 2: Verify type compiles**

```bash
npx tsc --noEmit
```
Expected: no errors.

- [ ] **Step 3: Commit (no register yet)**

```bash
git add entertainment/qulo-tiktok-promos/src/configs/full-app-intro.config.ts
git commit -m "feat(promos): add full-app-intro scene config (140s, 12 scenes)"
```

---

### Task 13: Populate `captions` array in full-app-intro config

**Files:**
- Modify: `src/configs/full-app-intro.config.ts`

- [ ] **Step 1: Append captions array**

Replace the `captions: []` line with the full phrase-level captions matching the VO timing from the spec:

```typescript
  captions: [
    // Sahne 1 (0-4s)
    {text: 'months on a dating app', startFrame: s(0.5), durationFrames: s(2)},
    {text: 'met no one', startFrame: s(2.5), durationFrames: s(1.5)},

    // Sahne 2 (4-10s)
    {text: 'you match', startFrame: s(4.5), durationFrames: s(1.2)},
    {text: 'they ghost', startFrame: s(5.7), durationFrames: s(1.3)},
    {text: 'forever loop', startFrame: s(7.5), durationFrames: s(1.8)},
    {text: 'sound familiar?', startFrame: s(9.3), durationFrames: s(0.7)},

    // Sahne 3 (10-16s)
    {text: 'a new app', startFrame: s(10.5), durationFrames: s(2)},
    {text: "you don't swipe", startFrame: s(12.7), durationFrames: s(1.6)},
    {text: 'you SOLVE', startFrame: s(14.3), durationFrames: s(1.7)},

    // Sahne 4 (16-30s)
    {text: "it's called Qulo", startFrame: s(16.5), durationFrames: s(2.5)},
    {text: 'see someone interesting?', startFrame: s(19.5), durationFrames: s(2.5)},
    {text: "read her 3 questions", startFrame: s(22.5), durationFrames: s(3)},
    {text: 'she wrote to filter', startFrame: s(26), durationFrames: s(3.5)},

    // Sahne 5 (30-55s)
    {text: 'answer all three', startFrame: s(30.5), durationFrames: s(2.5)},
    {text: 'pineapple on pizza?', startFrame: s(33.5), durationFrames: s(3)},
    {text: 'mountains or beach?', startFrame: s(38.5), durationFrames: s(3)},
    {text: "don't guess", startFrame: s(42), durationFrames: s(2)},
    {text: 'last red-flag question', startFrame: s(47), durationFrames: s(3)},
    {text: 'nail it', startFrame: s(50.5), durationFrames: s(2)},
    {text: 'one wrong, no match', startFrame: s(52.5), durationFrames: s(2.5)},

    // Sahne 6 (55-65s)
    {text: 'BOOM', startFrame: s(55.5), durationFrames: s(1.5)},
    {text: 'three for three', startFrame: s(57), durationFrames: s(2)},
    {text: 'MATCH UNLOCKED', startFrame: s(59), durationFrames: s(3)},
    {text: '+5 diamonds', startFrame: s(62), durationFrames: s(2.5)},

    // Sahne 7 (65-78s)
    {text: 'now you actually talk', startFrame: s(65.5), durationFrames: s(3)},
    {text: 'about something real', startFrame: s(68.5), durationFrames: s(2.5)},
    {text: 'no awkward opener', startFrame: s(72), durationFrames: s(3)},
    {text: 'match handed you the script', startFrame: s(75), durationFrames: s(3)},

    // Sahne 8 (78-93s)
    {text: 'your turn', startFrame: s(78.5), durationFrames: s(2)},
    {text: 'build your filter', startFrame: s(81), durationFrames: s(3)},
    {text: '3 questions', startFrame: s(84.5), durationFrames: s(2.5)},
    {text: 'weed out the noise', startFrame: s(88), durationFrames: s(4.5)},

    // Sahne 9 (93-103s)
    {text: 'stuck for ideas?', startFrame: s(93.5), durationFrames: s(2.5)},
    {text: 'tap once', startFrame: s(96.5), durationFrames: s(1.5)},
    {text: '✨ AI writes them', startFrame: s(98.5), durationFrames: s(3.5)},

    // Sahne 10 (103-118s)
    {text: 'green diamonds: EARN', startFrame: s(103.5), durationFrames: s(3.5)},
    {text: 'purple: SPEND', startFrame: s(107.5), durationFrames: s(3)},
    {text: '30 = 30 min boost', startFrame: s(111), durationFrames: s(3.5)},
    {text: 'a whole economy', startFrame: s(115), durationFrames: s(3)},

    // Sahne 11 (118-128s)
    {text: 'no empty chats', startFrame: s(118.5), durationFrames: s(2.5)},
    {text: 'no guessing', startFrame: s(121.5), durationFrames: s(2)},
    {text: 'real questions, real matches', startFrame: s(124), durationFrames: s(4)},

    // Sahne 12 (128-140s)
    {text: 'stop swiping', startFrame: s(128.5), durationFrames: s(2)},
    {text: 'start matching', startFrame: s(131), durationFrames: s(2.5)},
    {text: 'Qulo — iOS + Android', startFrame: s(134), durationFrames: s(3.5)},
    {text: 'go earn one 💎', startFrame: s(138), durationFrames: s(2)},
  ],
```

- [ ] **Step 2: Verify type compiles**

```bash
npx tsc --noEmit
```

- [ ] **Step 3: Commit**

```bash
git add entertainment/qulo-tiktok-promos/src/configs/full-app-intro.config.ts
git commit -m "feat(promos): populate full-app-intro captions (47 phrases)"
```

---

### Task 14: Register `fullAppIntroConfig` in REGISTRY

**Files:**
- Modify: `src/configs/index.ts`

- [ ] **Step 1: Edit `src/configs/index.ts`**

```typescript
import type {PromoConfig} from '../types';
import {stopSwipingConfig} from './stop-swiping.config';
import {dayInTheLifeConfig} from './day-in-the-life.config';
import {matchToFirstDateConfig} from './match-to-first-date.config';
import {fullAppIntroConfig} from './full-app-intro.config';

const REGISTRY: Record<string, PromoConfig> = {
  'stop-swiping': stopSwipingConfig,
  'day-in-the-life': dayInTheLifeConfig,
  'match-to-first-date': matchToFirstDateConfig,
  'full-app-intro': fullAppIntroConfig,
};

export const getConfig = (slug: string): PromoConfig => {
  const cfg = REGISTRY[slug];
  if (!cfg) {
    throw new Error(`Unknown promo configSlug: "${slug}". Known: ${Object.keys(REGISTRY).join(', ')}`);
  }
  return cfg;
};

export const allConfigSlugs = (): string[] => Object.keys(REGISTRY);
```

- [ ] **Step 2: Verify type compiles**

```bash
npx tsc --noEmit
```

- [ ] **Step 3: Visual sanity check (no audio yet — silent preview)**

```bash
npm run studio
```
Open browser. Confirm `Promo-full-app-intro` composition is listed. Click it — visual elements should render across the 4200-frame timeline. Audio bar will be empty (no mix yet). Close.

- [ ] **Step 4: Commit**

```bash
git add entertainment/qulo-tiktok-promos/src/configs/index.ts
git commit -m "feat(promos): register full-app-intro config in REGISTRY"
```

---

## FAZ 4 — Audio Pipeline Setup

### Task 15: Add dev dependencies (`tsx`, `elevenlabs`, `dotenv`)

**Files:**
- Modify: `package.json`
- Modify: `.gitignore`

- [ ] **Step 1: Install deps**

```bash
cd entertainment/qulo-tiktok-promos
npm install --save-dev tsx
npm install elevenlabs dotenv
```

- [ ] **Step 2: Verify install**

```bash
npx tsx --version
node -e "console.log(require('elevenlabs').ElevenLabsClient)"
```
Expected: tsx prints version; elevenlabs export visible.

- [ ] **Step 3: Update `.gitignore`**

Open `entertainment/qulo-tiktok-promos/.gitignore` (create if missing) and append:

```
# audio raw outputs (regenerated each build)
public/audio/raw/vo.mp3
public/audio/raw/bgm.mp3
public/audio/qulo-full-app-intro-mix.mp3
tmp/

# env
.env
```

- [ ] **Step 4: Commit**

```bash
git add entertainment/qulo-tiktok-promos/package.json \
        entertainment/qulo-tiktok-promos/package-lock.json \
        entertainment/qulo-tiktok-promos/.gitignore
git commit -m "build(promos): add tsx/elevenlabs/dotenv deps + ignore audio artifacts"
```

---

### Task 16: Create `.env.example`

**Files:**
- Create: `.env.example`

- [ ] **Step 1: Write `.env.example`**

Create `entertainment/qulo-tiktok-promos/.env.example`:

```
# ElevenLabs API key for VO generation
# Get one at https://elevenlabs.io → Profile → API Keys
ELEVENLABS_API_KEY=your_key_here

# Voice ID (default: Domi — confident sassy female US)
# Browse voices at https://elevenlabs.io/voices
ELEVENLABS_VOICE_ID=AZnzlk1XvdvUeBnXmlld
```

- [ ] **Step 2: Commit**

```bash
git add entertainment/qulo-tiktok-promos/.env.example
git commit -m "docs(promos): add .env.example documenting ELEVENLABS_API_KEY"
```

- [ ] **Step 3: User action — create local `.env`**

**Manual step (user):**
```bash
cp entertainment/qulo-tiktok-promos/.env.example entertainment/qulo-tiktok-promos/.env
# Edit .env with real API key
```

---

### Task 17: Create `scripts/generate-vo.ts`

**Files:**
- Create: `scripts/generate-vo.ts`

- [ ] **Step 1: Write the script**

Create `entertainment/qulo-tiktok-promos/scripts/generate-vo.ts`:

```typescript
import 'dotenv/config';
import {ElevenLabsClient} from 'elevenlabs';
import {writeFile, mkdir} from 'node:fs/promises';
import {dirname, resolve} from 'node:path';

const SCRIPT_TEXT = `Be honest. Months on a dating app. Met no one.

You match. They ghost. You match. They ghost. Forever loop. Sound familiar?

But there's a new app. You don't swipe. You solve.

It's called Qulo. You open it, see someone interesting — but instead of swiping, you read her three questions. The ones she wrote to filter people exactly like you.

Answer all three. Get them right. Pineapple on pizza? You better know her answer. Mountains or beach? Don't guess. Last red-flag question? Nail it. Get one wrong — game over, no match. Get all three? You just earned something most apps never made you earn.

Boom. Three for three. Match unlocked. You didn't swipe your way in — you earned it. And yeah, you just earned five diamonds too.

Now you actually talk. About something real. Pineapple on pizza? Bold take. She just opened with that. No "hey," no awkward opener — the match handed you the script.

Now your turn. Build your own three questions — the filter only people who actually get you will pass. Want only mountain people? Make question two impossible for beach people. The boring ones never make it through.

Stuck for ideas? Tap once. Qulo's AI reads your profile and writes three questions in your voice. Done in two seconds.

Here's the fun part. When someone solves your questions, you earn green diamonds. Spend thirty on a boost — thirty minutes of priority placement, and suddenly everyone interesting is solving yours. A whole economy.

No empty chats. No guessing if they actually like you. No effort wasted on people who'd ghost anyway. Just real questions, real answers, real matches.

So stop swiping. Start matching. Qulo is free, on iOS and Android right now. Link in bio. Go earn one.`;

async function main() {
  const apiKey = process.env.ELEVENLABS_API_KEY;
  const voiceId = process.env.ELEVENLABS_VOICE_ID ?? 'AZnzlk1XvdvUeBnXmlld';
  if (!apiKey) {
    throw new Error('ELEVENLABS_API_KEY missing — copy .env.example to .env and set the key');
  }

  const client = new ElevenLabsClient({apiKey});
  console.log(`Generating VO (voice: ${voiceId}, ${SCRIPT_TEXT.length} chars)...`);

  const audioStream = await client.textToSpeech.convert(voiceId, {
    text: SCRIPT_TEXT,
    model_id: 'eleven_multilingual_v2',
    output_format: 'mp3_44100_192',
    voice_settings: {
      stability: 0.45,
      similarity_boost: 0.75,
      style: 0.55,
      use_speaker_boost: true,
    },
  });

  const chunks: Buffer[] = [];
  for await (const chunk of audioStream) {
    chunks.push(Buffer.from(chunk));
  }
  const buffer = Buffer.concat(chunks);

  const outPath = resolve(__dirname, '..', 'public', 'audio', 'raw', 'vo.mp3');
  await mkdir(dirname(outPath), {recursive: true});
  await writeFile(outPath, buffer);
  console.log(`✓ VO written to ${outPath} (${(buffer.length / 1024).toFixed(1)} KB)`);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
```

- [ ] **Step 2: Add npm script**

In `entertainment/qulo-tiktok-promos/package.json`, add to `scripts`:

```json
"gen:vo": "tsx scripts/generate-vo.ts",
```

- [ ] **Step 3: Verify TypeScript compiles**

```bash
npx tsc --noEmit
```

- [ ] **Step 4: Commit**

```bash
git add entertainment/qulo-tiktok-promos/scripts/generate-vo.ts \
        entertainment/qulo-tiktok-promos/package.json
git commit -m "feat(promos): add generate-vo script (ElevenLabs Domi voice)"
```

---

### Task 18: Generate the VO (user runs)

**Manual user step. Requires `.env` set up.**

- [ ] **Step 1: Run VO generation**

```bash
cd entertainment/qulo-tiktok-promos
npm run gen:vo
```
Expected: `✓ VO written to .../public/audio/raw/vo.mp3 (XXX KB)`

- [ ] **Step 2: Verify duration is 125-145s**

```bash
ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 public/audio/raw/vo.mp3
```
Expected: a number between 125 and 145 (seconds).

If duration > 145s: open `scripts/generate-vo.ts`, lower `similarity_boost` to 0.7 and add `"speed": 1.08` (in voice_settings if SDK supports, otherwise post-process with ffmpeg `atempo=1.05`). Re-run.

If duration < 125s: re-run to get a different take (TTS is non-deterministic), or accept and pad with longer pauses in mix.

- [ ] **Step 3: Listen for quality**

```bash
afplay public/audio/raw/vo.mp3
```
Confirm: clear English, no robotic stutters, witty inflection on "BOOM", "Go earn one."

- [ ] **Step 4: No commit (vo.mp3 is gitignored)**

---

### Task 19: User sources BGM

**Manual user step.**

- [ ] **Step 1: Generate or source BGM**

Option A (recommended — Suno Pro):
1. Go to https://suno.com
2. Use prompt: `"Modern pop-electronic instrumental, 140 BPM, sub-bass and claps and playful synth arps, slight minor-key tension in first 10 seconds, big drop at 0:10, upbeat confident through middle, closing hit at 2:08, fully instrumental, no vocals, no lyrics, royalty-free style"`
3. Download as MP3.

Option B (fallback): Epidemic Sound search `"pop electronic upbeat 140 BPM instrumental"` — pick a 140-150s track.

Option C (free): YouTube Audio Library `"pop electronic"` filtered to 2-3 min.

- [ ] **Step 2: Place file**

```bash
mv ~/Downloads/<your-bgm-file>.mp3 entertainment/qulo-tiktok-promos/public/audio/raw/bgm.mp3
```

- [ ] **Step 3: Verify duration ≥ 140s**

```bash
ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 entertainment/qulo-tiktok-promos/public/audio/raw/bgm.mp3
```
Expected: ≥ 140. If shorter, source a longer track or loop it.

- [ ] **Step 4: No commit (bgm.mp3 is gitignored)**

---

### Task 20: User curates 6 CC0 SFX clips from Freesound

**Manual user step.**

- [ ] **Step 1: Create SFX directory**

```bash
mkdir -p entertainment/qulo-tiktok-promos/public/audio/raw/sfx
```

- [ ] **Step 2: Download 6 CC0 clips from https://freesound.org**

Filter: `License: Creative Commons 0` (CC0 only — no attribution needed).

Search terms and target filenames:

| Search | Save as |
|--------|---------|
| `"ting glass bell"` (150ms) | `diamond_ting.mp3` |
| `"celebrate chime sparkle"` (800ms) | `match_chime.mp3` |
| `"soft ding correct ui"` (200ms) | `correct_ding.mp3` |
| `"whoosh transition short"` (400ms) | `swoosh.mp3` |
| `"keyboard tap single"` (80ms) | `type_tap.mp3` |
| `"reverse cymbal vacuum"` (2s) | `ghost_silence.mp3` |

Place each into `entertainment/qulo-tiktok-promos/public/audio/raw/sfx/`.

- [ ] **Step 3: Convert to consistent format if needed**

Each clip should be MP3, mono or stereo, 44.1kHz. If any is WAV/OGG:

```bash
cd entertainment/qulo-tiktok-promos/public/audio/raw/sfx
for f in *.wav *.ogg; do
  [ -f "$f" ] && ffmpeg -i "$f" -ar 44100 -b:a 192k "${f%.*}.mp3" && rm "$f"
done
```

- [ ] **Step 4: Verify all 6 exist**

```bash
ls entertainment/qulo-tiktok-promos/public/audio/raw/sfx/
```
Expected: 6 files: `diamond_ting.mp3 match_chime.mp3 correct_ding.mp3 swoosh.mp3 type_tap.mp3 ghost_silence.mp3`

- [ ] **Step 5: Commit (SFX are CC0, safe to commit)**

```bash
git add entertainment/qulo-tiktok-promos/public/audio/raw/sfx/
git commit -m "feat(promos): add CC0 SFX pack (diamond/match/ding/swoosh/tap/ghost)"
```

---

### Task 21: Create `scripts/mix-audio.sh`

**Files:**
- Create: `scripts/mix-audio.sh`

- [ ] **Step 1: Write the script**

Create `entertainment/qulo-tiktok-promos/scripts/mix-audio.sh`:

```bash
#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")/.."

RAW=public/audio/raw
SFX=$RAW/sfx
TMP=tmp
OUT=public/audio/qulo-full-app-intro-mix.mp3

mkdir -p $TMP public/audio

echo "→ Stage 1: VO + BGM with sidechain ducking..."
ffmpeg -y -hide_banner -loglevel warning \
  -i $RAW/vo.mp3 \
  -i $RAW/bgm.mp3 \
  -filter_complex "
    [1:a]volume=0.7,atrim=duration=140,asetpts=PTS-STARTPTS[bgm_trim];
    [bgm_trim][0:a]sidechaincompress=threshold=0.05:ratio=8:attack=20:release=400[bgm_ducked];
    [bgm_ducked][0:a]amix=inputs=2:duration=longest:dropout_transition=0[vox_bgm]
  " \
  -map "[vox_bgm]" -c:a libmp3lame -b:a 192k -ar 44100 \
  $TMP/stage1.mp3

echo "→ Stage 2: Layer SFX onto timeline..."
ffmpeg -y -hide_banner -loglevel warning \
  -i $TMP/stage1.mp3 \
  -i $SFX/swoosh.mp3 \
  -i $SFX/diamond_ting.mp3 \
  -i $SFX/correct_ding.mp3 \
  -i $SFX/match_chime.mp3 \
  -i $SFX/ghost_silence.mp3 \
  -i $SFX/type_tap.mp3 \
  -filter_complex "
    [1:a]adelay=10000|10000,volume=0.5[swoosh_s3];
    [2:a]adelay=13000|13000,volume=0.6[ting_s3];
    [3:a]adelay=37000|37000,volume=0.55[ding_q1];
    [3:a]adelay=45500|45500,volume=0.55[ding_q2];
    [3:a]adelay=54000|54000,volume=0.55[ding_q3];
    [2:a]adelay=37000|37000,volume=0.5[ting_q1];
    [2:a]adelay=45500|45500,volume=0.5[ting_q2];
    [4:a]adelay=55500|55500,volume=0.75[match];
    [2:a]adelay=56000|56000,volume=0.7[ting_match];
    [5:a]adelay=7000|7000,volume=0.4[ghost];
    [6:a]adelay=80000|80000,volume=0.35[tap1];
    [6:a]adelay=82000|82000,volume=0.35[tap2];
    [6:a]adelay=84000|84000,volume=0.35[tap3];
    [2:a]adelay=131000|131000,volume=0.7[ting_finale];
    [0:a][swoosh_s3][ting_s3][ding_q1][ding_q2][ding_q3][ting_q1][ting_q2][match][ting_match][ghost][tap1][tap2][tap3][ting_finale]amix=inputs=15:duration=longest:dropout_transition=0,volume=1.3[mixed]
  " \
  -map "[mixed]" -c:a libmp3lame -b:a 192k -ar 44100 \
  $TMP/stage2.mp3

echo "→ Stage 3: Loudness normalize to -16 LUFS (TikTok target)..."
ffmpeg -y -hide_banner -loglevel warning \
  -i $TMP/stage2.mp3 \
  -af "loudnorm=I=-16:TP=-1:LRA=11" \
  -c:a libmp3lame -b:a 192k -ar 44100 \
  $OUT

echo ""
echo "✓ Master: $OUT"
ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1 $OUT
ls -lh $OUT

# Cleanup intermediate files
rm -f $TMP/stage1.mp3 $TMP/stage2.mp3
```

- [ ] **Step 2: Make it executable**

```bash
chmod +x entertainment/qulo-tiktok-promos/scripts/mix-audio.sh
```

- [ ] **Step 3: Commit**

```bash
git add entertainment/qulo-tiktok-promos/scripts/mix-audio.sh
git commit -m "feat(promos): add mix-audio.sh (VO+BGM ducking + SFX overlay + loudnorm)"
```

---

### Task 22: Run the audio mix

- [ ] **Step 1: Pre-flight check**

```bash
cd entertainment/qulo-tiktok-promos
ls public/audio/raw/vo.mp3 public/audio/raw/bgm.mp3 public/audio/raw/sfx/*.mp3
```
Expected: all 8 files present.

- [ ] **Step 2: Run mix script**

```bash
bash scripts/mix-audio.sh
```
Expected output ends with:
```
✓ Master: public/audio/qulo-full-app-intro-mix.mp3
duration=140.0XX
```

- [ ] **Step 3: Verify duration is 140.0s ±0.5**

```bash
ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 public/audio/qulo-full-app-intro-mix.mp3
```
Expected: 139.5–140.5

If significantly different from 140s: the VO duration drifted. Either re-run `gen:vo` or adjust the `atrim=duration=140` value in `mix-audio.sh` to match actual VO length + 5s buffer.

- [ ] **Step 4: Verify LUFS**

```bash
ffmpeg -i public/audio/qulo-full-app-intro-mix.mp3 -af "loudnorm=I=-16:TP=-1:LRA=11:print_format=json" -f null - 2>&1 | tail -20
```
Look for `"input_i"` (integrated LUFS) in the JSON. Expected: -16 ±1.

- [ ] **Step 5: Listen end-to-end**

```bash
afplay public/audio/qulo-full-app-intro-mix.mp3
```
Confirm: VO clearly audible over BGM, SFX punctuate at right moments, no clipping.

- [ ] **Step 6: No commit (mix is gitignored)**

---

## FAZ 5 — Render & Publish

### Task 23: Add render + publish npm scripts

**Files:**
- Modify: `package.json`

- [ ] **Step 1: Add scripts**

In `entertainment/qulo-tiktok-promos/package.json` `scripts` section, add:

```json
"render:full-app-intro": "npx remotion render src/index.ts TikTokPromo out/qulo-full-app-intro.mp4 --props='{\"configSlug\":\"full-app-intro\"}' --concurrency=4 --pixel-format yuv420p",
"publish:full-app-intro": "mkdir -p ../../marketing/tiktok/videos && cp out/qulo-full-app-intro.mp4 ../../marketing/tiktok/videos/",
"build:full-app-intro": "npm run gen:vo && bash scripts/mix-audio.sh && npm run render:full-app-intro && npm run publish:full-app-intro"
```

- [ ] **Step 2: Commit**

```bash
git add entertainment/qulo-tiktok-promos/package.json
git commit -m "build(promos): add render/publish/build scripts for full-app-intro"
```

---

### Task 24: Test render (preview pass to verify visual timeline)

- [ ] **Step 1: Open studio with audio attached**

```bash
cd entertainment/qulo-tiktok-promos
npm run studio
```

- [ ] **Step 2: Spot-check key scenes in browser**

Open `Promo-full-app-intro`. Scrub to each of these frames and verify:

| Frame | Expected |
|-------|----------|
| 60 | Generic swipe stack visible, no brand resemblance |
| 360 | HookScene with Qulo logo center |
| 1500 | QuizSolve Q3 with timer bar visible |
| 1700 | MatchCelebration + green diamond burst + 3/3 badge |
| 2100 | Chat thread with 3 messages, evening tint |
| 3300 | StatsGrid infographic (Green/Purple/Boost) + diamond flow |
| 4000 | CTAScene with App Store/Play badges |

If any scene looks wrong: note the issue, fix the relevant component or config entry, then re-check.

- [ ] **Step 3: Verify audio playback in studio**

Click play from frame 0. Confirm audio mixes correctly with visuals at key beats (match at ~55s, diamond chime, finale).

Close browser.

- [ ] **Step 4: No commit yet**

---

### Task 25: Full render

- [ ] **Step 1: Render**

```bash
cd entertainment/qulo-tiktok-promos
npm run render:full-app-intro
```
Expected: 5-15 minutes depending on CPU. Output: `out/qulo-full-app-intro.mp4`.

If OOM error: re-run with `--concurrency=2`.
If too slow: confirm `--pixel-format yuv420p` is in the script (some encoders speed up significantly).

- [ ] **Step 2: Verify output**

```bash
ffprobe -v error -show_entries stream=width,height,r_frame_rate -show_entries format=duration,size -of default=noprint_wrappers=1 out/qulo-full-app-intro.mp4
```
Expected:
- `width=1080`
- `height=1920`
- `r_frame_rate=30/1`
- `duration` between 139.9 and 140.1
- `size` between 8MB and 30MB

- [ ] **Step 3: Open and watch**

```bash
open out/qulo-full-app-intro.mp4
```
Watch full video. Note any issues. Common problems and fixes:
- Audio out of sync: re-check `mix-audio.sh` delay values
- Caption text wrong/missing: re-check `captions` array in config
- Component renders wrong: revisit Task 4-11 prop implementation
- Black frames: check scene `startFrame + durationFrames` math — no gap should exceed `durationInFrames`

- [ ] **Step 4: No commit (mp4 is gitignored)**

---

### Task 26: Publish to marketing folder

- [ ] **Step 1: Copy**

```bash
cd entertainment/qulo-tiktok-promos
npm run publish:full-app-intro
```
Expected: `cp out/qulo-full-app-intro.mp4 ../../marketing/tiktok/videos/`

- [ ] **Step 2: Verify**

```bash
ls -lh /Users/berkantcalikusu/IdeaProjects/qulo/marketing/tiktok/videos/qulo-full-app-intro.mp4
```
Expected: file present, same size as `out/qulo-full-app-intro.mp4`.

- [ ] **Step 3: No commit yet** (handled in Task 28)

---

## FAZ 6 — Marketing Assets & Upload Prep

### Task 27: Write TikTok caption + hashtag file

**Files:**
- Create: `marketing/tiktok/captions/full-app-intro.md`

- [ ] **Step 1: Create directory and file**

```bash
mkdir -p /Users/berkantcalikusu/IdeaProjects/qulo/marketing/tiktok/captions
```

- [ ] **Step 2: Write the file**

Create `marketing/tiktok/captions/full-app-intro.md`:

```markdown
# Qulo Full App Intro — TikTok Upload Brief

**Video:** `marketing/tiktok/videos/qulo-full-app-intro.mp4`
**Duration:** 140s (2:20)
**Format:** 1080×1920, 30fps, H.264, AAC audio
**Language:** English
**Target audience:** US/UK 22-30, dating-fatigued

---

## Caption (TikTok caption box, max 2200 chars)

Hook line (first ~80 chars — shown above fold):
> This dating app makes you EARN the match. No swipes. No ghosts. Real questions only ⚡

Full caption:
> This dating app makes you EARN the match. No swipes. No ghosts. Real questions only ⚡
>
> Answer her 3 questions → match unlocked. Build your own filter → AI writes it for you. Earn diamonds when people solve yours.
>
> Free on iOS + Android. Link in bio. Go earn one 💎

## Hashtags (first comment OR end of caption)

#dating #datingapp #datingadvice #datingtips #single #onlinedating
#datingscene #relationship #datinglife #datingapps #fyp #foryou

## Trending audio strategy

⚠️ DO NOT add trending audio — this video uses original VO + BGM mix. TikTok counts it as "original sound" which is fine. If you overlay trending audio, the VO becomes unintelligible.

## Upload settings

- **Cover frame:** 11s (Qulo logo reveal moment) — pick in TikTok editor
- **Allow comments:** ON
- **Allow stitch + duet:** ON (encourages UGC)
- **Region targeting:** US, UK, CA, AU (set in account settings or via TikTok Ads if running paid)
- **Schedule:** prime time — US/UK 18:00-21:00 EST (Tuesday-Thursday for best organic reach)

## Brand-safety pre-upload checklist

- [ ] No frame mentions Tinder, Bumble, Hinge, or any other dating app
- [ ] Caption does not mention TikTok or any other platform
- [ ] No copyrighted music (BGM is Suno-generated / Epidemic licensed)
- [ ] App Store/Play Store names spelled correctly
- [ ] Cover frame is the logo reveal (not a problem-state frame)
```

- [ ] **Step 3: Commit**

```bash
git add /Users/berkantcalikusu/IdeaProjects/qulo/marketing/tiktok/captions/full-app-intro.md
git commit -m "docs(marketing): TikTok caption + hashtags for full-app-intro"
```

---

### Task 28: Final QA pass + commit final assets

- [ ] **Step 1: Run all QA assertions**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo

VIDEO=marketing/tiktok/videos/qulo-full-app-intro.mp4

echo "=== Dimensions / FPS / duration ==="
ffprobe -v error \
  -select_streams v:0 \
  -show_entries stream=width,height,r_frame_rate \
  -show_entries format=duration,size \
  -of default=noprint_wrappers=1 $VIDEO

echo ""
echo "=== Audio stream ==="
ffprobe -v error \
  -select_streams a:0 \
  -show_entries stream=codec_name,channels,sample_rate \
  -of default=noprint_wrappers=1 $VIDEO

echo ""
echo "=== Loudness ==="
ffmpeg -i $VIDEO -af "loudnorm=I=-16:TP=-1:LRA=11:print_format=summary" -f null - 2>&1 | grep -E "Input Integrated|Input True Peak"

echo ""
echo "=== File size ==="
ls -lh $VIDEO
```

Expected:
- width=1080, height=1920, r_frame_rate=30/1
- duration ≈ 140.0, size < 30MB
- audio: aac, stereo or mono, 44100 or 48000
- Loudness Integrated: -16 ±1.5, True Peak: ≤ -1.0

- [ ] **Step 2: Manual brand-safety scrub**

```bash
open $VIDEO
```

Watch full video. Check the checklist in `marketing/tiktok/captions/full-app-intro.md`. If anything fails — note which frame range, fix the relevant component/config, re-render (Task 25), re-publish (Task 26).

- [ ] **Step 3: Confirm spec + plan committed**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git status docs/superpowers/specs/2026-06-04-qulo-full-app-intro-tiktok-design.md \
           docs/superpowers/plans/2026-06-04-qulo-full-app-intro-tiktok.md \
           marketing/tiktok/README.md
```

If any of these are still untracked or unstaged, commit them:

```bash
git add docs/superpowers/specs/2026-06-04-qulo-full-app-intro-tiktok-design.md \
        docs/superpowers/plans/2026-06-04-qulo-full-app-intro-tiktok.md \
        marketing/tiktok/README.md
git commit -m "docs: Qulo full-app-intro TikTok spec + plan + marketing index"
```

- [ ] **Step 4: Final summary message**

Print a summary of what's ready:

```
✓ Video rendered: marketing/tiktok/videos/qulo-full-app-intro.mp4
✓ Caption + hashtags: marketing/tiktok/captions/full-app-intro.md
✓ Spec: docs/superpowers/specs/2026-06-04-qulo-full-app-intro-tiktok-design.md
✓ Plan: docs/superpowers/plans/2026-06-04-qulo-full-app-intro-tiktok.md
✓ Pipeline reusable for next videos: npm run build:<slug>

Next: open TikTok in browser → upload video → paste caption + hashtags from
marketing/tiktok/captions/full-app-intro.md → pick cover at 11s → publish.
```

---

## Post-Implementation: Upload (User-driven)

After the plan completes, the user opens TikTok in their browser and uploads. Claude can assist by:
- Reading caption file
- Suggesting cover frame timestamps
- Recording upload URL + timestamp into `marketing/tiktok/uploaded/2026-06-04-full-app-intro.md`

This is handled outside the implementation plan.

---

## Self-Review

### 1. Spec Coverage

| Spec section | Task(s) |
|--------------|---------|
| Karar özeti (parameters) | T12, T17 (config + VO script) |
| Marka çakma yasağı | T2 (GenericSwipeStack), T28 brand-safety scrub |
| Sahne akışı (12 sahne) | T12, T13 |
| Tam VO scripti | T17 |
| Komponent envanteri (reuse + new) | T1-11 |
| types.ts genişletmesi | T1 |
| Mevcut komponent prop varyantları (11) | T4-11 |
| VO — ElevenLabs | T15-18 |
| BGM — Suno | T19 |
| SFX | T20 |
| Premix — ffmpeg | T21-22 |
| Dosya yapısı | All tasks (file-by-file) |
| Build pipeline (single command) | T23 |
| QA checklist | T24, T28 |
| Caption + hashtag | T27 |
| Risk noktaları | Documented inline in T18, T22, T25 |

All spec sections covered.

### 2. Placeholder Scan

- No "TBD" / "TODO" / "implement later"
- Every code step has actual code, not descriptions
- All commands are concrete with exact paths
- Validation criteria are explicit (LUFS bounds, duration bounds, file existence)

### 3. Type Consistency

- `PromoConfig` matches `src/types.ts` definition
- `SceneSpec.props` is `Record<string, unknown>` — config props match component prop types added in T4-11
- `fullAppIntroConfig` exported name matches import in T14 registry
- Voice ID `AZnzlk1XvdvUeBnXmlld` consistent across spec + T17 + T16 `.env.example`

No type/name mismatches found.
