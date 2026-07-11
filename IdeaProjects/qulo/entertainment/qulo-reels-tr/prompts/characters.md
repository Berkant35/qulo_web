# Karakter Prompt'ları

Kaynak of truth: `tools/assets.manifest.mjs` (STYLE_SUFFIX + MANIFEST).
Üretim: `GEMINI_API_KEY="..." node tools/generate-assets.mjs --all`
Yeniden üretim: `node tools/generate-assets.mjs m2` (beğenilmeyen id).

- w1_hook — kadın, özgüvenli poz (S1, S3, S4)
- w1_point — aynı kadın, yazma jesti (S2) — w1_hook referanslı
- m1/m2/m3 — üç erkek aday (S3 eleme + m3 S4 eşleşme)

Kurallar: modern giyim, S/B fotoğraf + beyaz kontur, düz yeşil fon (#00FF00),
metin/logo/watermark yok, kıyafette yeşil yok, tamamen giyinik/policy-güvenli.
