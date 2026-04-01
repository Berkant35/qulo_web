# Onboarding Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Mevcut iki ayrı onboarding akışını, parallax efektli, hikaye anlatıcı tek bir onboarding'e birleştirmek.

**Architecture:** PageView tabanlı 5 sayfalı onboarding + opsiyonel premium bottom sheet. 3 katmanlı parallax sistemi (arka plan floating elementler, orta katman güç/elmas ikonları, ön plan içerik). State yönetimi mixin pattern ile, SharedPreferences ile tek seferlik gösterim.

**Tech Stack:** Flutter, Riverpod, Lottie (`lottie: ^3.2.0`), flutter_svg, SharedPreferences, GoRouter

---

## File Map

```
lib/features/onboarding/
├── screens/
│   └── onboarding_screen.dart           ← Ana orchestration (mevcut dosya — tamamen yeniden yazılacak)
├── widgets/
│   ├── parallax_background.dart         ← YENİ: Floating elementler + parallax hesaplama
│   ├── onboarding_hook_page.dart        ← YENİ: Sayfa 1 — Radar Lottie + hook metin
│   ├── onboarding_questions_page.dart   ← YENİ: Sayfa 2 — boardQuestion Lottie
│   ├── onboarding_powers_page.dart      ← YENİ: Sayfa 3 — 6 güç grid + staggered anim
│   ├── onboarding_diamonds_page.dart    ← YENİ: Sayfa 4 — Yeşil elmas kazanç
│   ├── onboarding_language_page.dart    ← YENİ: Sayfa 5 — Dil seçimi
│   ├── onboarding_indicators.dart       ← MEVCUT: AnimatedContainer dot indicator (güncelleme)
│   ├── onboarding_bottom_bar.dart       ← YENİ: İleri/Atla/Başla butonları
│   ├── power_grid_item.dart             ← YENİ: Tek güç ikonu + label + glow
│   └── premium_suggestion_sheet.dart    ← YENİ: Opsiyonel premium bottom sheet
├── mixins/
│   └── onboarding_screen_mixin.dart     ← YENİ: Tüm state, analytics, navigation logic
└── (eski dosyalar silinecek — bkz. Task 10)

Modify: lib/routing/app_routes.dart          ← _checkQuestionOnboarding → onboarding_v2_seen key
Modify: lib/core/l10n/translations/tr.dart   ← Yeni onboarding_v2_ key'leri
Modify: lib/core/l10n/translations/en.dart   ← Yeni onboarding_v2_ key'leri
Modify: lib/core/services/analytics_events.dart ← Yeni onboarding_v2 event sabitleri
```

---

## Task 1: Localization Key'lerini Ekle

**Files:**
- Modify: `qulov2/lib/core/l10n/translations/tr.dart`
- Modify: `qulov2/lib/core/l10n/translations/en.dart`

- [ ] **Step 1: tr.dart'a yeni onboarding_v2 key'lerini ekle**

Mevcut onboarding key'lerinin altına (satır 53 civarı) ekle:

```dart
// Onboarding V2
'onboarding_v2_page1_title': "Qulo'da Eşleşmek Farklı",
'onboarding_v2_page1_desc': 'Burada sorularınla tanışırsın. Birisi tüm sorularını doğru cevaplarsa — eşleşirsiniz!',
'onboarding_v2_page2_title': 'Sorularını Hazırla',
'onboarding_v2_page2_desc': '2-10 soru oluştur. Kişisel, eğlenceli, Google\'lanamayan sorular sor. Biri tüm sorularını bilirse — eşleşirsiniz!',
'onboarding_v2_page3_title': '6 Süper Güç',
'onboarding_v2_page3_desc': 'Sorularını çözenler bu güçleri kullanabilir. Her güç mor elmas harcar — ve bu senin kazancın!',
'onboarding_v2_page4_title': 'Yeşil Elmas Kazan!',
'onboarding_v2_page4_desc': 'Sorularında güç kullanan her kişi sana yeşil elmas kazandırır. Daha çok soru, daha çok kazanç!',
'onboarding_v2_page5_title': 'Hangi Dillerde Soru Görmek İstersin?',
'onboarding_v2_page5_desc': 'Seçtiğin dillerdeki profilleri göstereceğiz. Birden fazla seçebilirsin.',
'onboarding_v2_skip': 'Atla',
'onboarding_v2_next': 'İleri',
'onboarding_v2_start': 'Başla',
'onboarding_v2_premium_title': 'Premium ile Daha Fazlası',
'onboarding_v2_premium_cta': "Premium'a Geç",
'onboarding_v2_premium_benefit_1': 'Sınırsız keşif',
'onboarding_v2_premium_benefit_2': 'Her ay mor elmas hediye',
'onboarding_v2_premium_benefit_3': 'Reklamsız deneyim',
```

- [ ] **Step 2: en.dart'a İngilizce karşılıkları ekle**

