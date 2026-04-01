# Onboarding Yeniden Tasarımı — Design Spec

**Tarih:** 2026-04-01
**Durum:** Onaylandı
**Kapsam:** qulov2 (Flutter mobile)

---

## Özet

Mevcut iki ayrı onboarding akışını (Welcome + Question Onboarding) tek bir güçlü, hikaye anlatıcı onboarding'e birleştiriyoruz. Parallax efektli geçişler, mevcut Lottie animasyonları ve güç ikonları/elmas SVG'leri kullanarak uygulamanın neon-mor/yeşil tasarım dilini onboarding'e taşıyoruz.

## Tasarım Kararları

| Karar | Seçim |
|-------|-------|
| Akış yapısı | İki onboarding → tek birleşik akış |
| Anlatım stili | Hikaye anlatıcı — karşı perspektif ("biri seni keşfediyor") |
| Dil seçimi konumu | Son sayfa |
| Skip davranışı | Her sayfada "Atla" butonu (sağ üst, mütevazı) |
| Geçiş animasyonu | Parallax — arka plan elementleri farklı hızda hareket eder |
| Elmas stratejisi | Yeşil elmas (kazanç) ön planda, mor elmas detayına girilmez |
| Ürün önerisi | Son sayfada opsiyonel bottom sheet, anında kapatılabilir |

## Sayfa Akışı (5 + 1 Opsiyonel)

### Sayfa 1: "Sorularınla Eşleş" (Hook)

**Hikaye:** Kullanıcıyı yakalayan açılış — Qulo'nun farkını anlat.

**Görsel Yapı:**
- Arka plan: Koyu gradient (`#0D0D0D` → `#1A1A2E`)
- Ortada: `lottie_radar.json` animasyonu (loop, keşif/tarama hissi)
- Parallax katmanı: 6 güç ikonu + elmas SVG'leri, opacity %10-30, swipe yönünün tersine yavaşça süzülür

**İçerik:**
- Başlık: **"Qulo'da Eşleşmek Farklı"** — Poppins Bold 28px, beyaz
- Alt metin: "Burada sorularınla tanışırsın. Birisi tüm sorularını doğru cevaplarsa — eşleşirsiniz!" — Poppins Regular 16px, beyaz %70

**Alt Kısım:**
- Dot indicator: Neon mor (`#BB86FC`) aktif (24px genişlik), gri pasif (8px)
- "İleri" butonu: Mor gradient filled button (`#9C27B0` → `#7B1FA2`)
- "Atla" butonu: Sağ üst köşe, küçük text button, opacity %50

---

### Sayfa 2: "Sorularını Hazırla"

**Hikaye:** "Birisi seni keşfetti ve sorularına bakıyor..."

**Görsel Yapı:**
- Ortada: `boardQuestion.json` Lottie animasyonu
- Parallax katmanı: `ic_help_circle` ve `ic_wand` ikonları farklı derinliklerde süzülür

**İçerik:**
- Başlık: **"Sorularını Hazırla"** — Poppins Bold 28px, beyaz
- Alt metin: "2-10 soru oluştur. Kişisel, eğlenceli, Google'lanamayan sorular sor. Biri tüm sorularını bilirse — eşleşirsiniz!" — Poppins Regular 16px, beyaz %70

**Alt Kısım:** Aynı yapı (dot indicator + İleri + Atla)

---

### Sayfa 3: "6 Süper Güç"

**Hikaye:** "Ama kolay değil! Çözenler süper güçler kullanabilir..."

**Görsel Yapı:**
- 6 güç ikonu staggered animation ile sahneye girer (her biri 100ms arayla)
- Her ikon: Circular container, neon mor glow (box-shadow `#BB86FC` alpha 0.25)
- Düzen: 2x3 grid
- Her ikonun altında tek kelime label
- Parallax katmanı: Yeşil elmas SVG'leri düşük opacity — sonraki sayfaya geçiş ipucu

**Güç Grid İçeriği:**

| İkon | Label | SVG Asset |
|------|-------|-----------|
| Kopyala | `power_copy` | `ic_copy.svg` |
| Yarıla | `power_half` | `ic_split.svg` |
| Atla | `power_skip` | `ic_skip_forward.svg` |
| İpucu | `power_hint` | `ic_lightbulb.svg` |
| Süre+ | `power_time` | `ic_clock.svg` |
| Hepsini Atla | `power_skip_all` | `ic_fast_forward.svg` |

**İçerik:**
- Başlık: **"6 Süper Güç"** — Poppins Bold 28px, beyaz
- Alt metin: "Sorularını çözenler bu güçleri kullanabilir. Her güç mor elmas harcar — ve bu senin kazancın!" — Poppins Regular 16px, beyaz %70

**Alt Kısım:** Aynı yapı

---

### Sayfa 4: "Yeşil Elmas Kazan"

**Hikaye:** "Birisi güç kullandığında sen yeşil elmas kazanıyorsun!"

