# Qulo Reels Varyant S1 — "Biz Neyiz?" (situationship, araştırma temelli, 30sn, 916+45)

Altyapı: `entertainment/qulo-reels-tr`. Global kurallar + keskin soru + kast rotasyonu + çok-format kuralı geçerli.
Araştırma dayanağı: Gen Z'nin 1/3'ü situationship yaşamış; bekârların ~%55'i bağlanmada karamsar; etiketten kaçış = daha yüksek stres/düşük memnuniyet (IJIAP; Yahoo romantic recession). Hook: "Üçte biri bir 'ilişki'nin adını koyamıyor."
Konsept: Loş barda kadın situationship'ten bıkmış; "biz neyiz?"den kaçan adaylar BELİRSİZLİK SİSİ + soru işareti bulutuna dönüşüp kaybolur (yeni UncertaintyFog animatiği). Net cevap veren kalır. Kapanış: "Belirsizlik değil, net cevap. Qulo."
Süre: 900f (30sn), müzik music_30s.mp3.
KAST: kadın w6 (yeni, sabrı tükenmiş şık); aday1 m_kacamak (omuz silken, ✗ 'Etiket koymayalım'); aday2 m_fit (✗ 'Arkadaşım işte'); kazanan m3 (✓ 'Beraberiz'). Meta policy: giyinik/tasteful.

## Soru seti (questions.ts)
```ts
export const SORULAR_TANIM: readonly SoruSpec[] = [
  {soru: 'Biz neyiz?', dogru: 'Sevgiliyiz', yanlis: 'Etiket koymayalım'},
  {soru: 'Arkadaşlarına beni nasıl tanıtıyorsun?', dogru: 'Sevgilim diye', yanlis: 'Arkadaşım işte'},
  {soru: '3 aydır neyiz peki?', dogru: 'Beraberiz', yanlis: 'Akışına bıraktık'},
];
```
m_kacamak → ✗ 'Etiket koymayalım' → sise dönüşür. m_fit → ✗ 'Akışına bıraktık'... DÜZELTME: aday2 soru[1] "Arkadaşlarına..." → ✗ 'Arkadaşım işte'. m3 → soru[2] ✓ 'Beraberiz'.

## Asset (Gemini — 3, üretildi)
| id | içerik | aspect |
|----|--------|--------|
| bg_kafe | loş kokteyl barı, mum ışıklı masalar, bokeh; noir plate; İNSANSIZ | 9:16 (BG_SUFFIX) |
| w6 | yeni kadın: kollar kavuşuk, kaş kalkık, sabrı tükenmiş şık | 2:3 |
| m_kacamak | omuz silken, kaçamak gülümseyen aday | 2:3 |

## Yeni bileşen: UncertaintyFog (src/components/UncertaintyFog.tsx)
{startFrame, x, y, width}: deterministik (rnd, NO Math.random). Aday kaybolurken üstüne biner: (a) hafif blur+gri sis bulutu (radial gradient div, opacity 0→0.7→0), (b) 6-8 adet '?' glyph'i yukarı süzülüp dağılır (danger/textMuted, sine sway), (c) aday sticker opacity 1→0 + hafif yukarı+bulanıklaşma. ~45 frame. GhostScene'deki "yukarı süzülme" pattern'ine benzer ama sis/soru-işareti temalı.

## Sahneler
- `TanimHook` (yeni, 120f): BackdropPlate(bg_kafe, darken ~0.4) + w6 sticker sağ-merkez (height-göreli) + başlık ['Üçte biri', 'adını *koyamıyor*.'] danger + alt beat (62+): 'Sen koyacak mısın?' small textMuted.
- `TanimScene` (yeni, parametrik) {suspectSrc, soru, correct, durationFrames}: BackdropPlate(bg_kafe) + QuestionCard üstte (answer çipli) + aday sticker ortada (height-göreli, Sequence durationInFrames ile SWAP_FRAME'de kesilir) + yanlışsa UncertaintyFog + EliminationStamp label 'TANIMSIZ'; doğruysa yeşil 'NET' damga + MatchSpark 'Eşleşme!' + w6 slide-in.
- Kapanış: S5Closing {topLine: 'Belirsizlik değil, net cevap.'}

## Config (s1.config.ts, 900f)
TanimHook s(0)/s(4) · TanimScene m_kacamak SORULAR_TANIM[0] s(4)/s(7) · TanimScene m_fit [1] s(11)/s(7) · TanimScene m3 [2] correct s(18)/s(8) · S5Closing s(26)/s(4). Toplam 900. Composition `QuloReelsTanim` + `QuloReelsTanim45` (1080×1350).

## Görevler
1. Asset üretimi TAMAM + onaylı → commit.
2. UncertaintyFog + TanimHook + TanimScene + SORULAR_TANIM + s1.config + kayıt (916+45) + still (iki format) + review. Mevcut sahne/bileşenlere dokunma. Height-göreli çapa ZORUNLU (çok-format).
3. Render (916+45) + kapak + deliverables 11 + birleşik + KATALOG + caption + teslim.
Doğrulama: tsc + still (iki format) + göz + commit. Git yavaş (timeout ≥300s).
