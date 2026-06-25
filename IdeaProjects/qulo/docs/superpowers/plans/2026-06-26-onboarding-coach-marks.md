# Onboarding Coach-Marks Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** qulov2'ye, belirli UI elemanlarının üstüne ışık tutan yeniden kullanılabilir bir anchored coach-mark motoru ekleyip discover/quiz/chat ekranlarında bağlam-içi onboarding turları göstermek.

**Architecture:** `lib/core/coach_mark/` altında feature-bağımsız bir overlay motoru (registry + anchor wrapper + step model + controller + painter + overlay widget) ve `core/services/coach_mark_service.dart` singleton kapısı. Hedef widget'lar `CoachMarkAnchor(anchorId: ...)` ile kendilerini bir registry'ye kaydeder; turlar anchorId üzerinden rect çözer. Persistence lokal SharedPreferences, içerik statik l10n (16 dil).

**Tech Stack:** Flutter, Riverpod, SharedPreferences, mevcut `context.tr` l10n, `Overlay`/`OverlayEntry`, `CustomPainter`.

## Global Constraints

- 16 dil zorunlu: `ar, de, en, es, fr, hi, it, ja, ko, nl, pl, pt, ru, sv, tr, zh` — `lib/core/l10n/translations/<lang>.dart` (her biri `const <lang>Translations = <String, String>{...}`). Hardcode string YASAK; erişim yalnızca `context.tr('key')`.
- L10n key formatı: düz snake_case (mevcut konvansiyon, örn. `onboarding_title_1`). Yeni key'ler `coach_` prefix'i.
- Dialog/sheet/overlay yalnızca merkezî servisler üzerinden; feature'dan donanım/overlay paketi doğrudan import YASAK (Hardware Manager pattern). Coach-mark motoruna erişim yalnızca `CoachMarkService` üstünden.
- Screen dosyaları thin orchestration (~200 satır sınırı); tur içerikleri ayrı `features/<feature>/coach/*.dart` dosyalarında.
- `_PrivateWidget` sınıfları başka dosyadan erişilecekse `_` olmadan kendi dosyasında.
- SharedPreferences erişimi: ayrı provider yok, doğrudan `SharedPreferences.getInstance()` (lazy singleton) — mevcut `onboarding_screen_mixin.dart` pattern'i.
- AppButton imzası: `AppButton({required String label, VoidCallback? onPressed, AppButtonVariant variant, bool isLoading, bool fullWidth, IconData? icon, Widget? leadingWidget})`.
- AppSpacing sabitleri: `xs=4, sm=8, md=12, lg=16, xl=24, xxl=32`; radius `radiusMd=12, radiusLg=16`; `maxContentWidth=560`.
- Persistence flag adları: `coach_discover_seen`, `coach_quiz_powers_seen`, `coach_chat_question_seen` (servis `coach_${tourId}_seen` üretir).
- Feature tamamlandıktan sonra `/flutter-review` ve `/i18n-guardian` çalıştırılır.
- **Dart paket adı `qulo_v2`** (dizin adı `qulov2`): tüm Dart import'ları `package:qulo_v2/...`. Test komutu `fvm flutter test`. Statik analiz `dart analyze` (bu FVM'de `flutter analyze` CRASH ediyor). Tüm komutlar `qulov2/` dizininden çalışır.

---

### Task 1: Core — Registry + Anchor + Step Model

**Files:**
- Create: `qulov2/lib/core/coach_mark/coach_mark_registry.dart`
- Create: `qulov2/lib/core/coach_mark/coach_mark_anchor.dart`
- Create: `qulov2/lib/core/coach_mark/coach_mark_step.dart`
- Test: `qulov2/test/core/coach_mark/coach_mark_registry_test.dart`

**Interfaces:**
- Produces:
  - `CoachMarkRegistry.keyFor(String anchorId) -> GlobalKey` (stable, putIfAbsent)
  - `CoachMarkRegistry.maybeKey(String anchorId) -> GlobalKey?`
  - `CoachMarkAnchor({required String anchorId, required Widget child})` — `child`'ı `keyFor(anchorId)` ile sarar
  - `CoachMarkShape { rect, circle }` (enum)
  - `CoachMarkStep({String? anchorId, required String titleKey, required String bodyKey, required String ctaKey, CoachMarkShape shape = CoachMarkShape.rect, WidgetBuilder? bodyBuilder, VoidCallback? onShow, VoidCallback? onDismiss})`

- [ ] **Step 1: Write the failing test**

```dart
// qulov2/test/core/coach_mark/coach_mark_registry_test.dart
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qulo_v2/core/coach_mark/coach_mark_registry.dart';

void main() {
  test('keyFor returns the same GlobalKey for the same id', () {
    final a = CoachMarkRegistry.keyFor('discover_solve');
    final b = CoachMarkRegistry.keyFor('discover_solve');
    expect(identical(a, b), isTrue);
  });

  test('keyFor returns different keys for different ids', () {
    final a = CoachMarkRegistry.keyFor('x1');
    final b = CoachMarkRegistry.keyFor('x2');
    expect(identical(a, b), isFalse);
  });

  test('maybeKey returns null for unknown id', () {
    expect(CoachMarkRegistry.maybeKey('never_registered'), isNull);
  });

  test('maybeKey returns the key after keyFor', () {
    final k = CoachMarkRegistry.keyFor('y1');
    expect(CoachMarkRegistry.maybeKey('y1'), same(k));
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd qulov2 && fvm flutter test test/core/coach_mark/coach_mark_registry_test.dart`
Expected: FAIL — `coach_mark_registry.dart` yok / `CoachMarkRegistry` tanımsız.

- [ ] **Step 3: Implement registry**

