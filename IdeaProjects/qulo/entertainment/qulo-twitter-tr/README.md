# Qulo Twitter Reklamı — TR, 16:9, 30sn

Türkçe, yatay (1920×1080) Qulo tanıtım videosu. Remotion (React → ffmpeg).

## Spec & Plan
- Spec: `docs/superpowers/specs/2026-06-27-twitter-promo-tr-16x9-design.md`
- Plan: `docs/superpowers/plans/2026-06-27-twitter-promo-tr-16x9.md`

## Komutlar
- `npm install` — bağımlılıklar
- `npm run studio` — canlı önizleme
- `npm run compositions` — composition listesi
- `npm run still -- out/frame.png --frame=N` — tek frame PNG
- `npm run render` — final MP4 (out/qulo-twitter-tr-30s-16x9.mp4)

## Sahneler (config: src/configs/twitter-tr.config.ts)
1. S1 Boş Kaos (0–4s) — uçuşan kartlar, sıfır eşleşme
2. S2 İki Soru (4–9s) — sıkılma + kriter sorusu
3. S3 Qulo Doğuşu (9–15s) — logo + beyin + tick'lenen sorular
4. S4 Problem Akışı (15–23s) — 3 Türk problemi → yeşil tick eleme
5. S5 Çözüm Anı (23–27s) — Eşleşme! pop (elmas yok)
6. S6 Kapanış (27–30s) — logo + "Doğru soru, doğru insan." + store badge'leri

## Ses
- `public/audio/vo_tr_final.mp3` (ElevenLabs TR VO — prompts/elevenlabs-vo-tr.md)
- `public/audio/music_30s.mp3` (müzik bed)
- Asset'ler git-ignored; ayrı saklanır.

## Twitter upload notu
- Format: MP4 H.264, 1920×1080, <512MB, <140sn — uyumlu.
- Ses kapalı autoplay'de mesaj yazılarla tam taşınır.
