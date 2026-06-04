# AppIcon Sistemi — Solar Bold Duotone Migration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Qulo mobile uygulamasındaki 14 ortak ikonu Solar bold-duotone/linear setine hizalamak; filled/outlined toggle'ı `AppIcon` wrapper + `IconRef` value class arkasına almak; aynı PR'da 20 dead code ikonu temizlemek.

**Architecture:** 3 katman — IconRef veri modeli (immutable const value class) + AppIcon yüksek seviye API (StatelessWidget wrapper) + mevcut QIcon renderer (dokunulmaz, alt katman). Tek atomic PR — yarım migration compile error verir.

**Tech Stack:** Flutter (Dart), `flutter_svg ^2.0.16` (mevcut), Iconify CDN (SVG indirme), `flutter analyze` doğrulama. Yeni paket yok.

**Spec referansı:** `docs/superpowers/specs/2026-06-05-app-icon-system-design.md`

---

## Working directory

Tüm komutlar `qulov2/` kök dizininden çalıştırılır:
```
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
```

Git komutları monorepo kökünden:
```
cd /Users/berkantcalikusu/IdeaProjects/qulo
```

---

## File Structure

### Oluşturulacak dosyalar
- `qulov2/lib/core/icons/icon_ref.dart` — `IconRef` immutable value class
- `qulov2/lib/core/widgets/app_icon.dart` — `AppIcon` StatelessWidget wrapper
- `qulov2/assets/icons/ic_*.svg` — 16 yeni SVG (8 filled + 8 rename çifti)

### Değiştirilecek dosyalar (28 dosya)
- `qulov2/lib/core/constants/q_icons.dart` — 14 IconRef ekle, sonra 17 migrating + 20 dead code string constant sil
- `qulov2/lib/routing/app_routes.dart` — bottom nav heart + userRounded toggle
- `qulov2/lib/core/widgets/in_app_banner.dart` — bell filled
- `qulov2/lib/core/widgets/locked_feature_button.dart` — lock
- `qulov2/lib/core/widgets/power_icon.dart` — lock
- `qulov2/lib/core/widgets/question_gate_banner.dart` — lock
- `qulov2/lib/features/passport/widgets/passport_premium_gate.dart` — lock
- `qulov2/lib/features/discover/widgets/discover_question_gate.dart` — lock + wand
- `qulov2/lib/features/discover/widgets/profile_card.dart` — mapPin + bolt + userRounded
- `qulov2/lib/features/profile/widgets/notification_bell_button.dart` — bell toggle
- `qulov2/lib/features/profile/widgets/edit_profile_basic_info_section.dart` — mapPin
- `qulov2/lib/features/profile/widgets/profile_identity_card.dart` — mapPin
- `qulov2/lib/features/profile/widgets/profile_preferences_section.dart` — mapPin + heart + globe
- `qulov2/lib/features/profile/widgets/profile_menu_list.dart` — crown + helpCircle
- `qulov2/lib/features/profile/widgets/photo_grid.dart` — userRounded
- `qulov2/lib/features/profile/widgets/questions_empty_state.dart` — wand
- `qulov2/lib/features/profile/widgets/questions_fab.dart` — lock
- `qulov2/lib/features/profile_detail/widgets/profile_basic_info.dart` — mapPin + bolt
- `qulov2/lib/features/diamonds/screens/diamonds_screen.dart` — bolt
- `qulov2/lib/features/diamonds/screens/subscription_comparison_screen.dart` — globe + helpCircle
- `qulov2/lib/features/diamonds/widgets/monthly_benefits_card.dart` — globe + helpCircle
- `qulov2/lib/features/diamonds/widgets/subscription_banner.dart` — crown
- `qulov2/lib/features/questions/widgets/best_question_highlight.dart` — crown
- `qulov2/lib/features/questions/widgets/easy_mode_category_section.dart` — wand
- `qulov2/lib/features/questions/widgets/easy_mode_suggestions_content.dart` — wand
- `qulov2/lib/features/questions/widgets/question_step_question.dart` — wand
- `qulov2/lib/features/quiz/widgets/quiz_result_dialog.dart` — crown + heart + bolt

### Silinecek dosyalar
- 5 alignment SVG: `ic_photo_camera.svg`, `ic_chats.svg`, `ic_zap.svg`, `ic_user.svg`, `ic_user_filled.svg`
- 20 dead code SVG'si (Task 13'te kullanım sayımıyla doğrulanır)

---

## Task 1: Solar SVG asset indirme (28 dosya)

**Files:**
- Create: `qulov2/assets/icons/ic_heart.svg`, `ic_heart_filled.svg`, `ic_bell.svg`, `ic_bell_filled.svg`, `ic_lock.svg`, `ic_lock_filled.svg`, `ic_camera.svg`, `ic_camera_filled.svg`, `ic_map_pin.svg`, `ic_map_pin_filled.svg`, `ic_globe.svg`, `ic_globe_filled.svg`, `ic_gift.svg`, `ic_gift_filled.svg`, `ic_crown.svg`, `ic_crown_filled.svg`, `ic_eye.svg`, `ic_eye_filled.svg`, `ic_wand.svg`, `ic_wand_filled.svg`, `ic_chat.svg`, `ic_chat_filled.svg`, `ic_bolt.svg`, `ic_bolt_filled.svg`, `ic_help_circle.svg`, `ic_help_circle_filled.svg`, `ic_user_rounded.svg`, `ic_user_rounded_filled.svg`

> Not: `ic_heart`, `ic_heart_filled`, `ic_bell`, `ic_bell_filled`, `ic_lock`, `ic_map_pin`, `ic_globe`, `ic_gift`, `ic_crown`, `ic_eye`, `ic_wand`, `ic_help_circle` mevcut dosyalardır — Solar SVG ile **overwrite** edilir. Diğer 16'sı yeni dosya.

