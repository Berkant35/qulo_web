# Qulo Reels Varyantları — 2. Dalga (E: TV Yarışması, H: Kalabalık Yalnızlığı)

Altyapı: `entertainment/qulo-reels-tr` (bkz. 2026-07-12-qulo-reels-tr-variants.md — Global kurallar aynen geçerli).
**YENİ KURAL (kullanıcı, kalıcı):** Sorular TR flört draması mizahıyla keskin olmalı; "kedi/köpek" tarzı jenerik soru YASAK (bkz. memory feedback_qulo_ad_questions_edgy). Policy sınırı: aşağılama/cinsellik yok.

## Yeni soru setleri (questions.ts)
```ts
export const SORULAR_SOV: readonly SoruSpec[] = [
  {soru: 'Evli misin?', dogru: 'Hayır!', yanlis: 'Ayrılmak üzereyiz'},
  {soru: 'Aynı anda kaç kişiyle yazışıyorsun?', dogru: 'Sadece seninle', yanlis: 'Üç... belki dört'},
  {soru: 'Eski sevgilin numaranı biliyor mu?', dogru: 'Engelledim', yanlis: 'Dün aradı'},
];
export const SORULAR_PARTI: readonly SoruSpec[] = [
  {soru: 'Gerçekten bekâr mısın?', dogru: 'Evet, gerçekten', yanlis: 'Karmaşık'},
  {soru: 'Buradaki kaç kişiye mesaj attın?', dogru: 'Kimseye', yanlis: 'Saymadım'},
];
```

## Yeni asset'ler
| id | içerik | aspect | ref |
|----|--------|--------|-----|
| e_host | 70'ler şovmeni: parlak ceket, elde retro mikrofon, abartılı gülümseme, sahne jesti | 2:3 | — |
| e_curtain | retro sahne perdesi dokusu (kıvrımlı kadife), sticker şerit | 3:4 | — |
| h_crowd1 | parti kalabalığı kesiti: 3-4 kişi hepsi telefonuna bakıyor, içkiler ellerinde | 3:4 | — |
| h_crowd2 | ikinci kalabalık kesiti: farklı 3-4 kişi, telefonda, sırtlar yarı dönük | 3:4 | — |
| h_look_w | AYNI kadın (w1 ref): omzunun üzerinden bakış, hafif gülümseme, elinde içecek | 2:3 | w1_hook |
| h_look_m | AYNI erkek (m_hook ref): kalabalık ötesine bakış, elinde bardak, meraklı ifade | 2:3 | m_hook |
| prop_disko | disko topu | 1:1 | — |

## Varyant E — "Retro TV Yarışması" (`QuloReelsSov`, configs/sov.config.ts, 750f)
- S1 ShowIntro (0-4s, yeni sahne): TV çerçevesi + tarama çizgileri (Remotion CSS), perde (e_curtain arka şerit), spot ışık konileri (CSS gradient), retro başlık kartı: **"DOĞRU CEVAP KİMDE?"** (sarımsı retro tip + Poppins 900), e_host slap-in + alt bant: "Türkiye'nin en dürüst yarışması."
- S2 Kurallar (4-9s): S2Rules parametrik: stickerSrc e_host, lines ['Kural basit:', 'Yanlış cevap = *elenirsin*.'], sorular: SORULAR_SOV ilk kart (slice(0,1)) — tek büyük kart "Evli misin?" ✓ Hayır! set çipi.
- S3 Eleme (9-19s): S3Elimination rounds: m1 ✕ 'Ayrılmak üzereyiz' (SORULAR_SOV[0]), m2 ✕ 'Üç... belki dört' (SORULAR_SOV[1]), m3 ✓ 'Engelledim' (SORULAR_SOV[2]); jüri: w1_hook. Podyum hissi: sahne altına Remotion podyum bantları (KOLAY: CollageShapes yeterli — podyum eklemek İSTEĞE BAĞLI, still'e göre karar).
- S4 Eşleşme (19-22s): S4Match m3 + w1 + MatchSpark + PaperShreds konfeti (2 burst).
- S5 (22-25s): S5Closing topLine 'Gerçek hayatta yarışma yok. Qulo var.'

## Varyant H — "Kalabalık Yalnızlığı" (`QuloReelsParti`, configs/parti.config.ts, 750f)
- S1 PartyCrowd (0-5s, yeni sahne): koyu zemin + prop_disko üstte döner (rotate anim) + ışık benekleri (CSS); h_crowd1/h_crowd2 kesitleri alt yarıda; herkes telefonda. Metin: 'Kalabalık bir oda.' / '*Sıfır* tanışma.'
- S2 EyeContact (5-10s, yeni sahne): kalabalık soluklaşır (opacity 0.25), h_look_w sol alt + h_look_m sağ alt köşelerden birbirine bakar; aralarında noktalı çizgi (CSS) çizilir. Metin: 'Bir bakış *yetmez*.'
- S3 Sorular (10-16s): S2Rules parametrik: stickerSrc h_look_w, stickerX 240, sorular SORULAR_PARTI (2 kart, set çipli), lines ['Önce', 'sorularımı geç.']
- S4 Eşleşme (16-21s): S4Match h_look_w + h_look_m (flip) + MatchSpark.
- S5 (21-25s): S5Closing topLine 'Kalabalıkta değil, doğru soruda tanışırsınız.'

## Görevler
1. Manifest + 7 asset üretimi + KULLANICI ONAYI (ana session).
2. Varyant E: ShowIntro sahnesi + sov.config + kayıt + still + review.
3. Varyant H: PartyCrowd + EyeContact sahneleri + parti.config + kayıt + still + review.
4. 2 render + kapaklar + deliverables güncelleme (05/06 + birleşik video yenile + KATALOG) + teslim.
Doğrulama her görevde: tsc + still + göz + commit. Git yavaş (timeout ≥300s).
