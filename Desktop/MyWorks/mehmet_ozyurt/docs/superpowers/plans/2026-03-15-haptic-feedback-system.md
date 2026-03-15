# Haptic Feedback Sistemi - Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development
> (if subagents available) or superpowers:executing-plans to implement this plan.
> Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Merkezi bir HapticFeedbackManager ile tum buton
etkilesimlerinde tutarli titresim geri bildirimi saglamak.

**Architecture:** Singleton HapticFeedbackManager (GetIt) +
HapticSettingsCubit (HydratedBloc ile persist) + AppButton
entegrasyonu. Manager HapticType enum'una gore dogru Flutter
HapticFeedback metodunu cagirir.

**Tech Stack:** Flutter (flutter/services.dart HapticFeedback),
flutter_bloc, hydrated_bloc, get_it

**Spec:** `docs/superpowers/specs/2026-03-15-haptic-feedback-system-design.md`

---

## Chunk 1: Core Bilesenleri (Enum + Cubit + Manager + DI)

### Task 1: HapticType Enum

**Files:**
- Create: `tabul/lib/core/service/haptic/haptic_type.dart`

- [ ] **Step 1: Enum dosyasini olustur**

```dart
/// Haptic geri bildirim tipleri
enum HapticType {
  /// Normal buton tiklamasi - lightImpact
  tap,

  /// Liste secimi, tab degisimi - selectionClick
  selection,

  /// Basarili islem, onay - mediumImpact
  success,

  /// Uyari dialog, kritik aksiyon - heavyImpact
  warning,

  /// Hata, yanlis giris - vibrate
  error,

  /// Haptic istenmeyen butonlar
  none,
}
```

- [ ] **Step 2: Derleme kontrolu**

Run: `cd tabul && flutter analyze lib/core/service/haptic/haptic_type.dart`
Expected: No issues found

- [ ] **Step 3: Commit**

```bash
git add tabul/lib/core/service/haptic/haptic_type.dart
git commit -m "feat: add HapticType enum for haptic feedback categories"
```

---

### Task 2: HapticSettingsCubit

**Files:**
- Create: `tabul/lib/core/bloc/cubit/haptic_settings_cubit.dart`

**Referans pattern:** `tabul/lib/core/bloc/cubit/locale_cubit.dart`
(HydratedCubit kullanimi icin)

- [ ] **Step 1: Cubit dosyasini olustur**

```dart
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tabul/main.dart';

/// Haptic geri bildirim ayarlarini yoneten HydratedCubit.
///
/// Kullanicinin haptic tercihini yonetir ve
/// HydratedBloc sayesinde uygulama kapatilsa bile
/// tercih korunur.
///
/// State: true = haptic acik (varsayilan), false = kapali
class HapticSettingsCubit extends HydratedCubit<bool> {
  HapticSettingsCubit() : super(true);

  /// Haptic acik/kapali durumunu degistirir
  void toggle() {
    myCustomLogger.d(
      'Haptic ayari degistirildi: ${!state}',
    );
    emit(!state);
  }

  @override
  bool? fromJson(Map<String, dynamic> json) {
    try {
      return json['enabled'] as bool? ?? true;
    } catch (e) {
      myCustomLogger.e(
        'HapticSettings fromJson hatasi: $e',
        error: e,
      );
      return true;
    }
  }

  @override
  Map<String, dynamic>? toJson(bool state) {
    try {
      return {'enabled': state};
    } catch (e) {
      myCustomLogger.e(
        'HapticSettings toJson hatasi: $e',
        error: e,
      );
      return null;
    }
  }
}
```

- [ ] **Step 2: Derleme kontrolu**

Run: `cd tabul && flutter analyze lib/core/bloc/cubit/haptic_settings_cubit.dart`
Expected: No issues found

- [ ] **Step 3: Commit**

```bash
git add tabul/lib/core/bloc/cubit/haptic_settings_cubit.dart
git commit -m "feat: add HapticSettingsCubit for persistent haptic toggle"
```

