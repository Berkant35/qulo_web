# Qulo Reels Varyant G1 — "Hayalet Avı" (ghosting, araştırma temelli, 30sn)

Altyapı: `entertainment/qulo-reels-tr`. Global kurallar + keskin soru + kast rotasyonu geçerli.
Araştırma dayanağı: ghosting %76 (Forbes Health/Gitnux), belirsizlik > red travması (Milano-Bicocca/Cumhuriyet), 2026 "netlik" trendi (Muhalif). Hook istatistiği: "5 kişiden 4'ü ghostlandı." (%76 → 4/5, savunulabilir yuvarlama).
Konsept: Gece sokağında hayaletler süzülür; kadının sorularına kaçamak cevap verenler HAYALETE DÖNÜŞÜP uçar (SpriteFlip). Net cevap veren kalır. "Hayaletlere değil, cevaplara eşleş."
Süre: 900f (30sn), müzik music_30s.mp3.
KAST (glam güncelleme 2026-07-12): kadın w5 (yeni glam — zarif V-yaka, dekolte odağı YOK); adaylar m_fit (atletik fitted gömlek, ✗ 'Yazıyor...'), m_zengin2 (smokinli zengin, ✗ 'Bakarız'); kazanan m1 (redemption). Meta policy tavanı: üstsüz/dekolte odağı ASLA.

## Soru seti (questions.ts)
```ts
export const SORULAR_GHOST: readonly SoruSpec[] = [
  {soru: 'Mesajıma dönmen kaç gün sürer?', dogru: 'Aynı gün', yanlis: 'Yazıyor...'},
  {soru: 'Üç hafta sonra da burada mısın?', dogru: 'Buradayım', yanlis: 'Bakarız'},
  {soru: 'Sıkılırsan ne yaparsın?', dogru: 'Konuşurum', yanlis: 'Kaybolurum'},
];
```
m_fit → ✗ 'Yazıyor...' → hayalet olur, uçar. m_zengin2 → ✗ 'Bakarız' → hayalet. m1 → ✓ 'Konuşurum' → eşleşme (w5+m1).

## Asset (Gemini — 3 yeni)
| id | içerik | aspect | suffix |
|----|--------|--------|--------|
| bg_gece | gece loş sokak: tek sokak lambası, uzun gölgeler, hafif sis; noir + halftone; İNSANSIZ | 9:16 | BG (noir) |
| hayalet_1 | sevimli-komik çarşaf hayalet, süzülür poz, iki kol yanda, oval göz delikleri | 1:1 | PROP (tek nesne) |
| hayalet_2 | AYNI hayalet (ref hayalet_1), el sallayarak veda eder poz, hafif yan dönük | 1:1 | PROP + referenceOf |

## Sahneler
- `GhostHook` (yeni, 120f): BackdropPlate(bg_gece) + arka planda 2 hayalet sticker yavaş süzülür (sine yatay + yukarı drift, opacity 0.5) + w5 sticker sağda + başlık: ['5 kişiden 4''ü', '*ghostlandı*.'] danger + alt beat (60+): 'Qulo''da hayaletler barınamaz.' small.
- `GhostScene` (yeni, parametrik) {suspectSrc, soru, correct, durationFrames}: BackdropPlate(bg_gece) + QuestionCard (answer çipli) + aday sticker ortada + yanlışsa: aday SpriteFlip [aday, hayalet_1, hayalet_2] (12f/poz) + yukarı süzülüp fade (translateY -700 + opacity 0, ~40f) + EliminationStamp label 'GHOSTLANDI' ; doğruysa: yeşil 'KALDI' damga + MatchSpark 'Eşleşme!' + w5 slide-in.
- Kapanış: S5Closing {topLine: 'Hayaletlere değil, cevaplara eşleş.'}

## Config (g1.config.ts, 900f)
GhostHook s(0)/s(4) · GhostScene m_fit s(4)/s(7) · GhostScene m_zengin2 s(11)/s(7) · GhostScene m1 ✓ s(18)/s(8) · S5Closing s(26)/s(4). Toplam 900. Composition `QuloReelsGhost`.

## Görevler
1. Manifest 3 asset + üretim + KULLANICI ONAYI (ana session).
2. GhostHook + GhostScene + SORULAR_GHOST + g1.config + kayıt + still + review (mevcutlara dokunma).
3. Render + kapak + deliverables 10 + birleşik + KATALOG + teslim.
