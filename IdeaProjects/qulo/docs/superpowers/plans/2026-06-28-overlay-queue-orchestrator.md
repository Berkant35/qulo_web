# Merkezi Overlay Orchestrator (OverlayQueue) — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** App geneli tek bir sıra servisi ile coach-mark, page-message modal/sheet ve in-app banner'ı aynı anda tek overlay olacak şekilde sıralı göster.

**Architecture:** `OverlayQueueService` singleton (Hardware-Manager pattern). Gösterilmek isteyen her overlay `enqueue(OverlayRequest{id, priority, show})` çağırır; `show()` overlay'i açıp kapanınca tamamlanan bir `Future` döner. Servis aynı anda tek overlay gösterir; aktif kapanınca priority sıralı kuyruktan sıradakini başlatır. Coach-mark, page-message host ve app.dart banner bloğu bu servise yönlendirilir.

**Tech Stack:** Flutter, Riverpod, `dart:async` (Completer/Future). Saf Dart kuyruk mantığı (UI'sız test edilebilir).

## Global Constraints

- **Mobile import:** Daima `package:qulo_v2/...` — relative import YASAK (`always_use_package_imports` lint).
- **Analyze:** `cd qulov2 && fvm dart analyze` (bu FVM'de `flutter analyze` CRASH eder). Test: `fvm flutter test`.
- **Pattern:** Hardware-Manager singleton — feature'lar overlay'i doğrudan insert etmez, `OverlayQueueService.instance` üzerinden geçer.
- **Hardcoded yok:** renk/string/spacing theme + l10n'dan (bu işte yeni UI yok; mevcut overlay'ler korunur).
- **Priority sabitleri (verbatim):** `onboarding = 300`, `campaign = 200`, `notification = 100`. Page-message efektif priority = `campaign + msg.priority`.
- **Banner kuyruk sınırı:** notification-tier kuyrukta **max 3** bekleyen; fazlası en eskiden düşer.
- **Kuyruk dışı:** page-message `inline_card`/`banner` (Column child) + `QuestionGateBanner` — DEĞİŞMEZ.
- **Branch:** `qulov2/feat/acquisition-attribution` (mevcut, HEAD `24e89a0`) üstüne devam — coach_mark_service.dart bu branch'te güncel (isTourActive). Yeni branch açma. **Remote'a push EDİLMEZ** (kullanıcı tetikler).
- **Server/ekonomi/chat etkisi yok.**

---

### Task 1: OverlayQueueService + OverlayRequest (çekirdek + test)

**Files:**
- Create: `qulov2/lib/core/services/overlay_request.dart`
- Create: `qulov2/lib/core/services/overlay_queue_service.dart`
- Test: `qulov2/test/core/services/overlay_queue_service_test.dart`

**Interfaces:**
- Produces:
  - `OverlayRequest({ required String id, required int priority, required Future<void> Function() show })`
  - `OverlayPriority.onboarding=300 / .campaign=200 / .notification=100`
  - `OverlayQueueService.instance` (singleton) + `OverlayQueueService()` (public ctor — test taze instance alır)
  - `void enqueue(OverlayRequest req)`, `void cancel(String id)`, `bool get isShowing`

- [ ] **Step 1: Branch'i doğrula**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git checkout feat/acquisition-attribution && git log --oneline -1
```
Expected: HEAD `24e89a0` (acquisition profile commit). Yeni branch açma.

- [ ] **Step 2: Model dosyasını yaz**

`qulov2/lib/core/services/overlay_request.dart`:

```dart
/// A request to show a single overlay through [OverlayQueueService].
class OverlayRequest {
  /// Idempotency key — the same id is never queued twice.
  final String id;

  /// Higher value is shown first. See [OverlayPriority].
  final int priority;

  /// Opens the overlay and returns a Future that completes ONLY when the
  /// overlay closes. The queue advances when this future completes.
  final Future<void> Function() show;

  const OverlayRequest({
    required this.id,
    required this.priority,
    required this.show,
  });
}

/// Standard priority tiers. Higher = shown first.
abstract final class OverlayPriority {
  static const int onboarding = 300;
  static const int campaign = 200;
  static const int notification = 100;
}
```

- [ ] **Step 3: Failing test'i yaz**

`qulov2/test/core/services/overlay_queue_service_test.dart`:

```dart
import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:qulo_v2/core/services/overlay_queue_service.dart';
import 'package:qulo_v2/core/services/overlay_request.dart';

void main() {
  // Helper: a show() backed by a Completer the test can resolve manually.
  ({OverlayRequest req, Completer<void> done, List<String> shown}) make(
    String id,
    int priority,
    List<String> shownLog,
  ) {
    final done = Completer<void>();
    final req = OverlayRequest(
      id: id,
      priority: priority,
      show: () {
        shownLog.add(id);
        return done.future;
      },
    );
    return (req: req, done: done, shown: shownLog);
  }

  test('first enqueue shows immediately', () {
    final q = OverlayQueueService();
    final log = <String>[];
    final a = make('a', OverlayPriority.campaign, log);
    q.enqueue(a.req);
    expect(log, ['a']);
    expect(q.isShowing, true);
  });

  test('second enqueue waits until active completes', () {
    final q = OverlayQueueService();
    final log = <String>[];
    final a = make('a', OverlayPriority.campaign, log);
    final b = make('b', OverlayPriority.campaign, log);
    q.enqueue(a.req);
    q.enqueue(b.req);
    expect(log, ['a']); // b waits
    a.done.complete();
    // microtask flush
    return Future.microtask(() {
      expect(log, ['a', 'b']);
    });
  });

  test('higher priority shown before lower while waiting', () async {
    final q = OverlayQueueService();
    final log = <String>[];
    final a = make('a', OverlayPriority.notification, log);
    final low = make('low', OverlayPriority.notification, log);
    final high = make('high', OverlayPriority.onboarding, log);
    q.enqueue(a.req); // active
    q.enqueue(low.req);
    q.enqueue(high.req);
    a.done.complete();
    await Future.microtask(() {});
    expect(log, ['a', 'high']); // high before low
  });

  test('equal priority keeps FIFO', () async {
    final q = OverlayQueueService();
    final log = <String>[];
    final a = make('a', OverlayPriority.campaign, log);
    final b = make('b', OverlayPriority.campaign, log);
    final c = make('c', OverlayPriority.campaign, log);
    q.enqueue(a.req);
    q.enqueue(b.req);
    q.enqueue(c.req);
    a.done.complete();
    await Future.microtask(() {});
    b.done.complete();
    await Future.microtask(() {});
    expect(log, ['a', 'b', 'c']);
  });

  test('duplicate id is ignored', () {
    final q = OverlayQueueService();
    final log = <String>[];
    final a = make('a', OverlayPriority.campaign, log);
    final a2 = make('a', OverlayPriority.campaign, log);
    q.enqueue(a.req);
    q.enqueue(a2.req); // same id, ignored
    expect(log, ['a']);
  });

  test('notification queue caps at 3 (oldest dropped)', () async {
    final q = OverlayQueueService();
    final log = <String>[];
    final active = make('act', OverlayPriority.campaign, log);
    q.enqueue(active.req); // active, not notification
    for (final id in ['n1', 'n2', 'n3', 'n4']) {
      q.enqueue(make(id, OverlayPriority.notification, log).req);
    }
    active.done.complete();
    await Future.microtask(() {});
    // n1 dropped; n2 first to show
    expect(log.where((e) => e.startsWith('n')).first, 'n2');
  });

  test('throwing show does not wedge the queue', () async {
    final q = OverlayQueueService();
    final log = <String>[];
    final bad = OverlayRequest(
      id: 'bad',
      priority: OverlayPriority.campaign,
      show: () => throw StateError('boom'),
    );
    final good = make('good', OverlayPriority.campaign, log);
    q.enqueue(bad); // active; show() throws synchronously
    q.enqueue(good.req);
    await Future.microtask(() {});
    expect(log, ['good']); // queue advanced past the throw
  });
}
```

- [ ] **Step 4: Test'in fail ettiğini doğrula**

Run: `cd qulov2 && fvm flutter test test/core/services/overlay_queue_service_test.dart`
Expected: FAIL — `OverlayQueueService` yok.

- [ ] **Step 5: Servisi yaz**

`qulov2/lib/core/services/overlay_queue_service.dart`:

```dart
import 'package:qulo_v2/core/services/overlay_request.dart';

/// App-wide serializer for "show something to the user" overlays
/// (coach-marks, page-message modals/sheets, in-app banners).
///
/// Only ONE overlay is shown at a time. Others wait in a priority-ordered
/// queue and start as each active overlay closes. Hardware-Manager pattern:
/// features go through [instance], never insert overlays directly.
class OverlayQueueService {
  OverlayQueueService();
  static final OverlayQueueService instance = OverlayQueueService();

  OverlayRequest? _active;
  final List<OverlayRequest> _queue = [];

  /// Max queued notification-tier requests; oldest is dropped past this.
  static const int _maxQueuedNotifications = 3;

  /// True while an overlay is on screen.
  bool get isShowing => _active != null;

  /// Queues [req]. Shows immediately if nothing is active, else waits in
  /// priority order. Same id already active/queued → ignored (idempotent).
  void enqueue(OverlayRequest req) {
    if (_active?.id == req.id) return;
    if (_queue.any((r) => r.id == req.id)) return;

    if (req.priority == OverlayPriority.notification) {
      final queuedNotifs = _queue
          .where((r) => r.priority == OverlayPriority.notification)
          .toList();
      if (queuedNotifs.length >= _maxQueuedNotifications) {
        _queue.remove(queuedNotifs.first); // drop oldest notification
      }
    }

    if (_active == null) {
      _start(req);
    } else {
      _insertByPriority(req);
    }
  }

  /// Removes a still-queued request by id. No effect on the active overlay.
  void cancel(String id) {
    _queue.removeWhere((r) => r.id == id);
  }

  void _insertByPriority(OverlayRequest req) {
    // Higher priority first; equal priority keeps FIFO (insert after equals).
    var i = 0;
    while (i < _queue.length && _queue[i].priority >= req.priority) {
      i++;
    }
    _queue.insert(i, req);
  }

  void _start(OverlayRequest req) {
    _active = req;
    final Future<void> future;
    try {
      future = req.show();
    } catch (_) {
      _active = null;
      _drainNext();
      return;
    }
    future.whenComplete(() {
      if (_active?.id == req.id) {
        _active = null;
        _drainNext();
      }
    });
  }

  void _drainNext() {
    if (_queue.isEmpty) return;
    final next = _queue.removeAt(0);
    _start(next);
  }
}
```

- [ ] **Step 6: Test'i geçir + analyze**

Run: `cd qulov2 && fvm flutter test test/core/services/overlay_queue_service_test.dart && fvm dart analyze lib/core/services/overlay_queue_service.dart lib/core/services/overlay_request.dart`
Expected: tüm testler PASS, analyze temiz.

> NOT: `_start`'taki `whenComplete` senkron `_active` ataması ile `enqueue` arasındaki sıralamada microtask sınırına dikkat. Testler `Future.microtask` ile flush ediyor; davranış doğrulanır.

- [ ] **Step 7: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git add lib/core/services/overlay_request.dart lib/core/services/overlay_queue_service.dart test/core/services/overlay_queue_service_test.dart
git commit -m "feat(mobile): OverlayQueueService — app geneli overlay sıralama çekirdeği"
```

---

### Task 2: Coach-mark'ı queue'ya bağla

**Files:**
- Modify: `qulov2/lib/core/services/coach_mark_service.dart`

**Interfaces:**
- Consumes: `OverlayQueueService.instance.enqueue/cancel`, `OverlayRequest`, `OverlayPriority.onboarding`.
- Produces: `maybeStartTour` artık overlay'i queue üzerinden açar; `forceClose` kuyruktan da iptal eder.

- [ ] **Step 1: Servisi queue'ya yönlendir**

`qulov2/lib/core/services/coach_mark_service.dart` — tam yeni içerik (import'lar + Completer + enqueue):

```dart
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qulo_v2/core/coach_mark/coach_mark_controller.dart';
import 'package:qulo_v2/core/coach_mark/coach_mark_overlay.dart';
import 'package:qulo_v2/core/coach_mark/coach_mark_step.dart';
import 'package:qulo_v2/core/services/overlay_queue_service.dart';
import 'package:qulo_v2/core/services/overlay_request.dart';

/// Single entry point for anchored coach-mark tours. Feature code calls
/// [maybeStartTour]; the overlay/painter internals stay encapsulated here.
/// Tours are shown through [OverlayQueueService] so they never collide with
/// page-message modals or in-app banners.
class CoachMarkService {
  CoachMarkService._();
  static final CoachMarkService instance = CoachMarkService._();

  OverlayEntry? _activeEntry;
  Completer<void>? _activeCompleter;
  String? _queuedTourId;

  bool get isTourActive => _activeEntry != null;

  String _flag(String tourId) => 'coach_${tourId}_seen';
  String _queueId(String tourId) => 'coach_$tourId';

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
    if (_activeEntry != null) return; // a tour is already on screen
    if (_queuedTourId != null) return; // a tour is already queued
    if (steps.isEmpty) return;
    if (await isSeen(tourId)) return;
    if (!context.mounted) return;

    _queuedTourId = tourId;
    OverlayQueueService.instance.enqueue(
      OverlayRequest(
        id: _queueId(tourId),
        priority: OverlayPriority.onboarding,
        show: () => _show(context, tourId, steps),
      ),
    );
  }

  Future<void> _show(
    BuildContext context,
    String tourId,
    List<CoachMarkStep> steps,
  ) {
    _queuedTourId = null;
    final completer = Completer<void>();
    // Context may have unmounted while waiting in the queue.
    if (!context.mounted) {
      completer.complete();
      return completer.future;
    }
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) {
      completer.complete();
      return completer.future;
    }

    final controller = CoachMarkController(steps: steps);
    controller.onFinished = () => _close(tourId);

    final entry = OverlayEntry(
      builder: (_) => CoachMarkOverlay(controller: controller),
    );
    _activeEntry = entry;
    _activeCompleter = completer;
    overlay.insert(entry);
    return completer.future;
  }

  /// Force-removes the active tour overlay WITHOUT marking it seen, and
  /// cancels it if still waiting in the queue. Call from a triggering
  /// screen's dispose() so a route pop cannot orphan the overlay.
  void forceClose() {
    if (_queuedTourId != null) {
      OverlayQueueService.instance.cancel(_queueId(_queuedTourId!));
      _queuedTourId = null;
    }
    _activeEntry?.remove();
    _activeEntry = null;
    _activeCompleter?.complete(); // let the queue advance
    _activeCompleter = null;
  }

  void _close(String tourId) {
    _activeEntry?.remove();
    _activeEntry = null;
    _activeCompleter?.complete(); // queue advances
    _activeCompleter = null;
    // Fire-and-forget; flag write must not block UI removal.
    markSeen(tourId);
  }
}
```

> NOT: `Completer` için `dart:async` gerekir; `package:flutter/widgets.dart` onu re-export etmez. Üste `import 'dart:async';` ekle (yukarıdaki bloğa dahil değil — ANALYZE hatası alırsan ilk satıra `import 'dart:async';` koy).

- [ ] **Step 2: `dart:async` import'unu garanti et**

`coach_mark_service.dart` ilk satırı `import 'dart:async';` olmalı (Completer için). Yoksa ekle.

- [ ] **Step 3: Analyze + mevcut coach testleri**

Run: `cd qulov2 && fvm dart analyze lib/core/services/coach_mark_service.dart && fvm flutter test test/core/coach_mark/`
Expected: analyze temiz; mevcut coach-mark testleri (registry/controller/overlay) PASS (bu dosyalar değişmedi).

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git add lib/core/services/coach_mark_service.dart
git commit -m "feat(mobile): coach-mark'ı OverlayQueue üzerinden aç (forceClose kuyruk iptali)"
```

---

### Task 3: Page-message modal/sheet'i queue'ya bağla

**Files:**
- Modify: `qulov2/lib/features/page_messages/widgets/page_message_host.dart`

**Interfaces:**
- Consumes: `OverlayQueueService.instance.enqueue`, `OverlayRequest`, `OverlayPriority.campaign`.
- Produces: modal/bottom_sheet page-message'ları artık queue üzerinden açılır; inline/banner DEĞİŞMEZ.

- [ ] **Step 1: Import ekle**

`page_message_host.dart` import bloğuna ekle:
```dart
import 'package:qulo_v2/core/services/overlay_queue_service.dart';
import 'package:qulo_v2/core/services/overlay_request.dart';
```

- [ ] **Step 2: `_dispatch` switch'inde modal/sheet'i enqueue et**

`_dispatch()` içindeki switch'i şu hale getir (inline/banner aynı kalır):

```dart
    switch (msg.displayType) {
      case 'inline_card':
      case 'banner':
        setState(() => _inline = msg);
      case 'bottom_sheet':
        OverlayQueueService.instance.enqueue(
          OverlayRequest(
            id: 'pagemsg_${msg.id}',
            priority: OverlayPriority.campaign + msg.priority,
            show: () => _showOverlay(msg),
          ),
        );
      case 'modal':
        OverlayQueueService.instance.enqueue(
          OverlayRequest(
            id: 'pagemsg_${msg.id}',
            priority: OverlayPriority.campaign + msg.priority,
            show: () => _showOverlay(msg, isModal: true),
          ),
        );
    }
```

> `_showOverlay` zaten `await showAppDialog/showAppBottomSheet` ile sheet/dialog kapanınca tamamlanan `Future<void>` döndürür — queue için doğrudan `show` olarak kullanılır. Başka değişiklik gerekmez.

- [ ] **Step 3: Analyze + test**

Run: `cd qulov2 && fvm dart analyze lib/features/page_messages/widgets/page_message_host.dart && fvm flutter test`
Expected: analyze temiz; mevcut testler (+ Task 1 queue testi) PASS, yeni kırık yok.

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git add lib/features/page_messages/widgets/page_message_host.dart
git commit -m "feat(mobile): page-message modal/sheet'i OverlayQueue üzerinden aç"
```

---

### Task 4: In-app banner'ı queue'ya bağla

**Files:**
- Modify: `qulov2/lib/app.dart`

**Interfaces:**
- Consumes: `OverlayQueueService.instance.enqueue`, `OverlayRequest`, `OverlayPriority.notification`.
- Produces: foreground bildirim banner'ı artık queue üzerinden gösterilir (onboarding/modal aktifse ertelenir).

- [ ] **Step 1: Import'ları ekle**

`qulov2/lib/app.dart` import bloğuna (yoksa):
```dart
import 'package:qulo_v2/core/services/overlay_queue_service.dart';
import 'package:qulo_v2/core/services/overlay_request.dart';
```

- [ ] **Step 2: `onForegroundNotification` gövdesini queue'ya sar**

`_setupNotificationCallbacks` içindeki `onForegroundNotification` callback'inin gövdesini, banner'ı bir `Completer`'la queue'ya alacak şekilde değiştir. Mevcut `entry`/`removeEntry`/insert mantığı `show` içine taşınır; `removeEntry` artık completer'ı da tamamlar:

```dart
      onForegroundNotification: (message) {
        final title = message.notification?.title ?? 'Qulo';
        final body = message.notification?.body ?? '';
        final actionUrl = message.data['action_url'] as String?;

        final overlayState = rootNavigatorKey.currentState?.overlay;
        if (overlayState == null) return;

        final bannerId = 'banner_${message.messageId ?? message.hashCode}';

        OverlayQueueService.instance.enqueue(
          OverlayRequest(
            id: bannerId,
            priority: OverlayPriority.notification,
            show: () {
              final completer = Completer<void>();
              bool removed = false;
              late OverlayEntry entry;
              void removeEntry() {
                if (removed) return;
                removed = true;
                entry.remove();
                if (!completer.isCompleted) completer.complete();
              }

              AnalyticsManager.instance.logEvent(
                AnalyticsEvents.notificationBannerShow,
                params: {AnalyticsEvents.paramType: message.data['type'] ?? 'unknown'},
              );

              entry = OverlayEntry(
                builder: (_) => Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Material(
                    color: Colors.transparent,
                    child: InAppBanner(
                      title: title,
                      body: body,
                      onTap: () {
                        AnalyticsManager.instance.logEvent(
                          AnalyticsEvents.notificationBannerTap,
                          params: {AnalyticsEvents.paramType: message.data['type'] ?? 'unknown'},
                        );
                        removeEntry();
                        if (actionUrl != null && actionUrl.isNotEmpty) {
                          final navType = DeepLinkParser.resolveNavType(actionUrl);
                          final router = ref.read(routerProvider);
                          navType == DeepLinkNavType.push
                              ? router.push(actionUrl)
                              : router.go(actionUrl);
                        }
                      },
                      onDismiss: () {
                        AnalyticsManager.instance.logEvent(
                          AnalyticsEvents.notificationBannerDismiss,
                          params: {AnalyticsEvents.paramType: message.data['type'] ?? 'unknown'},
                        );
                        removeEntry();
                      },
                    ),
                  ),
                ),
              );
              overlayState.insert(entry);
              return completer.future;
            },
          ),
        );
      },
```

> Mevcut suppress logic (`shouldSuppressNotification` / `_shouldSuppressBanner`) `onForegroundNotification` ÇAĞRILMADAN ÖNCE notification_manager/provider katmanında çalışıyor — bastırılan bildirim buraya hiç gelmez, dolayısıyla kuyruğa da girmez. Bu task o mantığı değiştirmez.
> `Completer` için `app.dart` üstünde `import 'dart:async';` olduğundan emin ol (yoksa ekle).

- [ ] **Step 3: Analyze + test**

Run: `cd qulov2 && fvm dart analyze lib/app.dart && fvm flutter test`
Expected: analyze temiz; tüm testler PASS.

- [ ] **Step 4: Commit**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
git add lib/app.dart
git commit -m "feat(mobile): in-app banner'ı OverlayQueue üzerinden göster (onboarding/modal'ı ertele)"
```

---

### Task 5: Final review + doğrulama

**Files:** (yok — review + doğrulama)

- [ ] **Step 1: Flutter-review**

`/flutter-review` skill'ini çalıştır (OverlayQueueService + 3 entegrasyon dosyası). Bulguları gider, gerekirse commit et.

- [ ] **Step 2: Tam analyze + test**

```bash
cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2
fvm dart analyze
fvm flutter test
```
Expected: 0 hata; queue testleri + mevcut testler PASS (bilinen pre-existing `user_model_test.dart setupComplete` fail'i hariç — bu işle ilgisiz).

- [ ] **Step 3: Uçtan uca doğrulama (manuel, cihaz/emülatör)**

1. Yeni/temiz kullanıcı discover'a girer → coach-mark intro açılır. Coach açıkken bir page-message (modal) tetiklenirse coach kapanana kadar **beklemeli**, sonra açılmalı.
2. Coach veya modal açıkken bir push bildirim gelir → banner **hemen üste binmez**; coach/modal kapanınca banner gösterilir.
3. Art arda birden çok bildirim → en fazla 3 banner sırayla; üstü düşer.
4. Coach açıkken ekrandan çıkılırsa (route pop) → `forceClose` ile kuyruk kilitlenmeden ilerler.

- [ ] **Step 4: Özet + memory + ledger**

Kullanıcıya özet sun. Ledger'a OverlayQueue feature'ını işle. Branch push EDİLMEZ (kullanıcı tetikler — acquisition ile birlikte gidecek).

---

## Self-Review Notları

- **Spec kapsamı:** Bölüm 2 (servis) → Task 1; Bölüm 3.1 (coach) → Task 2; 3.2 (page-message) → Task 3; 3.3 (banner) → Task 4; Bölüm 5 edge case'ler → Task 1 (cap/exception/idempotency) + Task 2 (forceClose/unmount). Tümü kapsandı.
- **Tip tutarlılığı:** `OverlayRequest{id, priority, show}`, `OverlayPriority.onboarding/campaign/notification`, `enqueue/cancel/isShowing` tüm task'larda aynı.
- **Kuyruk dışı:** inline/banner page-message + QuestionGateBanner hiçbir task'ta dokunulmuyor (spec Bölüm 4).
- **Branch:** feat/acquisition-attribution üstüne; coach_mark_service.dart bu branch'te güncel — conflict yok.
