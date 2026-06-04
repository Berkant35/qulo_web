# AppIcon Sistemi — Solar Bold Duotone Entegrasyonu

**Tarih:** 2026-06-05
**Branch:** APP-1915
**Kapsam:** Qulo mobile (qulov2). Server ve web etkilenmez.
**Out of scope:** DiamondIcon ve `icGem` / yeşil-mor elmas görselleri (kullanıcı talebi).

---

## 1. Amaç

Qulo'nun mevcut 81 SVG ikonundan UI kimliğini şekillendiren 14 ortak ikonu (heart, bell, lock, camera, mapPin, globe, gift, crown, eye, wand, chat, bolt, helpCircle, userRounded) tek bir görsel dile — **Solar Bold Duotone (filled) + Solar Linear (outlined)** — hizalamak. Filled/outlined toggle'ı kod tabanında tekrar eden ternary olmaktan çıkarıp `AppIcon` widget'ı arkasına almak. Quiz power'ları ve domain-spesifik ikonlar (hobby, zodiac vb.) bu PR'da dokunulmaz.

## 2. Mevcut Sistem Özeti

- `lib/core/constants/q_icons.dart` — `abstract final class QIcons`, 81 `static const String` path constant. Naming: `ic_<name>.svg`.
- `lib/core/widgets/q_icon.dart` — `SvgPicture.asset` + `ColorFilter.srcIn` wrapper, theme-aware color fallback (`color ?? IconTheme.of(context).color`).
- `lib/core/widgets/diamond_icon.dart` — animasyonlu domain widget'ı (mor/yeşil elmas). Bu PR'da dokunulmaz.
- `lib/core/widgets/power_icon.dart` — QIcon kullanan stack badge.
- Mevcut filled/outlined paired pattern sadece 4 ikon için var (heart, bell, compass, user). Bu PR yapıyı 14 ikona genişletir.
- Test: `test/` klasörü boş — widget/golden test infrastructure yok. CLAUDE.md kuralı: `flutter analyze` 0 hata.
- Bağımlılık: `flutter_svg ^2.0.16`. **Yeni paket eklenmez.**

## 3. Mimari

```
CALLSITE
  AppIcon(QIcons.heart, filled: isLiked, color: appColors.primary)
       │
       ▼
AppIcon (core/widgets/app_icon.dart)
  • IconRef alır, filled bool ile path seçer
  • size/color default'larını verir
  • İçeride QIcon'a delege eder
       │
       ▼
QIcon (core/widgets/q_icon.dart)  — DOKUNULMAZ
  • SvgPicture.asset + ColorFilter.srcIn
  • Theme-aware color fallback
```

**Üç katman, tek sorumluluk:** IconRef veri modeli + AppIcon API + QIcon renderer.

### 3.1 IconRef value class

Dosya: `lib/core/icons/icon_ref.dart`

```dart
import 'package:flutter/foundation.dart';

@immutable
class IconRef {
  final String filled;
  final String outlined;
  const IconRef({required this.filled, required this.outlined});
}
```

`const` tüm IconRef'ler derleme zamanı immutable — runtime allocation yok.

### 3.2 AppIcon widget

Dosya: `lib/core/widgets/app_icon.dart`

```dart
import 'package:flutter/widgets.dart';
import 'package:qulov2/core/icons/icon_ref.dart';
import 'package:qulov2/core/widgets/q_icon.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(
    this.ref, {
    this.filled = false,
    this.color,
    this.size = 24,
    super.key,
  });

  final IconRef ref;
  final bool filled;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return QIcon(
      filled ? ref.filled : ref.outlined,
      color: color,
      size: size,
    );
  }
}
```

`filled` default `false` → outlined varyantı. Çağrı yerinde `filled: someBool` ile dinamik toggle.

### 3.3 QIcons genişletme