- [ ] **Step 1: Asset dizinine geç ve mevcut state'i not et**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2/assets/icons
ls ic_heart.svg ic_bell.svg ic_user.svg ic_zap.svg ic_chats.svg ic_photo_camera.svg
```
Expected: 6 dosyanın da var olduğu görünür (Task 2'de silinecekler dahil).

- [ ] **Step 2: 28 SVG'yi Iconify CDN'den indir**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2/assets/icons

# Format: curl -s "https://api.iconify.design/solar/<slug>.svg" -o "<filename>"

# heart
curl -s "https://api.iconify.design/solar/heart-linear.svg" -o "ic_heart.svg"
curl -s "https://api.iconify.design/solar/heart-bold-duotone.svg" -o "ic_heart_filled.svg"

# bell
curl -s "https://api.iconify.design/solar/bell-linear.svg" -o "ic_bell.svg"
curl -s "https://api.iconify.design/solar/bell-bold-duotone.svg" -o "ic_bell_filled.svg"

# lock
curl -s "https://api.iconify.design/solar/lock-keyhole-linear.svg" -o "ic_lock.svg"
curl -s "https://api.iconify.design/solar/lock-keyhole-bold-duotone.svg" -o "ic_lock_filled.svg"

# camera (rename: ic_photo_camera → ic_camera)
curl -s "https://api.iconify.design/solar/camera-linear.svg" -o "ic_camera.svg"
curl -s "https://api.iconify.design/solar/camera-bold-duotone.svg" -o "ic_camera_filled.svg"

# mapPin
curl -s "https://api.iconify.design/solar/map-point-linear.svg" -o "ic_map_pin.svg"
curl -s "https://api.iconify.design/solar/map-point-bold-duotone.svg" -o "ic_map_pin_filled.svg"

# globe
curl -s "https://api.iconify.design/solar/global-linear.svg" -o "ic_globe.svg"
curl -s "https://api.iconify.design/solar/global-bold-duotone.svg" -o "ic_globe_filled.svg"

# gift
curl -s "https://api.iconify.design/solar/gift-linear.svg" -o "ic_gift.svg"
curl -s "https://api.iconify.design/solar/gift-bold-duotone.svg" -o "ic_gift_filled.svg"

# crown
curl -s "https://api.iconify.design/solar/crown-linear.svg" -o "ic_crown.svg"
curl -s "https://api.iconify.design/solar/crown-bold-duotone.svg" -o "ic_crown_filled.svg"

# eye
curl -s "https://api.iconify.design/solar/eye-linear.svg" -o "ic_eye.svg"
curl -s "https://api.iconify.design/solar/eye-bold-duotone.svg" -o "ic_eye_filled.svg"

# wand (Solar: magic-stick-3)
curl -s "https://api.iconify.design/solar/magic-stick-3-linear.svg" -o "ic_wand.svg"
curl -s "https://api.iconify.design/solar/magic-stick-3-bold-duotone.svg" -o "ic_wand_filled.svg"

# chat (rename: ic_chats → ic_chat)
curl -s "https://api.iconify.design/solar/chat-round-linear.svg" -o "ic_chat.svg"
curl -s "https://api.iconify.design/solar/chat-round-bold-duotone.svg" -o "ic_chat_filled.svg"

# bolt (rename: ic_zap → ic_bolt)
curl -s "https://api.iconify.design/solar/bolt-linear.svg" -o "ic_bolt.svg"
curl -s "https://api.iconify.design/solar/bolt-bold-duotone.svg" -o "ic_bolt_filled.svg"

# helpCircle (Solar: question-circle)
curl -s "https://api.iconify.design/solar/question-circle-linear.svg" -o "ic_help_circle.svg"
curl -s "https://api.iconify.design/solar/question-circle-bold-duotone.svg" -o "ic_help_circle_filled.svg"

# userRounded (rename: ic_user → ic_user_rounded)
curl -s "https://api.iconify.design/solar/user-rounded-linear.svg" -o "ic_user_rounded.svg"
curl -s "https://api.iconify.design/solar/user-rounded-bold-duotone.svg" -o "ic_user_rounded_filled.svg"
```

- [ ] **Step 3: 28 SVG'nin başarıyla indiğini doğrula**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2/assets/icons
for f in ic_heart ic_heart_filled ic_bell ic_bell_filled ic_lock ic_lock_filled ic_camera ic_camera_filled ic_map_pin ic_map_pin_filled ic_globe ic_globe_filled ic_gift ic_gift_filled ic_crown ic_crown_filled ic_eye ic_eye_filled ic_wand ic_wand_filled ic_chat ic_chat_filled ic_bolt ic_bolt_filled ic_help_circle ic_help_circle_filled ic_user_rounded ic_user_rounded_filled; do
  size=$(stat -f%z "$f.svg" 2>/dev/null || echo "MISSING")
  echo "$size $f.svg"
done
```
Expected: Her satır > 100 byte olmalı. "MISSING" veya 0 byte yoksa OK. (Iconify hatalı slug için boş döner.) 0 byte veya MISSING varsa o slug'ı Step 2'den manuel düzelt.

- [ ] **Step 4: Bir SVG'yi açıp `currentColor` kullandığını doğrula**

```bash
grep -l "currentColor" qulov2/assets/icons/ic_heart_filled.svg qulov2/assets/icons/ic_lock.svg qulov2/assets/icons/ic_bolt_filled.svg
```
Expected: 3 dosyanın yolu listelenir. `currentColor` desteği QIcon'un `ColorFilter.srcIn` recoloring'i için gerekli.

- [ ] **Step 5: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add qulov2/assets/icons/
git commit -m "$(cat <<'EOF'
feat(icons): Solar bold-duotone/linear setinden 28 SVG eklendi

heart, bell, lock, camera, mapPin, globe, gift, crown, eye, wand, chat,
bolt, helpCircle, userRounded — her biri filled (bold-duotone) + outlined
(linear) varyantıyla. Mevcut 12 ikonun içeriği Solar'a overwrite, 16'sı
yeni dosya (8 filled yeni + 4 rename çifti).

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 2: Eski alignment SVG'lerini sil (5 dosya)

**Files:**
- Delete: `qulov2/assets/icons/ic_photo_camera.svg`, `ic_chats.svg`, `ic_zap.svg`, `ic_user.svg`, `ic_user_filled.svg`

- [ ] **Step 1: Dosyaları sil**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2/assets/icons
rm ic_photo_camera.svg ic_chats.svg ic_zap.svg ic_user.svg ic_user_filled.svg
```

