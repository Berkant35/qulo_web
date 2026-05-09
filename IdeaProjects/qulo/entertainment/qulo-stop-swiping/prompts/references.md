# Reference Portraits

Bu dosyadaki prompt'ları **Midjourney v7 / DALL-E 3 / Veo 3 image gen** ile üret. Çıktıları PNG olarak kaydet.

## Kadın baş karakter

**Hedef dosya:** `public/refs/female_lead_portrait.png`

**Görsel kriterleri:**
- Yaş: 28-32 arası
- Etnik: ambiguous global (Mediterranean / mixed European-Middle Eastern), international audience'ta tanıdık hissetsin
- İfade: nötr, hafif yorgun, "10 yıllık dating app yorgunluğu" izlenimi
- Saç: omuz altı, doğal kahverengi/koyu sarı, taranmamış-doğal
- Makyaj: minimal/yok
- Bakış: kameraya direkt, hüzünlü ama dirençli

**Midjourney prompt:**

```
Cinematic portrait of a woman in her late twenties, ambiguous Mediterranean features, soft tired eyes, no makeup, natural shoulder-length brown hair, gentle melancholy expression, neutral pose facing camera, soft window light from the left, deep teal shadows, 35mm film grain, anamorphic lens shallow depth of field, color graded like a A24 indie film (Past Lives, Aftersun aesthetic), highly detailed skin texture, natural blemishes preserved, 4K --ar 1:1 --style raw --v 7
```

**Negative / avoid:** glamour, fashion model, smooth skin, smiling, professional makeup, studio strobe, oversaturated.

**Retry stratejisi:** 4 generation çıkar, en doğal/erişilebilir hisseden seç. Yüz simetrisi mükemmel olmasın — gerçek insan hissi önemli.

## Erkek match karakter (Shot 2 ve Shot 4)

**Hedef dosya:** `public/refs/male_match_portrait.png`

**Görsel kriterleri:**
- Yaş: 30-34 arası
- Etnik: ambiguous global (Northern European / mixed)
- İfade: sıcak, hafif gülümseme, sıcak gözler
- Saç: kısa-orta, koyu kahve, hafif dağınık
- Sakal: 2-3 günlük, bakımlı değil ama doğal
- Bakış: kameraya direkt, sevecen ama özgüvenli

**Midjourney prompt:**

```
Cinematic portrait of a man in his early thirties, mixed European features, warm kind eyes, soft genuine smile, short messy dark brown hair, three-day stubble, gentle confidence, neutral pose facing camera, golden hour window light, warm honey tones, 35mm film grain, anamorphic lens shallow depth of field, A24 indie film color grade (Past Lives, Aftersun aesthetic), highly detailed skin texture, natural beard texture, 4K --ar 1:1 --style raw --v 7
```

**Negative / avoid:** male model, gym body, perfect teeth, professional photo, studio lighting, oversaturated, generic stock photo look.

**Retry stratejisi:** 4 generation. Shot 2'de "kaçan kart" üzerinde 2D olarak görünecek; Shot 4'te aynı kişi Veo 3 image-to-video ile animate edilecek. **Yüz tanınabilir olmalı** — generic erkek değil, izleyici aynı kişiyi tanımalı.

## Yerleşim

Her iki PNG'yi seçtikten sonra:

```bash
mv ~/Downloads/female_lead.png entertainment/qulo-stop-swiping/public/refs/female_lead_portrait.png
mv ~/Downloads/male_match.png entertainment/qulo-stop-swiping/public/refs/male_match_portrait.png
```

Sonra agent'a "reference'lar yerleştirildi" haberi ver — Veo prompt'larını finalize edecek.
