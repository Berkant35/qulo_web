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
