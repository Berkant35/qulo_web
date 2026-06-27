# Merkezi Overlay Orchestrator (OverlayQueue) — Tasarım

**Tarih:** 2026-06-28
**Kapsam:** Mobile (Flutter, qulov2) — app geneli
**Durum:** Tasarım onaylandı, plana hazır

## 1. Amaç ve Problem

Discover (ve genel olarak app) ekranında, kullanıcıya bir şey gösteren birden fazla mekanizma **birbirinden habersiz** tetikleniyor ve üst üste biniyor:

- **Coach-mark** (onboarding turu) — root `OverlayEntry`, `isTourActive` guard yalnızca kendi içinde.
- **Page-message modal/bottom_sheet** — `NavigationService` overlay, coach'tan habersiz.
- **In-app banner** (FCM foreground bildirim) — root `OverlayEntry`, 4sn auto-dismiss, hiçbirini kontrol etmiyor → onboarding/modal üstüne biniyor.

Merkezi koordinasyon yok. Sonuç: coach-mark açıkken page-message modal'ı veya bildirim banner'ı üstüne binebiliyor.

**Çözüm:** App geneli tek bir sıra (queue) servisi. Gösterilmek isteyen her overlay servise "ben sıradayım, önceliğim X" der; servis **aynı anda tek** overlay gösterir, o kapanınca sıradakini açar.

**Kapsam dışı:** Sunucu değişikliği yok. Ekonomi/chat akışı etkisi yok (saf UI orchestration).

## 2. Çekirdek Servis

`OverlayQueueService` — singleton (Hardware-Manager pattern, `OverlayQueueService.instance`).

### Model
```dart
class OverlayRequest {
  final String id;          // idempotency anahtarı (ör. 'coach_discover_intro', 'pagemsg_<id>', 'banner_<msgId>')
  final int priority;       // yüksek = önce
  final Future<void> Function() show; // overlay'i açar, KAPANANA kadar tamamlanmayan future döner
}
```

### Priority sabitleri
```dart
abstract final class OverlayPriority {
  static const int onboarding = 300;   // coach-mark
  static const int campaign = 200;     // page-message modal/bottom_sheet (+ server priority offset)
  static const int notification = 100; // in-app banner
}
```
Page-message için efektif priority = `campaign + serverPriority` (server `priority` alanı, 0..N). Bu sayede kampanyalar kendi aralarında server sırasını korur ama her zaman onboarding'in altında, bildirimin üstünde kalır.

### İç durum + davranış
- `_active: OverlayRequest?` — şu an gösterilen.
- `_queue: List<OverlayRequest>` — bekleyenler, priority azalan sıralı (eşit priority → FIFO).
- `enqueue(req)`:
  1. `req.id` zaten `_active` veya `_queue`'da ise **yok say** (idempotent — aynı overlay iki kez sıraya girmez).
  2. `notification` priority'li request'lerde, kuyrukta bekleyen notification sayısı **3'ü aşarsa en eski notification düşürülür** (banner seli önleme).
  3. `_active == null` ise hemen `_start(req)`; değilse priority'ye göre kuyruğa ekle.
- `_start(req)`: `_active = req` → `req.show()` çağrılır → future complete olunca `_active = null` → `_drainNext()`.
- `_drainNext()`: kuyruk boş değilse en yüksek priority öğeyi çıkar, `_start` et.
- `cancel(id)`: kuyruktan id'yi çıkarır; `_active.id == id` ise aktif future'ın complete edilmesi çağıran tarafın sorumluluğu (cancel yalnızca bekleyeni siler).

### Hata güvenliği
`req.show()` future'ı hata/exception ile biterse de `_active` temizlenir ve kuyruk ilerler (try/finally) — tek bir bozuk overlay tüm kuyruğu kilitlemez.

## 3. Entegrasyon Noktaları

### 3.1 Coach-mark (`coach_mark_service.dart`)
`maybeStartTour` artık doğrudan `overlay.insert` yapmaz; bunun yerine bir `Completer` kurup `OverlayQueueService.enqueue` çağırır:
- `id`: `'coach_<tourId>'`, `priority`: `OverlayPriority.onboarding`.
- `show`: overlay'i insert eder, `Completer<void>` döner.
- `onFinished` (mevcut `_close`) **ve** `forceClose` → `completer.complete()` (kuyruk ilerler).
- Mevcut `isTourActive`/`_activeEntry` guard'ı korunur (servisin kendi iç tutarlılığı için) ama **tek-aktiflik artık queue tarafından** garanti edilir. `isTourActive` getter'ı geriye dönük uyumluluk için kalır.