```dart
// qulov2/lib/core/coach_mark/coach_mark_registry.dart
import 'package:flutter/widgets.dart';

/// Maps a stable anchorId to a GlobalKey so coach-mark tours can resolve a
/// target widget's screen rect without prop-threading keys through the tree.
abstract final class CoachMarkRegistry {
  static final Map<String, GlobalKey> _keys = {};

  static GlobalKey keyFor(String anchorId) =>
      _keys.putIfAbsent(anchorId, () => GlobalKey());

  static GlobalKey? maybeKey(String anchorId) => _keys[anchorId];
}
```

- [ ] **Step 4: Implement anchor wrapper**

```dart
// qulov2/lib/core/coach_mark/coach_mark_anchor.dart
import 'package:flutter/widgets.dart';
import 'coach_mark_registry.dart';

/// Wrap any widget that a coach-mark step targets. Registers a stable
/// GlobalKey under [anchorId] so the overlay can read its global rect.
class CoachMarkAnchor extends StatelessWidget {
  const CoachMarkAnchor({super.key, required this.anchorId, required this.child});

  final String anchorId;
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      KeyedSubtree(key: CoachMarkRegistry.keyFor(anchorId), child: child);
}
```

- [ ] **Step 5: Implement step model**

```dart
// qulov2/lib/core/coach_mark/coach_mark_step.dart
import 'package:flutter/widgets.dart';

enum CoachMarkShape { rect, circle }

/// One step in a coach-mark tour. [anchorId] null => centered modal card.
class CoachMarkStep {
  const CoachMarkStep({
    this.anchorId,
    required this.titleKey,
    required this.bodyKey,
    required this.ctaKey,
    this.shape = CoachMarkShape.rect,
    this.bodyBuilder,
    this.onShow,
    this.onDismiss,
  });

  final String? anchorId;
  final String titleKey;
  final String bodyKey;
  final String ctaKey;
  final CoachMarkShape shape;

  /// Optional custom body (e.g. power icons). Overrides [bodyKey] text.
  final WidgetBuilder? bodyBuilder;

  final VoidCallback? onShow;
  final VoidCallback? onDismiss;
}
```

- [ ] **Step 6: Run test to verify it passes**

Run: `cd qulov2 && fvm flutter test test/core/coach_mark/coach_mark_registry_test.dart`
Expected: PASS (4 tests).

- [ ] **Step 7: Analyze + commit**

```bash
cd qulov2 && dart analyze lib/core/coach_mark/
git add qulov2/lib/core/coach_mark/ qulov2/test/core/coach_mark/coach_mark_registry_test.dart
git commit -m "feat(coach-mark): registry, anchor wrapper, step model"
```

---

### Task 2: Core — Controller (queue + lifecycle callbacks)

**Files:**
- Create: `qulov2/lib/core/coach_mark/coach_mark_controller.dart`
- Test: `qulov2/test/core/coach_mark/coach_mark_controller_test.dart`

**Interfaces:**
- Consumes: `CoachMarkStep` (Task 1)
- Produces: `CoachMarkController extends ChangeNotifier`
  - ctor `CoachMarkController({required List<CoachMarkStep> steps})`
  - `VoidCallback? onFinished` (settable)
  - getters: `int index`, `CoachMarkStep current`, `bool isLast`, `bool finished`, `int stepCount`
  - `void start()` — idempotent; fires `steps[0].onShow`
  - `void next()` — fires `current.onDismiss`; advances or finishes (fires `current.onShow` on advance, `onFinished` on finish)
  - `void skipAll()` — fires `current.onDismiss` then finishes

- [ ] **Step 1: Write the failing test**

```dart
// qulov2/test/core/coach_mark/coach_mark_controller_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:qulo_v2/core/coach_mark/coach_mark_controller.dart';
import 'package:qulo_v2/core/coach_mark/coach_mark_step.dart';

void main() {
  List<String> log = [];
  CoachMarkStep step(String id) => CoachMarkStep(
        titleKey: 't_$id', bodyKey: 'b_$id', ctaKey: 'c_$id',
        onShow: () => log.add('show_$id'),
        onDismiss: () => log.add('dismiss_$id'),
      );

  setUp(() => log = []);

  test('start fires first onShow and sets index 0', () {
    final c = CoachMarkController(steps: [step('a'), step('b')]);
    c.start();
    expect(c.index, 0);
    expect(log, ['show_a']);
  });

  test('start is idempotent', () {
    final c = CoachMarkController(steps: [step('a')]);
    c.start();
    c.start();
    expect(log, ['show_a']);
  });

  test('next dismisses current and shows the next', () {
    final c = CoachMarkController(steps: [step('a'), step('b')]);
    c.start();
    c.next();
    expect(c.index, 1);
    expect(log, ['show_a', 'dismiss_a', 'show_b']);
  });

  test('next on last step finishes and fires onFinished', () {
    var finished = false;
    final c = CoachMarkController(steps: [step('a')])..onFinished = () => finished = true;
    c.start();
    c.next();
    expect(c.finished, isTrue);
    expect(finished, isTrue);
    expect(log, ['show_a', 'dismiss_a']);
  });

  test('skipAll dismisses current then finishes', () {
    var finished = false;
    final c = CoachMarkController(steps: [step('a'), step('b')])..onFinished = () => finished = true;
    c.start();
    c.skipAll();
    expect(c.finished, isTrue);
    expect(finished, isTrue);
    expect(log, ['show_a', 'dismiss_a']);
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd qulov2 && fvm flutter test test/core/coach_mark/coach_mark_controller_test.dart`
Expected: FAIL — `CoachMarkController` tanımsız.

- [ ] **Step 3: Implement controller**

