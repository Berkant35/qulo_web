# AI Arama SEO — Uygulama Kaydı (2026-08-01)

Kaynak araştırma: [`seo-ai-search-research-2026-08.md`](./seo-ai-search-research-2026-08.md)
(19 arama, her iddia birincil kaynak / korelasyon çalışması / spekülasyon olarak etiketli).

## Araştırmanın değiştirdiği karar

Google 2026-05-15'te ilk resmî üretken-AI optimizasyon dokümanını yayımladı ve orada
yaygın "AI SEO" taktiklerinin çoğunu **mit** olarak adlandırdı. Bunun somut sonucu:
planlanan işlerin bir kısmı **yapılmadı**, çünkü kanıt desteklemiyor.

| Yaygın tavsiye | Karar | Gerekçe |
|---|---|---|
| `llms.txt` ekle | ❌ Yapılmadı | Google "Search bunu kullanmıyor" diyor; 137k alan adı taraması: dosyayı yayımlayanların %97'si sıfır istek almış |
| Daha çok schema tipi ekle | ❌ Yapılmadı | Ahrefs kontrollü testi (1.885 sayfa vs 4.000 kontrol): AI Mode/ChatGPT'de artış yok, AI Overviews'ta **−%4,6** |
| İçeriği "AI için" parçalara böl | ❌ Yapılmadı | Google açıkça mit diyor |
| Görünmeyen içeriği JSON-LD ile işaretle | ❌ Kaldırıldı | searchVIU testi: 5 AI sisteminin **hiçbiri** yalnızca JSON-LD'deki değerleri okumadı |