---

### Task 3: HapticFeedbackManager

**Files:**
- Create: `tabul/lib/core/service/haptic/haptic_feedback_manager.dart`

**Bagimliliklar:** Task 1 (HapticType), Task 2
(HapticSettingsCubit)

- [ ] **Step 1: Manager dosyasini olustur**

```dart
import 'package:flutter/services.dart';
import 'package:tabul/core/bloc/cubit/haptic_settings_cubit.dart';
import 'package:tabul/core/injection/locator.dart';
import 'package:tabul/core/service/haptic/haptic_type.dart';
import 'package:tabul/main.dart';

/// Merkezi haptic geri bildirim yoneticisi.
///
/// Tum haptic cagrilarini tek noktadan yonetir.
/// HapticSettingsCubit uzerinden acik/kapali kontrolu yapar.
/// Singleton olarak GetIt'e register edilir.
class HapticFeedbackManager {
  HapticFeedbackManager()
      : _settingsCubit = locator<HapticSettingsCubit>();

  final HapticSettingsCubit _settingsCubit;

  /// Ana haptic tetikleme metodu
  void trigger(HapticType type) {
    if (type == HapticType.none) return;
    if (!_settingsCubit.state) return;

    myCustomLogger.d('Haptic: ${type.name}');

    switch (type) {
      case HapticType.tap:
        HapticFeedback.lightImpact();
      case HapticType.selection:
        HapticFeedback.selectionClick();
      case HapticType.success:
        HapticFeedback.mediumImpact();
      case HapticType.warning:
        HapticFeedback.heavyImpact();
      case HapticType.error:
        HapticFeedback.vibrate();
      case HapticType.none:
        break;
    }
  }

  /// Normal buton tiklamasi
  void tap() => trigger(HapticType.tap);

  /// Liste secimi, tab degisimi
  void selection() => trigger(HapticType.selection);

  /// Basarili islem
  void success() => trigger(HapticType.success);

  /// Uyari, kritik aksiyon
  void warning() => trigger(HapticType.warning);

  /// Hata geri bildirimi
  void error() => trigger(HapticType.error);
}
```

- [ ] **Step 2: Derleme kontrolu**

Run: `cd tabul && flutter analyze lib/core/service/haptic/haptic_feedback_manager.dart`
Expected: No issues found

- [ ] **Step 3: Commit**

```bash
git add tabul/lib/core/service/haptic/haptic_feedback_manager.dart
git commit -m "feat: add HapticFeedbackManager singleton service"
```

---

### Task 4: DI Registration (locator.dart)

**Files:**
- Modify: `tabul/lib/core/injection/locator.dart`

**Onemli:** HapticSettingsCubit, HapticFeedbackManager'dan
ONCE register edilmeli (bagimlilik sirasi).

- [ ] **Step 1: Import'lari ekle**

