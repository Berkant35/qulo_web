# Power Inventory Display — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Profil sayfasında kullanıcının sahip olduğu 6 özel gücün envanter sayısını kompakt grid olarak göstermek.

**Architecture:** Yeni `PowerInventoryGrid` widget'ı `SectionCard` içinde 6 güç ikonu + count gösterir. `exchangeProvider` dinleyerek envanter verisi alır. Tıklama → mevcut `PowerPurchaseSheet` açar.

**Tech Stack:** Flutter, Riverpod, mevcut PowerIcon widget, ExchangeProvider, PowerPurchaseSheet

**Spec:** `docs/superpowers/specs/2026-03-19-power-inventory-display-design.md`

---

## File Structure

| Dosya | Sorumluluk |
|-------|-----------|
| `qulov2/lib/features/profile/widgets/power_inventory_grid.dart` | **Yeni** — 6 güç ikonu + count gösteren kompakt grid widget |
| `qulov2/lib/features/profile/screens/profile_screen.dart` | **Değiştir** — Grid'i BadgeBar altına ekle, fetchAll çağrısı |
| `qulov2/lib/core/l10n/app_localizations.dart` | **Değiştir** — `my_powers` key ekle (TR + EN) |

---

## Task 1: Localization Key Ekle

**Files:**
- Modify: `qulov2/lib/core/l10n/app_localizations.dart:193-199` (TR powers section)
- Modify: `qulov2/lib/core/l10n/app_localizations.dart:874-880` (EN powers section)

- [ ] **Step 1: TR `my_powers` key ekle**

`app_localizations.dart` dosyasında Türkçe `// Powers` comment'inin (satır 193) hemen altına, mevcut `'power_copy'` satırının (satır 194) üstüne **tek satır** ekle:

```dart
    'my_powers': 'Güçlerim',
```

Sonuç şöyle görünmeli:
```dart
    // Powers                          ← mevcut (satır 193)
    'my_powers': 'Güçlerim',           ← YENİ
    'power_copy': 'Kopya',             ← mevcut (satır 194)
```

- [ ] **Step 2: EN `my_powers` key ekle**

Aynı dosyada İngilizce `// Powers` comment'inin (satır ~874) hemen altına, mevcut `'power_copy'` satırının üstüne **tek satır** ekle:

```dart
    'my_powers': 'My Powers',
```

- [ ] **Step 3: Analyze çalıştır**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter analyze`
Expected: No issues found

- [ ] **Step 4: Commit**

```bash
git add qulov2/lib/core/l10n/app_localizations.dart
git commit -m "feat: add my_powers localization key (TR + EN)"
```

---

## Task 2: PowerInventoryGrid Widget Oluştur

**Files:**
- Create: `qulov2/lib/features/profile/widgets/power_inventory_grid.dart`

- [ ] **Step 1: Widget dosyasını oluştur**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/widgets/app_loading_widget.dart';
import 'package:qulo_v2/core/widgets/power_icon.dart';
import 'package:qulo_v2/features/profile/widgets/section_card.dart';
import 'package:qulo_v2/features/quiz/widgets/power_purchase_sheet.dart';
import 'package:qulo_v2/providers/exchange_provider.dart';

/// Profilde gösterilen 6 güç envanteri grid'i.
/// Tıklama → PowerPurchaseSheet açar.
class PowerInventoryGrid extends ConsumerWidget {
  const PowerInventoryGrid({super.key});

  /// Aktif güç tipleri (powerBlock/powerUnblock hariç).
  static const _activePowers = [
    PowerType.oracle,
    PowerType.half,
    PowerType.skip,
    PowerType.skipAll,
    PowerType.timeExtend,
    PowerType.hint,
  ];

  // Not: showModalBottomSheet direkt kullanıyoruz — power_bar.dart ile tutarlı.
  // PowerPurchaseSheet kendi state'ini yönetiyor, NavigationService wrapper gereksiz.
  void _openPurchaseSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXl),
        ),
      ),
      builder: (_) => const PowerPurchaseSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exchange = ref.watch(exchangeProvider);

    // Henüz hiç yüklenmediyse ve loading de değilse gösterme
    if (exchange.rates == null && !exchange.isLoading) {
      return const SizedBox.shrink();
    }

    // İlk yükleme sırasında loading göster
    final isFirstLoad = exchange.isLoading && exchange.rates == null;

    return SectionCard(
      title: context.tr('my_powers'),
      onTap: () => _openPurchaseSheet(context),
      child: isFirstLoad
          ? const Center(child: AppLoadingWidget.small())
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _activePowers.map((type) {
                final count = exchange.getCount(type.apiName);
                return _PowerGridItem(
                  type: type,
                  count: count,
                  onTap: () => _openPurchaseSheet(context),
                );
              }).toList(),
            ),
    );
  }
}

class _PowerGridItem extends StatelessWidget {
  final PowerType type;
  final int count;
  final VoidCallback onTap;

  const _PowerGridItem({
    required this.type,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEmpty = count == 0;

    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isEmpty ? 0.35 : 1.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PowerIcon(
              type: type,
              size: 28,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '×$count',
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isEmpty
                    ? theme.colorScheme.onSurfaceVariant
                    : type.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Analyze çalıştır**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter analyze`