- [ ] **Step 2: Silindiğini doğrula**

```bash
ls qulov2/assets/icons/ic_photo_camera.svg qulov2/assets/icons/ic_chats.svg qulov2/assets/icons/ic_zap.svg qulov2/assets/icons/ic_user.svg qulov2/assets/icons/ic_user_filled.svg 2>&1
```
Expected: 5 satır da "No such file or directory" hatası vermeli.

- [ ] **Step 3: Bu silmelerin compile'ı kırmadığını flutter analyze ile doğrula** (henüz constant'lar dokunulmadığı için kırmaz — constant'lar string path tutar, dosya yokluğu derleme zamanı kontrol edilmez)

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
flutter analyze
```
Expected: 0 hata. Path'ler hâlâ string constant'larda yazılı olduğu için derleme geçer; runtime'da bu constant'lara dokunan çağrı yeri varsa AssetException atar — Task 6-12'de hepsi migrate edilecek.

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add -u qulov2/assets/icons/
git commit -m "$(cat <<'EOF'
chore(icons): eski alignment SVG'lerini sil (Solar rename'leri öncesi)

ic_photo_camera, ic_chats, ic_zap, ic_user, ic_user_filled silindi. Yerleri
Task 1'deki ic_camera, ic_chat, ic_bolt, ic_user_rounded ile dolduruldu.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 3: IconRef value class oluştur

**Files:**
- Create: `qulov2/lib/core/icons/icon_ref.dart`

- [ ] **Step 1: Klasörü ve dosyayı oluştur**

```bash
mkdir -p /Users/berkantcalikusu/IdeaProjects/qulo/qulov2/lib/core/icons
```

- [ ] **Step 2: `icon_ref.dart` içeriğini yaz**

Dosya: `qulov2/lib/core/icons/icon_ref.dart`

```dart
import 'package:flutter/foundation.dart';

/// Filled (Solar bold-duotone) ve outlined (Solar linear) SVG path'lerini
/// bir arada tutan immutable value object.
///
/// Kullanım: [QIcons.heart] gibi const referanslar üzerinden çağrılır,
/// [AppIcon] widget'ı `filled` bool'una göre uygun path'i seçer.
@immutable
class IconRef {
  final String filled;
  final String outlined;
  const IconRef({required this.filled, required this.outlined});
}
```

- [ ] **Step 3: flutter analyze ile syntax doğrula**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
flutter analyze lib/core/icons/icon_ref.dart
```
Expected: 0 hata, 0 uyarı.

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add qulov2/lib/core/icons/icon_ref.dart
git commit -m "$(cat <<'EOF'
feat(core): IconRef value class — filled/outlined SVG path container

AppIcon widget'ının filled bool'una göre path seçtiği immutable veri
modeli. const compatible — derleme zamanı statik.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 4: AppIcon widget oluştur

**Files:**
- Create: `qulov2/lib/core/widgets/app_icon.dart`

- [ ] **Step 1: `app_icon.dart` içeriğini yaz**

Dosya: `qulov2/lib/core/widgets/app_icon.dart`

```dart
import 'package:flutter/widgets.dart';
import 'package:qulov2/core/icons/icon_ref.dart';
import 'package:qulov2/core/widgets/q_icon.dart';

/// Tip güvenli icon API'si — [IconRef]'ten filled veya outlined varyantı
/// seçip [QIcon]'a delege eder. QIcon altyapısı dokunulmadan kalır;
/// AppIcon sadece üst katman.
///
/// Kullanım:
/// ```dart
/// AppIcon(QIcons.heart, filled: isLiked, color: appColors.primary)
/// AppIcon(QIcons.lock, size: 20)
/// ```
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

- [ ] **Step 2: Import path'lerini doğrula**

`pubspec.yaml`'da paket adının `qulov2` olduğunu kontrol et:
```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
grep "^name:" pubspec.yaml
```
Expected: `name: qulov2`. Eğer farklıysa (örn. `qulo_v2`) yukarıdaki `package:qulov2/...` import'larını paket adına göre düzelt.

- [ ] **Step 3: flutter analyze**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
flutter analyze lib/core/widgets/app_icon.dart
```
Expected: 0 hata.

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add qulov2/lib/core/widgets/app_icon.dart
git commit -m "$(cat <<'EOF'
feat(core): AppIcon widget — IconRef + filled bool API

QIcon altyapısına delege eden StatelessWidget. Filled/outlined toggle
tek satırda: AppIcon(QIcons.heart, filled: isLiked).

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 5: QIcons additive — 14 IconRef ekle

> **Strateji:** Eski string constant'lara henüz dokunulmuyor. Sadece 14 yeni IconRef eklenir. Callsite migration sırasında her ikon için string constant kullanımı 0'a düşene kadar string constant kalır. Task 13'te toplu temizlik yapılır.

**Files:**
- Modify: `qulov2/lib/core/constants/q_icons.dart` — sona yeni section ekle

- [ ] **Step 1: Mevcut dosyayı oku ve son satırı not et**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
tail -5 lib/core/constants/q_icons.dart
```
Expected: Class kapanış `}` görünür. Yeni IconRef'ler bu kapanıştan ÖNCE eklenmeli.