```dart
// Onboarding V2
'onboarding_v2_page1_title': 'Matching on Qulo is Different',
'onboarding_v2_page1_desc': 'Here you meet through questions. If someone answers all your questions correctly — you match!',
'onboarding_v2_page2_title': 'Prepare Your Questions',
'onboarding_v2_page2_desc': 'Create 2-10 questions. Personal, fun, questions that can\'t be Googled. If someone gets them all right — you match!',
'onboarding_v2_page3_title': '6 Super Powers',
'onboarding_v2_page3_desc': 'Solvers can use these powers on your questions. Each power costs purple diamonds — and that\'s your earnings!',
'onboarding_v2_page4_title': 'Earn Green Diamonds!',
'onboarding_v2_page4_desc': 'Every person who uses a power on your questions earns you green diamonds. More questions, more earnings!',
'onboarding_v2_page5_title': 'Which Languages Do You Want to See?',
'onboarding_v2_page5_desc': 'We\'ll show you profiles with questions in your languages. You can select multiple.',
'onboarding_v2_skip': 'Skip',
'onboarding_v2_next': 'Next',
'onboarding_v2_start': 'Get Started',
'onboarding_v2_premium_title': 'More with Premium',
'onboarding_v2_premium_cta': 'Go Premium',
'onboarding_v2_premium_benefit_1': 'Unlimited discovery',
'onboarding_v2_premium_benefit_2': 'Monthly purple diamond bonus',
'onboarding_v2_premium_benefit_3': 'Ad-free experience',
```

- [ ] **Step 3: Commit**

```bash
git add qulov2/lib/core/l10n/translations/tr.dart qulov2/lib/core/l10n/translations/en.dart
git commit -m "feat(onboarding): add v2 localization keys for TR and EN"
```

---

## Task 2: Analytics Event Sabitleri

**Files:**
- Modify: `qulov2/lib/core/services/analytics_events.dart`

- [ ] **Step 1: Yeni onboarding_v2 event sabitlerini ekle**

`analytics_events.dart` dosyasında mevcut onboarding event'lerinin altına ekle:

```dart
// ─── Onboarding V2 ───
static const onboardingV2Start = 'onboarding_v2_start';
static const onboardingV2PageView = 'onboarding_v2_page_view';
static const onboardingV2Skip = 'onboarding_v2_skip';
static const onboardingV2Complete = 'onboarding_v2_complete';
static const onboardingV2LanguagesSelected = 'onboarding_v2_languages_selected';
static const onboardingV2PremiumShown = 'onboarding_v2_premium_shown';
static const onboardingV2PremiumTapped = 'onboarding_v2_premium_tapped';
static const onboardingV2PremiumDismissed = 'onboarding_v2_premium_dismissed';

// Params
static const paramPageIndex = 'page_index';
static const paramPageName = 'page_name';
static const paramFromPage = 'from_page';
static const paramLanguages = 'languages';
static const paramLanguageCount = 'language_count';
```

Not: `paramPageIndex` ve `paramPageName` zaten mevcutsa ekleme — mevcut olanları kontrol et. `paramFromPage` muhtemelen yoktur.

- [ ] **Step 2: Commit**

```bash
git add qulov2/lib/core/services/analytics_events.dart
git commit -m "feat(onboarding): add v2 analytics event constants"
```

---

## Task 3: Onboarding Screen Mixin

**Files:**
- Create: `qulov2/lib/features/onboarding/mixins/onboarding_screen_mixin.dart`

- [ ] **Step 1: Mixin dosyasını oluştur**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qulo_v2/core/constants/app_constants.dart';
import 'package:qulo_v2/core/navigation/navigation.dart';
import 'package:qulo_v2/core/services/analytics_manager.dart';
import 'package:qulo_v2/core/services/analytics_events.dart';
import 'package:qulo_v2/features/onboarding/screens/onboarding_screen.dart';
import 'package:qulo_v2/providers/user_languages_provider.dart';
import 'package:qulo_v2/routing/route_names.dart';

