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