- [ ] **Step 2: Import ekle (dosyanın en üstüne)**

`qulov2/lib/core/constants/q_icons.dart` dosyasının en üstüne ekle:

```dart
import 'package:qulov2/core/icons/icon_ref.dart';
```

> Eğer dosyada başka import yoksa, ilk satır olarak ekle. Varsa alfabetik sıraya göre yerleştir.

- [ ] **Step 3: Class içine `}` öncesi 14 IconRef'i ekle**

`q_icons.dart`'taki class kapanış `}` satırından hemen önce:

```dart

  // ─── Solar Bold Duotone / Linear (14 IconRef) ───
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
```

- [ ] **Step 4: flutter analyze**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
flutter analyze lib/core/constants/q_icons.dart
```
Expected: 0 hata. Eski string constant'lar bozulmadan duruyor, yenisi additive.

- [ ] **Step 5: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add qulov2/lib/core/constants/q_icons.dart
git commit -m "$(cat <<'EOF'
feat(icons): QIcons'a 14 Solar IconRef eklendi (additive)

heart, bell, lock, camera, mapPin, globe, gift, crown, eye, wand, chat,
bolt, helpCircle, userRounded. Eski string constant'lara henüz
dokunulmadı — callsite migration sonrası Task 13'te toplu temizlenecek.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 6: Migration — Bottom nav toggle (routing/app_routes.dart)

**Files:**
- Modify: `qulov2/lib/routing/app_routes.dart` — 4 callsite (Discover heart toggle, Profile userRounded toggle)

**Pattern:**
```dart
// ÖNCE
QIcon(state.selected ? QIcons.icHeartFilled : QIcons.icHeart, ...)
QIcon(state.selected ? QIcons.icUserFilled : QIcons.icUser, ...)

// SONRA
AppIcon(QIcons.heart, filled: state.selected, ...)
AppIcon(QIcons.userRounded, filled: state.selected, ...)
```

- [ ] **Step 1: Mevcut callsite'ları bul**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
grep -n "QIcons\.\(icHeart\|icHeartFilled\|icUser\|icUserFilled\)" lib/routing/app_routes.dart
```
Expected: 4 satır listelenir.

- [ ] **Step 2: AppIcon import ekle (dosyanın import bölümüne)**

`qulov2/lib/routing/app_routes.dart` dosyasının import bloğuna ekle:

```dart
import 'package:qulov2/core/widgets/app_icon.dart';
```

> İmport sıralaması alfabetik. `flutter` ve `package:` import'ları arasındaki convention'a uy.

- [ ] **Step 3: 4 callsite'ı migrate et**

Step 1'deki her satır için: ternary `QIcon(... ? QIcons.icHeartFilled : QIcons.icHeart, ...)` → `AppIcon(QIcons.heart, filled: <ternary condition>, ...)`. Pattern aynı argüman isimleriyle (`color`, `size`) korunur.

- [ ] **Step 4: Eski QIcon import'unun hâlâ gerekli olup olmadığını kontrol et**

```bash
grep -c "QIcon(" lib/routing/app_routes.dart
```
Expected: 0 ise `import '.../q_icon.dart';` satırını sil. >0 ise import'u tut.

- [ ] **Step 5: flutter analyze**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
flutter analyze lib/routing/app_routes.dart
```
Expected: 0 hata.

- [ ] **Step 6: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add qulov2/lib/routing/app_routes.dart
git commit -m "$(cat <<'EOF'
refactor(routing): bottom nav heart/userRounded AppIcon'a geçti

Discover ve Profile tab'larında ternary filled/outlined seçimi tek satır
AppIcon(... , filled: state.selected) formuna geçti.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 7: Migration — Core widgets + passport (lock + bell)

**Files:**
- Modify: `qulov2/lib/core/widgets/in_app_banner.dart` — bell filled
- Modify: `qulov2/lib/core/widgets/locked_feature_button.dart` — lock
- Modify: `qulov2/lib/core/widgets/power_icon.dart` — lock
- Modify: `qulov2/lib/core/widgets/question_gate_banner.dart` — lock
- Modify: `qulov2/lib/features/passport/widgets/passport_premium_gate.dart` — lock

**Pattern (toggle yok, single variant):**
```dart
// ÖNCE
QIcon(QIcons.icLock, color: appColors.primary)
QIcon(QIcons.icBellFilled, color: ...)

// SONRA
AppIcon(QIcons.lock, color: appColors.primary)
AppIcon(QIcons.bell, filled: true, color: ...)
```

- [ ] **Step 1: Tüm 5 dosyada callsite'ları listele**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
grep -n "QIcons\.\(icLock\|icBellFilled\)" \
  lib/core/widgets/in_app_banner.dart \
  lib/core/widgets/locked_feature_button.dart \
  lib/core/widgets/power_icon.dart \
  lib/core/widgets/question_gate_banner.dart \
  lib/features/passport/widgets/passport_premium_gate.dart
```
Expected: 5-6 satır listelenir.

- [ ] **Step 2: Her dosyaya `AppIcon` import ekle**

5 dosyanın import bloğuna ekle:
```dart
import 'package:qulov2/core/widgets/app_icon.dart';
```

- [ ] **Step 3: `in_app_banner.dart` — bell filled migration**

`QIcons.icBellFilled` → `AppIcon(QIcons.bell, filled: true, ...)`. Tek callsite.

- [ ] **Step 4: Diğer 4 dosyada `icLock` callsite'larını migrate et**

Her satırda: `QIcon(QIcons.icLock, ...)` → `AppIcon(QIcons.lock, ...)`. Argüman isimleri (`color`, `size`) aynı.

- [ ] **Step 5: Her dosyada QIcon kalmadıysa import'unu sil**