```dart
// qulov2/lib/core/coach_mark/coach_mark_controller.dart
import 'package:flutter/foundation.dart';
import 'coach_mark_step.dart';

class CoachMarkController extends ChangeNotifier {
  CoachMarkController({required this.steps}) : assert(steps.length > 0);

  final List<CoachMarkStep> steps;

  int _index = 0;
  bool _started = false;
  bool _finished = false;

  VoidCallback? onFinished;

  int get index => _index;
  int get stepCount => steps.length;
  CoachMarkStep get current => steps[_index];
  bool get isLast => _index >= steps.length - 1;
  bool get finished => _finished;

  void start() {
    if (_started) return;
    _started = true;
    current.onShow?.call();
    notifyListeners();
  }

  void next() {
    if (_finished) return;
    current.onDismiss?.call();
    if (isLast) {
      _finish();
      return;
    }
    _index++;
    current.onShow?.call();
    notifyListeners();
  }

  void skipAll() {
    if (_finished) return;
    current.onDismiss?.call();
    _finish();
  }

  void _finish() {
    _finished = true;
    onFinished?.call();
    notifyListeners();
  }
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `cd qulov2 && fvm flutter test test/core/coach_mark/coach_mark_controller_test.dart`
Expected: PASS (5 tests).

- [ ] **Step 5: Commit**

```bash
cd qulov2 && dart analyze lib/core/coach_mark/coach_mark_controller.dart
git add qulov2/lib/core/coach_mark/coach_mark_controller.dart qulov2/test/core/coach_mark/coach_mark_controller_test.dart
git commit -m "feat(coach-mark): controller with queue + lifecycle callbacks"
```

---

### Task 3: Core — Painter + Overlay Widget

**Files:**
- Create: `qulov2/lib/core/coach_mark/coach_mark_painter.dart`
- Create: `qulov2/lib/core/coach_mark/coach_mark_overlay.dart`
- Test: `qulov2/test/core/coach_mark/coach_mark_overlay_test.dart`

**Interfaces:**
- Consumes: `CoachMarkController`, `CoachMarkStep`, `CoachMarkShape`, `CoachMarkRegistry` (Tasks 1–2), `context.tr` (l10n), `AppButton`, `AppSpacing`
- Produces:
  - `CoachMarkPainter({Rect? holeRect, double radius, required Color barrierColor, required CoachMarkShape shape})`
  - `CoachMarkOverlay({required CoachMarkController controller})` — full-screen; reads target rect from registry, paints barrier+cutout, shows title/body/CTA card; "İleri/Başla" → `controller.next()`, skip (✕) → `controller.skipAll()`.

- [ ] **Step 1: Write the failing widget test**

```dart
// qulov2/test/core/coach_mark/coach_mark_overlay_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qulo_v2/core/coach_mark/coach_mark_controller.dart';
import 'package:qulo_v2/core/coach_mark/coach_mark_overlay.dart';
import 'package:qulo_v2/core/coach_mark/coach_mark_step.dart';
import 'package:qulo_v2/core/l10n/app_localizations.dart';

Widget _wrap(Widget child) => MaterialApp(
      localizationsDelegates: const [AppLocalizationsDelegate()],
      supportedLocales: const [Locale('en')],
      locale: const Locale('en'),
      home: Scaffold(body: child),
    );

void main() {
  testWidgets('renders title and advances on CTA tap', (tester) async {
    final c = CoachMarkController(steps: const [
      CoachMarkStep(titleKey: 'coach_discover_intro_title', bodyKey: 'coach_discover_intro_body', ctaKey: 'coach_cta_next'),
      CoachMarkStep(titleKey: 'coach_discover_solve_title', bodyKey: 'coach_discover_solve_body', ctaKey: 'coach_cta_start'),
    ]);
    var finished = false;
    c.onFinished = () => finished = true;

    await tester.pumpWidget(_wrap(CoachMarkOverlay(controller: c)));
    await tester.pump();

    expect(c.index, 0);
    // Tap the CTA button (AppButton renders its label text).
    await tester.tap(find.text(AppLocalizations(const Locale('en')).get('coach_cta_next')));
    await tester.pump();
    expect(c.index, 1);
    expect(finished, isFalse);
  });
}
```

> Not: Test, Task 5'te eklenecek `coach_*` key'lerine bağlı. Bu task'ı Task 5'ten SONRA veya birlikte koşmak gerekir; sırasız çalışılıyorsa key'leri önce `en.dart`'a ekleyin (Task 5 Step 1).

- [ ] **Step 2: Run test to verify it fails**

Run: `cd qulov2 && fvm flutter test test/core/coach_mark/coach_mark_overlay_test.dart`
Expected: FAIL — `coach_mark_overlay.dart` yok.

- [ ] **Step 3: Implement painter**

```dart
// qulov2/lib/core/coach_mark/coach_mark_painter.dart
import 'package:flutter/widgets.dart';
import 'coach_mark_step.dart';

class CoachMarkPainter extends CustomPainter {
  CoachMarkPainter({
    required this.holeRect,
    required this.barrierColor,
    required this.shape,
    this.radius = 12,
    this.padding = 6,
  });

  final Rect? holeRect;
  final Color barrierColor;
  final CoachMarkShape shape;
  final double radius;
  final double padding;

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Path()..addRect(Offset.zero & size);
    final paint = Paint()..color = barrierColor;
    final rect = holeRect;
    if (rect == null) {
      canvas.drawPath(bg, paint);
      return;
    }
    final inflated = rect.inflate(padding);
    final hole = Path();
    if (shape == CoachMarkShape.circle) {
      hole.addOval(inflated);
    } else {
      hole.addRRect(RRect.fromRectAndRadius(inflated, Radius.circular(radius)));
    }
    canvas.drawPath(Path.combine(PathOperation.difference, bg, hole), paint);
  }

  @override
  bool shouldRepaint(CoachMarkPainter old) =>
      old.holeRect != holeRect || old.barrierColor != barrierColor || old.shape != shape;
}
```

- [ ] **Step 4: Implement overlay widget**

```dart
// qulov2/lib/core/coach_mark/coach_mark_overlay.dart
import 'package:flutter/material.dart';
import '../l10n/l10n.dart';
import '../theme/app_spacing.dart';
import '../widgets/app_button.dart';
import 'coach_mark_controller.dart';
import 'coach_mark_painter.dart';
import 'coach_mark_registry.dart';
import 'coach_mark_step.dart';

