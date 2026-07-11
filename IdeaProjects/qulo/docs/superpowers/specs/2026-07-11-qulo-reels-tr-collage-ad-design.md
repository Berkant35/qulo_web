# Qulo Instagram Reels Reklamı — Retro Kolaj, TR, 9:16 (Design Spec)

**Tarih:** 2026-07-11
**Durum:** Onaylandı (kullanıcı ile brainstorming sonucu)
**Referans ilham:** AI-üretimli asset + kod-tabanlı animasyon hibrit akışı (rom1trs'in Nano Banana + motion collage yaklaşımı)

## Amaç

Instagram Reels reklamı olarak yayınlanacak, ~25 saniyelik, Türkçe, 1080×1920 (9:16) dikey tanıtım videosu üretmek. AI-üretimli (Gemini `gemini-3-pro-image` / Nano Banana Pro) retro editörel kolaj görselleri, mevcut kanıtlanmış config-driven Remotion pattern'iyle birleştirilir. Hedef: profesyonel görünüm, insanları durduran hook/thumbnail, kadın kitleye güçlü çengel.

## Karar Özeti

| Karar | Seçim |
|-------|-------|
| AI'nin rolü | Hibrit: AI asset üretir, Remotion animasyonlar |
| Görsel motoru | Gemini `gemini-3-pro-image` (Nano Banana Pro) — billing aktif, 9:16 testi başarılı |
| Platform/format | Instagram Reels reklamı, 1080×1920 @30fps, ~25sn, H.264 MP4 |
| Estetik | Retro editörel kolaj: beyaz konturlu sticker figürler, siyah zemin + neon yeşil/mor grafik şekiller, yırtık kağıt/halftone dokular |
| İnsanlar | **Modern giyimli**, çekici, karizmatik kadın/erkek — retro kolaj dili korunur ama kıyafet/saç günümüz modası |
| Dil/pazar | Türkçe — TR pazarı |
| Kapsam | Önce tek video; sistemleştirme (skill/pipeline) sonraki iş |
| Senaryo | "Eleme" — kadın kuralları koyar, yanlış cevaplayan elenir |

## Senaryo — "Eleme" (~25sn, 750 frame @30fps)

| # | Zaman | Sahne | AI asset (katman) | Remotion animasyonu + metin |
|---|-------|-------|-------------------|------------------------------|
| S1 | 0–3sn | Hook | Kadın figürü (özgüvenli poz) + doku parçaları | Figür "yapıştırılır" (scale-in + hafif rotasyon), şekiller patlayarak belirir. **"Sana ulaşmak bu kadar kolay olmamalı."** |
| S2 | 3–9sn | Kurallar | Kadın figürü (ikinci poz) | Soru kartları (Remotion UI) tek tek yazılır. **"2-10 soru. Kuralları sen koy."** |
| S3 | 9–17sn | Eleme | 3 erkek figürü (farklı tipler) | Her erkek bir soru kartını dener; yanlış cevapta kağıdı **yırtılıp düşer** (tear efekti + kırmızı çarpı). **"Yanlış cevap? Elenirsin."** |
| S4 | 17–22sn | Eşleşme | Kalan erkek + kadın figürü | İki sticker ortada birleşir; yeşil spark + konfeti şekiller (**elmas YOK**). **"Eşleşme!"** |
| S5 | 22–25sn | Kapanış | — (saf marka ekranı) | Logo + **"Doğru soru, doğru insan."** + store badge'leri + CTA. |

## Estetik ve İçerik Kuralları

- **Kolaj dili:** 1960'lar dergi kes-yapıştır estetiği, modern dokunuş. Figürler kalın beyaz konturlu "sticker". Zemin `#0D0D0D`; grafik vurgular yeşil `#69F0AE` ve mor `#BB86FC`.
- **İnsanlar modern:** kıyafet/saç günümüz modası; çekici ve karizmatik ama **policy-güvenli** (tamamen giyinik, cinsel çağrışımlı kadraj yok — Meta dating reklam politikası).
- **AI görsellerde metin/UI/logo/watermark YASAK** — tüm yazı ve arayüz Remotion'dan gelir (prompt'lara gömülür).
- **Elmas görseli YASAK** (önceki karar, devam ediyor). Kutlama = yeşil spark/konfeti şekiller.
- **Grafik şekiller AI'den değil:** halftone, daire, yay vb. Remotion SVG/CSS ile çizilir (keskinlik + animasyonlanabilirlik). AI yalnızca insan figürleri ve organik dokular (yırtık kağıt) üretir.
- **Ekran metinleri Türkçe**; Poppins (`@remotion/google-fonts/Poppins`), ı/İ/ç/ğ/ş/ö/ü görsel kontrol edilir.
- **Reels güvenli bölgeleri:** alt ~250px ve sağ ~120px IG arayüzüne bırakılır; kritik metin/figür bu alanlara taşmaz.
- **Ses kapalı izlenebilirlik:** mesaj tamamen ekran yazılarıyla taşınır; müzik bed destek amaçlı.

