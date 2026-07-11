# Qulo Instagram Reels Reklamı — TR, 9:16, 25sn, Retro Kolaj

AI-üretimli kolaj sticker'ları (Gemini gemini-3-pro-image) + Remotion animasyon.

## Spec & Plan
- Spec: `docs/superpowers/specs/2026-07-11-qulo-reels-tr-collage-ad-design.md`
- Plan: `docs/superpowers/plans/2026-07-11-qulo-reels-tr-collage-ad.md`

## Komutlar
- `npm install` — bağımlılıklar
- `npm run studio` — canlı önizleme
- `GEMINI_API_KEY="..." npm run assets -- --all` — AI sticker üretimi (bkz. prompts/characters.md)
- `npm run render` — final MP4 (out/qulo-reels-tr-25s-9x16.mp4)

## Sahneler (config: src/configs/reels-tr.config.ts)
1. S1 Hook (0–3s) — "Sana ulaşmak bu kadar kolay olmamalı."
2. S2 Kurallar (3–9s) — "2-10 soru. Kuralları sen koy."
3. S3 Eleme (9–17s) — yanlış cevap → sticker yırtılıp düşer
4. S4 Eşleşme (17–22s) — doğru cevaplayan + "Eşleşme!"
5. S5 Kapanış (22–25s) — logo + "Doğru soru, doğru insan." + store badge

## Instagram upload notu
- Reels reklam: MP4 H.264, 1080×1920, ≤30sn — uyumlu.
- Kapaklar: out/cover_9x16.png (Reels), out/cover_4x5.png (feed önizleme).
- Ses kapalı autoplay'de mesaj ekran yazılarıyla tam taşınır.