class CoachMarkOverlay extends StatefulWidget {
  const CoachMarkOverlay({super.key, required this.controller});

  final CoachMarkController controller;

  @override
  State<CoachMarkOverlay> createState() => _CoachMarkOverlayState();
}

class _CoachMarkOverlayState extends State<CoachMarkOverlay> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onChange);
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.controller.start());
  }

  void _onChange() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onChange);
    super.dispose();
  }

  Rect? _resolveRect(String? anchorId) {
    if (anchorId == null) return null;
    final ctx = CoachMarkRegistry.maybeKey(anchorId)?.currentContext;
    final box = ctx?.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return null;
    final offset = box.localToGlobal(Offset.zero);
    return offset & box.size;
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final step = controller.current;
    final screen = MediaQuery.of(context).size;
    final hole = _resolveRect(step.anchorId);
    const barrier = Color(0xCC000000);

    // Card on the opposite half from the target (or centered when no anchor).
    final targetBelowHalf = hole != null && hole.center.dy > screen.height / 2;
    final Alignment cardAlign = hole == null
        ? Alignment.center
        : (targetBelowHalf ? Alignment.topCenter : Alignment.bottomCenter);

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: CoachMarkPainter(holeRect: hole, barrierColor: barrier, shape: step.shape),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: controller.skipAll,
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: cardAlign,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
                child: Container(
                  margin: const EdgeInsets.all(AppSpacing.lg),
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.tr(step.titleKey),
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: AppSpacing.sm),
                      step.bodyBuilder != null
                          ? step.bodyBuilder!(context)
                          : Text(context.tr(step.bodyKey),
                              style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: AppSpacing.md),
                      _StepDots(count: controller.stepCount, index: controller.index),
                      const SizedBox(height: AppSpacing.md),
                      AppButton(label: context.tr(step.ctaKey), onPressed: controller.next),
                    ],
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

class _StepDots extends StatelessWidget {
  const _StepDots({required this.count, required this.index});
  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (count <= 1) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == index;
        return Container(
          width: active ? 10 : 6,
          height: active ? 10 : 6,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).disabledColor,
          ),
        );
      }),
    );
  }
}
```

- [ ] **Step 5: Run test to verify it passes**

Run: `cd qulov2 && fvm flutter test test/core/coach_mark/coach_mark_overlay_test.dart`
Expected: PASS (Task 5'teki `en.dart` key'leri mevcutsa).

- [ ] **Step 6: Commit**

```bash
cd qulov2 && dart analyze lib/core/coach_mark/
git add qulov2/lib/core/coach_mark/coach_mark_painter.dart qulov2/lib/core/coach_mark/coach_mark_overlay.dart qulov2/test/core/coach_mark/coach_mark_overlay_test.dart
git commit -m "feat(coach-mark): cutout painter + overlay card widget"
```

---

### Task 4: Core — CoachMarkService (singleton, persistence, single-tour guard)

**Files:**
- Create: `qulov2/lib/core/services/coach_mark_service.dart`
- Test: `qulov2/test/core/services/coach_mark_service_test.dart`

**Interfaces:**
- Consumes: `CoachMarkController`, `CoachMarkOverlay`, `CoachMarkStep`, SharedPreferences
- Produces: `CoachMarkService` (singleton via `CoachMarkService.instance`)
  - `Future<bool> isSeen(String tourId)`
  - `Future<void> markSeen(String tourId)`
  - `Future<void> maybeStartTour(BuildContext context, {required String tourId, required List<CoachMarkStep> steps})` — flag false ve aktif tur yoksa overlay basar; bitince markSeen + remove.
  - `bool get isTourActive`

- [ ] **Step 1: Write the failing test (persistence + guard, no BuildContext)**

```dart
// qulov2/test/core/services/coach_mark_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qulo_v2/core/services/coach_mark_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('isSeen is false by default, true after markSeen', () async {
    final s = CoachMarkService.instance;
    expect(await s.isSeen('discover'), isFalse);
    await s.markSeen('discover');
    expect(await s.isSeen('discover'), isTrue);
  });

  test('markSeen writes the coach_<tour>_seen flag', () async {
    await CoachMarkService.instance.markSeen('quiz_powers');
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('coach_quiz_powers_seen'), isTrue);
  });

  test('isTourActive is false when no overlay is shown', () {
    expect(CoachMarkService.instance.isTourActive, isFalse);
  });
}
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd qulov2 && fvm flutter test test/core/services/coach_mark_service_test.dart`
Expected: FAIL — `coach_mark_service.dart` yok.

- [ ] **Step 3: Implement service**

```dart
// qulov2/lib/core/services/coach_mark_service.dart
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../coach_mark/coach_mark_controller.dart';
import '../coach_mark/coach_mark_overlay.dart';
import '../coach_mark/coach_mark_step.dart';

/// Single entry point for anchored coach-mark tours. Feature code calls
/// [maybeStartTour]; the overlay/painter internals stay encapsulated here.
class CoachMarkService {
  CoachMarkService._();
  static final CoachMarkService instance = CoachMarkService._();

  OverlayEntry? _activeEntry;

  bool get isTourActive => _activeEntry != null;

  String _flag(String tourId) => 'coach_${tourId}_seen';