Expected: No issues found

- [ ] **Step 3: Commit**

```bash
git add qulov2/lib/features/profile/widgets/power_inventory_grid.dart
git commit -m "feat: add PowerInventoryGrid widget for profile power display"
```

---

## Task 3: Profil Sayfasına Entegrasyon

**Files:**
- Modify: `qulov2/lib/features/profile/screens/profile_screen.dart`

- [ ] **Step 1: Import ekle**

`profile_screen.dart` dosyasının import bölümüne ekle:

```dart
import 'package:qulo_v2/features/profile/widgets/power_inventory_grid.dart';
import 'package:qulo_v2/providers/exchange_provider.dart';
```

- [ ] **Step 2: initState'te fetchAll çağrısı ekle**

Mevcut `initState` (satır 39-45):

```dart
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(userProvider.notifier).fetchMe();
    });
    AnalyticsManager.instance.logEvent(AnalyticsEvents.profileViewOwn);
  }
```

`fetchMe()` çağrısının altına exchange fetch ekle:

```dart
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(userProvider.notifier).fetchMe();
      final exchangeState = ref.read(exchangeProvider);
      if (exchangeState.rates == null) {
        ref.read(exchangeProvider.notifier).fetchAll();
      }
    });
    AnalyticsManager.instance.logEvent(AnalyticsEvents.profileViewOwn);
  }
```

- [ ] **Step 3: BadgeBar altına PowerInventoryGrid ekle**

Mevcut BadgeBar bölümü (satır 223-238):

```dart
                // ─── Badge Bar ───
                BadgeBar(
                  user: user,
                  onClaimReward: (level) async {
                    ...
                  },
                ),
                const SizedBox(height: AppSpacing.lg),

                // ─── About Me Card ───
```

BadgeBar'ın `SizedBox(height: AppSpacing.lg)` sonrasına, About Me Card öncesine ekle:

```dart
                const SizedBox(height: AppSpacing.lg),

                // ─── Power Inventory ───
                const PowerInventoryGrid(),
                const SizedBox(height: AppSpacing.lg),

                // ─── About Me Card ───
```

**Not:** Mevcut `SizedBox(height: AppSpacing.lg)` BadgeBar sonrasında zaten var. PowerInventoryGrid'den sonra da bir `SizedBox(height: AppSpacing.lg)` eklenir. Orijinal About Me Card öncesindeki `SizedBox` kaldırılmaz — ama duplikasyon olmaması için mevcut spacing'i kontrol et.

- [ ] **Step 4: Analyze çalıştır**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter analyze`
Expected: No issues found

- [ ] **Step 5: Commit**

```bash
git add qulov2/lib/features/profile/screens/profile_screen.dart
git commit -m "feat: integrate PowerInventoryGrid into profile screen"
```

---

## Task 4: Manuel Test ve Doğrulama

- [ ] **Step 1: Uygulamayı çalıştır**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter run`

- [ ] **Step 2: Test senaryolarını doğrula**

| Senaryo | Beklenen |
|---------|----------|
| Profil sayfası açılış | BadgeBar altında 6 güç ikonu grid göster |
| Envanter > 0 olan güç | Tam opacity, renkli ×N text |
| Envanter == 0 olan güç | Soluk (opacity 0.35), gri ×0 text |
| Güce tıkla | PowerPurchaseSheet bottom sheet açılır |
| Sheet'ten satın al | Sheet kapanır, grid count güncellenir |
| SectionCard başlığa tıkla | PowerPurchaseSheet açılır |
| İlk yükleme (loading) | SectionCard içinde AppLoadingWidget.small() gösterir |
| Fetch tamamlanmadı + loading değil | Grid gizli (SizedBox.shrink) |
| API hatası | Grid gizli kalır |

- [ ] **Step 3: Final commit (gerekirse düzeltmeler)**

Eğer testlerde sorun çıkarsa düzelt ve commit et.