Dosyanin basindaki import blogunun sonuna ekle
(diger core import'larinin yanina):

```dart
import 'package:tabul/core/bloc/cubit/haptic_settings_cubit.dart';
import 'package:tabul/core/service/haptic/haptic_feedback_manager.dart';
```

- [ ] **Step 2: Registration satirlarini ekle**

`init()` fonksiyonu icinde `//core` bolumune,
`AppRatingCubit` satirindan sonra ekle:

```dart
  locator.registerLazySingleton(
    () => HapticSettingsCubit(),
  );
  locator.registerLazySingleton(
    () => HapticFeedbackManager(),
  );
```

- [ ] **Step 3: Derleme kontrolu**

Run: `cd tabul && flutter analyze lib/core/injection/locator.dart`
Expected: No issues found

- [ ] **Step 4: Commit**

```bash
git add tabul/lib/core/injection/locator.dart
git commit -m "feat: register HapticSettingsCubit and HapticFeedbackManager in DI"
```

---

## Chunk 2: AppButton Entegrasyonu

### Task 5: AppButton'a hapticType parametresi ekle

**Files:**
- Modify: `tabul/lib/core/shared/buttons/app_button.dart`

Bu task AppButton'a `hapticType` parametresi ekler ve
`build()` metodunda `onPressed` callback'ini sarmalar.

- [ ] **Step 1: Import ekle**

Dosyanin basina ekle:

```dart
import 'package:tabul/core/injection/locator.dart';
import 'package:tabul/core/service/haptic/haptic_feedback_manager.dart';
import 'package:tabul/core/service/haptic/haptic_type.dart';
```

- [ ] **Step 2: Constructor'a hapticType parametresi ekle**

`AppButton._` constructor'ina yeni parametre ekle:

```dart
  final HapticType hapticType;

  const AppButton._({
    super.key,
    this.text,
    this.icon,
    this.onPressed,
    required this.style,
    this.customStyle,
    this.enabled = true,
    this.child,
    this.isLoading = false,
    this.alignment,
    this.textAlign,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.hapticType = HapticType.tap,
  });
```

- [ ] **Step 3: Tum static metotlara hapticType parametresi ekle**

Her static metoda `HapticType? hapticType` parametresi ekle
ve `AppButton._()` cagrisina gecir. Varsayilan degerleri
spec'e gore ata:

`tap` varsayilan metotlar (small, medium, large,
primaryFilled, secondaryFilled, outline, textOnly, iconOnly,
floating, custom):
```dart
  static AppButton small({
    // ... mevcut parametreler ...
    HapticType hapticType = HapticType.tap,
  }) {
    return AppButton._(
      // ... mevcut degerler ...
      hapticType: hapticType,
    );
  }
```

`success` varsayilan metotlar (startGame, joinGame,
createRoom, ready, playNow):
```dart
  static AppButton startGame({
    // ... mevcut parametreler ...
    HapticType hapticType = HapticType.success,
  }) {
    return AppButton._(
      // ... mevcut degerler ...
      hapticType: hapticType,
    );
  }
```

`error` varsayilan metotlar (error):
```dart
  static AppButton error({
    // ... mevcut parametreler ...
    HapticType hapticType = HapticType.error,
  }) {
    return AppButton._(
      // ... mevcut degerler ...
      hapticType: hapticType,
    );
  }
```

`success` varsayilan metotlar (success):
```dart
  static AppButton success({
    // ... mevcut parametreler ...
    HapticType hapticType = HapticType.success,
  }) {
    return AppButton._(
      // ... mevcut degerler ...
      hapticType: hapticType,
    );
  }
```

- [ ] **Step 4: build() metodunda haptic trigger ekle**

`build()` metodunun basinda, `onPressed` callback'ini
sarmala. Mevcut `build()` metodunun basina, `effectiveStyle`
taniminin ONCESINE ekle:

```dart
  @override
  Widget build(BuildContext context) {
    // Haptic feedback sarmalayici
    final wrappedOnPressed = onPressed != null
        ? () {
            locator<HapticFeedbackManager>().trigger(
              hapticType,
            );
            onPressed!();
          }
        : null;

    // ... mevcut kod aynen kalir ...
```

Sonra `build()` icerisinde tum `onPressed` referanslarini
`wrappedOnPressed` ile degistir. Toplam 4 yer:

1. `TextButton(onPressed: wrappedOnPressed, ...)`
2. `OutlinedButton(onPressed: wrappedOnPressed, ...)`
3. `IconButton(onPressed: wrappedOnPressed, ...)`
4. `ElevatedButton(onPressed: wrappedOnPressed, ...)`

- [ ] **Step 5: Derleme kontrolu**

Run: `cd tabul && flutter analyze lib/core/shared/buttons/app_button.dart`
Expected: No issues found

- [ ] **Step 6: Commit**

```bash
git add tabul/lib/core/shared/buttons/app_button.dart
git commit -m "feat: integrate haptic feedback into AppButton with per-type defaults"
```

---

## Chunk 3: Mevcut Kodun Temizligi

### Task 6: Daginik HapticFeedback cagrilarini manager ile degistir

**Files:** (asagidaki dosyalarin hepsi modify edilecek)
- `tabul/lib/product/widget/tabul_card.dart`
- `tabul/lib/feature/home/view/widgets/cauldron_deck_grid_widget.dart`
- `tabul/lib/feature/home/view/widgets/parts/tabul_deck_list_view.dart`
- `tabul/lib/feature/home/view/widgets/quick_tabul_game_widget.dart`
- `tabul/lib/feature/home/view/widgets/tabul_kazan_widget.dart`
- `tabul/lib/feature/home/view/widgets/cauldron_mini_slot_widget.dart`
- `tabul/lib/core/shared/sheets/settings_menu_sheet.dart`
- `tabul/lib/feature/referral/view/sheets/redeem_code_sheet.dart`
- `tabul/lib/core/shared/sheets/language_selection_sheet.dart`
- `tabul/lib/feature/home/view/pages/home_page.dart`
- `tabul/lib/feature/home/view/pages/tabul_kazan_page.dart`

**Degisiklik patterni (her dosya icin ayni):**

1. `import 'package:flutter/services.dart';` satirini kaldir
   (baska kullanimi yoksa)
2. `import 'package:tabul/core/injection/locator.dart';` ekle
   (yoksa)
3. `import 'package:tabul/core/service/haptic/haptic_feedback_manager.dart';`
   ekle
4. HapticFeedback cagrilarini degistir:

| Eski | Yeni |
|------|------|
| `HapticFeedback.lightImpact()` | `locator<HapticFeedbackManager>().tap()` |
| `HapticFeedback.selectionClick()` | `locator<HapticFeedbackManager>().selection()` |
| `HapticFeedback.mediumImpact()` | `locator<HapticFeedbackManager>().success()` |
| `HapticFeedback.heavyImpact()` | `locator<HapticFeedbackManager>().warning()` |
| `HapticFeedback.vibrate()` | `locator<HapticFeedbackManager>().error()` |

**Not:** Eger haptic cagrisi bir AppButton'un `onPressed`
icerisindeyse VE o AppButton zaten dogru `hapticType` ile
olusturuluyorsa, haptic cagrisini tamamen SIL (cifte tetikleme
onlenir). AppButton disindaki widget'larda (GestureDetector,
InkWell, DragTarget vb.) manager cagrisini birak.