Asıl kaldıraç iki maddede toplanıyor: **AI crawler'ları JavaScript çalıştırmıyor**
(dolayısıyla içerik statik HTML'de olmalı) ve **alıntıların çoğu site dışı editoryal
içerikten geliyor** (uygulama tavsiyelerinde %62,4 listicle, %9,5 store listelemesi).

## Yapılanlar

### 1. AI crawler erişimi — doğrulandı, varsayılmadı
Üretimde her user-agent ile gerçek istek atıldı: GPTBot, OAI-SearchBot, ChatGPT-User,
ClaudeBot, PerplexityBot, Googlebot → **hepsi HTTP 200, 126.885 byte, `<h1>` mevcut.**
Netlify tarafında bot engeli yok. (Araştırma bunu en sık görülen sessiz blokaj olarak
işaretliyordu; kod değil edge kuralları suçlu oluyor.)

### 2. `/help` — 16 dilde SSS içeriği HTML'e taşındı ⭐ en büyük kazanım
Sayfa tamamen `"use client"` idi ve cevaplar `{open && ...}` ile koşulluydu: kullanıcı
tıklamadan **cevaplar DOM'a hiç girmiyordu**. Canlı ölçüm: 146 görünür kelime, 12 soru,
**0 cevap**; sayfada `/help` SSS'ine ait şema da yoktu.

Server component'e çevrildi, `<details>/<summary>` ile JS'siz akordeon (mevcut `FAQ.tsx`
deseni), tek birleşik `FAQPage` şeması.

| | Önce | Sonra |
|---|---|---|
| `/en/help` görünür karakter | ~1.000 (yalnız sorular) | 1.956 |
| JSON-LD `Question` girdisi | 5 (jenerik site geneli) | 12 (sayfanın kendi SSS'i) |
| Cevap içeren locale | 0/16 | **16/16** |

### 3. Ana sayfa — görünmez şema görünür içeriğe dönüştü
`FAQ_DATA` yalnızca JSON-LD olarak yayınlanıyordu; hiçbir sayfada görünmüyordu. Bu tam
olarak araştırmanın "hiçbir AI sistemi okumuyor" dediği durum. Ana sayfaya görünür FAQ
bölümü eklendi; şema oraya taşındı ve site geneli yayından kaldırıldı.

Eksik çeviriler tamamlandı: `FAQ_DATA` artık **16/16 locale × 5 soru** (önce 12 locale,
çoğu 2-3 soru; nl/pl/sv/hi hiç yoktu). `FAQ_TITLES` 5 → 16 locale.

Bu sorular fan-out alt-sorgularının birebir karşılığı: "Qulo ücretsiz mi?",
"Qulo güvenli mi?", "nasıl çalışır?".

### 4. `robots.txt` — bozuk yapı düzeltildi + niyet belgelendi
- İki ayrı `User-agent: *` grubu vardı; bazı parser'lar yalnızca sonuncuyu tutar ve
  `Allow: /` sessizce kaybolur → tek gruba indirildi.
- `Disallow: /_next/` kaldırıldı: Google render için CSS/JS'e ihtiyaç duyuyor,
  render etmeyen crawler'lar içinse zaten bir kazanç yoktu.
- 15 crawler için açık `Allow` bloğu eklendi (Googlebot, Google-Extended, Bingbot,
  Applebot(-Extended), OAI-SearchBot, GPTBot, ChatGPT-User, ClaudeBot, Claude-User,
  Claude-SearchBot, PerplexityBot, Perplexity-User, Amazonbot, meta-externalagent).
  `*` zaten izin veriyor; bu bloklar niyeti belgeliyor ve ileride iyi niyetli bir
  "AI botlarını kapatalım" düzenlemesinin sessizce bizi silmesini zorlaştırıyor.

### 5. Sitemap ve indeks temizliği
- `sitemap-0.xml` indekste iki kez listeleniyordu → tek girdi.
- `/invite`, `/email-verified`, `/reset-password` (**48 URL**) sitemap'ten çıkarıldı.
  Bu sayfaların kendi metadata'sı yoktu; ana sayfanın canonical'ını miras alıyor,
  yani 48 URL "asıl sayfa ana sayfadır" sinyali veriyordu. Artık `noindex, follow` +
  kendi canonical'ları var. Sitemap: 978 → 930 URL.
- Tekdüze `priority 0.7` yerine kademeli öncelik (ana sayfa 1.0, makaleler 0.9,
  içerik sayfaları 0.8).

### 6. Yapısal veri doğruluğu
- `wordCount` her yazıda sabit `1500` yazıyordu → yapısal yazılarda gerçek değer
  hesaplanıyor (ör. 918), eski JSX yazılarında **uydurmak yerine alan atlanıyor**.
- `dateModified` her zaman `datePublished`'a eşitti → opsiyonel `updatedAt` alanı
  eklendi. Tazelik sinyali önemli (AI'ın alıntıladığı sayfaların %75'i son bir yıl
  içinde güncellenmiş) ama **içerik gerçekten değişmeden tarih bumplamak** işe
  yaramaz; alan bilinçli olarak opsiyonel.
- `FAQPage` şeması artık yalnızca görünür SSS bulunan sayfalarda.
- `og:image` + `twitter:image`: 979 sayfanın 976'sında (önce ~28). Kalan 3'ü
  kapsam dışı (kök yönlendirme, 404, brandLogo).

### 7. Kod temizliği (dokunulan dosya kuralı)
- Paylaşılan `JsonLd` komponenti (`<` kaçışıyla `</script>` breakout kapalı).
  16 sayfada aynı fonksiyonun kopyası var — yenisi ve dokunulanlar bunu kullanıyor.
- `FAQ.tsx`: `FaqList` + `faqPageSchema` ayrıştırıldı; birden çok bölüm gösteren
  sayfalar tek birleşik şema yayımlayabiliyor.
- `blog/[slug]` içerik yönlendirmesi: yapısal yazılar için `STRUCTURED_ARTICLES`
  kaydı — her yeni yazı için `case` bloğu eklemeye gerek kalmadı.
- `utilityRoute.ts` + `openGraph.ts` yardımcıları.

## Doğrulama

```
npx tsc --noEmit   → exit 0
npm run lint       → exit 0
npm run build      → exit 0, 982/982 sayfa
```
Üretilen HTML üzerinden: robots.txt tek `*` grubu / `_next` yok / 15 bot,
sitemap 930 URL & utility route yok, 16/16 ana sayfa 5 soruluk şema,
16/16 help sayfası 12 soruluk şema + görünür cevaplar, 3 utility route `noindex`
+ kendi canonical'ı, `wordCount` gerçek.

## Yapılmadı — sıradaki iş (etki sırasıyla)

1. **Site dışı editoryal yerleşim.** Bu dokümandaki her şeyden yüksek etkili, en yüksek
   emek. Uygulama tavsiyesi alıntılarının %62,4'ü editoryal listicle'lardan;
   markalı web bahsi AI Overview görünürlüğüyle 0,664 korelasyon (backlink: 0,218).
   Somut adım: `/press` sayfasını gerçek bir basın kitine dönüştürmek (logo paketi,
   kurucu biyografisi, tek cümlelik ve tek paragraflık boilerplate, tarihli istatistikler),
   sonra "best dating apps 2026" için zaten sıralanan sitelere pitch.
2. **Cevap biçimli sayfalar** (`/is-qulo-free`, `/how-qulo-matching-works`, `/is-qulo-safe`).
   Semrush: Q&A formatı +%25,45, bölüm yapısı +%22,91. Karşılaştırma sayfalarında
   rakip ismi vermeme kuralı geçerli — "swipe tabanlı uygulamalar" jenerik çerçevesi.
   Dikkat: `dating-app-without-swiping` mevcut blog yazısıyla keyword çakışır.
3. **Bing Webmaster Tools + IndexNow.** ChatGPT retrieval'ı tarihsel olarak Bing
   verisine yaslanıyor; Bing schema'nın LLM'lerine yardım ettiğini açıkça söyleyen
   tek platform.
4. **7 eski blog yazısının 11 dilde İngilizce gövde sunması** — 98 URL'de hreflang
   ile içerik uyuşmuyor. `_content/*.ts` yapısal modeline taşınmalı.
5. **`<html lang="en">` 16 dilin hepsinde sabit.** Gerçek `lang`/`dir` yalnızca client
   script ile atanıyor; JS çalıştırmayan crawler'lar her sayfayı İngilizce görüyor.
   Düzeltmesi Next.js'te birden çok kök layout gerektiriyor (route group refactor) —
   ayrı ve dikkatli bir PR.
6. **Search Console doğrulaması boş** (`verification: {}`), üretken AI performans
   raporu açılamıyor. GA4'e `chatgpt.com` / `perplexity.ai` / `claude.ai` referral
   segmentleri eklenmeli.
7. `public/feed.xml` elle güncelleniyor, İngilizce ve son iki yazı eksik.
8. 20 istatistiğin 16'sı kaynaksız (`stats.ts`); blog gövdelerinde de kaynaksız yüzdeler var.

**Kalibrasyon:** AI referral trafiği hâlâ global web trafiğinin ~%0,15–0,25'i.
Bu iş klasik SEO'nun yerine değil, üstüne yapılır.
