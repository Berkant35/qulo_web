# Qulo Reels Varyant B1 — "Kırıntı" (breadcrumbing, araştırma temelli, 30sn, 916+45)

Altyapı: `entertainment/qulo-reels-tr`. Global kurallar + keskin soru + kast rotasyonu + çok-format geçerli.
Araştırma: breadcrumbing ~%35 (The Daily Star / MDPI); "duygusal olarak aç bırakıp ilgiyi canlı tutma", adım atmadan kırıntı bırakma → yalnızlık/çaresizlik. Modern flört acıları serisi (10 ghosting + 11 situationship + B1 breadcrumbing).
Konsept: Bekleme kafesinde kadın oyalanıyor; kaçamak/"bir ara" cevabı veren aday KIRINTILARA UFALANIP savrulur (PaperShreds "ufalanma"). Net adım atan kalır. Kapanış: "Kırıntıyla doyulmaz."
Süre: 900f (30sn), müzik music_30s.mp3.
KAST: kadın w7 (yeni, bekleyen/şüpheli); aday1 m_hook (✗ 'Bir ara bakarız'); aday2 m2 (✗ 'Duruma göre'); kazanan m3 (✓ 'Netçe evet'). Meta policy: giyinik/tasteful.

## Soru seti (questions.ts)
```ts
export const SORULAR_KIRINTI: readonly SoruSpec[] = [
  {soru: 'Ne zaman buluşuyoruz?', dogru: 'Cumartesi 8\'de', yanlis: 'Bir ara bakarız'},
  {soru: 'Bu hafta müsait misin?', dogru: 'Sana ayırdım', yanlis: 'Duruma göre'},
  {soru: 'Beni gerçekten istiyor musun?', dogru: 'Netçe evet', yanlis: 'Görüşürüz artık'},
];
```
m_hook → ✗ 'Bir ara bakarız' → ufalanır. m2 → ✗ 'Duruma göre' → ufalanır. m3 → ✓ 'Netçe evet' → eşleşme (w7+m3).

## Asset (Gemini — 2, üretildi)
| id | içerik | aspect |
|----|--------|--------|
| bg_bekleme | pencere kenarı kafe, iki kişilik masa + boş sandalye, bekleme havası; noir plate; İNSANSIZ | 9:16 (BG_SUFFIX) |
| w7 | yeni kadın: trençkot, telefona bakıp şüpheli-yorgun ifade | 2:3 |

## Sahneler (GhostScene/TanimScene template'i)
- `KirintiHook` (yeni, 120f): BackdropPlate(bg_bekleme, darken ~0.4) + w7 sticker sağ-merkez (height-göreli) + başlık ['Seni oyalıyor,', 'adım *atmıyor*.'] danger + alt beat (62+): 'Kırıntıyla doyulmaz.' small.
- `KirintiScene` (yeni, parametrik) {suspectSrc, soru, correct, durationFrames}: BackdropPlate(bg_bekleme) + QuestionCard (answer çipli) + aday sticker ortada + yanlışsa: SWAP_FRAME'de aday PaperShreds ile "ufalanır" (yoğun kırıntı bursts count ~30 + aday opacity 1→0 + hafif çöküş translateY +40) + EliminationStamp label 'KIRINTI'; doğruysa yeşil 'NET' damga + MatchSpark 'Eşleşme!' + w7 slide-in.
- Kapanış: S5Closing {topLine: 'Kırıntı değil, net cevap.'}

## Config (b1.config.ts, 900f)
KirintiHook s(0)/s(4) · KirintiScene m_hook SORULAR_KIRINTI[0] s(4)/s(7) · KirintiScene m2 [1] s(11)/s(7) · KirintiScene m3 [2] correct s(18)/s(8) · S5Closing s(26)/s(4). Toplam 900. Composition `QuloReelsKirinti` + `QuloReelsKirinti45`.

## Görevler
1. Asset TAMAM + onaylı → commit.
2. KirintiHook + KirintiScene + SORULAR_KIRINTI + b1.config + kayıt (916+45) + still (iki format) + review. Height-göreli çapa zorunlu. Mevcutlara dokunma.
3. Render (916+45) + kapak + deliverables 13 + birleşik + KATALOG + caption + teslim.