```bash
for f in lib/core/widgets/in_app_banner.dart lib/core/widgets/locked_feature_button.dart lib/core/widgets/power_icon.dart lib/core/widgets/question_gate_banner.dart lib/features/passport/widgets/passport_premium_gate.dart; do
  count=$(grep -c "QIcon(" "$f")
  echo "$count $f"
done
```
Count = 0 olan dosyalardan `import '.../q_icon.dart';` satırını sil.

- [ ] **Step 6: flutter analyze**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
flutter analyze lib/core/widgets/ lib/features/passport/
```
Expected: 0 hata.

- [ ] **Step 7: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add qulov2/lib/core/widgets/in_app_banner.dart qulov2/lib/core/widgets/locked_feature_button.dart qulov2/lib/core/widgets/power_icon.dart qulov2/lib/core/widgets/question_gate_banner.dart qulov2/lib/features/passport/widgets/passport_premium_gate.dart
git commit -m "$(cat <<'EOF'
refactor(core/passport): core widgets + passport gate AppIcon'a geçti

in_app_banner.bell, locked_feature_button.lock, power_icon.lock,
question_gate_banner.lock, passport_premium_gate.lock.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 8: Migration — Discover feature

**Files:**
- Modify: `qulov2/lib/features/discover/widgets/discover_question_gate.dart` — lock + wand
- Modify: `qulov2/lib/features/discover/widgets/profile_card.dart` — mapPin + bolt + userRounded

**Pattern:**
```dart
// ÖNCE: QIcon(QIcons.icLock, ...) / QIcon(QIcons.icWand, ...)
// SONRA: AppIcon(QIcons.lock, ...) / AppIcon(QIcons.wand, ...)
// ÖNCE: QIcon(QIcons.icMapPin, ...) / QIcon(QIcons.icZap, ...) / QIcon(QIcons.icUser, ...)
// SONRA: AppIcon(QIcons.mapPin, ...) / AppIcon(QIcons.bolt, ...) / AppIcon(QIcons.userRounded, ...)
```

- [ ] **Step 1: Callsite'ları listele**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
grep -n "QIcons\.\(icLock\|icWand\|icMapPin\|icZap\|icUser\)" \
  lib/features/discover/widgets/discover_question_gate.dart \
  lib/features/discover/widgets/profile_card.dart
```
Expected: 5 satır.

- [ ] **Step 2: AppIcon import ekle her iki dosyaya**

```dart
import 'package:qulov2/core/widgets/app_icon.dart';
```

- [ ] **Step 3: `discover_question_gate.dart` migration**
- `icLock` → `AppIcon(QIcons.lock, ...)`
- `icWand` → `AppIcon(QIcons.wand, ...)`

- [ ] **Step 4: `profile_card.dart` migration**
- `icMapPin` → `AppIcon(QIcons.mapPin, ...)`
- `icZap` → `AppIcon(QIcons.bolt, ...)`
- `icUser` (avatar fallback) → `AppIcon(QIcons.userRounded, ...)`

- [ ] **Step 5: QIcon import temizlik**

```bash
for f in lib/features/discover/widgets/discover_question_gate.dart lib/features/discover/widgets/profile_card.dart; do
  count=$(grep -c "QIcon(" "$f")
  echo "$count $f"
done
```
Count = 0 ise QIcon import'unu sil.

- [ ] **Step 6: flutter analyze**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
flutter analyze lib/features/discover/
```
Expected: 0 hata.

- [ ] **Step 7: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add qulov2/lib/features/discover/widgets/discover_question_gate.dart qulov2/lib/features/discover/widgets/profile_card.dart
git commit -m "$(cat <<'EOF'
refactor(discover): question_gate + profile_card AppIcon'a geçti

discover_question_gate.lock+wand, profile_card.mapPin+bolt+userRounded.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 9: Migration — Profile feature

**Files:**
- Modify: `qulov2/lib/features/profile/widgets/notification_bell_button.dart` — bell toggle
- Modify: `qulov2/lib/features/profile/widgets/edit_profile_basic_info_section.dart` — mapPin
- Modify: `qulov2/lib/features/profile/widgets/profile_identity_card.dart` — mapPin
- Modify: `qulov2/lib/features/profile/widgets/profile_preferences_section.dart` — mapPin + heart + globe
- Modify: `qulov2/lib/features/profile/widgets/profile_menu_list.dart` — crown + helpCircle
- Modify: `qulov2/lib/features/profile/widgets/photo_grid.dart` — userRounded
- Modify: `qulov2/lib/features/profile/widgets/questions_empty_state.dart` — wand
- Modify: `qulov2/lib/features/profile/widgets/questions_fab.dart` — lock

**Pattern (notification_bell_button özel — toggle):**
```dart
// notification_bell_button.dart
// ÖNCE
QIcon(QIcons.icBell, ...)  // veya benzeri tek varyant
// SONRA — widget'ta hasUnread state'i mevcut, ona göre filled:
AppIcon(QIcons.bell, filled: hasUnread, ...)
```

Diğer 7 dosyada: `QIcon(QIcons.icX, ...)` → `AppIcon(QIcons.x, ...)` direkt.

- [ ] **Step 1: Tüm callsite'ları listele**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
grep -n "QIcons\.\(icBell\|icMapPin\|icHeart\|icGlobe\|icCrown\|icHelpCircle\|icUser\|icWand\|icLock\)" \
  lib/features/profile/widgets/notification_bell_button.dart \
  lib/features/profile/widgets/edit_profile_basic_info_section.dart \
  lib/features/profile/widgets/profile_identity_card.dart \
  lib/features/profile/widgets/profile_preferences_section.dart \
  lib/features/profile/widgets/profile_menu_list.dart \
  lib/features/profile/widgets/photo_grid.dart \
  lib/features/profile/widgets/questions_empty_state.dart \
  lib/features/profile/widgets/questions_fab.dart
```
Expected: ~12 satır.

- [ ] **Step 2: 8 dosyaya `AppIcon` import ekle**

