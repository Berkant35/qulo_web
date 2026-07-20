# Photo Reverse-Prompt Skill — Tasarım Spec'i

**Tarih:** 2026-07-20
**Konum:** `~/.claude/skills/photo-reverse-prompt/SKILL.md` (global skill)
**Durum:** Onaylandı (brainstorming session)

## Amaç

Kullanıcı bir fotoğraf attığında, Claude o fotoğrafı 4 aşamalı çerçeveyle analiz edip
Nano Banana'ya (Gemini image generation) yapıştırılmaya hazır, **aynı kalitede, aynı
gerçeklikte, aynı çirkinlikte/güzellikte** sonuç üretecek tek bir İngilizce reverse-prompt
bloğu çıkarır.

Temel problem: görsel üretim modelleri her şeyi "clean girl" estetiğine çeker —
pürüzsüz cilt, mükemmel ışık, minimal/estetik ortam. Bu skill o eğilimi sistematik
olarak kırar; fotoğrafın ham, filtresiz gerçekliğini kelimelere döker.

## Kapsam ve Guardrail

- **Fenotip üretir, kimlik kopyalamaz.** Gerçek kişinin yüz geometrisi/benzerliği
  birebir tarif edilmez; yerine aynı arketipte kurgusal bir kişi tanımlanır
  (yaş aralığı, tip, ifade, doku). Bu kural SKILL.md'ye açık yazılır.
- Kullanıcı zaten kimlik kopyası istemiyor; amaç gerçeğe yakın fenotipler +
  fotoğraf gerçekliği (kalite, ortam, kıyafet/ayakkabı dahil tüm detaylar).

## Tetikleyiciler

Fotoğraf + şu ifadeler: "reverse prompt", "bu fotoğrafı analiz et",
"nano banana promptu çıkar", "fenotip çıkar", "bu fotoğrafın promptunu ver".

## Analiz Çerçevesi (4 aşama)

### 1. 📷 Teknik DNA (Fotoğraf Kalitesi)
- Çekim cihazı tahmini (ör. "2018 orta segment Android ön kamera")
- Çözünürlük hissi, noise/grain seviyesi, JPEG artifact'leri
- Işık kaynağı ve kusurları: floresan sarısı, sert flaş, karışık beyaz dengesi
- Netlik/bulanıklık, kadraj hataları (kesik alın, eğik ufuk)
- Amaç: modelin "stüdyo kalitesi" varsayılanını kırmak

### 2. 👤 Fenotip (kimlik değil, tip)
- Yaş aralığı, vücut/yüz tipi — kategorik tarif
- Cilt gerçekliği: gözenek, sivilce izi, göz altı morluğu, yağlanma
- Bakış/ifade mikro-analizi: "gözlerdeki kötülük" → soğuk küçümseyen bakış,
  yorgun boş bakış, gergin zoraki gülümseme vb. kelimelere dökülür
- Saç durumu: yağlı dip, kaçmış tel, kötü boya
- Kıyafet + ayakkabı dahil her giyim detayı: yıpranmışlık, markasızlık, uyumsuzluk
- KURAL: yüz geometrisi birebir tarif edilmez, arketip tarif edilir

### 3. 🏠 Ortam
- Mekân tipi + dağınıklık envanteri (arka plandaki somut objeler tek tek)
- Duvar/zemin durumu: soyulmuş boya, eski halı, nem lekesi
- Eşya kalitesi ve "yaşanmışlık" işaretleri
- Anti-pattern: minimal/estetik/pinterest ortam YASAK

### 4. 🚫 Anti-Clean-Girl Kural Bloğu
- Sabit direktif seti: "no beautification, no skin smoothing, no perfect symmetry,
  no golden-hour lighting, amateur photo, unflattering angle…"
- + fotoğrafa özel negatifler

## Çıktı Formatı

1. **Türkçe analiz raporu** — yukarıdaki 4 başlıkla, insan-okur
2. **Tek İngilizce prompt bloğu** — kopyala-yapıştır hazır; kalite direktifleri +
   fenotip + ortam + anti-clean-girl direktifleri tek paragraf akışında;
   en boy oranı ve çözünürlük hissi dahil

Varyasyon: varsayılan tek prompt, birebir sadakat. Kullanıcı "varyasyon üret"
derse aynı kalite/ortam estetiği korunarak farklı fenotipler üretilir.

## Yapı Kararı

Tek dosyalı SKILL.md (Yaklaşım A). Kod yok, saf analiz + yazım skill'i.
Lexicon büyürse ileride `references/` dosyasına bölünebilir (YAGNI — şimdilik değil).

## Test / Doğrulama

Yazımdan sonra örnek bir fotoğrafla denenir; çıktı prompt'u Nano Banana'da
beklenen gerçekliği veriyor mu birlikte doğrulanır. Gerekirse gerçeklik
kelime dağarcığı iterasyonla güçlendirilir.
