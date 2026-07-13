# Qulo Reels Varyant R2 — "Sorgu Odası" (4 şıklı ifade, 30sn)

Altyapı: `entertainment/qulo-reels-tr`. Global kurallar + keskin soru kuralı geçerli. YENİ: Gemini tam kare ortam plate'leri (BackdropPlate) — mekân zenginliği; kolaj dili korunur (S/B film-noir + halftone).
Konsept: karakol sorgu odası; adaylar ifade veriyor, 4 şıktan seçiyor; kaçamak/komik şık = ELENDİ (mugshot kesiti). "Yalanı olan giremez." Komik-gerilim; policy-güvenli (şiddet yok, mizah).
Süre: **900 frame (30sn)** — bu varyant 30sn'lik; müzik `qulo-twitter-tr/public/audio/music_30s.mp3` kopyalanır (git-ignored).

## Soru modeli (questions.ts — YENİ TİP)
```ts
export type SorguSoru = {
  soru: string;
  siklar: readonly [string, string, string, string]; // A-D
  dogruIndex: 0 | 1 | 2 | 3;  // dürüst cevap
  secimIndex: 0 | 1 | 2 | 3;  // adayın seçtiği şık
};
export const SORGU_SORULARI: readonly SorguSoru[] = [
  {soru: 'Eski sevgilinizle son görüşmeniz?', siklar: ['Yıllar önce', 'Geçen hafta, kahve', 'Hatırlamıyorum', 'Hangisi?'], dogruIndex: 0, secimIndex: 3},
  {soru: 'Telefonunuzda kaç dating uygulaması var?', siklar: ['Sadece Qulo', 'İki-üç', 'Hepsi var', 'Avukatımı istiyorum'], dogruIndex: 0, secimIndex: 3},
  {soru: 'Profil fotoğrafınız kaç yıllık?', siklar: ['Geçen hafta çektim', '2-3 sene olmuştur', 'Üniversiteden', 'Askerden'], dogruIndex: 0, secimIndex: 0},
];
```
m1 → Q1'de "Hangisi?" seçer (panik) → ELENDİ. m2 → Q2'de "Avukatımı istiyorum" → ELENDİ. m3 → Q3'te dürüst şık → TEMİZ → eşleşme.

## Asset (Gemini)
| id | içerik | aspect | not |
|----|--------|--------|-----|
| bg_sorgu | sorgu odası tam kare: metal masa + boş sandalye, tek sarkan ampul, ayna cam, sigara dumanı havası; S/B film-noir + halftone; FIGÜRSÜZ | 9:16 | BG_SUFFIX (yeni: full-bleed plate, chroma yok) |
| bg_mugshot | mugshot duvarı tam kare: boy çizgili duvar (çizgiler VAR ama rakam/harf YOK), sert flaş ışığı; FIGÜRSÜZ | 9:16 | BG_SUFFIX |

BG_SUFFIX (manifest'e eklenir): full-bleed 9:16 background plate, retro 1960s film-noir B&W photography with visible halftone print texture, cinematic, empty of people, no text/letters/numbers/logos/watermarks. (Chroma temizliği UYGULANMAZ — script'e bg_ önekli asset'lerde removeBackground'u atlama koşulu eklenir.)

## Yeni bileşenler
- `BackdropPlate` {src, zoomFrom?, zoomTo?, darken?}: tam kare Img + yavaş Ken Burns (scale zoomFrom→zoomTo scene boyunca) + üstte `rgba(0,0,0,darken)` overlay + vinyet (radial gradient). Metin/kart okunabilirliği için darken ~0.35.
- `OptionsCard` {soru, siklar, secimIndex, dogruIndex, x, y, width?, enterFrame?, pickFrame, verdictFrame}: kağıt kart; soru typewriter; 4 şık chip'i (A) B) C) D) etiketli, sırayla pop 6f arayla); pickFrame'de secim şıkkı vurgulanır (border kalınlaşır + hafif scale); verdictFrame'de seçim yanlışsa kırmızıya döner + kart shake + diğer şıklar %40 soluk, doğruysa yeşile döner. (QuestionCard'a DOKUNULMAZ — ayrı bileşen.)
- `EliminationStamp` {frame}: "ELENDİ" kırmızı damga (rotate -12°, spring çarpma + hafif geri tepme) — Remotion çizimi.
- `MugshotCut` sahne-içi bölüm değil, InterrogationScene'in son ~35 frame'i: bg_mugshot plate'e hard cut + aday sticker ortada + flaş (2 frame beyaz overlay) + EliminationStamp + altta küçük tarih yazısı yerine 'İFADE: GEÇERSİZ' bandı (Remotion).

## Sahneler (yeni: InterrogationScene — parametrik)
`InterrogationScene` {suspectSrc, sorgu: SorguSoru, eliminated: boolean, bgSorgu, bgMugshot?}: bg_sorgu BackdropPlate + sarkan ampul ışık salınımı (üstten radial gradient spot, x'i sine ile hafif salınan) + aday sticker masada (alt-orta, width ~520) + OptionsCard üstte + eliminated ise son 35f mugshot kesiti; değilse yeşil onay ("TEMİZ" yeşil damga) + spark.

## Config (r2.config.ts, 900f!)
- S1 SorguHook s(0)/s(4): bg_sorgu + ampul salınımı + w1_hook sticker (sorgucu, sağda, flip) + başlık: 'Qulo''ya girmeden önce' / 'ifadeniz alınacak.' (danger)
- S2 Kurallar s(4)/s(7-4=3): başlık: '3 soru. 4 şık.' / 'Yalan *yok*.' + dosya kartı görseli (Remotion: paper kart 'DOSYA NO: QULO-01' YAZMASIN — metin kuralı: Türkçe serbest, yaz: 'İFADE TUTANAĞI').
- S3 Sorgu1 s(7)/s(6.5): InterrogationScene m1 + SORGU_SORULARI[0] + eliminated (mugshot).
- S4 Sorgu2 s(13.5)/s(6.5): InterrogationScene m2 + SORGU_SORULARI[1] + eliminated.
- S5 Sorgu3 s(20)/s(6): InterrogationScene m3 + SORGU_SORULARI[2] + temiz (yeşil damga 'TEMİZ') + MatchSpark mini (label 'Eşleşme!').
- S6 S5Closing s(26)/s(4): topLine 'Yalanı olan giremez.'
Toplam: 120+90+195+195+180+120 = 900 ✓ (s() ile: 4+3+6.5+6.5+6+4=30sn)
Composition `QuloReelsSorgu` 900f — Root'ta durationInFrames config'ten gelir (zaten öyle).
Audio: music_30s.mp3 (kopyala: qulo-twitter-tr/public/audio/music_30s.mp3 → public/audio/music_30s.mp3), volume 0.65.

## Görevler
1. Manifest BG_SUFFIX + 2 plate + script bg_ skip-chroma + üretim + KULLANICI ONAYI (ana session).
2. BackdropPlate + OptionsCard + EliminationStamp + InterrogationScene + SorguHook/Kurallar sahneleri + SorguSoru tipi + r2.config + kayıt + still + review. (Mevcut bileşen/sahnelere DOKUNULMAZ; 900f farklılığına dikkat — reelsConfig'lerin hepsi kendi durationInFrames'ini taşıyor, Root config'ten okuyor, sorun yok.)
3. Render (30sn) + kapak + deliverables 08 + birleşik video + KATALOG + teslim.
Doğrulama: tsc + still + göz + commit. Git yavaş (timeout ≥300s).