Her dosyaya:
```dart
import 'package:qulov2/core/widgets/app_icon.dart';
```

- [ ] **Step 3: `notification_bell_button.dart` — bell toggle**

Widget'ta unread durumunu temsil eden bir bool state olmalı (provider veya parametre). Onu `filled:` argümanına bağla:

```dart
// ÖNCE
QIcon(QIcons.icBell, ...)

// SONRA (örnek — gerçek state ismi widget'a göre değişir)
AppIcon(QIcons.bell, filled: hasUnread, ...)
```

Eğer widget'ta unread state'i hâlâ yoksa (ör. sadece icon gösteriyorsa) parametre olarak ekle:
```dart
final bool hasUnread;
// constructor: required this.hasUnread,
```

> Bu adımı atlamadan önce widget'ın çağrıldığı yerleri (`profile_screen.dart` muhtemelen) `grep -rn "NotificationBellButton(" lib/` ile bul ve `hasUnread:` parametresini callsite'ta sağla. Provider'dan unread count okunuyorsa `ref.watch(unreadCountProvider) > 0` mantığı.

- [ ] **Step 4: Diğer 7 dosyada direkt migration**

Step 1'deki listede her callsite için pattern uygula:
- `icMapPin` → `AppIcon(QIcons.mapPin, ...)`
- `icHeart` → `AppIcon(QIcons.heart, ...)`
- `icGlobe` → `AppIcon(QIcons.globe, ...)`
- `icCrown` → `AppIcon(QIcons.crown, ...)`
- `icHelpCircle` → `AppIcon(QIcons.helpCircle, ...)`
- `icUser` → `AppIcon(QIcons.userRounded, ...)`
- `icWand` → `AppIcon(QIcons.wand, ...)`
- `icLock` → `AppIcon(QIcons.lock, ...)`

- [ ] **Step 5: QIcon import temizlik**

```bash
for f in lib/features/profile/widgets/notification_bell_button.dart lib/features/profile/widgets/edit_profile_basic_info_section.dart lib/features/profile/widgets/profile_identity_card.dart lib/features/profile/widgets/profile_preferences_section.dart lib/features/profile/widgets/profile_menu_list.dart lib/features/profile/widgets/photo_grid.dart lib/features/profile/widgets/questions_empty_state.dart lib/features/profile/widgets/questions_fab.dart; do
  count=$(grep -c "QIcon(" "$f")
  echo "$count $f"
done
```
Count = 0 ise QIcon import'unu sil.

- [ ] **Step 6: flutter analyze (profile feature)**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
flutter analyze lib/features/profile/
```
Expected: 0 hata. (Tüm proje analyze etmiyoruz — eski string constant'lar başka feature'larda hâlâ kullanılıyor olabilir.)

- [ ] **Step 7: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add qulov2/lib/features/profile/widgets/
git commit -m "$(cat <<'EOF'
refactor(profile): 8 profile widget'ı AppIcon'a geçti

notification_bell_button (filled toggle), edit_profile_basic_info,
profile_identity_card, profile_preferences_section, profile_menu_list,
photo_grid, questions_empty_state, questions_fab.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 10: Migration — Profile_detail feature

**Files:**
- Modify: `qulov2/lib/features/profile_detail/widgets/profile_basic_info.dart` — mapPin + bolt

- [ ] **Step 1: Callsite'ları listele**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
grep -n "QIcons\.\(icMapPin\|icZap\)" lib/features/profile_detail/widgets/profile_basic_info.dart
```
Expected: 2 satır.

- [ ] **Step 2: AppIcon import ekle**

```dart
import 'package:qulov2/core/widgets/app_icon.dart';
```

- [ ] **Step 3: Migration**
- `icMapPin` → `AppIcon(QIcons.mapPin, ...)`
- `icZap` → `AppIcon(QIcons.bolt, ...)`

- [ ] **Step 4: QIcon import temizlik**

```bash
count=$(grep -c "QIcon(" lib/features/profile_detail/widgets/profile_basic_info.dart)
echo "$count"
```
Count = 0 ise QIcon import'unu sil.

- [ ] **Step 5: flutter analyze**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
flutter analyze lib/features/profile_detail/
```
Expected: 0 hata.

- [ ] **Step 6: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add qulov2/lib/features/profile_detail/widgets/profile_basic_info.dart
git commit -m "$(cat <<'EOF'
refactor(profile_detail): profile_basic_info AppIcon'a geçti (mapPin+bolt)

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 11: Migration — Diamonds feature

**Files:**
- Modify: `qulov2/lib/features/diamonds/screens/diamonds_screen.dart` — bolt
- Modify: `qulov2/lib/features/diamonds/screens/subscription_comparison_screen.dart` — globe + helpCircle
- Modify: `qulov2/lib/features/diamonds/widgets/monthly_benefits_card.dart` — globe + helpCircle
- Modify: `qulov2/lib/features/diamonds/widgets/subscription_banner.dart` — crown

> **Not:** Bu task DiamondIcon'a, mor/yeşil elmas SVG'lerine, `icGem` constant'ına DOKUNMAZ. Sadece AppIcon'a migrate edilen 4 ikon (bolt, globe, helpCircle, crown).

- [ ] **Step 1: Callsite'ları listele**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
grep -n "QIcons\.\(icZap\|icGlobe\|icHelpCircle\|icCrown\)" \
  lib/features/diamonds/screens/diamonds_screen.dart \
  lib/features/diamonds/screens/subscription_comparison_screen.dart \
  lib/features/diamonds/widgets/monthly_benefits_card.dart \
  lib/features/diamonds/widgets/subscription_banner.dart
```
Expected: ~6 satır.

- [ ] **Step 2: 4 dosyaya AppIcon import ekle**