mixin OnboardingScreenMixin on ConsumerState<OnboardingScreen>,
    TickerProviderStateMixin<OnboardingScreen> {
  static const _prefKey = 'onboarding_v2_seen';
  static const _totalPages = 5;
  static const _pageNames = ['hook', 'questions', 'powers', 'diamonds', 'language'];

  final _analytics = AnalyticsManager.instance;
  late final PageController pageController;
  late final AnimationController floatingController;

  int currentPage = 0;
  late List<String> selectedLanguages;
  double scrollOffset = 0.0;

  void initMixin() {
    pageController = PageController()
      ..addListener(_onScroll);
    floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    final appLocale = Localizations.localeOf(context).languageCode;
    selectedLanguages = [
      AppConstants.supportedQuestionLocales.contains(appLocale)
          ? appLocale
          : 'tr',
    ];

    _analytics.logEvent(AnalyticsEvents.onboardingV2Start);
  }

  void disposeMixin() {
    pageController.dispose();
    floatingController.dispose();
  }

  void _onScroll() {
    if (pageController.hasClients) {
      setState(() {
        scrollOffset = pageController.page ?? 0.0;
      });
    }
  }

  void onPageChanged(int index) {
    setState(() => currentPage = index);
    _analytics.logEvent(AnalyticsEvents.onboardingV2PageView, params: {
      AnalyticsEvents.paramPageIndex: index,
      AnalyticsEvents.paramPageName: _pageNames[index],
    });
  }

  void onLanguageToggle(String locale) {
    setState(() {
      if (selectedLanguages.contains(locale)) {
        if (selectedLanguages.length > 1) {
          selectedLanguages.remove(locale);
        }
      } else {
        selectedLanguages.add(locale);
      }
    });
  }

  void onNext() {
    if (currentPage < _totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> onSkip() async {
    _analytics.logEvent(AnalyticsEvents.onboardingV2Skip, params: {
      AnalyticsEvents.paramFromPage: _pageNames[currentPage],
    });
    await _markSeen();
    if (!mounted) return;
    ref.read(navigationServiceProvider).go(RouteNames.discover);
  }

  Future<void> onStart() async {
    _analytics.logEvent(AnalyticsEvents.onboardingV2Complete);
    _analytics.logEvent(AnalyticsEvents.onboardingV2LanguagesSelected, params: {
      AnalyticsEvents.paramLanguages: selectedLanguages.join(','),
      AnalyticsEvents.paramLanguageCount: selectedLanguages.length,
    });
    await _markSeen();
    if (!mounted) return;
    ref.read(userLanguagesProvider.notifier).save(selectedLanguages);
    _showPremiumSuggestion();
  }

  void _showPremiumSuggestion() {
    _analytics.logEvent(AnalyticsEvents.onboardingV2PremiumShown);
    ref.read(navigationServiceProvider).showAppBottomSheet(
      CustomBottomSheet(
        builder: (context) => const PremiumSuggestionSheet(),
      ),
    ).then((_) {
      // Bottom sheet kapandıktan sonra discover'a git
      if (mounted) {
        ref.read(navigationServiceProvider).go(RouteNames.discover);
      }
    });
  }

  Future<void> _markSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKey, true);
    // Eski key'i de işaretle — geriye uyumluluk
    await prefs.setBool('onboarding_questions_seen', true);
  }

  bool get isLastPage => currentPage == _totalPages - 1;
  int get totalPages => _totalPages;
}
```

**Import notu:** Bu dosyanın başına şu import'lar eklenecek (Task 9'da dosya oluşturulunca):
```dart
import 'package:qulo_v2/features/onboarding/widgets/premium_suggestion_sheet.dart';
```
`CustomBottomSheet` zaten `navigation.dart` barrel export'undan gelir.

- [ ] **Step 2: Commit**

```bash
git add qulov2/lib/features/onboarding/mixins/onboarding_screen_mixin.dart
git commit -m "feat(onboarding): add v2 screen mixin with parallax, analytics, navigation"
```

---

## Task 4: Parallax Background Widget

**Files:**
- Create: `qulov2/lib/features/onboarding/widgets/parallax_background.dart`

- [ ] **Step 1: ParallaxBackground widget'ını oluştur**

Bu widget tüm sayfalarda arka planda süzülen güç ikonlarını ve elmas SVG'lerini render eder. `scrollOffset` ve `floatingAnimation` parametreleri ile parallax + floating efekti sağlar.

```dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qulo_v2/core/constants/app_assets.dart';
import 'package:qulo_v2/core/constants/q_icons.dart';

class ParallaxBackground extends StatelessWidget {
  final double scrollOffset;
  final Animation<double> floatingAnimation;