Mevcut 81 string constant'tan:
- 17 tanesi silinir (14 IconRef'e taşınan + `icHeart`/`icHeartFilled`/`icBell`/`icBellFilled`/`icUser`/`icUserFilled` paired'lar).
- 20 tanesi dead code temizliği (bkz. §6).
- 44 string constant olduğu gibi kalır (quiz powers, domain, navigation atoms, gender).
- 14 yeni `IconRef` eklenir.

### 3.4 IconRef mapping (14 ikon)

```dart
abstract final class QIcons {
  // ─── Mevcut string constant'lar (44 tane, dokunulmaz) ───
  static const String icSkipForward  = 'assets/icons/ic_skip_forward.svg';
  static const String icOracle       = 'assets/icons/ic_oracle.svg';
  static const String icLightbulb    = 'assets/icons/ic_lightbulb.svg';
  static const String icClock        = 'assets/icons/ic_clock.svg';
  static const String icSplit        = 'assets/icons/ic_split.svg';
  static const String icFastForward  = 'assets/icons/ic_fast_forward.svg';
  static const String icX            = 'assets/icons/ic_x.svg';
  static const String icSend         = 'assets/icons/ic_send.svg';
  static const String icPlus         = 'assets/icons/ic_plus.svg';
  static const String icPencil       = 'assets/icons/ic_pencil.svg';
  static const String icTrash        = 'assets/icons/ic_trash.svg';
  static const String icLogOut       = 'assets/icons/ic_log_out.svg';
  static const String icChevronRight = 'assets/icons/ic_chevron_right.svg';
  // ... diğer 31 string constant (gender, hobby, zodiac, badge vb.)

  // ─── Solar IconRef'ler (14 ikon) ───
  static const IconRef heart = IconRef(
    filled:   'assets/icons/ic_heart_filled.svg',
    outlined: 'assets/icons/ic_heart.svg',
  );
  static const IconRef bell = IconRef(
    filled:   'assets/icons/ic_bell_filled.svg',
    outlined: 'assets/icons/ic_bell.svg',
  );
  static const IconRef lock = IconRef(
    filled:   'assets/icons/ic_lock_filled.svg',
    outlined: 'assets/icons/ic_lock.svg',
  );
  static const IconRef camera = IconRef(
    filled:   'assets/icons/ic_camera_filled.svg',
    outlined: 'assets/icons/ic_camera.svg',
  );
  static const IconRef mapPin = IconRef(
    filled:   'assets/icons/ic_map_pin_filled.svg',
    outlined: 'assets/icons/ic_map_pin.svg',
  );
  static const IconRef globe = IconRef(
    filled:   'assets/icons/ic_globe_filled.svg',
    outlined: 'assets/icons/ic_globe.svg',
  );
  static const IconRef gift = IconRef(
    filled:   'assets/icons/ic_gift_filled.svg',
    outlined: 'assets/icons/ic_gift.svg',
  );
  static const IconRef crown = IconRef(
    filled:   'assets/icons/ic_crown_filled.svg',
    outlined: 'assets/icons/ic_crown.svg',
  );
  static const IconRef eye = IconRef(
    filled:   'assets/icons/ic_eye_filled.svg',
    outlined: 'assets/icons/ic_eye.svg',
  );
  static const IconRef wand = IconRef(
    filled:   'assets/icons/ic_wand_filled.svg',
    outlined: 'assets/icons/ic_wand.svg',
  );
  static const IconRef chat = IconRef(
    filled:   'assets/icons/ic_chat_filled.svg',
    outlined: 'assets/icons/ic_chat.svg',
  );
  static const IconRef bolt = IconRef(
    filled:   'assets/icons/ic_bolt_filled.svg',
    outlined: 'assets/icons/ic_bolt.svg',
  );
  static const IconRef helpCircle = IconRef(
    filled:   'assets/icons/ic_help_circle_filled.svg',
    outlined: 'assets/icons/ic_help_circle.svg',
  );
  static const IconRef userRounded = IconRef(
    filled:   'assets/icons/ic_user_rounded_filled.svg',
    outlined: 'assets/icons/ic_user_rounded.svg',
  );
}
```

