# Qulo SEO Blog — Yayın Günlüğü

`qulo-seo-blog` skill'inin her çalışmasında buraya bir satır işlenir. Amaç: konu/keyword
çakışmasını önlemek ve neyin ne zaman yayımlandığını izlemek.

| Tarih | Slug | Ana açı | Hedef keyword'ler | Kaynaklar | Görsel |
|-------|------|---------|-------------------|-----------|--------|
| 2026-07-20 | `psychology-of-the-first-message` | "Selam" görmezden gelinir, soru yanıt alır — soru sormanın (özellikle takip sorusunun) beğeni ve ikinci buluşma yarattığı; Qulo ilk teması zaten soru-cevap yapıyor | first message dating app, best opening lines online dating, how to start a conversation on a dating app, why questions get more replies, dating app opener psychology, ilk mesaj ne yazmalı, sohbet başlatma psikolojisi | Huang et al. 2017 JPSP · Sprecher et al. 2013 JESP · Hinge 2015 opener deneyi (IBTimes) · OkCupid OkTrends 500k+ mesaj | branded SVG→PNG cover (rsvg-convert, Gemini key yok) |
| 2026-07-18 | `what-actually-predicts-compatibility` | "Tipiniz" aşkı öngörmüyor — uyumluluğu etkileşim belirler; profil-tabanlı eşleştirme bilimsel olarak çürük | what predicts compatibility, does your type matter, ideal partner preferences, can you predict attraction, uyumluluk bilimi, aşkı ne belirler | Joel et al. 2020 PNAS · Eastwick & Finkel 2008 JPSP · Finkel et al. 2012 PSPI · Pew 2023 | og-image (site geneli) · post cover: Gemini key beklemede |

**Not (2026-07-18):** Bu yazı **16 dilin hepsinde tam çeviri** (fallback yok) — yapısal `ArticleBlocks` modeliyle (`_content/<slug>.ts` → `LocalizedArticle`). Build'de 16 locale sayfası çevrilmiş içerikle doğrulandı. Yeni yazılar bu modeli izler.

## Mevcut yayınlanmış slug'lar (çakışma referansı)
- what-is-swipe-fatigue
- quiz-dating-future-of-matching
- online-dating-safety-tips
- dating-app-burnout-signs
- dating-apps-without-swiping
- quiz-dating-for-introverts
- science-behind-question-based-matching
- what-actually-predicts-compatibility
- **psychology-of-the-first-message** (yeni)