- [ ] **Step 3: Migration**
- `icZap` → `AppIcon(QIcons.bolt, ...)`
- `icGlobe` → `AppIcon(QIcons.globe, ...)`
- `icHelpCircle` → `AppIcon(QIcons.helpCircle, ...)`
- `icCrown` → `AppIcon(QIcons.crown, ...)`

- [ ] **Step 4: QIcon import temizlik (DiamondIcon import'una dokunma!)**

```bash
for f in lib/features/diamonds/screens/diamonds_screen.dart lib/features/diamonds/screens/subscription_comparison_screen.dart lib/features/diamonds/widgets/monthly_benefits_card.dart lib/features/diamonds/widgets/subscription_banner.dart; do
  count=$(grep -c "QIcon(" "$f")
  echo "$count $f"
done
```
Count = 0 olan dosyada `import '.../q_icon.dart';` satırını sil. `diamond_icon.dart` import'larına DOKUNMA.

- [ ] **Step 5: flutter analyze**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
flutter analyze lib/features/diamonds/
```
Expected: 0 hata.

- [ ] **Step 6: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add qulov2/lib/features/diamonds/
git commit -m "$(cat <<'EOF'
refactor(diamonds): subscription ekranları + diamonds_screen AppIcon'a geçti

diamonds_screen.bolt, subscription_comparison.globe+helpCircle,
monthly_benefits_card.globe+helpCircle, subscription_banner.crown.
DiamondIcon ve yeşil/mor elmas görselleri dokunulmadı.

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 12: Migration — Questions + Quiz feature

**Files:**
- Modify: `qulov2/lib/features/questions/widgets/best_question_highlight.dart` — crown
- Modify: `qulov2/lib/features/questions/widgets/easy_mode_category_section.dart` — wand
- Modify: `qulov2/lib/features/questions/widgets/easy_mode_suggestions_content.dart` — wand
- Modify: `qulov2/lib/features/questions/widgets/question_step_question.dart` — wand
- Modify: `qulov2/lib/features/quiz/widgets/quiz_result_dialog.dart` — crown + heart + bolt

- [ ] **Step 1: Callsite'ları listele**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
grep -n "QIcons\.\(icCrown\|icWand\|icHeart\|icZap\)" \
  lib/features/questions/widgets/best_question_highlight.dart \
  lib/features/questions/widgets/easy_mode_category_section.dart \
  lib/features/questions/widgets/easy_mode_suggestions_content.dart \
  lib/features/questions/widgets/question_step_question.dart \
  lib/features/quiz/widgets/quiz_result_dialog.dart
```
Expected: ~7 satır.

- [ ] **Step 2: 5 dosyaya AppIcon import ekle**

- [ ] **Step 3: Migration**
- `icCrown` → `AppIcon(QIcons.crown, ...)`
- `icWand` → `AppIcon(QIcons.wand, ...)`
- `icHeart` → `AppIcon(QIcons.heart, ...)`
- `icZap` → `AppIcon(QIcons.bolt, ...)`

- [ ] **Step 4: QIcon import temizlik**

```bash
for f in lib/features/questions/widgets/best_question_highlight.dart lib/features/questions/widgets/easy_mode_category_section.dart lib/features/questions/widgets/easy_mode_suggestions_content.dart lib/features/questions/widgets/question_step_question.dart lib/features/quiz/widgets/quiz_result_dialog.dart; do
  count=$(grep -c "QIcon(" "$f")
  echo "$count $f"
done
```
Count = 0 ise QIcon import sil.

- [ ] **Step 5: flutter analyze**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
flutter analyze lib/features/questions/ lib/features/quiz/
```
Expected: 0 hata.

- [ ] **Step 6: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add qulov2/lib/features/questions/widgets/ qulov2/lib/features/quiz/widgets/quiz_result_dialog.dart
git commit -m "$(cat <<'EOF'
refactor(questions/quiz): 5 widget AppIcon'a geçti

best_question_highlight.crown, easy_mode_category_section.wand,
easy_mode_suggestions_content.wand, question_step_question.wand,
quiz_result_dialog (crown+heart+bolt).

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 13: QIcons cleanup — 17 migrating + 20 dead code constants sil

> Bu task'tan önce Task 6-12'deki tüm callsite migration'ları tamamlanmış olmalı. Aksi halde compile error alırsın.

**Files:**
- Modify: `qulov2/lib/core/constants/q_icons.dart` — 17 migrating + ≤20 dead code string constant sil
- Delete: ≤20 dead code SVG dosyası

- [ ] **Step 1: Migrating 17 string constant'ın 0 kullanımda olduğunu doğrula**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
for c in icHeart icHeartFilled icBell icBellFilled icLock icPhotoCamera icMapPin icGlobe icGift icCrown icEye icWand icChats icZap icHelpCircle icUser icUserFilled; do
  count=$(grep -rn "QIcons\.$c\b" lib --include="*.dart" 2>/dev/null | wc -l | tr -d ' ')
  echo "$count $c"
done
```
Expected: Her satır `0 <name>`. Eğer bir constant >0 dönerse ilgili Task 6-12'ye dön, kalan callsite'ı migrate et.

- [ ] **Step 2: 20 dead code aday constant'ın kullanım sayımı**

```bash
for c in icAgeRange icArrowLeft icBadgeGold icBadgeSilver icBadgeBronze icCheckCircle icCompassFilled icCompassOff icFire icGem icGenderPref icImagePlus icLocation icMinusCircle icPlane icPlusCircle icSettings icUserOutline icEyeOff icBellOff; do
  count=$(grep -rn "QIcons\.$c\b" lib --include="*.dart" 2>/dev/null | wc -l | tr -d ' ')
  echo "$count $c"
done
```
Beklenen: çoğu 0. **NOT:** `icGem` DiamondIcon ile ilişkili olabilir — eğer >0 ise SİLME, listeyi güncelle ve atla. Sadece 0 olanları sil.

- [ ] **Step 3: 0 kullanımı doğrulanmış constant'ları `q_icons.dart`'tan sil**

Her constant satırını dosyadan sil. Step 1 + Step 2'deki 0-kullanım listesi.

```dart
// SİL
static const String icHeart = 'assets/icons/ic_heart.svg';
static const String icHeartFilled = 'assets/icons/ic_heart_filled.svg';
// ... vb. 0 kullanımı olan her satır
```

- [ ] **Step 4: Karşılık gelen SVG dosyalarını sil**

Step 1'in 17 migrating ikonu için ilgili SVG path'leri Task 1'de overwrite/rename edildi, ek silme YOK.

Step 2'deki 0-kullanım dead code ikonları için SVG'leri sil:

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2/assets/icons
# Sadece Step 2'de 0 dönen ikonların SVG'lerini sil. Örnek:
# rm ic_age_range.svg ic_arrow_left.svg ic_badge_gold.svg ic_badge_silver.svg ic_badge_bronze.svg \
#    ic_check_circle.svg ic_compass_filled.svg ic_compass_off.svg ic_fire.svg ic_gem.svg \
#    ic_gender_pref.svg ic_image_plus.svg ic_location.svg ic_minus_circle.svg ic_plane.svg \
#    ic_plus_circle.svg ic_settings.svg ic_user_outline.svg ic_eye_off.svg ic_bell_off.svg
```

> **DİKKAT:** Step 2'de >0 dönen bir constant varsa onun SVG'sini SİLME. `icGem` özel — DiamondIcon kullanıyor olabilir.

- [ ] **Step 5: flutter analyze (tüm proje)**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
flutter analyze
```
Expected: 0 hata. Eğer "undefined name 'icX'" hatası varsa, ilgili callsite migrate edilmemiş — Task 6-12'ye dön.

- [ ] **Step 6: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git add qulov2/lib/core/constants/q_icons.dart qulov2/assets/icons/
git commit -m "$(cat <<'EOF'
chore(icons): QIcons cleanup — 17 migrating + dead code constants

Tüm callsite'lar AppIcon'a geçti, eski string constant'lar siliniyor.
Dead code SVG'leri de silindi (0 kullanım doğrulandı; icGem dahil edilmedi).

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
```

---

## Task 14: Final — analyze, smoke test, flutter-review, push

- [ ] **Step 1: Tüm proje flutter analyze**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
flutter analyze
```
Expected: 0 hata, 0 uyarı. Herhangi bir hata varsa root cause'u bul ve düzelt.

- [ ] **Step 2: Manuel smoke test (8 ekran) — `flutter run` ile**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
flutter run
```

Her aşağıdaki ekranı aç, ikonun render olduğunu ve Solar bold-duotone/linear stilinde göründüğünü doğrula:

| # | Ekran | Beklenen |
|---|---|---|
| 1 | Bottom nav → Discover tab tıkla | `heart` outlined → seçili olunca filled |
| 2 | Bottom nav → Profile tab tıkla | `userRounded` outlined → seçili olunca filled |
| 3 | Profile header çan | `bell` (unread varsa filled, yoksa outlined) |
| 4 | Free user → Discover → question gate | `lock` + `wand` görünür |
| 5 | Discover → profile card | `mapPin` (uzaklık), `bolt` (boost), `userRounded` (avatar fallback) |
| 6 | Profile menu → Subscribe → Comparison | `crown` + `globe` + `helpCircle` |
| 7 | Passport premium gate | `lock` |
| 8 | Quiz sonuç dialog | `crown` + `heart` + `bolt` |

Beklenmedik render hatası, eksik ikon veya yanlış stil varsa not al, ilgili Task'a dön.

- [ ] **Step 3: `/flutter-review` skill çalıştır (CLAUDE.md kuralı)**

Skill'i çağır:
```
/flutter-review
```

Review çıktısına göre BLOCKER seviye uyarı varsa düzelt + yeni commit ekle.

- [ ] **Step 4: Branch'i push et**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo
git push origin APP-1915
```

> Eğer remote-tracking branch yoksa: `git push -u origin APP-1915`.

- [ ] **Step 5: Final commit (varsa rötuş)**

Eğer flutter-review veya smoke test sonucu küçük düzeltmeler yaptıysan:

```bash
git add <değişen-dosyalar>
git commit -m "$(cat <<'EOF'
fix(icons): smoke test + flutter-review rötuşları

<kısa açıklama>

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
EOF
)"
git push origin APP-1915
```

---

## Doğrulama özeti

Plan sonu durumu:
- `qulov2/lib/core/icons/icon_ref.dart` mevcut, IconRef class export ediyor.
- `qulov2/lib/core/widgets/app_icon.dart` mevcut, AppIcon widget export ediyor.
- `qulov2/lib/core/constants/q_icons.dart` 14 IconRef + 44 surviving string constant içeriyor; 17 migrating + dead code constant'lar silindi.
- `qulov2/assets/icons/` 28 Solar SVG + 44 mevcut SVG içeriyor (5 alignment + ≤20 dead code silindi).
- 24 dosyada toplam 39 callsite AppIcon'a geçti.
- `flutter analyze` → 0 hata.
- 8 ekran manuel smoke geçti.
- `/flutter-review` BLOCKER yok.
- APP-1915 branch'i push edildi.

## Out of scope (bu PR'da olmayan)

- DiamondIcon ve `icGem` / mor-yeşil elmas görselleri
- Quiz power ikonları (icSkipForward, icLightbulb, icOracle, icSplit, icClock, icFastForward)
- Domain-spesifik ikonlar (icHobby, icZodiac, icSmoke vb.)
- Navigation atom'ları (icChevronRight, icX, icSend, icPlus, icPencil, icTrash, icLogOut)
- Gender ikonları (icMale, icFemale, icTransgender)
- Golden test infrastructure
- Light theme renk override (mevcut tema sistemi otomatik handle ediyor)