## 4. Asset Organizasyonu

### 4.1 Solar source mapping (Iconify slug)

| IconRef | Outlined slug | Filled slug |
|---|---|---|
| `heart` | `solar:heart-linear` | `solar:heart-bold-duotone` |
| `bell` | `solar:bell-linear` | `solar:bell-bold-duotone` |
| `lock` | `solar:lock-keyhole-linear` | `solar:lock-keyhole-bold-duotone` |
| `camera` | `solar:camera-linear` | `solar:camera-bold-duotone` |
| `mapPin` | `solar:map-point-linear` | `solar:map-point-bold-duotone` |
| `globe` | `solar:global-linear` | `solar:global-bold-duotone` |
| `gift` | `solar:gift-linear` | `solar:gift-bold-duotone` |
| `crown` | `solar:crown-linear` | `solar:crown-bold-duotone` |
| `eye` | `solar:eye-linear` | `solar:eye-bold-duotone` |
| `wand` | `solar:magic-stick-3-linear` | `solar:magic-stick-3-bold-duotone` |
| `chat` | `solar:chat-round-linear` | `solar:chat-round-bold-duotone` |
| `bolt` | `solar:bolt-linear` | `solar:bolt-bold-duotone` |
| `helpCircle` | `solar:question-circle-linear` | `solar:question-circle-bold-duotone` |
| `userRounded` | `solar:user-rounded-linear` | `solar:user-rounded-bold-duotone` |

İndirme: `https://api.iconify.design/solar/{slug}.svg` → `qulov2/assets/icons/`. SVG'ler `fill="currentColor"` ile gelir, QIcon'un `ColorFilter.srcIn` recoloring'i ile uyumlu — ekstra dönüşüm gerekmez.

### 4.2 Dosya işlemleri (14 IconRef × 2 = 28 Solar SVG)

**Yeni dosya (16):**

| Kategori | Dosya | Solar slug |
|---|---|---|
| Filled (8 yeni) | `ic_lock_filled.svg` | `lock-keyhole-bold-duotone` |
| | `ic_map_pin_filled.svg` | `map-point-bold-duotone` |
| | `ic_globe_filled.svg` | `global-bold-duotone` |
| | `ic_gift_filled.svg` | `gift-bold-duotone` |
| | `ic_crown_filled.svg` | `crown-bold-duotone` |
| | `ic_eye_filled.svg` | `eye-bold-duotone` |
| | `ic_wand_filled.svg` | `magic-stick-3-bold-duotone` |
| | `ic_help_circle_filled.svg` | `question-circle-bold-duotone` |
| Rename çiftleri (8) | `ic_camera.svg` + `ic_camera_filled.svg` | `camera-linear` / `-bold-duotone` |
| | `ic_chat.svg` + `ic_chat_filled.svg` | `chat-round-linear` / `-bold-duotone` |
| | `ic_bolt.svg` + `ic_bolt_filled.svg` | `bolt-linear` / `-bold-duotone` |
| | `ic_user_rounded.svg` + `ic_user_rounded_filled.svg` | `user-rounded-linear` / `-bold-duotone` |

**Overwrite — mevcut path, içerik Solar'a değişir (12 dosya):**

`ic_heart.svg`, `ic_heart_filled.svg`, `ic_bell.svg`, `ic_bell_filled.svg`, `ic_lock.svg`, `ic_map_pin.svg`, `ic_globe.svg`, `ic_gift.svg`, `ic_crown.svg`, `ic_eye.svg`, `ic_wand.svg`, `ic_help_circle.svg`.

**Silinecek — alignment rename'leri (5 dosya):**

`ic_photo_camera.svg`, `ic_chats.svg`, `ic_zap.svg`, `ic_user.svg`, `ic_user_filled.svg`.