## Mimari

Yeni izole kardeş proje: `entertainment/qulo-reels-tr/` (Twitter projesi `qulo-twitter-tr` pattern'inin kopyası, 9:16'ya uyarlanır; mevcut projelere dokunulmaz).

```
qulo-reels-tr/
├── package.json / tsconfig.json / remotion.config.ts
├── tools/generate-assets.mjs      # Gemini API asset üretimi + arka plan temizleme
├── prompts/
│   ├── characters.md              # figür prompt'ları (kadın + 3 erkek, poz varyantları)
│   ├── scenes.md                  # doku/parça prompt'ları
│   └── elevenlabs-vo-tr.md        # opsiyonel VO script'i
├── public/
│   ├── ai/                        # onaylı şeffaf PNG sticker'lar + dokular
│   ├── brand/qulo_logo.svg
│   └── audio/                     # müzik bed (git-ignored)
└── src/
    ├── theme.ts                   # 1080×1920 @30fps; renk token'ları + Reels safe-zone
    ├── types.ts / Root.tsx / QuloReelsAd.tsx    # config-driven oynatıcı (aynı pattern)
    ├── configs/reels-tr.config.ts # sahne zamanlaması + ses track'leri
    ├── scenes/  S1Hook … S5Closing
    └── components/                # CollageSticker, TornPaper, HalftoneShape, StaggerText,
                                   # StoreBadges (Twitter projesinden uyarlanır), MatchSpark
```

### Asset üretim akışı (`tools/generate-assets.mjs`)

1. `GEMINI_API_KEY` env'den okunur (`~/.zshrc`'de tanımlı; git'e girmez). Yoksa anlaşılır hata + edinme yönergesi.
2. Figürler **tek tek sticker olarak** üretilir: düz tek renk fonda, kalın beyaz konturlu, 2K çözünürlük (`imageConfig: {aspectRatio, imageSize: "2K"}`).
3. Script arka planı temizler (düz fon → şeffaf PNG; flood-fill/chroma yaklaşımı) → `public/ai/`.
4. **Kullanıcı onayı zorunlu:** görseller onaylanmadan sahne koduna bağlanmaz; beğenilmeyen, sahne adıyla script tekrar çalıştırılarak yeniden üretilir.
5. Karakter tutarlılığı: aynı figürün ikinci pozu, onaylı ilk görsel **referans görsel** olarak verilerek üretilir (image-to-image).

### Remotion katmanı

- `CollageSticker`: şeffaf PNG figürü alır; yapıştırma (scale/rotate spring), sallanma, yırtılıp düşme (tear) animasyonlarını sağlar.
- Sahne zamanlaması tamamen `reels-tr.config.ts`'ten (`s(saniye)` yardımıyla) okunur.
- Ses: müzik bed `<Audio>` katmanı; VO eklenirse müzik ~0.30'a düşürülür (Twitter projesindeki kural).

## Doğrulama ve Çıktılar

- Sahne başına döngü: `tsc --noEmit` → `remotion still` anahtar frame PNG → göz kontrolü → commit (sahne sahne).
- Final: `npm run render` → `out/qulo-reels-tr-25s-9x16.mp4` (H.264, 1080×1920, <30sn — Reels uyumlu).
- Kapak/thumbnail: hook frame'inden `remotion still` ile 1080×1920 PNG + reklam yöneticisi için 1080×1350 (4:5) kırpım.

## Hata Durumları

- Gemini 429/5xx: script sahne bazlı yeniden denenebilir; eksik asset'leri listeler.
- Eksik asset: Remotion placeholder gradient ile derlenmeye devam eder (render bloklanmaz, konsola uyarı).
- Maliyet çerçevesi: ~6-10 görsel + yeniden üretim payı ≈ $2-3 (`gemini-3-pro-image` görsel başına ~$0.13-0.24).

## Kapsam Dışı (sonraki işler)

- Sistemleştirme: tekrar kullanılabilir pipeline/businessCaseSkill ("reklam yap" → senaryo → asset → render).
- EN/diğer pazarlar, 4:5/16:9 ek formatlar, A/B varyant otomasyonu.
- Seedance/Kling tarzı AI video animasyon katmanı (bu videoda animasyon %100 Remotion).
