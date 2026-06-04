# Qulo Marketing — TikTok

Merkezi TikTok output klasörü. Tüm video, caption, hashtag dosyaları burada toplanır.

## Klasör Yapısı

```
marketing/tiktok/
├── videos/         # Render edilmiş MP4'ler (1080×1920, 30fps, sessiz)
├── captions/       # (planlanan) Video başına EN caption + hashtag dosyaları
└── uploaded/       # (planlanan) Yüklenen videoların kaydı (tarih, link, metrik)
```

## Format Standartları

- **Çözünürlük:** 1080×1920 (9:16 vertical)
- **FPS:** 30
- **Süre:** 12–60s
- **Dil:** English only
- **Ses:** Sessiz — TikTok'a yüklerken trending audio eklenir

## Mevcut Videolar

| Dosya | Süre | İçerik |
|-------|------|--------|
| `qulo-day-in-the-life-fixed.mp4` | 60s | Tam ürün akışı: discover → 3 soru çöz → match → coffee daveti → CTA |
| `qulo-day-in-the-life.mp4` | 60s | Yukarıdakinin eski sürümü (fixed tercih edilir) |
| `qulo-match-to-first-date.mp4` | 60s | Hikayeci: "this is how I got asked out" → match → chat → randevu |
| `qulo-stop-swiping.mp4` | 15s | Kısa hook: "Stop swiping. Start solving." |

## Yeni Video Üretimi

Yeni TikTok promo render etmek için `entertainment/qulo-tiktok-promos/` Remotion projesi kullanılır
(`qulo-tiktok-promo` skill orkestrasyonu). Render sonrası MP4 buraya kopyalanır.