**Silinecek — dead code SVG'leri (§6'daki 20 ikonun her birinin SVG'si):**

Aday liste: `ic_compass_filled.svg`, `ic_compass_off.svg`, `ic_fire.svg`, `ic_gem.svg`, `ic_plane.svg`, `ic_age_range.svg`, `ic_gender_pref.svg`, `ic_arrow_left.svg`, `ic_check_circle.svg`, `ic_image_plus.svg`, `ic_location.svg`, `ic_plus_circle.svg`, `ic_minus_circle.svg`, `ic_settings.svg`, `ic_badge_bronze.svg`, `ic_badge_silver.svg`, `ic_badge_gold.svg`, `ic_user_outline.svg`, `ic_eye_off.svg`, `ic_bell_off.svg`. Kesin liste implementation aşamasında her constant için `grep -rn "QIcons\.<name>\b" lib` ile 0 kullanım doğrulanarak finalize edilir; SVG dosyası + constant birlikte silinir.

### 4.3 pubspec.yaml

Değişiklik yok. `assets/icons/` folder glob — yeni SVG'ler otomatik dahil.

## 5. Callsite Migration (24 dosya, 39 callsite)

### 5.1 Filled/outlined toggle aktif (4 yer)

| Dosya | Önce | Sonra |
|---|---|---|
| `lib/routing/app_routes.dart` | `QIcon(state.selected ? QIcons.icHeartFilled : QIcons.icHeart, ...)` (Discover tab) | `AppIcon(QIcons.heart, filled: state.selected, ...)` |
| `lib/routing/app_routes.dart` | `QIcon(state.selected ? QIcons.icUserFilled : QIcons.icUser, ...)` (Profile tab) | `AppIcon(QIcons.userRounded, filled: state.selected, ...)` |
| `lib/core/widgets/in_app_banner.dart` | `QIcon(QIcons.icBellFilled, ...)` | `AppIcon(QIcons.bell, filled: true, ...)` |
| `lib/features/profile/widgets/notification_bell_button.dart` | `QIcon(QIcons.icBell, ...)` | `AppIcon(QIcons.bell, filled: hasUnread, ...)` (mevcut `hasUnread` state'i bu widget'ta var) |

### 5.2 Tek varyant (35 callsite, 20 dosya)

Pattern: `QIcon(QIcons.icX, ...)` → `AppIcon(QIcons.x, ...)`. Argüman sırası ve isimleri (`color`, `size`) aynı.

| IconRef | Dosyalar |
|---|---|
| `lock` (7) | `core/widgets/locked_feature_button.dart`, `core/widgets/power_icon.dart`, `core/widgets/question_gate_banner.dart`, `features/discover/widgets/discover_question_gate.dart`, `features/passport/widgets/passport_premium_gate.dart`, `features/profile/widgets/questions_fab.dart` |
| `wand` (6) | `features/discover/widgets/discover_question_gate.dart`, `features/profile/widgets/questions_empty_state.dart`, `features/questions/widgets/best_question_highlight.dart` (varsa), `features/questions/widgets/easy_mode_category_section.dart`, `features/questions/widgets/easy_mode_suggestions_content.dart`, `features/questions/widgets/question_step_question.dart` |
| `bolt` (5) | `features/diamonds/screens/diamonds_screen.dart`, `features/discover/widgets/profile_card.dart`, `features/profile_detail/widgets/profile_basic_info.dart`, `features/quiz/widgets/quiz_result_dialog.dart` |
| `mapPin` (5) | `features/discover/widgets/profile_card.dart`, `features/profile/widgets/edit_profile_basic_info_section.dart`, `features/profile/widgets/profile_identity_card.dart`, `features/profile/widgets/profile_preferences_section.dart`, `features/profile_detail/widgets/profile_basic_info.dart` |
| `helpCircle` (4) | `features/diamonds/screens/subscription_comparison_screen.dart`, `features/diamonds/widgets/monthly_benefits_card.dart`, `features/profile/widgets/profile_menu_list.dart` |
| `crown` (4) | `features/diamonds/widgets/subscription_banner.dart`, `features/profile/widgets/profile_menu_list.dart`, `features/questions/widgets/best_question_highlight.dart`, `features/quiz/widgets/quiz_result_dialog.dart` |
| `globe` (3) | `features/diamonds/screens/subscription_comparison_screen.dart`, `features/diamonds/widgets/monthly_benefits_card.dart`, `features/profile/widgets/profile_preferences_section.dart` |
| `heart` (3) | `features/profile/widgets/profile_preferences_section.dart`, `features/quiz/widgets/quiz_result_dialog.dart` (bottom nav dışı) |
| `userRounded` (2) | `features/discover/widgets/profile_card.dart` avatar fallback, `features/profile/widgets/photo_grid.dart` empty slot |