  const ParallaxBackground({
    super.key,
    required this.scrollOffset,
    required this.floatingAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return AnimatedBuilder(
      animation: floatingAnimation,
      builder: (context, _) {
        final time = floatingAnimation.value * 2 * math.pi;
        return Stack(
          children: _buildElements(size, time),
        );
      },
    );
  }

  List<Widget> _buildElements(Size size, double time) {
    // Her element: (assetPath, relativeX, relativeY, size, speed, phase, parallaxFactor, baseOpacity)
    final elements = <_FloatingElement>[
      // Güç ikonları — orta katman (parallax 0.6)
      _FloatingElement(QIcons.icCopy, 0.1, 0.15, 28, 0.8, 0.0, 0.6, 0.15),
      _FloatingElement(QIcons.icSplit, 0.85, 0.25, 24, 1.0, 1.0, 0.6, 0.12),
      _FloatingElement(QIcons.icSkipForward, 0.15, 0.65, 22, 0.9, 2.0, 0.6, 0.1),
      _FloatingElement(QIcons.icLightbulb, 0.8, 0.55, 26, 0.7, 3.0, 0.6, 0.18),
      _FloatingElement(QIcons.icClock, 0.5, 0.1, 20, 1.1, 4.0, 0.6, 0.1),
      _FloatingElement(QIcons.icFastForward, 0.9, 0.8, 24, 0.85, 5.0, 0.6, 0.12),
      // Elmas SVG'leri — arka katman (parallax 0.3)
      _FloatingElement(AppAssets.greenDiamond, 0.2, 0.4, 20, 0.6, 0.5, 0.3, 0.1),
      _FloatingElement(AppAssets.purpleDiamond, 0.75, 0.7, 18, 0.7, 1.5, 0.3, 0.08),
      _FloatingElement(AppAssets.greenDiamond, 0.6, 0.2, 16, 0.5, 2.5, 0.3, 0.1),
      _FloatingElement(AppAssets.purpleDiamond, 0.35, 0.85, 22, 0.8, 3.5, 0.3, 0.08),
    ];

    return elements.map((e) {
      // Parallax offset: scroll yönünün tersine
      final parallaxX = -scrollOffset * size.width * e.parallaxFactor;
      // Floating salınım
      final floatX = math.sin(time * e.speed + e.phase) * 6;
      final floatY = math.cos(time * e.speed * 0.7 + e.phase) * 8;

      final x = e.relX * size.width + parallaxX + floatX;
      final y = e.relY * size.height + floatY;

      // Sayfa bazlı opacity: güç ikonları sayfa 3'te, elmaslar sayfa 4'te daha belirgin
      final pageOpacity = _getPageOpacity(e, scrollOffset);

      return Positioned(
        left: x,
        top: y,
        child: Opacity(
          opacity: (e.baseOpacity * pageOpacity).clamp(0.0, 0.4),
          child: SvgPicture.asset(
            e.assetPath,
            width: e.size,
            height: e.size,
            colorFilter: e.assetPath.startsWith('assets/icons/')
                ? const ColorFilter.mode(Color(0xFFBB86FC), BlendMode.srcIn)
                : null,
          ),
        ),
      );
    }).toList();
  }

  double _getPageOpacity(_FloatingElement e, double offset) {
    final isPowerIcon = e.assetPath.startsWith('assets/icons/');
    final isDiamond = e.assetPath.contains('diamond');

    // Güç ikonları: sayfa 2-3 civarında daha belirgin
    if (isPowerIcon) {
      final dist = (offset - 2.0).abs();
      return 1.0 + (1.0 - dist.clamp(0.0, 2.0) / 2.0) * 1.5;
    }
    // Elmaslar: sayfa 3-4 civarında daha belirgin
    if (isDiamond) {
      final dist = (offset - 3.0).abs();
      return 1.0 + (1.0 - dist.clamp(0.0, 2.0) / 2.0) * 1.5;
    }
    return 1.0;
  }
}

class _FloatingElement {
  final String assetPath;
  final double relX;
  final double relY;
  final double size;
  final double speed;
  final double phase;
  final double parallaxFactor;
  final double baseOpacity;

  const _FloatingElement(
    this.assetPath,
    this.relX,
    this.relY,
    this.size,
    this.speed,
    this.phase,
    this.parallaxFactor,
    this.baseOpacity,
  );
}
```

- [ ] **Step 2: Commit**

```bash
git add qulov2/lib/features/onboarding/widgets/parallax_background.dart
git commit -m "feat(onboarding): add parallax background with floating power/diamond elements"
```

---

## Task 5: Onboarding Bottom Bar ve Indicators Güncelleme

**Files:**
- Create: `qulov2/lib/features/onboarding/widgets/onboarding_bottom_bar.dart`
- Modify: `qulov2/lib/features/onboarding/widgets/onboarding_indicators.dart`

- [ ] **Step 1: OnboardingBottomBar widget'ını oluştur**

```dart
import 'package:flutter/material.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/features/onboarding/widgets/onboarding_indicators.dart';

class OnboardingBottomBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final bool isLastPage;
  final VoidCallback onNext;
  final VoidCallback onStart;

