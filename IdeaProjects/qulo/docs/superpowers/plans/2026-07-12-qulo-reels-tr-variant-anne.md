# Qulo Reels Varyant AN — "Anne Onayı" (kültürel mizah, 30sn, 916+45)

Altyapı: `entertainment/qulo-reels-tr`. Global kurallar + keskin soru + kast rotasyonu + çok-format geçerli.
Konsept: Türk annesi damat adayını süzer; jüri kedi değil ANNE. Sorular annenin dertlerinden. Geçemeyen aday TERLİK yer (SpriteFlip animatik, klasik TR gag); geçen onaylanır → anne kızıyla eşleştirir. Kültürel jackpot, en yüksek viral.
Süre: 900f (30sn), müzik music_30s.mp3.
KAST: anne (yeni — orta yaş, süzen bakış, kollar kavuşuk); adaylar m2 (✗) + erko_kasli (✗); kazanan m1 (✓); kız w4. Policy: herkes giyinik/tasteful, şiddet yok (terlik komik-jest, isabet yok).

## Soru seti (questions.ts)
```ts
export const SORULAR_ANNE: readonly SoruSpec[] = [
  {soru: 'Ne iş yapıyorsun evladım?', dogru: 'Öğretmenim', yanlis: 'Kripto işleri'},
  {soru: 'Akşamları evde misin?', dogru: 'Ailemleyim', yanlis: 'Genelde dışarıdayım'},
  {soru: 'Kızımı üzersen?', dogru: 'Asla üzmem', yanlis: 'Kimse mükemmel değil'},
];
```
m2 → ✗ 'Kripto işleri' → terlik → ELENDİ. erko_kasli → ✗ 'Genelde dışarıdayım' → terlik → ELENDİ. m1 → ✓ 'Asla üzmem' → anne onaylar → eşleşme (w4+m1).

## Asset (Gemini — 4 yeni)
| id | içerik | aspect | suffix |
|----|--------|--------|--------|
| bg_salon | sıcak Türk oturma odası: kanepe, sehpada çay bardakları, dantel örtü, duvar halısı; noir+halftone; İNSANSIZ | 9:16 | BG_SUFFIX |
| anne | orta yaş Türk annesi, şık bluz/hırka, kollar kavuşuk, süzen/şüpheci ciddi bakış, kamera bakışı | 2:3 | STYLE |
| anne_terlik | AYNI anne (ref anne), bir elinde terlik havada fırlatmaya hazır, kaşları çatık kararlı | 2:3 | STYLE + referenceOf anne |
| prop_terlik | tek ev terliği (klasik), sticker | 1:1 | PROP |

Animatik: yanlış cevapta anne SpriteFlip [anne, anne_terlik] + prop_terlik havada uçar (translateX aday yönüne, spin) → aday tearFrame ile yırtılır/ELENDİ. SpriteFlip + CollageSticker mevcut.

## Yeni sahne/bileşen
- `AnneScene` (parametrik) {bg, suspectSrc, soru, correct, durationFrames}: BackdropPlate(bg_salon) + QuestionCard üstte (answer çipli) + aday sticker sağ-orta + anne sol-alt sabit (SpriteFlip: watch=anne; reject=anne→anne_terlik) + yanlışsa prop_terlik uçar + aday tearFrame + EliminationStamp 'ELENDİ'; doğruysa anne onay (yeşil 'HELAL OLSUN' damga) + MatchSpark 'Eşleşme!' + w4 slide-in. Height-göreli çapa (916+45).
- `AnneHook` (yeni, 120f): BackdropPlate(bg_salon) + anne sağ + başlık ['Sınavı geçtin.', 'Sıra *annede*.'] accent purple + alt beat (62+): 'Onayı kolay değil.' small.
- Kapanış: S5Closing {topLine: 'Annenin onayı, doğru soruyla.'}

## Config (anne.config.ts, 900f)
AnneHook s(0)/s(4) · AnneScene m2 [0] s(4)/s(7) · AnneScene erko_kasli [1] s(11)/s(7) · AnneScene m1 [2] correct s(18)/s(8) · S5Closing s(26)/s(4). Toplam 900. Composition `QuloReelsAnne` + `QuloReelsAnne45`.

## Görevler
1. Asset üretimi + KULLANICI ONAYI (ana session).
2. AnneScene + AnneHook + SORULAR_ANNE + anne.config + kayıt (916+45) + still (iki format) + review. Mevcutlara dokunma; SpriteFlip/CollageSticker/QuestionCard/EliminationStamp/MatchSpark/BackdropPlate yeniden kullan. Height-göreli ZORUNLU.
3. Render (916+45) + kapak + deliverables 12 + birleşik + KATALOG + caption + teslim.