### 5.3 Dead → Live ikonlar (0 mevcut callsite, hazır kalır)

`camera`, `gift`, `eye`, `chat` — bu PR'da SVG + IconRef hazır, çağrı yeri yok. Gelecek feature'larda opt-in (photo upload, referral kartı yenilemesi, who-viewed-me, chat tab refactor).

## 6. Dead Code Temizliği (Aynı PR)

Mevcut q_icons.dart'taki ≤1 kullanımlı 20 ikon: `icAgeRange`, `icArrowLeft`, `icBadgeGold`, `icBadgeSilver`, `icBadgeBronze`, `icCheckCircle`, `icCompassFilled`, `icCompassOff`, `icFire`, `icGem`, `icGenderPref`, `icImagePlus`, `icLocation`, `icMinusCircle`, `icPlane`, `icPlusCircle`, `icSettings`, `icUserOutline`, `icEyeOff`, `icBellOff` (son ikisi varsa).

Implementation aşamasında her constant için `grep -rn "QIcons\.<name>\b" lib` çalıştırıp 0 kullanım doğrulandıktan sonra silinir. Constant + SVG dosyası birlikte gider.

**Gerekçe:** PR zaten q_icons.dart'ı düzenliyor — fırsat. Selective alignment'ın yan ürünü olarak yapılır, ayrı PR'a böldürmek minimal kazanç sağlar.

## 7. Out of Scope (Bu PR)

- `DiamondIcon` widget'ı + `icPurpleDiamond`, `icGreenDiamond` referansları + animasyonlu yeşil/mor elmas görselleri — kullanıcı talebi: yeşil elmas ekonomisi hariç.
- Quiz power ikonları (`icSkipForward`, `icLightbulb`, `icOracle`, `icSplit`, `icClock`, `icFastForward`) — Solar setinin doğrudan karşılığı yok, custom kalır.
- Domain-spesifik ikonlar (`icHobby`, `icZodiac`, `icSmoke`, `icPets`, `icSchool`, `icJob`, `icMusic`, `icTravel`, `icCake`, `icCalendar`, `icHeight`, `icWeight`, `icPersonality`) — kullanım yerleri custom, Solar generic karşılıkları stilistik kayba neden olur.
- Navigation atom'ları (`icChevronRight`, `icX`, `icSend`, `icPlus`, `icPencil`, `icTrash`, `icLogOut`) — proje boyunca çok yaygın, ayrı bir alignment kararı gerektirir.
- Gender ikonları (`icMale`, `icFemale`, `icTransgender`) — yasal hassasiyet, ayrı değerlendirme gerektirir.
- Golden test infrastructure — proje şu an widget testi tutmuyor; bu PR'da kurmak scope dışı.
- Light theme renk override — `app_colors.dart` resolved tema sistemi zaten otomatik handle ediyor.

## 8. Error Handling

