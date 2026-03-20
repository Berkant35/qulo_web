# Chat Question Realtime Fix Design

## Problem

Soru cevaplandığında, soruyu **gönderen** kişinin chat ekranında soru kartı anlık olarak guncellenmiyor. Bildirim geliyor ama kart hala "cevap bekleniyor" gosteriyor. Geri cikip tekrar girince guncelleniyor.

## Root Cause

Widget (`ChatQuestionMessage`) sadece `chatQuestionProvider`'i izliyor. Bu provider `FutureProvider.autoDispose.family` — her calismasinda API'ye istek atiyor.

Realtime callback `chatQuestionCacheProvider`'i guncelliyor ama widget bu cache'i **watch etmiyor**. `ref.invalidate` cagrilinca provider API'ye yeni istek atiyor — dolayli ve kirilgan.

Ozet: Cache guncelleniyor ama widget cache'e bagli degil.

## Solution: Cache-Reactive Provider (Yaklasim A)

### Mimari Degisiklik

**Onceki akis:**
```
Widget -> watch(chatQuestionProvider) -> FutureProvider -> API fetch
Realtime -> cache guncelle + invalidate -> tekrar API fetch (gecikme)
```

**Yeni akis:**
```
Widget -> watch(chatQuestionProvider) -> cache'den oku (aninda)
           |                                |
     ilk yukleme: API fetch -> cache'e yaz   realtime -> cache'e yaz
```

### Degisen Dosyalar

1. **`lib/providers/chat_provider.dart`** — Provider tanimlari
2. **`lib/features/chat/mixins/chat_screen_mixin.dart`** — Realtime callback
3. **`lib/features/chat/widgets/chat_question_message.dart`** — `_refreshQuestion`

### 1. Provider Yeniden Tasarimi (`chat_provider.dart`)

```dart
// Cache aynen kalir
final chatQuestionCacheProvider =
    StateProvider<Map<String, ChatQuestionModel>>((ref) => {});

// Fetch tetikleyici — cache'de yoksa API'den ceker, cache'e yazar
final _chatQuestionFetchProvider =
    FutureProvider.autoDispose.family<void, String>((ref, questionId) async {
  final cache = ref.read(chatQuestionCacheProvider);
  if (cache.containsKey(questionId)) return;

  final repo = ref.read(chatRepositoryProvider);
  final result = await repo.getQuestion(questionId);
  result.when(
    success: (question) {
      ref.read(chatQuestionCacheProvider.notifier).update((state) {
        final copy = Map<String, ChatQuestionModel>.from(state);
        copy[questionId] = question;
        return copy;
      });
    },
    failure: (_) {},
  );
});

// Widget'in watch ettigi provider — cache-reactive
final chatQuestionProvider =
    Provider.autoDispose.family<AsyncValue<ChatQuestionModel?>, String>((ref, questionId) {
  final cache = ref.watch(chatQuestionCacheProvider);
  if (cache.containsKey(questionId)) {
    return AsyncValue.data(cache[questionId]);
  }
  final fetch = ref.watch(_chatQuestionFetchProvider(questionId));
  return fetch.when(
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
    data: (_) {
      final updated = ref.read(chatQuestionCacheProvider);
      final question = updated[questionId];
      // Fetch tamamlandi ama cache henuz yazilmamis olabilir (1 frame gecikme)
      // null donmek yerine loading goster — cache yazilinca rebuild tetiklenir
      if (question == null) return const AsyncValue.loading();
      return AsyncValue.data(question);
    },
  );
});
```

### 2. Realtime Callback Sadeleşmesi (`chat_screen_mixin.dart`)

```dart
callback: (payload) {
  if (_disposed) return;
  final record = payload.newRecord;
  final questionId = record['id'] as String?;
  if (questionId != null) {
    try {
      final updated = ChatQuestionModel.fromJson(record);
      ref.read(chatQuestionCacheProvider.notifier).update((state) {
        final copy = Map<String, ChatQuestionModel>.from(state);
        copy[questionId] = updated;
        return copy;
      });
    } catch (e) {
      debugPrint('[Realtime] Question parse failed: $e');
      // Parse basarisiz -> API'den taze veri cek
      ref.read(chatRepositoryProvider).getQuestion(questionId).then((result) {
        if (_disposed) return; // mixin dispose edildiyse cache'e yazma
        result.when(
          success: (question) {
            ref.read(chatQuestionCacheProvider.notifier).update((state) {
              final copy = Map<String, ChatQuestionModel>.from(state);
              copy[questionId] = question;
              return copy;
            });
          },
          failure: (_) {},
        );
      });
    }
    // ref.invalidate KALDIRILDI
  }
},
```

### 3. Refresh Sadeleşmesi (`chat_question_message.dart`)

```dart
void _refreshQuestion(WidgetRef ref) {
  ref.read(chatQuestionCacheProvider.notifier).update((state) {
    final updated = Map<String, ChatQuestionModel>.from(state);
    updated.remove(questionId);
    return updated;
  });
}
```

### 4. Migration: REPLICA IDENTITY FULL

Supabase Realtime UPDATE event'lerinde tum kolonlarin gelmesi icin:

```sql
ALTER TABLE chat_questions REPLICA IDENTITY FULL;
```

Bu olmadan Supabase sadece degisen kolonlari + PK gonderir, `fromJson` eksik alanlarla patlar.

## Bilinen Etkilesimler

- **`ChatNotifier.updateChatLock()`**: Bu metod `chatQuestionCacheProvider`'dan okuyarak chat input kilidini belirliyor. Yeni akista cache realtime'dan aninda guncellenecegi icin `updateChatLock` da dogru zamanda tetiklenir — davranis degismiyor.
- **Global cache scope:** `chatQuestionCacheProvider` global bir `StateProvider`. `initMixin` her chat giriste cache'i temizliyor (`state = {}`). Navigation stack'te birden fazla chat ekrani aciksa, ikinci chat'e giris birinci chat'in cache'ini siler. Bu mevcut davranis — yeni bir sorun degil, bilinen limitasyon.

## Edge Cases

- **Chat'e giris:** `initMixin` cache'i temizliyor (`state = {}`) -> tum kartlar API'den taze fetch eder. Mevcut davranis korunuyor.
- **Ayni anda iki soru cevaplanirsa:** Ayri realtime event, ayri cache key, sorun yok.
- **Solve screen'den donus:** `_refreshQuestion` cache'den siler -> fetch tetiklenir.
- **Parse hatasi:** `catch` blogu loglama + API fallback yapar, sessizce yutmaz.

## Scope

- Yeni dosya yok
- 3 dosya degisecek + 1 SQL migration
- Mevcut test'lere etkisi yok (provider tipi degisiyor ama widget API'si ayni: `AsyncValue`)