  const OnboardingBottomBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.isLastPage,
    required this.onNext,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OnboardingIndicators(count: totalPages, currentPage: currentPage),
        const SizedBox(height: AppSpacing.xl),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pagePadding),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    context.appColors.primaryDark,
                    const Color(0xFF7B1FA2),
                  ],
                ),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: ElevatedButton(
                onPressed: isLastPage ? onStart : onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
                child: Text(
                  isLastPage
                      ? context.tr('onboarding_v2_start')
                      : context.tr('onboarding_v2_next'),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}
```

- [ ] **Step 2: OnboardingIndicators'ı AnimatedContainer'a güncelle**

Mevcut `onboarding_indicators.dart` dosyasını `AnimatedContainer` kullanacak şekilde güncelle:

```dart
import 'package:flutter/material.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';

class OnboardingIndicators extends StatelessWidget {
  final int count;
  final int currentPage;

  const OnboardingIndicators({
    super.key,
    required this.count,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: i == currentPage ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: i == currentPage
                ? context.appColors.primary
                : context.appColors.primary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: Commit**

```bash
git add qulov2/lib/features/onboarding/widgets/onboarding_bottom_bar.dart qulov2/lib/features/onboarding/widgets/onboarding_indicators.dart
git commit -m "feat(onboarding): add gradient bottom bar and animated indicators"
```

---

## Task 6: Sayfa 1 — Hook Page + Sayfa 2 — Questions Page

**Files:**
- Create: `qulov2/lib/features/onboarding/widgets/onboarding_hook_page.dart`
- Create: `qulov2/lib/features/onboarding/widgets/onboarding_questions_page.dart`

- [ ] **Step 1: Hook page widget'ını oluştur (Sayfa 1)**

```dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qulo_v2/core/constants/app_assets.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';

class OnboardingHookPage extends StatelessWidget {
  const OnboardingHookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Lottie.asset(
              AppAssets.radar,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text(
            context.tr('onboarding_v2_page1_title'),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            context.tr('onboarding_v2_page1_desc'),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: Questions page widget'ını oluştur (Sayfa 2)**

```dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qulo_v2/core/constants/app_assets.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';

class OnboardingQuestionsPage extends StatelessWidget {
  const OnboardingQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Lottie.asset(
              AppAssets.boardQuestion,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text(
            context.tr('onboarding_v2_page2_title'),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            context.tr('onboarding_v2_page2_desc'),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: Commit**

```bash
git add qulov2/lib/features/onboarding/widgets/onboarding_hook_page.dart qulov2/lib/features/onboarding/widgets/onboarding_questions_page.dart
git commit -m "feat(onboarding): add hook page (radar lottie) and questions page"
```

---

## Task 7: Sayfa 3 — Powers Page + Power Grid Item

**Files:**
- Create: `qulov2/lib/features/onboarding/widgets/power_grid_item.dart`
- Create: `qulov2/lib/features/onboarding/widgets/onboarding_powers_page.dart`

- [ ] **Step 1: PowerGridItem widget'ını oluştur**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';

class PowerGridItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final int index;
  final Animation<double> animation;

  const PowerGridItem({
    super.key,
    required this.iconPath,
    required this.label,
    required this.index,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    // Staggered: her ikon 100ms arayla girer
    final delay = index * 0.15;
    final start = delay.clamp(0.0, 0.7);
    final end = (start + 0.3).clamp(0.0, 1.0);

    final itemAnimation = CurvedAnimation(
      parent: animation,
      curve: Interval(start, end, curve: Curves.easeOutBack),
    );

    return AnimatedBuilder(
      animation: itemAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: itemAnimation.value,
          child: Opacity(
            opacity: itemAnimation.value.clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.appColors.primary.withValues(alpha: 0.15),
              boxShadow: [
                BoxShadow(
                  color: context.appColors.primary.withValues(alpha: 0.25),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: 28,
                height: 28,
                colorFilter: ColorFilter.mode(
                  context.appColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: OnboardingPowersPage widget'ını oluştur**

```dart
import 'package:flutter/material.dart';
import 'package:qulo_v2/core/constants/q_icons.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/features/onboarding/widgets/power_grid_item.dart';

class OnboardingPowersPage extends StatefulWidget {
  const OnboardingPowersPage({super.key});

  @override
  State<OnboardingPowersPage> createState() => _OnboardingPowersPageState();
}

class _OnboardingPowersPageState extends State<OnboardingPowersPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _staggerController;

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final powers = [
      (QIcons.icCopy, context.tr('power_copy')),
      (QIcons.icSplit, context.tr('power_half')),
      (QIcons.icSkipForward, context.tr('power_skip')),
      (QIcons.icLightbulb, context.tr('power_hint')),
      (QIcons.icClock, context.tr('power_time')),
      (QIcons.icFastForward, context.tr('power_skip_all')),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.tr('onboarding_v2_page3_title'),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxl),
          // 2x3 Grid
          SizedBox(
            height: 220,
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.lg,
              crossAxisSpacing: AppSpacing.lg,
              childAspectRatio: 0.85,
              children: List.generate(powers.length, (i) {
                return PowerGridItem(
                  iconPath: powers[i].$1,
                  label: powers[i].$2,
                  index: i,
                  animation: _staggerController,
                );
              }),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            context.tr('onboarding_v2_page3_desc'),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: Commit**

```bash
git add qulov2/lib/features/onboarding/widgets/power_grid_item.dart qulov2/lib/features/onboarding/widgets/onboarding_powers_page.dart
git commit -m "feat(onboarding): add powers page with staggered grid animation"
```

---

## Task 8: Sayfa 4 — Diamonds Page + Sayfa 5 — Language Page

**Files:**
- Create: `qulov2/lib/features/onboarding/widgets/onboarding_diamonds_page.dart`
- Create: `qulov2/lib/features/onboarding/widgets/onboarding_language_page.dart`

- [ ] **Step 1: Diamonds page widget'ını oluştur (Sayfa 4)**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:qulo_v2/core/constants/app_assets.dart';
import 'package:qulo_v2/core/constants/q_icons.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';

class OnboardingDiamondsPage extends StatelessWidget {
  const OnboardingDiamondsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 180,
            height: 180,
            child: Lottie.asset(
              AppAssets.buyDiamond,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          // Mini görsel akış: güç ikonu → ok → yeşil elmas
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Güç ikonu (mor glow)
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.appColors.primary.withValues(alpha: 0.15),
                  boxShadow: [
                    BoxShadow(
                      color: context.appColors.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    QIcons.icLightbulb,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      context.appColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Icon(Icons.arrow_forward, color: Colors.white.withValues(alpha: 0.5), size: 20),
              const SizedBox(width: AppSpacing.md),
              // Yeşil elmas (yeşil glow)
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.appColors.secondary.withValues(alpha: 0.15),
                  boxShadow: [
                    BoxShadow(
                      color: context.appColors.secondary.withValues(alpha: 0.3),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.greenDiamond,
                    width: 32,
                    height: 32,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text(
            context.tr('onboarding_v2_page4_title'),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.appColors.secondary, // Yeşil neon başlık
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            context.tr('onboarding_v2_page4_desc'),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: Language page widget'ını oluştur (Sayfa 5)**

```dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qulo_v2/core/constants/app_assets.dart';
import 'package:qulo_v2/core/constants/app_constants.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';

class OnboardingLanguagePage extends StatelessWidget {
  final List<String> selectedLanguages;
  final ValueChanged<String> onToggle;

  const OnboardingLanguagePage({
    super.key,
    required this.selectedLanguages,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: Lottie.asset(
              AppAssets.location,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            context.tr('onboarding_v2_page5_title'),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            context.tr('onboarding_v2_page5_desc'),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            alignment: WrapAlignment.center,
            children: AppConstants.supportedQuestionLocales.map((locale) {
              final isSelected = selectedLanguages.contains(locale);
              final flag = AppConstants.localeFlagEmojis[locale] ?? '';
              return FilterChip(
                label: Text('$flag ${context.tr('locale_$locale')}'),
                selected: isSelected,
                onSelected: (_) => onToggle(locale),
                selectedColor: context.appColors.primarySurface,
                checkmarkColor: context.appColors.primary,
                side: BorderSide(
                  color: isSelected
                      ? context.appColors.primary
                      : context.appColors.border,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: Commit**

```bash
git add qulov2/lib/features/onboarding/widgets/onboarding_diamonds_page.dart qulov2/lib/features/onboarding/widgets/onboarding_language_page.dart
git commit -m "feat(onboarding): add diamonds page (green diamond focus) and language page"
```

---

## Task 9: Premium Suggestion Bottom Sheet

**Files:**
- Create: `qulov2/lib/features/onboarding/widgets/premium_suggestion_sheet.dart`

- [ ] **Step 1: PremiumSuggestionSheet widget'ını oluştur**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:qulo_v2/core/constants/app_assets.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/navigation/navigation.dart';
import 'package:qulo_v2/core/services/analytics_manager.dart';
import 'package:qulo_v2/core/services/analytics_events.dart';
import 'package:qulo_v2/core/theme/app_colors.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/routing/route_names.dart';

class PremiumSuggestionSheet extends ConsumerWidget {
  const PremiumSuggestionSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final analytics = AnalyticsManager.instance;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        AppSpacing.xxl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Kapatma butonu
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                analytics.logEvent(AnalyticsEvents.onboardingV2PremiumDismissed);
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.close,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ),
          // Lottie
          SizedBox(
            width: 120,
            height: 120,
            child: Lottie.asset(AppAssets.subscribe, fit: BoxFit.contain),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Başlık
          Text(
            context.tr('onboarding_v2_premium_title'),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Avantaj listesi
          _BenefitRow(text: context.tr('onboarding_v2_premium_benefit_1')),
          const SizedBox(height: AppSpacing.sm),
          _BenefitRow(text: context.tr('onboarding_v2_premium_benefit_2')),
          const SizedBox(height: AppSpacing.sm),
          _BenefitRow(text: context.tr('onboarding_v2_premium_benefit_3')),
          const SizedBox(height: AppSpacing.xl),
          // Premium butonu
          SizedBox(
            width: double.infinity,
            height: 52,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    context.appColors.primaryDark,
                    const Color(0xFF7B1FA2),
                  ],
                ),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: ElevatedButton(
                onPressed: () {
                  analytics.logEvent(AnalyticsEvents.onboardingV2PremiumTapped);
                  Navigator.of(context).pop();
                  ref.read(navigationServiceProvider).push(RouteNames.subscription);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
                child: Text(
                  context.tr('onboarding_v2_premium_cta'),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  final String text;
  const _BenefitRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.check_circle, color: context.appColors.secondary, size: 20),
        const SizedBox(width: AppSpacing.sm),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.9),
              ),
        ),
      ],
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add qulov2/lib/features/onboarding/widgets/premium_suggestion_sheet.dart
git commit -m "feat(onboarding): add premium suggestion bottom sheet with dismiss support"
```

---

## Task 10: Ana Onboarding Screen — Birleştirme

**Files:**
- Rewrite: `qulov2/lib/features/onboarding/screens/onboarding_screen.dart`

- [ ] **Step 1: OnboardingScreen'i tamamen yeniden yaz**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/widgets/app_scaffold.dart';
import 'package:qulo_v2/features/onboarding/mixins/onboarding_screen_mixin.dart';
import 'package:qulo_v2/features/onboarding/widgets/onboarding_bottom_bar.dart';
import 'package:qulo_v2/features/onboarding/widgets/onboarding_diamonds_page.dart';
import 'package:qulo_v2/features/onboarding/widgets/onboarding_hook_page.dart';
import 'package:qulo_v2/features/onboarding/widgets/onboarding_language_page.dart';
import 'package:qulo_v2/features/onboarding/widgets/onboarding_powers_page.dart';
import 'package:qulo_v2/features/onboarding/widgets/onboarding_questions_page.dart';
import 'package:qulo_v2/features/onboarding/widgets/parallax_background.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with TickerProviderStateMixin, OnboardingScreenMixin {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initMixin();
  }

  @override
  void dispose() {
    disposeMixin();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0D0D0D),
              Color(0xFF1A1A2E),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Parallax arka plan
              ParallaxBackground(
                scrollOffset: scrollOffset,
                floatingAnimation: floatingController,
              ),
              // Ön plan: PageView + kontroller
              Column(
                children: [
                  // Atla butonu (son sayfada gösterme)
                  if (!isLastPage)
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: AppSpacing.pagePadding,
                          top: AppSpacing.sm,
                        ),
                        child: TextButton(
                          onPressed: onSkip,
                          child: Text(
                            context.tr('onboarding_v2_skip'),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.5),
                                ),
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox(height: 48), // Sabit yükseklik tutmak için

                  // PageView
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      onPageChanged: onPageChanged,
                      children: [
                        const OnboardingHookPage(),
                        const OnboardingQuestionsPage(),
                        const OnboardingPowersPage(),
                        const OnboardingDiamondsPage(),
                        OnboardingLanguagePage(
                          selectedLanguages: selectedLanguages,
                          onToggle: onLanguageToggle,
                        ),
                      ],
                    ),
                  ),

                  // Alt bar (indicator + buton)
                  OnboardingBottomBar(
                    currentPage: currentPage,
                    totalPages: totalPages,
                    isLastPage: isLastPage,
                    onNext: onNext,
                    onStart: onStart,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add qulov2/lib/features/onboarding/screens/onboarding_screen.dart
git commit -m "feat(onboarding): rewrite main screen with parallax, 5 pages, premium sheet"
```

---

## Task 11: Routing Güncellemesi

**Files:**
- Modify: `qulov2/lib/routing/app_routes.dart`

- [ ] **Step 1: _checkQuestionOnboarding'i güncelle**

`app_routes.dart` satır 389-399 arasındaki `_checkQuestionOnboarding` metodunu güncelle:

Eski:
```dart
Future<void> _checkQuestionOnboarding() async {
  final prefs = await SharedPreferences.getInstance();
  final seen = prefs.getBool('onboarding_questions_seen') ?? false;
  if (!seen && mounted) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(navigationServiceProvider).push(RouteNames.questionOnboarding);
      }
    });
  }
}
```

Yeni:
```dart
Future<void> _checkOnboarding() async {
  final prefs = await SharedPreferences.getInstance();
  final seen = prefs.getBool('onboarding_v2_seen') ?? false;
  // Eski key'i de kontrol et — geriye uyumluluk
  final oldSeen = prefs.getBool('onboarding_questions_seen') ?? false;
  if (!seen && !oldSeen && mounted) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(navigationServiceProvider).push(RouteNames.onboarding);
      }
    });
  }
}
```

Ve `initState`'te çağrıyı güncelle:
```dart
@override
void initState() {
  super.initState();
  _checkOnboarding();
}
```

- [ ] **Step 2: Onboarding route'unu rootNavigator'a taşı**

`app_routes.dart` satır 72-76 arasındaki onboarding route'unu güncelle — `parentNavigatorKey: rootNavigatorKey` ekle (bottom nav bar üzerinde full-screen gösterilsin):

Eski:
```dart
GoRoute(
  path: '/onboarding',
  name: RouteNames.onboarding,
  builder: (context, state) => const OnboardingScreen(),
),
```

Yeni:
```dart
GoRoute(
  parentNavigatorKey: rootNavigatorKey,
  path: '/onboarding',
  name: RouteNames.onboarding,
  builder: (context, state) => const OnboardingScreen(),
),
```

- [ ] **Step 3: Question onboarding route'unu kaldır**

Satır 78-84 arasındaki question onboarding route bloğunu sil:
```dart
// Bu bloğu sil:
GoRoute(
  parentNavigatorKey: rootNavigatorKey,
  path: '/questions/onboarding',
  name: RouteNames.questionOnboarding,
  builder: (context, state) => const QuestionOnboardingScreen(),
),
```

- [ ] **Step 4: QuestionOnboardingScreen import'unu kaldır**

`app_routes.dart`'ın en üstünden:
```dart
import 'package:qulo_v2/features/questions/screens/question_onboarding_screen.dart';
```
Bu satırı sil.

- [ ] **Step 5: Commit**

```bash
git add qulov2/lib/routing/app_routes.dart
git commit -m "feat(onboarding): update routing to use v2 unified onboarding"
```

---

## Task 12: Eski Dosyaları Kaldır

**Files:**
- Delete: `qulov2/lib/features/onboarding/widgets/onboarding_page.dart`
- Delete: `qulov2/lib/features/questions/screens/question_onboarding_screen.dart`
- Delete: `qulov2/lib/features/questions/widgets/onboarding_slide.dart`
- Delete: `qulov2/lib/features/questions/widgets/onboarding_language_slide.dart`
- Delete: `qulov2/lib/features/questions/widgets/onboarding_bottom_section.dart`
- Delete: `qulov2/lib/features/questions/mixins/question_onboarding_screen_mixin.dart`

- [ ] **Step 1: Eski dosyaları sil**

```bash
rm qulov2/lib/features/onboarding/widgets/onboarding_page.dart
rm qulov2/lib/features/questions/screens/question_onboarding_screen.dart
rm qulov2/lib/features/questions/widgets/onboarding_slide.dart
rm qulov2/lib/features/questions/widgets/onboarding_language_slide.dart
rm qulov2/lib/features/questions/widgets/onboarding_bottom_section.dart
rm qulov2/lib/features/questions/mixins/question_onboarding_screen_mixin.dart
```

- [ ] **Step 2: Route names'ten questionOnboarding'i kaldır**

`route_names.dart` satır 28'deki şu satırı sil:
```dart
static const questionOnboarding = 'question-onboarding';
```

- [ ] **Step 3: Kalan import referanslarını temizle**

`flutter analyze` çalıştır ve kalan ölü import'ları temizle.

```bash
cd qulov2 && flutter analyze
```

Hatalı import'ları düzelt.

- [ ] **Step 4: Commit**

```bash
git add -A
git commit -m "refactor(onboarding): remove old welcome and question onboarding files"
```

---

## Task 13: Flutter Analyze ve Son Doğrulama

**Files:** Tüm yeni/değişen dosyalar

- [ ] **Step 1: Flutter analyze çalıştır**

```bash
cd qulov2 && flutter analyze
```

Beklenen: 0 hata, 0 uyarı. Hata varsa düzelt.

- [ ] **Step 2: Uygulamayı çalıştır ve onboarding'i test et**

```bash
cd qulov2 && flutter run
```

Kontrol listesi:
- [ ] Uygulama açılıyor, onboarding ekranı gözüküyor
- [ ] 5 sayfa arasında swipe çalışıyor
- [ ] Parallax efekti görünüyor (arka plan farklı hızda hareket ediyor)
- [ ] Güç ikonları ve elmaslar floating animasyonla salınıyor
- [ ] Sayfa 1: Radar Lottie oynuyor
- [ ] Sayfa 2: boardQuestion Lottie oynuyor
- [ ] Sayfa 3: 6 güç ikonu staggered animasyonla giriyor
- [ ] Sayfa 4: buydiamond Lottie oynuyor, yeşil başlık doğru renkte
- [ ] Sayfa 5: Dil chip'leri çalışıyor, en az 1 zorunlu
- [ ] "Atla" butonu her sayfada görünüyor (son sayfa hariç)
- [ ] "İleri" butonu mor gradient
- [ ] Son sayfada "Başla" butonu → premium bottom sheet açılıyor
- [ ] Bottom sheet "✕" ile kapanıyor → discover'a gidiyor
- [ ] "Atla" → discover'a gidiyor
- [ ] İkinci açılışta onboarding gösterilmiyor (SharedPreferences)

- [ ] **Step 3: Final commit**

```bash
git add -A
git commit -m "feat(onboarding): complete v2 onboarding with parallax, powers, diamonds"
```