### 3.2 Page-message (`page_message_host.dart`)
`_dispatch()` içindeki `switch`:
- `inline_card` / `banner` → **DEĞİŞMEZ** (Column child'ı olarak render, kuyruk dışı).
- `bottom_sheet` / `modal` → doğrudan `showAppBottomSheet`/`showAppDialog` yerine `OverlayQueueService.enqueue`:
  - `id`: `'pagemsg_<msg.id>'`, `priority`: `OverlayPriority.campaign + msg.priority`.
  - `show`: mevcut `_showOverlay` mantığını çağırır; `showAppDialog/Sheet` zaten `await` edilebilir bir future döndürdüğü için o future doğrudan `show`'un dönüşü olur (sheet/dialog kapanınca complete).

### 3.3 In-app banner (`app.dart` `_setupNotificationCallbacks`)
Banner `OverlayEntry` insert eden blok `OverlayQueueService.enqueue` ile sarılır:
- `id`: `'banner_<messageId veya timestamp>'`, `priority`: `OverlayPriority.notification`.
- `show`: banner entry'sini insert eder, `Completer<void>` döner; mevcut `removeEntry` (tap veya 4sn auto-dismiss) → `completer.complete()`.
- Mevcut suppress logic (aktif chat'te mesaj bildirimini bastırma) **enqueue'dan ÖNCE** çalışır — bastırılan bildirim kuyruğa hiç girmez.

## 4. Kuyruk Dışı Kalanlar (dokunulmaz)
- Page-message `inline_card` / `banner` (ekran içi Column child'ı).
- `QuestionGateBanner` (koşullu child widget).
Bunlar overlay değil; layout'un parçası, çakışma yaratmıyorlar.

## 5. Edge Case'ler
- **Banner birikmesi:** kuyrukta max 3 bekleyen `notification`; fazlası en eskiden düşer.
- **Ekran değişimi:** root overlay app-geneli; ertelenmiş banner onboarding/modal bitince yine gösterilir (hangi ekranda olursa olsun — kabul edilebilir, çünkü bildirim zaten global).
- **Ekran pop (coach ortada):** `forceClose` → coach future complete → kuyruk takılmadan ilerler.
- **show içinde exception:** try/finally ile `_active` temizlenir, kuyruk ilerler.
- **Aynı overlay iki tetik:** `id` idempotency ile ikinci enqueue yok sayılır (ör. page-message listener'ın iki kez ateşlemesi).

## 6. Dosyalar
- **Yeni:**
  - `lib/core/services/overlay_queue_service.dart` (servis)
  - `lib/core/services/overlay_request.dart` (`OverlayRequest` + `OverlayPriority`)
- **Değişen:**
  - `lib/core/services/coach_mark_service.dart` (enqueue ile sarmalama)
  - `lib/features/page_messages/widgets/page_message_host.dart` (modal/sheet → enqueue)
  - `lib/app.dart` (banner → enqueue)
- **Test:**
  - `test/core/services/overlay_queue_service_test.dart`

## 7. Test Stratejisi
Saf kuyruk mantığı UI'sız test edilir — `show` olarak `Completer` tabanlı fake future'lar verilir:
- enqueue boşken → hemen aktif olur (`show` çağrılır).
- aktif varken enqueue → kuyrukta bekler; aktif complete olunca sıradaki başlar.
- priority sıralaması: yüksek priority önce; eşit priority FIFO.
- idempotency: aynı id ikinci enqueue yok sayılır.
- notification cap: 4. notification eklenince en eski bekleyen düşer.
- exception güvenliği: `show` future'ı throw ederse kuyruk yine ilerler.

## 8. Onaylanan Kararlar
- App geneli merkezi orchestrator (sadece discover değil).
- In-app banner **ertelenir**, onboarding/modal bitince gösterilir.
- Öncelik: **Onboarding > Kampanya > Bildirim**.
- inline/banner page-message + QuestionGateBanner **kuyruk dışı**.
- Coach-mark artık queue üzerinden açılır; tek-aktiflik queue garantisi.
- Banner için kuyrukta **max 3** bekleyen.
