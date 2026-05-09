# Shot 4 — Recognition (2.5s)

**Hedef dosya:** `public/veo/shot4_recognition_v1.mp4`
**Süre:** 2.5sn
**Mod:** Image-to-video, **iki reference** kullanılır:
- Primary subject: `public/refs/female_lead_portrait.png`
- Secondary subject (telefonda görünecek match): `public/refs/male_match_portrait.png`

**Eğer Veo 3 Pro tek reference destekliyorsa:** Sadece kadın referansını kullan, erkek bildirim Remotion'da overlay olarak eklenir (Notification UI component'i içinde male portrait kullanılır).

## Prompt (single-reference fallback)

```
The same woman, in warm window light, holding her phone. Her phone screen briefly lights up with a notification (the screen is angled slightly away from camera so the actual notification UI is not legible). Her face shifts from focused thought to soft recognition — a slow inhale, the corners of her mouth lift just a few millimeters. Her eyes hold something — relief mixed with surprise. She is seeing someone she recognizes. Anamorphic lens, 35mm film grain, A24 indie warm color grade with subtle green accent in highlights. Tight chest-up framing. 9:16 vertical, 30fps, 2.5 seconds.
```

## Önemli kompozisyon notu

Telefon ekranı ya hiç görünmesin ya da çok hafif açıdan görünsün ki Remotion'da üstüne **NotificationUI** component'i compositlenebilsin. Eğer Veo ekranda gerçek bir UI render ederse Remotion overlay üzerine binme zorunda kalır — temiz olmaz.

## Negative

`oversaturated, big smile, dramatic reaction, music video, fast cuts, magical particles, CGI rendering, beautified skin, makeup, perfect teeth showing`

## Retry stratejisi

3 generation. Seçim kriteri:
- ✅ Aynı kadın (4. shot'ta da consistency)
- ✅ Yüz değişimi MICRO — overact KESINLIKLE yasak ("happy ending" klişesinden kaç)
- ✅ Phone ekranı temiz / az görünür
- ✅ Warm grade Shot 3'le tutarlı
- ❌ Geniş gülüş varsa REJECT (subtle olacak)
- ❌ Phone ekranında belirgin başka UI varsa REJECT

## Yerleşim

```bash
mv ~/Downloads/shot4_v1.mp4 entertainment/qulo-stop-swiping/public/veo/shot4_recognition_v1.mp4
```