  Future<bool> isSeen(String tourId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_flag(tourId)) ?? false;
  }

  Future<void> markSeen(String tourId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_flag(tourId), true);
  }

  Future<void> maybeStartTour(
    BuildContext context, {
    required String tourId,
    required List<CoachMarkStep> steps,
  }) async {
    if (_activeEntry != null) return; // single-tour guard
    if (steps.isEmpty) return;
    if (await isSeen(tourId)) return;
    if (!context.mounted) return;

    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;

    final controller = CoachMarkController(steps: steps);
    controller.onFinished = () => _close(tourId);

    final entry = OverlayEntry(builder: (_) => CoachMarkOverlay(controller: controller));
    _activeEntry = entry;
    overlay.insert(entry);
  }

  void _close(String tourId) {
    _activeEntry?.remove();
    _activeEntry = null;
    // Fire-and-forget; flag write must not block UI removal.
    markSeen(tourId);
  }
}
```

- [ ] **Step 4: Run test to verify it passes**

Run: `cd qulov2 && fvm flutter test test/core/services/coach_mark_service_test.dart`
Expected: PASS (3 tests).

- [ ] **Step 5: Commit**

```bash
cd qulov2 && dart analyze lib/core/services/coach_mark_service.dart
git add qulov2/lib/core/services/coach_mark_service.dart qulov2/test/core/services/coach_mark_service_test.dart
git commit -m "feat(coach-mark): service singleton with persistence + single-tour guard"
```

---

### Task 5: i18n — coach_* keys (16 languages)

**Files:**
- Modify: `qulov2/lib/core/l10n/translations/en.dart` (ekleme)
- Modify: `qulov2/lib/core/l10n/translations/tr.dart` (ekleme)
- Modify (14 dosya): `ar, de, es, fr, hi, it, ja, ko, nl, pl, pt, ru, sv, zh` `.dart`

**Interfaces:**
- Produces (tüm 16 dilde aynı key seti):
  `coach_cta_next, coach_cta_start, coach_cta_got_it,`
  `coach_discover_intro_title, coach_discover_intro_body,`
  `coach_discover_solve_title, coach_discover_solve_body,`
  `coach_discover_match_title, coach_discover_match_body,`
  `coach_quiz_powers_title, coach_quiz_powers_body,`
  `coach_quiz_power_oracle, coach_quiz_power_half, coach_quiz_power_skip,`
  `coach_quiz_power_hint, coach_quiz_power_time_extend, coach_quiz_power_skip_all,`
  `coach_chat_question_title, coach_chat_question_body`

- [ ] **Step 1: Add EN keys (verbatim)**

`en.dart` içindeki `const enTranslations = <String, String>{` map'inin sonuna (kapanış `};` öncesi) ekle:

```dart
  // Coach-marks
  'coach_cta_next': 'Next',
  'coach_cta_start': 'Get started',
  'coach_cta_got_it': 'Got it',
  'coach_discover_intro_title': 'How Qulo works',
  'coach_discover_intro_body': 'No swiping. You match by solving the questions people set.',
  'coach_discover_solve_title': 'Solve to match',
  'coach_discover_solve_body': "Answer this person's questions. Get them all right and you match.",
  'coach_discover_match_title': 'Like or pass',
  'coach_discover_match_body': 'Tap solve to try matching, or pass to see the next person.',
  'coach_quiz_powers_title': 'Your powers',
  'coach_quiz_powers_body': 'Stuck on a question? Spend powers to get an edge.',
  'coach_quiz_power_oracle': 'Oracle: reveals a strong hint',
  'coach_quiz_power_half': 'Half: removes half the wrong options',
  'coach_quiz_power_skip': 'Skip: skip this question',
  'coach_quiz_power_hint': 'Hint: shows the question hint',
  'coach_quiz_power_time_extend': 'Time: adds extra seconds',
  'coach_quiz_power_skip_all': 'Skip all: skip every remaining question',
  'coach_chat_question_title': 'Send a question',
  'coach_chat_question_body': 'Tap here to prepare and send a new question to your match.',
```

- [ ] **Step 2: Add TR keys (verbatim)**

`tr.dart` map'inin sonuna ekle:

```dart
  // Coach-marks
  'coach_cta_next': 'İleri',
  'coach_cta_start': 'Başla',
  'coach_cta_got_it': 'Anladım',
  'coach_discover_intro_title': 'Qulo nasıl çalışır',
  'coach_discover_intro_body': 'Kaydırma yok. İnsanların hazırladığı soruları çözerek eşleşirsin.',
  'coach_discover_solve_title': 'Çöz ve eşleş',
  'coach_discover_solve_body': 'Bu kişinin sorularını yanıtla. Hepsi doğruysa eşleşirsin.',
  'coach_discover_match_title': 'Beğen ya da geç',
  'coach_discover_match_body': 'Eşleşmeyi denemek için çöz’e dokun, ya da sıradakine geç.',
  'coach_quiz_powers_title': 'Güçlerin',
  'coach_quiz_powers_body': 'Soruda takıldın mı? Avantaj için güç harca.',
  'coach_quiz_power_oracle': 'Kâhin: güçlü bir ipucu verir',
  'coach_quiz_power_half': 'Yarı: yanlış şıkların yarısını siler',
  'coach_quiz_power_skip': 'Atla: bu soruyu atlar',
  'coach_quiz_power_hint': 'İpucu: sorunun ipucunu gösterir',
  'coach_quiz_power_time_extend': 'Süre: ekstra saniye ekler',
  'coach_quiz_power_skip_all': 'Hepsini atla: kalan tüm soruları atlar',
  'coach_chat_question_title': 'Soru gönder',
  'coach_chat_question_body': 'Eşleşmene yeni bir soru hazırlayıp göndermek için buraya dokun.',
