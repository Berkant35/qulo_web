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

**Üst-sağ köşe BOŞ kalmalı** (camera framing'de telefon ekranının üstündeki bölge). Bu alana Remotion'da uçan kart compositlenecek. Eğer Veo bu bölüme duvar tekstürü, ışık vs koyarsa hâlâ kullanılır ama efekt güçlüğü artar — temiz koyu zemin idealdir.

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
