# Qulo Reels Reklam Varyantları (A/B/C) — Plan

**Goal:** Mevcut `entertainment/qulo-reels-tr` altyapısıyla (bileşenler + config-driven oynatıcı) 3 yeni ~25sn 9:16 varyant üretmek. Mevcut `QuloReelsAd` composition'ı DEĞİŞMEZ. Kullanıcı isteği: daha zengin kolaj ortamı (prop sticker'lar, daha yoğun şekiller), infografik hissinin azaltılması.

**Mimari:** Tek proje, çoklu composition. `Root.tsx` 4 composition kaydeder: `QuloReelsAd` (mevcut), `QuloReelsTersKose`, `QuloReelsKaos`, `QuloReelsBulusma`. Ortak `renderScene` switch'i büyür; her varyantın kendi config dosyası olur (`configs/terskose.config.ts` vb). Sahneler prop-parametrik hale getirilir (varsayılanlar mevcut davranışı korur) ki varyantlar aynı sahne bileşenlerini farklı figür/soru setleriyle kullanabilsin. Prop sticker'lar mevcut `CollageSticker` ile konur (küçük width).

**Kanonik evren:** Video 1'deki kadın (w1) ve kazanan erkek (m3) marka karakterleridir; varyantlarda tutarlı şekilde yeniden kullanılır (B'de bunalmış hali w1 referanslı üretilir; C'de çift sahneleri w1+m3 çift-referanslı üretilir).

## Global kurallar (video 1 ile aynı)
1080×1920 @30fps 750f; Türkçe; elmas YOK; AI görselde metin/UI YOK; S/B figür + beyaz kontur + yeşil fon (#00FF00) sticker stili; policy-güvenli; theme token; safe zone top140/bottom260/h70; sticker konum sözleşmesi top = y - width (görünür alt ≈ y + 0.49w, hedef ≤1650); still doğrulama otoritedir; git yavaş (timeout ≥300s).

## Yeni asset'ler (tools/assets.manifest.mjs'e eklenir)

| id | içerik | referans |
|----|--------|----------|
| m_hook | özgüvenli şık erkek, kollar çapraz, hafif gülümseme (A hook+jüri+eşleşme) | — |
| w2 | çekici kadın aday, casual şık, yürürken (A eleme 1) | — |
| w3 | çekici kadın aday, sportif stil, selam veren (A eleme 2) | — |
| w1_tired | AYNI kadın (w1), telefona bakıp bunalmış, eli alnında (B hook) | w1_hook |
| c_cafe | AYNI çift (w1+m3) kafede kahve içip gülüşürken, tek sticker | w1_hook + m3 (çift referans) |
| c_cat | AYNI çift bir kediyle oynarken | w1_hook + m3 |
| c_walk | AYNI çift parkta yürürken | w1_hook + m3 |
| prop_plak | vinil plak, sticker | — |
| prop_pizza | pizza dilimi, sticker | — |

Araç değişikliği: `referenceOf` string VEYA string[] kabul etmeli (çift referans için); prop'lar için aspectRatio '1:1'.

## Varyant A — "Ters Köşe" (`QuloReelsTersKose`, configs/terskose.config.ts)
Erkek perspektifi; sahne bileşenleri prop-parametrik olarak yeniden kullanılır.
Sorular (SORULAR_ERKEK, configs/questions.ts'e eklenir): {Plak mı playlist mi? → Plak / Playlist}, {Dağ mı deniz mi? → Dağ / Deniz}, {Pizza mı sushi mi? → Pizza / Sushi}
- S1 Hook (0-3): m_hook + "Herkes sana yazsın istemezsin." (alternatif kısa: "Kalabalık değil, *doğru kişi*.") — still ile karar.
- S2 Kurallar (3-9): m_hook (aynı figür, ayna) + erkek soruları + set çipleri + prop_plak/prop_pizza küçük sticker'lar kartların çevresinde.
- S3 Eleme (9-17): kadın adaylar w2 (✕ Playlist), w3 (✕ Deniz), w1 (✓ Pizza — kazanan, video 1 kadını!).
- S4 Eşleşme (17-22): m_hook + w1 + MatchSpark.
- S5 Kapanış (22-25): mevcut S5Closing aynen.

## Varyant B — "Kaos'tan Kurala" (`QuloReelsKaos`, configs/kaos.config.ts)
En yoğun kolaj. Yeni sahneler: KaosRain, KaosSweep.
- S1 KaosRain (0-5): Remotion-çizimi mini profil kartları yağmuru (30-40 kart: paper zemin, gri avatar dairesi + çizgi placeholder — AI değil) + w1_tired ortada. Metin: "Yüzlerce profil. *Sıfır* bağ."
- S2 KaosSweep (5-8): kartlar hızla yanlara süpürülür (interpolate), tek büyük soru kartı kalır. Metin: "Kaydırma *bitti*."
- S3 Mekanik (8-15): S2Rules parametrik (w1_point + SORULAR ilk 2'si + set çipleri).
- S4 Eleme+Eşleşme (15-22): tek round eleme (m1 ✕) → m3 ✓ → MatchSpark (sıkıştırılmış; S3Elimination 2-round parametrik varyasyonu veya yeni kompakt sahne).
- S5 Kapanış (22-25): S5Closing.

## Varyant C — "Buluşma Payoff'u" (`QuloReelsBulusma`, configs/bulusma.config.ts)
Duygusal; video 1'in sorularının gerçeğe dönüşmesi. Yeni sahne: PayoffScene (parametrik: soru kartı küçük üstte + büyük çift sticker'ı + caption).
- S1 Hook (0-4): "Doğru cevaplar ne işe yarar?" + w1+m3 mini eşleşme recap (MatchSpark küçük).
- S2 Payoff 1 (4-10): "Kahve mi çay mı? ✓Kahve" kartı → c_cafe büyük sticker. Caption: "İlk kahve."
- S3 Payoff 2 (10-16): "Kedi mi köpek mi? ✓Kedi" → c_cat. Caption: "Kedisiyle tanıştın."
- S4 Payoff 3 (16-21): "İlk buluşma: yürüyüş ✓" → c_walk. Caption: "O yürüyüş."
- S5 Kapanış (21-25): S5Closing + üst satır "Doğru cevaplar buluşmaya dönüşür."

## Görevler
1. Araç: referenceOf array desteği + manifest 9 yeni asset + prop aspect '1:1' (küçük).
2. Asset üretimi + KULLANICI ONAYI (ana session, interaktif).
3. Refactor: sahneleri prop-parametrik yap (S1Hook/S2Rules/S3Elimination/S4Match imzalarına opsiyonel props; varsayılan = mevcut davranış; QuloReelsAd render çıktısı DEĞİŞMEMELİ — mevcut still'lerle karşılaştırılır) + Root çoklu composition + PlayerFactory.
4. Varyant A sahne/config + still doğrulama + review.
5. Varyant B (KaosRain/KaosSweep yeni bileşenleriyle) + still + review.
6. Varyant C (PayoffScene) + still + review.
7. 3 render + kapaklar + kullanıcıya teslim. Çıktı adları: out/qulo-reels-tr-terskose.mp4, -kaos.mp4, -bulusma.mp4 (+ cover'lar).

Doğrulama her görevde: tsc + still + göz + commit. Reviewer per task (mevcut SDD akışı).