```

- [ ] **Step 3: Add the same keys to the other 14 files**

`ar, de, es, fr, hi, it, ja, ko, nl, pl, pt, ru, sv, zh` dosyalarına aynı 19 key'i ekle. Geçici olarak EN değerleriyle ekleyebilirsin; Step 5'te i18n-guardian doğru dile çevirecek.

- [ ] **Step 4: Verify keys resolve in EN**

Run: `cd qulov2 && fvm flutter test test/core/coach_mark/coach_mark_overlay_test.dart`
Expected: PASS (overlay testi artık EN key'leri çözüyor).

- [ ] **Step 5: Run i18n-guardian + commit**

Invoke skill: `/i18n-guardian` — eksik/EN-placeholder çevirileri 14 dile tamamla ve 16 dil tamlığını doğrula.

```bash
cd qulov2 && dart analyze lib/core/l10n/
git add qulov2/lib/core/l10n/translations/
git commit -m "i18n(coach-mark): add coach_* keys across 16 locales"
```

---

### Task 6: Discover Tour Integration (3-step)

**Files:**
- Create: `qulov2/lib/features/discover/coach/discover_coach_marks.dart`
- Modify: `qulov2/lib/features/discover/widgets/discover_card_view.dart` (DiscoverSolveButton + DiscoverActionButtons'ı `CoachMarkAnchor` ile sar)
- Modify: `qulov2/lib/features/discover/mixins/discover_screen_mixin.dart` (tetikleme)
- Modify: `qulov2/lib/features/discover/screens/discover_screen.dart` (mixin tetiklemesini çağır)

**Interfaces:**
- Consumes: `CoachMarkStep`, `CoachMarkService`, `CoachMarkAnchor`, `AppConstants.minQuestions`, `userProvider`
- Produces: `List<CoachMarkStep> buildDiscoverCoachSteps()` ; anchorId'ler: `discover_solve`, `discover_actions`

- [ ] **Step 1: Create the tour definition**

```dart
// qulov2/lib/features/discover/coach/discover_coach_marks.dart
import '../../../core/coach_mark/coach_mark_step.dart';

/// 3-step discover onboarding tour. Step 1 is a centered intro (no anchor);
/// steps 2–3 highlight the solve button and the action row.
List<CoachMarkStep> buildDiscoverCoachSteps() => const [
      CoachMarkStep(
        titleKey: 'coach_discover_intro_title',
        bodyKey: 'coach_discover_intro_body',
        ctaKey: 'coach_cta_next',
      ),
      CoachMarkStep(
        anchorId: 'discover_solve',
        titleKey: 'coach_discover_solve_title',
        bodyKey: 'coach_discover_solve_body',
        ctaKey: 'coach_cta_next',
      ),
      CoachMarkStep(
        anchorId: 'discover_actions',
        titleKey: 'coach_discover_match_title',
        bodyKey: 'coach_discover_match_body',
        ctaKey: 'coach_cta_start',
      ),
    ];
```

- [ ] **Step 2: Wrap the anchor widgets**

`discover_card_view.dart` içinde `DiscoverSolveButton`'ı saran `SafeTapButton`'ı `CoachMarkAnchor` ile, `DiscoverActionButtons`'ı da `CoachMarkAnchor` ile sar. Dosya başına import ekle:

```dart
import '../../../core/coach_mark/coach_mark_anchor.dart';
```

Solve butonu (mevcut `SafeTapButton(... DiscoverSolveButton ...)`):

```dart
CoachMarkAnchor(
  anchorId: 'discover_solve',
  child: SafeTapButton(
    onTap: _isProcessing ? null : _navigateToQuiz,
    builder: (context, isLoading, onTap) => DiscoverSolveButton(
      label: context.tr('solve_questions'),
      onTap: onTap,
      isLoading: isLoading || _isProcessing,
    ),
  ),
),
```

Action butonları (mevcut `DiscoverActionButtons(...)`):

```dart
CoachMarkAnchor(
  anchorId: 'discover_actions',
  child: DiscoverActionButtons(
    canUndo: canUndo,
    onUndo: _handleUndo,
    onReject: () => widget.onSwipeLeft(),
  ),
),
```

- [ ] **Step 3: Add the trigger to the mixin**

`discover_screen_mixin.dart` içine ekle (importlar: coach_mark_service, discover_coach_marks, app_constants, userProvider zaten erişilebilir):

```dart
import '../../../core/services/coach_mark_service.dart';
import '../coach/discover_coach_marks.dart';
// ... AppConstants ve userProvider import'larını dosyanın mevcut import'larına göre ekle.

bool _coachTried = false;

