# Qulo Reels Varyant P — "İlgi Bombardımanı" (kurtarıcı olarak Qulo)

Altyapı: `entertainment/qulo-reels-tr`. Global kurallar + keskin soru kuralı (memory feedback_qulo_ad_questions_edgy) geçerli.
Konsept: çok beğenilen kadın yüzlerce boş DM'e boğulur → Qulo'nun soru-kapısı filtre olur → kontrol kadına geçer. Kadın güçlendirme; policy-güvenli (tamamen giyinik, cinsellik yok, "olumsuz sonuç" = boş mesaj bombardımanı).

## Yeni soru seti (questions.ts)
```ts
export const SORULAR_DM: readonly SoruSpec[] = [
  {soru: 'Bende en çok ne dikkatini çekti?', dogru: 'Kitap yorumların', yanlis: 'Fotoğrafların'},
  {soru: 'Kaç kişiye bu mesajı attın?', dogru: 'Sadece sana', yanlis: 'Kopyala-yapıştır'},
  {soru: 'Beni tanımak için ne sorarsın?', dogru: 'Neye güldüğünü', yanlis: 'Numaranı'},
];
```

## Asset
| id | içerik | aspect | ref |
|----|--------|--------|-----|
| p_phone | AYNI kadın (w1 ref): telefonu iki eliyle göğüs hizasında tutuyor, ekrana hafif bunalmış/şaşkın bakıyor, şık | 2:3 | w1_hook |

Yeniden kullanılan: w1_hook (özgüvenli), w1_tired (bunalmış), m1/m2/m3 (adaylar+kazanan). DM baloncukları Remotion-çizimi (AI değil).

## Yeni bileşen: MessageRain (src/components/MessageRain.tsx)
Deterministik (rnd, NO Math.random). Props {startFrame, count?, phase?: 'flood'|'clear', originX?, originY?}. Küçük sohbet baloncukları (paper zemin, koyu kısa metin: 'selam', 'müsait misin?', 'çok güzelsin', 'naber', 'tanışalım mı?', '🔥', 'orada mısın?') ekranın üstünden/yanlarından kadına doğru yağar; 'flood'=sürekli akış, 'clear'=hızla yanlara süpürülüp kaybolur. Baloncuk metinleri sabit havuzdan index ile seçilir.

## Sahneler
- S1 DmFlood (0-4s, yeni sahne): koyu zemin; p_phone merkez-alt (w~600, y~1330); MessageRain 'flood' (count ~26) baloncukları yağıyor; başlık: 'Herkes yazıyor.' / '*Kimse* tanımıyor.' accent danger.
- S2 DmProblem (4-8s, yeni sahne): w1_tired merkez; baloncuklar hâlâ yoğun ama kadın bunalmış; başlık: 'Görünür olmak,' / 'bir *yük* mü olmalı?' accent purple.
- S3 Kurallar (8-13s): S2Rules parametrik: stickerSrc w1_point, sorular SORULAR_DM.slice(0,2) (2 kart set çipli), lines ['Artık', 'kurallar *sende*.']. MessageRain 'clear' burst başta (baloncuklar süpürülür).
- S4 Eleme (13-21s): S3Elimination rounds: m1 ✕ 'Fotoğrafların' (SORULAR_DM[0]), m2 ✕ 'Kopyala-yapıştır' (SORULAR_DM[1]), m3 ✓ 'Neye güldüğünü' (SORULAR_DM[2]); jüri w1_hook. (kağıt yırtılma + PaperShreds mevcut.)
- S5 Eşleşme+Kapanış: S4Match s(21)/s(?) ... timing: S4Match s(21)/s(2)? Yetersiz. FINAL timing: S1 s(0)/s(4), S2 s(4)/s(4), S3 s(8)/s(5), S4Elim s(13)/s(6), S4Match s(19)/s(3) {leftSrc w1_hook, rightSrc m3, confetti true}, S5Closing s(22)/s(3) topLine 'Görünürlüğün yükün değil, filtren olsun.' Toplam 750.

## Görevler
1. Manifest + p_phone üretimi + KULLANICI ONAYI (ana session).
2. MessageRain bileşeni + DmFlood/DmProblem sahneleri + p.config + SORULAR_DM + kayıt + still + review.
3. Render + kapak + deliverables (07 + birleşik video + KATALOG) + teslim.
Doğrulama: tsc + still + göz + commit. Git yavaş (timeout ≥300s).