**Koordinasyon:** `settings_menu_sheet.dart` bu task'ta
sadece mevcut `HapticFeedback.selectionClick()` cagrisinin
degistirilmesi icin yer alir. Task 8'de ayni dosyaya haptic
toggle widget'i eklenecek — import'lar bu task'ta zaten
eklenecegi icin Task 8'de tekrar eklenmesine gerek yok.

- [ ] **Step 1: Her dosyayi tek tek degistir**

Her dosya icin:
1. Dosyayi oku
2. `flutter/services.dart` import'unu kaldir (baska
   kullanimi yoksa kontrol et — ornegin
   `SystemChrome`, `SystemUiOverlayStyle` vb. varsa birak)
3. Manager import'larini ekle
4. HapticFeedback cagrilarini degistir
5. AppButton icerisindeki gereksiz cagriari sil

- [ ] **Step 2: Derleme kontrolu**

Run: `cd tabul && flutter analyze`
Expected: No issues found

- [ ] **Step 3: Commit**

```bash
git add \
  tabul/lib/product/widget/tabul_card.dart \
  tabul/lib/feature/home/view/widgets/cauldron_deck_grid_widget.dart \
  tabul/lib/feature/home/view/widgets/parts/tabul_deck_list_view.dart \
  tabul/lib/feature/home/view/widgets/quick_tabul_game_widget.dart \
  tabul/lib/feature/home/view/widgets/tabul_kazan_widget.dart \
  tabul/lib/feature/home/view/widgets/cauldron_mini_slot_widget.dart \
  tabul/lib/core/shared/sheets/settings_menu_sheet.dart \
  tabul/lib/feature/referral/view/sheets/redeem_code_sheet.dart \
  tabul/lib/core/shared/sheets/language_selection_sheet.dart \
  tabul/lib/feature/home/view/pages/home_page.dart \
  tabul/lib/feature/home/view/pages/tabul_kazan_page.dart
git commit -m "refactor: replace scattered HapticFeedback calls with centralized manager"
```