/// Cards görünür + kullanıcının min sorusu varsa (gate banner yoksa) turu başlat.
void maybeStartDiscoverCoach({required bool hasCards}) {
  if (_coachTried || !hasCards) return;
  final user = ref.read(userProvider).valueOrNull;
  final hasMinQuestions = (user?.questionCount ?? 0) >= AppConstants.minQuestions;
  if (!hasMinQuestions) return; // QuestionGateBanner ile çakışma koruması
  _coachTried = true;
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!mounted) return;
    CoachMarkService.instance.maybeStartTour(
      context,
      tourId: 'discover',
      steps: buildDiscoverCoachSteps(),
    );
  });
}
```

- [ ] **Step 4: Call the trigger from the screen**

`discover_screen.dart` içinde kartların render edildiği branch'te (cards mevcut, `DiscoverCardView` gösterilen yerde) build sırasında çağır:

```dart
// cards listesinin dolu olduğu branch içinde, return'den önce:
maybeStartDiscoverCoach(hasCards: true);
```

- [ ] **Step 5: Analyze + manual verification**

Run: `cd qulov2 && dart analyze lib/features/discover/`
Expected: No issues.

Manuel doğrulama (debug build, taze kullanıcı / `coach_discover_seen` silinmiş):
- En az 4 sorusu olan kullanıcıyla discover'a gir → 3 adımlı tur çıkar: ortada tanıtım → solve butonu vurgulu → aksiyon satırı vurgulu.
- Soru sayısı < 4 olan kullanıcıda tur ÇIKMAZ (gate banner görünür).
- Tur bitince tekrar discover'a girince TEKRAR çıkmaz (`coach_discover_seen=true`).

- [ ] **Step 6: Commit**

```bash
git add qulov2/lib/features/discover/
git commit -m "feat(coach-mark): discover 3-step onboarding tour"
```

---

### Task 7: Quiz Power Tour Integration (single card + timer pause/resume)

**Files:**
- Create: `qulov2/lib/features/quiz/coach/quiz_power_coach_marks.dart`
- Modify: `qulov2/lib/features/quiz/widgets/power_bar.dart` (kök `Row`'u `CoachMarkAnchor` ile sar)
- Modify: `qulov2/lib/features/quiz/widgets/quiz_question_content.dart` (tetikleme; timerKey'e erişimi var)

**Interfaces:**
- Consumes: `CoachMarkStep`, `CoachMarkService`, `CoachMarkAnchor`, `PowerType`, `PowerIcon`, `quiz_timer` `timerKey` (`GlobalKey<QuizTimerState>` → `.pause()`/`.resume()`)
- Produces: `List<CoachMarkStep> buildQuizPowerCoachSteps(BuildContext context, {required VoidCallback onPause, required VoidCallback onResume})` ; anchorId: `quiz_powerbar`

- [ ] **Step 1: Create the tour definition (single combined card)**

```dart
// qulov2/lib/features/quiz/coach/quiz_power_coach_marks.dart
import 'package:flutter/material.dart';
import '../../../core/coach_mark/coach_mark_step.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/power_icon.dart';

/// Single-step tour highlighting the whole power bar. onShow pauses the quiz
/// timer; onDismiss resumes it (guaranteed even on skip/back).
List<CoachMarkStep> buildQuizPowerCoachSteps({
  required VoidCallback onPause,
  required VoidCallback onResume,
}) =>
    [
      CoachMarkStep(
        anchorId: 'quiz_powerbar',
        shape: CoachMarkShape.rect,
        titleKey: 'coach_quiz_powers_title',
        bodyKey: 'coach_quiz_powers_body',
        ctaKey: 'coach_cta_got_it',
        onShow: onPause,
        onDismiss: onResume,
        bodyBuilder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.tr('coach_quiz_powers_body'),
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.md),
            _powerRow(context, PowerType.oracle, 'coach_quiz_power_oracle'),
            _powerRow(context, PowerType.half, 'coach_quiz_power_half'),
            _powerRow(context, PowerType.skip, 'coach_quiz_power_skip'),
            _powerRow(context, PowerType.hint, 'coach_quiz_power_hint'),
            _powerRow(context, PowerType.timeExtend, 'coach_quiz_power_time_extend'),
            _powerRow(context, PowerType.skipAll, 'coach_quiz_power_skip_all'),
          ],
        ),
      ),
    ];

Widget _powerRow(BuildContext context, PowerType type, String key) => Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          PowerIcon(type: type, size: 24),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(context.tr(key),
                style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
```

- [ ] **Step 2: Wrap the power bar**

`power_bar.dart` içinde dış `Row(... children: _powers.map ...)`'u `CoachMarkAnchor` ile sar:

```dart
import '../../../core/coach_mark/coach_mark_anchor.dart';
// ...
return CoachMarkAnchor(
  anchorId: 'quiz_powerbar',
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: _powers.map((type) { /* mevcut kod aynen */ }).toList(),
  ),
);
```

- [ ] **Step 3: Trigger from quiz_question_content with timer pause/resume**

`quiz_question_content.dart` — `QuizTimer(key: timerKey, ...)` zaten burada. Aynı `timerKey`'i kullanarak tetikleme ekle. Stateful değilse, tetiklemeyi içeren `StatefulWidget`'a çevirmeden, `timerKey` parametre olarak alınıyorsa onu kullan. Tetikleyici (build içinde, bir `bool _coachTried` guard ile postFrame):

```dart
import '../../../core/services/coach_mark_service.dart';
import '../coach/quiz_power_coach_marks.dart';
// ...
// QuizQuestionContent State (veya parent) içinde:
bool _coachTried = false;

void _maybeStartPowerCoach() {
  if (_coachTried) return;
  _coachTried = true;
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!mounted) return;
    CoachMarkService.instance.maybeStartTour(
      context,
      tourId: 'quiz_powers',
      steps: buildQuizPowerCoachSteps(
        onPause: () => timerKey.currentState?.pause(),
        onResume: () => timerKey.currentState?.resume(),
      ),
    );
  });
}
```

`_maybeStartPowerCoach()`'ı, ilk soru + timer mount edildikten sonra (build'in aktif soru gösterdiği yerde) çağır.

> Not: `QuizQuestionContent` stateless ise, tetikleme için onu `StatefulWidget`'a çevir (yalnızca `_coachTried` guard + postFrame için). `timerKey` mevcut şekilde korunur.

- [ ] **Step 4: Analyze + manual verification (timer edge cases)**

Run: `cd qulov2 && dart analyze lib/features/quiz/`
Expected: No issues.

Manuel doğrulama (`coach_quiz_powers_seen` silinmiş):
- Discover'dan bir soru çöz → ilk soru açılınca power bar vurgulu tek kart çıkar, **timer DURUR** (saniye azalmaz).
- "Anladım" → kart kapanır, **timer DEVAM eder**.
- Aynı kartta ✕ (skip) ile kapat → timer yine DEVAM eder (resume garantisi).
- Kart açıkken app'i arka plana al, geri dön → timer hâlâ durur; kapatınca devam eder (çift-resume yok).
- İkinci soru çözmede tur TEKRAR çıkmaz.

- [ ] **Step 5: Commit**

```bash
git add qulov2/lib/features/quiz/
git commit -m "feat(coach-mark): quiz power intro with timer pause/resume"
```

---

### Task 8: Chat Question Tour Integration

**Files:**
- Create: `qulov2/lib/features/chat/coach/chat_question_coach_marks.dart`
- Modify: `qulov2/lib/features/chat/widgets/chat_input_bar.dart` (soru `IconButton`'ını `CoachMarkAnchor` ile sar)
- Modify: `qulov2/lib/features/chat/mixins/chat_screen_mixin.dart` (tetikleme)

**Interfaces:**
- Consumes: `CoachMarkStep`, `CoachMarkService`, `CoachMarkAnchor`
- Produces: `List<CoachMarkStep> buildChatQuestionCoachSteps()` ; anchorId: `chat_question_btn`

- [ ] **Step 1: Create the tour definition**

```dart
// qulov2/lib/features/chat/coach/chat_question_coach_marks.dart
import '../../../core/coach_mark/coach_mark_step.dart';

