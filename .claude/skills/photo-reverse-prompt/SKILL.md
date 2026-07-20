---
name: photo-reverse-prompt
description: Use when the user shares a photo and wants a reverse prompt for image generation - triggers include "reverse prompt", "bu fotoğrafı analiz et", "nano banana promptu çıkar", "fenotip çıkar", "bu fotoğrafın promptunu ver". Analyzes photo quality, subject phenotype and environment realism, then outputs a Turkish analysis report plus one copy-paste English prompt that reproduces the photo's raw unfiltered realism in Nano Banana / Gemini image generation - without copying any real person's identity.
---

# Photo Reverse-Prompt — Gerçeklik Çıkarıcı

## Amaç

Kullanıcının paylaştığı fotoğrafı analiz edip, görsel üretim modeline (Nano Banana /
Gemini) verildiğinde **aynı kaliteyi, aynı gerçekliği, aynı çirkinliği/güzelliği**
üretecek tek bir İngilizce prompt bloğu çıkarmak.

Temel problem: görsel modeller her şeyi "clean girl" estetiğine çeker — pürüzsüz cilt,
mükemmel ışık, minimal/estetik ortam. Bu skill o sapmayı sistematik olarak kırar.

**Sadakat ilkesi:** Amaç fotoğrafı kötüleştirmek DEĞİL, doğru tespit etmek. Fotoğraf
gerçekten kaliteliyse kaliteli tarif et; çirkinse çirkin. Anti-clean-girl bloğu yalnızca
modelin otomatik güzelleştirme eğilimini bastırmak içindir.

## Guardrail — Kimlik Kopyalama YASAK

- Gerçek kişinin yüz geometrisini, birebir benzerliğini, ayırt edici benzersiz
  kombinasyonunu tarif ETME. "Identical face to", "looks exactly like" tarzı ifadeler YASAK.
- Bunun yerine **arketip** tarif et: yaş aralığı, vücut/yüz tipi kategorisi, ifade,
  cilt dokusu, genel fenotip. Çıktı, aynı tipte KURGUSAL bir kişi üretmeli.
- Fotoğraftaki kişi tanınmış biriyse veya kullanıcı açıkça kimlik kopyası isterse:
  yapamayacağını söyle, arketip versiyonunu öner.

## Akış

1. Fotoğrafı aşağıdaki 4 aşamalı çerçeveyle analiz et — her aşamada checklist'in
   TAMAMINI fotoğrafa karşı kontrol et, görmediğini uydurma
2. Türkçe analiz raporunu 4 başlıkla yaz
3. Sonda tek bir kopyala-yapıştır İngilizce prompt bloğu ver (şablon aşağıda)

## Aşama 1 — 📷 Teknik DNA (Fotoğraf Kalitesi)

Fotoğrafın "nasıl çekildiğini" kelimelere dök. Kontrol listesi:

- **Cihaz tahmini:** telefon mu kamera mı; segment ve dönem hissi
  (ör. "2018 orta segment Android ön kamera", "iPhone arka kamera, gece modu")
- **Çözünürlük hissi:** keskin mi, yumuşak mı, upscale edilmiş mi
- **Noise/grain:** düşük ışık noise'u, renk lekelenmesi (chroma noise), ISO izleri
- **Sıkıştırma:** JPEG artifact'leri, WhatsApp/sosyal medya sıkıştırması izleri
- **Işık kaynağı ve kusurları:** floresan sarısı/yeşili, sert direkt flaş, cam kenarı
  gün ışığı, karışık beyaz dengesi, patlamış parlak alanlar, boğulmuş gölgeler
- **Odak/netlik:** nereye odaklı, motion blur var mı, el titremesi
- **Kadraj:** açı (yukarıdan/aşağıdan/göz hizası), kesik uzuv/alın, eğik ufuk,
  merkezleme hatası, selfie kolu mesafesi
- **Renk karakteri:** soluk mu doygun mu, filtre izi var mı

Amaç: modelin "profesyonel stüdyo fotoğrafı" varsayılanını kırmak. Kalite ne ise onu yaz.

## Aşama 2 — 👤 Fenotip (kimlik değil, tip)

Kişiyi arketip düzeyinde ama ACIMASIZ dürüstlükle tarif et. Kontrol listesi:

- **Temel:** yaş aralığı, cinsiyet, etnik/bölgesel fenotip kategorisi, boy/kilo izlenimi,
  vücut tipi (ince/tıknaz/sarkık/kaslı), duruş (kambur, gergin, rahat)
- **Yüz tipi (kategorik):** yuvarlak/köşeli/uzun, çene yapısı, belirgin özellik
  kategorileri (kalın kaş, geniş burun, ince dudak) — geometri ölçüsü YOK, kategori VAR
