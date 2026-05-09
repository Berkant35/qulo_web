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