---

## Chunk 4: Ayarlar UI + Lokalizasyon

### Task 7: Lokalizasyon key'lerini ekle

**Files:**
- Modify: `tabul/lib/l10n/intl_tr.arb`
- Modify: `tabul/lib/l10n/intl_en.arb`

- [ ] **Step 1: Turkce ARB dosyasina ekle**

`intl_tr.arb` dosyasinin sonuna (kapatan `}` oncesine) ekle:

```json
  "haptic_feedback": "Titresim geri bildirimi"
```

- [ ] **Step 2: Ingilizce ARB dosyasina ekle**

`intl_en.arb` dosyasinin sonuna (kapatan `}` oncesine) ekle:

```json
  "haptic_feedback": "Haptic feedback"
```

- [ ] **Step 3: Lokalizasyon kodunu uret**

Run: `cd tabul && flutter gen-l10n`
Expected: Basarili — `lib/generated/` altinda dosyalar
guncellenir

- [ ] **Step 4: Commit**

```bash
git add tabul/lib/l10n/ tabul/lib/generated/
git commit -m "feat: add haptic_feedback localization keys"
```

---

### Task 8: Settings menu'ye haptic toggle ekle

**Files:**
- Modify: `tabul/lib/core/shared/sheets/settings_menu_sheet.dart`

- [ ] **Step 1: Import'lari ekle**

Dosyanin basina ekle (yoksa):

```dart
import 'package:tabul/core/bloc/cubit/haptic_settings_cubit.dart';
```

- [ ] **Step 2: Haptic toggle widget'ini ekle**

`_SettingsMenuContent.build()` icinde, `_PromoCodeButton`
widget'inin USTUNE (context.gap24 sonrasina) ekle:

```dart
            // Haptic geri bildirim toggle
            BlocBuilder<HapticSettingsCubit, bool>(
              bloc: locator<HapticSettingsCubit>(),
              builder: (context, isEnabled) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: MyColors.myLightBlue100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: MyColors.myLightBlue200,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      AppText.bodyLarge(
                        text: S.current.haptic_feedback,
                        color: MyColors.myDarkBlue200,
                      ),
                      Switch(
                        value: isEnabled,
                        onChanged: (_) {
                          locator<HapticSettingsCubit>()
                              .toggle();
                        },
                        activeColor: MyColors.myDarkBlue200,
                      ),
                    ],
                  ),
                );
              },
            ),
            context.gap8,
```

- [ ] **Step 3: Derleme kontrolu**

Run: `cd tabul && flutter analyze lib/core/shared/sheets/settings_menu_sheet.dart`
Expected: No issues found

- [ ] **Step 4: Commit**

```bash
git add tabul/lib/core/shared/sheets/settings_menu_sheet.dart
git commit -m "feat: add haptic feedback toggle to settings menu"
```

---

## Chunk 5: Son Dogrulama

### Task 9: Tam derleme ve analiz

- [ ] **Step 1: Tum projeyi analiz et**

Run: `cd tabul && flutter analyze`
Expected: No issues found

- [ ] **Step 2: Build kontrolu**

Run: `cd tabul && flutter build apk --debug 2>&1 | tail -5`
Expected: Build basarili

- [ ] **Step 3: Son commit (gerekirse)**

Eger analiz veya build sirasinda duzeltme yapildiysa:
```bash
git add -A tabul/
git commit -m "fix: resolve haptic feedback integration issues"
```