- **Cilt gerçekliği:** gözenekler, sivilce/sivilce izi, leke, kızarıklık, yağlanma/parlama,
  göz altı morluğu/torbası, kırışıklık, tüylenme, tıraş izi — NE VARSA yaz
- **Bakış ve ifade (kritik):** gözlerdeki duyguyu isimlendir — soğuk küçümseyen bakış,
  yorgun boş bakış, sinsi yan bakış, gergin zoraki gülümseme, mesafeli poz gülümsemesi,
  içten kahkaha. Mikro-ifadeyi yakala: ağız gülüyor ama gözler gülmüyor mu?
- **Saç:** kesim, renk (dip boyası kaçmış mı), yağlılık, dağınıklık, incelme/dökülme
- **Kıyafet — AYAKKABI DAHİL her parça:** her giysiyi tek tek tarif et — tip, renk,
  kumaş hissi, yıpranmışlık (boncuklanma, solma, leke, buruşukluk), beden uyumu
  (dar/bol/sarkmış), marka hissi (markasız/taklit/ucuz zincir mağaza/pahalı),
  kombinasyon uyumsuzluğu; ayakkabı: model tipi, eskime, temizlik, çorap detayı
- **Aksesuar:** takı, saat, telefon, çanta — kalite ve eskime hissiyle

KURAL: Bu tarif KURGUSAL bir kişi üretmeli — Guardrail bölümüne uy.

## Aşama 3 — 🏠 Ortam

Mekânı "yaşanmışlık envanteri" olarak çıkar. Kontrol listesi:

- **Mekân tipi:** ev odası, mutfak, sokak, düğün salonu, araba içi, iş yeri...
- **Arka plan envanteri:** görünen HER somut objeyi tek tek say — çamaşır askısı,
  tüp, dağınık yatak, poşet, kablo yumağı, buzdolabı magnetleri, halı deseni
- **Yüzeyler:** duvar (soyulmuş boya, nem lekesi, çivi deliği, eski poster izi),
  zemin (eski halı, muşamba, çatlak fayans), tavan (avize tipi, floresan)
- **Eşya kalitesi:** mobilya dönemi ve yıpranmışlığı, örtü/dantel, ucuz plastik eşya
- **Düzen durumu:** dağınıklık derecesi ve türü — gerçek yaşanmışlık işaretleri
- **Derinlik:** arka planda ne kadar alan görünüyor, kapı aralığından ne görünüyor

ANTI-PATTERN: Ortamı asla "minimal, estetik, pinterest-worthy, cozy" diye
güzelleştirme. Ortam neyse o — sıradanlık ve kusur, gerçekliğin kendisidir.

## Aşama 4 — 🚫 Anti-Clean-Girl Kural Bloğu

Prompt'un sonuna eklenen direktif seti. Çekirdek (her zaman):

```
Raw unedited amateur photo, not a professional photoshoot. No beautification,
no skin smoothing, no makeup enhancement, no perfect symmetry, no golden-hour
lighting, no cinematic color grading, no bokeh unless present in source.
Keep skin texture, pores, blemishes and asymmetry exactly as described.
Ordinary lived-in environment, not staged, not aesthetic, not minimalist.
```

+ Fotoğrafa özel ekler: analizde tespit ettiğin kusurları negatife çevir
(ör. fotoğraf sert flaşlıysa → "harsh direct flash, flattened shadows";
ortam dağınıksa → "cluttered background must stay cluttered").

Fotoğraf gerçekten kaliteli/güzelse çekirdek bloğu buna göre yumuşat —
sadakat ilkesi anti-clean-girl bloğundan üstündür.

## Çıktı Formatı

Önce Türkçe analiz raporu, sonra prompt bloğu. Şablon:

```
## 📷 Teknik DNA
[analiz]

## 👤 Fenotip
[analiz]

## 🏠 Ortam
[analiz]

## 🚫 Fotoğrafa Özel Negatifler
[analiz]

---

## 🎯 Nano Banana Prompt

[Tek paragraf akışında İngilizce prompt: kamera/kalite tarifi → kişi (arketip)
→ poz ve ifade → kıyafet ve ayakkabı → ortam envanteri → ışık → anti-clean-girl
bloğu. Sonuna en boy oranı ve çözünürlük hissi: ör. "3:4 portrait, smartphone
front camera quality, slightly soft 12MP look".]
```

Prompt bloğu TEK parça olmalı — kullanıcı kopyalayıp direkt yapıştıracak.

## Varyasyon

Varsayılan: tek prompt, kaynak fotoğrafa birebir sadakat.
Kullanıcı "varyasyon üret" derse: Teknik DNA + Ortam + Anti-Clean-Girl bloğu AYNEN
korunur, yalnızca fenotip değiştirilir (farklı yaş/tip/saç/kıyafet kombinasyonu) —
her varyasyon yine tek parça prompt olarak verilir.