List<CoachMarkStep> buildChatQuestionCoachSteps() => const [
      CoachMarkStep(
        anchorId: 'chat_question_btn',
        shape: CoachMarkShape.circle,
        titleKey: 'coach_chat_question_title',
        bodyKey: 'coach_chat_question_body',
        ctaKey: 'coach_cta_got_it',
      ),
    ];
```

- [ ] **Step 2: Wrap the question button**

`chat_input_bar.dart` içindeki soru `IconButton(... icon: Icon(Icons.help_outline) ...)`'ını sar:

```dart
import '../../../core/coach_mark/coach_mark_anchor.dart';
// ...
CoachMarkAnchor(
  anchorId: 'chat_question_btn',
  child: IconButton(
    onPressed: isLocked ? null : onQuestionTap,
    icon: Icon(
      Icons.help_outline,
      color: isLocked
          ? context.appColors.primary.withValues(alpha: 0.4)
          : context.appColors.primary,
      size: 22,
    ),
  ),
),
```

- [ ] **Step 3: Add the trigger to chat mixin**

`chat_screen_mixin.dart` `initMixin()` içindeki `Future.microtask(...)` bloğunun SONUNA ekle (mesajlar yüklendikten sonra postFrame):

```dart
import '../../../core/services/coach_mark_service.dart';
import '../coach/chat_question_coach_marks.dart';
// ...
WidgetsBinding.instance.addPostFrameCallback((_) {
  if (!mounted) return;
  CoachMarkService.instance.maybeStartTour(
    context,
    tourId: 'chat_question',
    steps: buildChatQuestionCoachSteps(),
  );
});
```

- [ ] **Step 4: Analyze + manual verification**

Run: `cd qulov2 && dart analyze lib/features/chat/`
Expected: No issues.

Manuel doğrulama (`coach_chat_question_seen` silinmiş):
- İlk kez bir match chat'ine gir → soru (`help_outline`) butonu dairesel vurguyla işaretlenir, açıklama kartı çıkar.
- "Anladım" → kapanır.
- Başka bir chat'e gir → TEKRAR çıkmaz (`coach_chat_question_seen=true`).

- [ ] **Step 5: Commit**

```bash
git add qulov2/lib/features/chat/
git commit -m "feat(coach-mark): chat question button onboarding tooltip"
```

---

### Task 9: Final Review

**Files:** (tümü, değişiklik yok — review)

- [ ] **Step 1: Full analyze + test**

Run: `cd qulov2 && dart analyze && fvm flutter test test/core/coach_mark/ test/core/services/coach_mark_service_test.dart`
Expected: No analyze issues; tüm coach-mark testleri PASS.

- [ ] **Step 2: Run flutter-review skill**

Invoke skill: `/flutter-review` — screen boyut limitleri, widget extraction, banned patterns, reuse, konvansiyonlar.

- [ ] **Step 3: Run i18n-guardian skill**

Invoke skill: `/i18n-guardian` — 16 dil `coach_*` tamlık doğrulaması.

- [ ] **Step 4: Address findings + final commit**

Review bulgularını düzelt, varsa commit et.

---

## Self-Review (plan ↔ spec)

**Spec coverage:**
- §3.1 core motor → Task 1–4 ✅
- §4.1 discover 3-step → Task 6 ✅ (gate stacking guard dahil)
- §4.2 quiz tek kart + timer pause/resume edge case → Task 7 ✅
- §4.3 chat soru butonu → Task 8 ✅
- §5 i18n 16 dil → Task 5 ✅
- §6 persistence flags → Task 4 (`coach_${tourId}_seen`) ✅
- §7 dosya yapısı → Task 1–8 dosya yolları ✅
- §8 edge case'ler (layout yoksa rect null → centered fallback; single-tour guard; resume idempotent) → Task 3 `_resolveRect` + Task 4 guard + Task 7 resume ✅
- §9 test edilebilirlik → Task 1/2/4 unit, Task 3 widget ✅
- §10 YAGNI (server/AB/maskot yok) → planda yok ✅

**Type consistency:** `CoachMarkRegistry.keyFor/maybeKey`, `CoachMarkStep(anchorId/titleKey/bodyKey/ctaKey/shape/bodyBuilder/onShow/onDismiss)`, `CoachMarkController(start/next/skipAll/onFinished/current/index/stepCount/finished)`, `CoachMarkService.instance.maybeStartTour/isSeen/markSeen/isTourActive` — tüm tasklarda tutarlı kullanıldı. anchorId string'leri: `discover_solve`, `discover_actions`, `quiz_powerbar`, `chat_question_btn`. tourId'ler: `discover`, `quiz_powers`, `chat_question`.

**Placeholder scan:** Kod adımları tam; "TODO/TBD" yok. Tek dış-bağımlılık: Task 3 widget testi Task 5 EN key'lerine bağlı — not düşüldü.