| Risk | Önlem |
|---|---|
| SVG indirme atlanır → AssetException | Rollout sırası zorunlu: SVG hazırlık → kod → callsite. Phase 1 olmadan Phase 4 başlamaz. |
| Yanlış path string | IconRef const, derleme zamanı statik. `QIcons.heart` yazımı IDE autocomplete'ten gelir, yazım hatası imkânsız. |
| pubspec asset eksik | `assets/icons/` folder glob — yeni SVG'ler otomatik dahil. |
| flutter_svg render hatası | Mevcut QIcon altyapısı kanıtlanmış; AppIcon QIcon'a delege ediyor — yeni hata noktası yok. |
| Silinen constant'a referans kaldı | Phase 5 `flutter analyze` "undefined name" verir — compile-time yakalanır. |
| Migration'da bir IconRef çağrısı atlandı | Eski SVG dosyası silinince runtime asset not found → Phase 6 smoke test yakalar. |

## 9. Test Stratejisi

**Test infrastructure yok** (proje `test/` boş). Bu PR test framework kurmaz. Onaylama:

1. **`flutter analyze`** — 0 hata zorunlu (CLAUDE.md kuralı).
2. **Manuel smoke test** (`flutter run`) — aşağıdaki 8 ekran:
   - Bottom nav Discover tab tıkla → `heart` filled/outlined geçiş
   - Bottom nav Profile tab tıkla → `userRounded` filled/outlined geçiş
   - Profile header çan → `bell` (unread varsa filled, yoksa outlined)
   - Free user discover → question gate → `lock` + `wand` görünür
   - Profile card → `mapPin` (uzaklık), `bolt` (boost), `userRounded` (avatar fallback)
   - Subscription comparison ekranı → `crown` + `globe` + `helpCircle`
   - Passport premium gate → `lock`
   - Quiz sonuç dialog → `crown` + `heart` + `bolt`
3. **`/flutter-review` skill** — CLAUDE.md auto-review kuralı, commit öncesi zorunlu.

## 10. Rollout — Tek Atomic PR (8 faz)

```
Phase 1: SVG asset hazırlığı
  • 28 Solar SVG indir (Iconify API)
  • 5 eski SVG sil (ic_photo_camera, ic_chats, ic_zap, ic_user, ic_user_filled)
  • Dead code SVG'leri sil (20 ikon, grep ile 0 kullanım doğrulanarak)

Phase 2: Mimari kod
  • lib/core/icons/icon_ref.dart      → IconRef value class
  • lib/core/widgets/app_icon.dart    → AppIcon wrapper (StatelessWidget)

Phase 3: q_icons.dart cleanup
  • Sil: 17 migrating constant + 20 dead-code constant
  • Ekle: 14 IconRef const

Phase 4: Callsite migration (24 dosya, 39 callsite)
  • QIcon → AppIcon değişimleri §5.1 + §5.2

Phase 5: flutter analyze → 0 hata

Phase 6: Manuel smoke (8 ekran, §9)

Phase 7: /flutter-review skill

Phase 8: Commit + push → APP-1915
```

**Atomic gerekçe:** Yarım migration compile error (silinen constant'a referans). Tek PR'da kapanır.

## 11. Bağımlılıklar

Hiçbir yeni paket yok. `flutter_svg ^2.0.16` mevcut, IconRef pure Dart, AppIcon pure Flutter widget. **Sıfır pubspec değişikliği.**

## 12. Açık Noktalar — Yok

Kullanıcı tüm 4 bölümü onayladı:
- Selective alignment (mevcut overlapping 14 ikonu Solar'a hizala, custom kalanlar dokunulmaz)
- Hepsine çift varyant (14 × 2 = 28 SVG)
- Yaklaşım B (AppIcon wrapper + IconRef, QIcon altyapısı korunur)
- Tek atomic PR, dead code temizliği aynı PR'da

Implementation plan bu spec'in onayı sonrası ayrı dosyada üretilecek.