**Görsel Yapı:**
- Ortada: `buydiamond.json` Lottie animasyonu (elmas kazanç kutlaması)
- Lottie altında mini görsel akış: Güç ikonu (mor glow) → ok (→) → `green_diamond.svg` (yeşil glow, büyük)
- Parallax katmanı: `green_diamond_slide_left.svg` ve `green_diamond_slide_right.svg` arka planda süzülür — sayfa yeşil enerji ile dolu hisseder

**İçerik:**
- Başlık: **"Yeşil Elmas Kazan!"** — Poppins Bold 28px, **yeşil neon (#69F0AE)**
- Alt metin: "Sorularında güç kullanan her kişi sana yeşil elmas kazandırır. Daha çok soru, daha çok kazanç!" — Poppins Regular 16px, beyaz %70

**Renk Notu:** Bu sayfa yeşil vurgulu — başlık rengi, parallax elementleri ve glow'lar yeşil neon kullanır. Diğer sayfalardan farklılaşır.

**Alt Kısım:** Aynı yapı

---

### Sayfa 5: "Dil Seçimi + Başla"

**Hikaye:** Kapanış — "Hazırsın, dilini seç ve başla"

**Görsel Yapı:**
- Üstte: 🌍 globe ikonu veya `location.json` Lottie (kısa loop)
- Ortada: FilterChip'ler ile dil seçimi (en az 1 zorunlu)
- Chip tasarımı: Seçili → `primarySurface` arka plan + mor border, Seçilmemiş → gri outline
- Default seçim: Mevcut uygulama locale'i (veya `tr` fallback)
- Parallax katmanı: Tüm güç ikonları + elmaslar çok düşük opacity (%5-10) — hikayenin özeti

**İçerik:**
- Başlık: **"Hangi Dillerde Soru Görmek İstersin?"** — Poppins Bold 24px, beyaz
- Alt metin: "Seçtiğin dillerdeki profilleri göstereceğiz. Birden fazla seçebilirsin." — Poppins Regular 14px, beyaz %70

**Alt Kısım:**
- "Başla" butonu: Mor gradient filled button, büyük (genişlik dolduran)
- Dot indicator
- "Atla" butonu YOK — bu son sayfa, sadece "Başla" ile kapanır

---

### Sayfa 5.5: Premium Öneri (Opsiyonel Bottom Sheet)

**Tetikleme:** "Başla" tıklandıktan hemen sonra, discover'a geçmeden önce bottom sheet açılır.

**Görsel Yapı:**
- `subscribe.json` Lottie üstte
- 2-3 madde premium avantaj listesi (bullet ile)
- "Premium'a Geç" butonu (mor gradient)
- Sağ üst köşede belirgin "✕" butonu — tek tıkla kapat
- Swipe-down ile de kapatılabilir (DraggableScrollableSheet)

**Kural:** Bu overlay ASLA zorunlu değil. "✕" veya swipe-down ile anında kapatılır ve discover'a devam edilir.

---

## Parallax Sistemi Teknik Detay

### Katman Yapısı
Her sayfa 3 katmandan oluşur:

1. **Arka plan katmanı (en yavaş):** Koyu gradient + çok düşük opacity elementler (%5-10)
2. **Orta katman (orta hız):** Güç ikonları ve elmas SVG'leri, opacity %15-30, PageView scroll offset'ine bağlı hareket
3. **Ön plan (normal hız):** Lottie animasyon + başlık + alt metin + butonlar

### Parallax Hesaplama
- `PageController.addListener` ile scroll pozisyonu dinlenir
- Her katman farklı çarpanla hareket eder:
  - Arka plan: `scrollOffset * 0.3` (yavaş)
  - Orta katman: `scrollOffset * 0.6` (orta)
  - Ön plan: `scrollOffset * 1.0` (normal PageView davranışı)
- Yön: Arka plan elementleri swipe yönünün tersine hareket eder (derinlik illüzyonu)

### Floating Element Animasyonu
- Güç ikonları ve elmaslar `AnimationController` ile sürekli hafif salınım yapar
- Her element farklı faz ve hızda: `sin(time * speed + phase)` ile x/y offset
- Opacity sayfaya göre değişir (ilgili sayfada daha belirgin)

---

## Navigasyon ve State

### Tetikleme
- Kayıt sonrası otomatik gösterilir (mevcut Welcome onboarding yerine)
- SharedPreferences: `'onboarding_v2_seen'` key ile tek seferlik

### Mevcut Akışlarla İlişki
- `OnboardingScreen` (eski Welcome) → kaldırılır, yeni akış ile değiştirilir
- `QuestionOnboardingScreen` (eski Question) → kaldırılır, yeni akışa entegre edilir
- Eski SharedPreferences key'leri (`'onboarding_questions_seen'`) korunur (geriye uyumluluk)

### Çıkış Noktaları
- "Atla" (herhangi bir sayfa) → `onboarding_v2_seen = true`, discover'a yönlendir
- "Başla" (son sayfa) → dilleri kaydet + `onboarding_v2_seen = true`, discover'a yönlendir
- Premium bottom sheet "✕" → discover'a devam

### Analytics Events
- `onboarding_v2_start` — ekran açılışı
- `onboarding_v2_page_view` — her sayfa görüntüleme (params: pageIndex, pageName)
- `onboarding_v2_skip` — atla tıklanması (params: fromPage)
- `onboarding_v2_complete` — "Başla" ile tamamlama
- `onboarding_v2_languages_selected` — seçilen diller (params: languages, count)
- `onboarding_v2_premium_shown` — bottom sheet gösterimi
- `onboarding_v2_premium_tapped` — premium butona tıklama
- `onboarding_v2_premium_dismissed` — bottom sheet kapatma

---

## Localization

Tüm metinler `translations/` altında externalize edilecek. Key yapısı:

```
onboarding_v2_page1_title: "Qulo'da Eşleşmek Farklı"
onboarding_v2_page1_desc: "Burada sorularınla tanışırsın..."
onboarding_v2_page2_title: "Sorularını Hazırla"
onboarding_v2_page2_desc: "2-10 soru oluştur..."
onboarding_v2_page3_title: "6 Süper Güç"
onboarding_v2_page3_desc: "Sorularını çözenler bu güçleri..."
onboarding_v2_page4_title: "Yeşil Elmas Kazan!"
onboarding_v2_page4_desc: "Sorularında güç kullanan her kişi..."
onboarding_v2_page5_title: "Hangi Dillerde Soru Görmek İstersin?"
onboarding_v2_page5_desc: "Seçtiğin dillerdeki profilleri..."
onboarding_v2_skip: "Atla"
onboarding_v2_next: "İleri"
onboarding_v2_start: "Başla"
onboarding_v2_premium_title: "Premium ile Daha Fazlası"
onboarding_v2_premium_cta: "Premium'a Geç"
```

Güç label'ları mevcut key'leri kullanır: `power_copy`, `power_half`, `power_skip`, `power_hint`, `power_time`, `power_skip_all`

---

## Kullanılan Mevcut Varlıklar

### Lottie Animasyonlar
| Dosya | Sayfa | Kullanım |
|-------|-------|----------|
| `lottie_radar.json` | Sayfa 1 | Keşif/tarama hissi |
| `boardQuestion.json` | Sayfa 2 | Soru kartı animasyonu |
| `buydiamond.json` | Sayfa 4 | Elmas kazanç kutlaması |
| `location.json` | Sayfa 5 | Globe/konum (opsiyonel) |
| `subscribe.json` | Sayfa 5.5 | Premium öneri |

### SVG İkonlar (Güçler)
`ic_copy.svg`, `ic_split.svg`, `ic_skip_forward.svg`, `ic_lightbulb.svg`, `ic_clock.svg`, `ic_fast_forward.svg`

### SVG Elmaslar
`green_diamond.svg`, `purple_diamond.svg`, `green_diamond_slide_left.svg`, `green_diamond_slide_right.svg`, `purple_diamond_slide_left.svg`, `purple_diamond_slide_right.svg`

---

## Dosya Yapısı (Planlanan)

```
lib/features/onboarding/
├── screens/
│   └── onboarding_screen.dart          ← Ana orchestration (~150 satır)
├── widgets/
│   ├── onboarding_page_view.dart       ← PageView + parallax controller
│   ├── parallax_background.dart        ← Floating elementler + parallax hesaplama
│   ├── onboarding_hook_page.dart       ← Sayfa 1: Radar + hook metin
│   ├── onboarding_questions_page.dart  ← Sayfa 2: Soru hazırla
│   ├── onboarding_powers_page.dart     ← Sayfa 3: 6 güç grid + staggered anim
│   ├── onboarding_diamonds_page.dart   ← Sayfa 4: Yeşil elmas kazanç
│   ├── onboarding_language_page.dart   ← Sayfa 5: Dil seçimi + Başla
│   ├── onboarding_indicators.dart      ← Dot indicator (yeniden kullanım)
│   ├── onboarding_bottom_bar.dart      ← İleri/Atla butonları
│   ├── power_grid_item.dart            ← Tek güç ikonu + label + glow
│   └── premium_suggestion_sheet.dart   ← Opsiyonel premium bottom sheet
└── mixins/
    └── onboarding_screen_mixin.dart    ← State, analytics, navigation logic
```

---

## Kaldırılacaklar

- `lib/features/onboarding/screens/onboarding_screen.dart` (eski Welcome) → yeni ile değiştirilir
- `lib/features/onboarding/widgets/onboarding_page.dart` (eski) → kaldırılır
- `lib/features/onboarding/widgets/onboarding_indicators.dart` → güncellenir veya yeniden yazılır
- `lib/features/questions/screens/question_onboarding_screen.dart` → kaldırılır
- `lib/features/questions/widgets/onboarding_slide.dart` → kaldırılır
- `lib/features/questions/widgets/onboarding_language_slide.dart` → dil seçimi yeni akışa taşınır
- `lib/features/questions/widgets/onboarding_bottom_section.dart` → kaldırılır
- `lib/features/questions/mixins/question_onboarding_screen_mixin.dart` → kaldırılır
- `_MainShellState._checkQuestionOnboarding()` → yeni key ile güncellenir
