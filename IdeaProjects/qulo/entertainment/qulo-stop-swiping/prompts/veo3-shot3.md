# Shot 3 — The Conscious Shift (4.0s)

**Hedef dosya:** `public/veo/shot3_conscious_shift_v1.mp4`
**Süre:** 4.0sn
**Mod:** Image-to-video, reference: `public/refs/female_lead_portrait.png`

## Prompt

```
The same woman, but now in a completely different lighting and energy: warm golden hour light from a window, she is sitting upright on the edge of her bed, posture engaged, alert. She is holding her phone with intent — not scrolling — and reading something carefully. Her thumb deliberately taps the screen as if answering a question, slow and considered. As she taps, the cool blue light fades and a subtle warm green glow rises on her face (we see emotion enter her eyes). She is thinking, present, alive. Tight chest-up framing. Anamorphic lens, 35mm film grain, A24 indie color grade transitioning from cool to warm with green and amber accents. 9:16 vertical, 30fps, 4 seconds.
```

## Önemli kompozisyon notu

Renk geçişi (cool → warm green) Veo'nun kendisi yapsın. Remotion'da ek bir warm overlay daha bindireceğiz — yani Veo'da minimal warm shift yeterli, abartı değil.

## Negative

`oversaturated, beauty shot, smooth skin, makeup, music video, fast cuts, dancing, dramatic gesture, magical particles, fantasy elements, CGI rendering`

## Retry stratejisi

3 generation. Seçim kriteri:
- ✅ Aynı kadın, ama Shot 1-2'den **farklı duruş ve ışık**
- ✅ Düşünceli/aktif okuma + niyetli tap
- ✅ Cool→warm renk şifti hissedilir (drastic değil, geçiş halinde)
- ✅ Gözlerde duygu var ama "uyandı" değil (saf transformation klişesi)
- ❌ Phone ekranı net görünüyorsa (UI Veo'dan değil Remotion'dan gelecek) REJECT
- ❌ Mavi ışık baskınsa (renk şifti olmamış) REJECT

## Yerleşim

```bash
mv ~/Downloads/shot3_v1.mp4 entertainment/qulo-stop-swiping/public/veo/shot3_conscious_shift_v1.mp4
```
