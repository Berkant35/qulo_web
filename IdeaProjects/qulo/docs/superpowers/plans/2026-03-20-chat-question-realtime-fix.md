# Chat Question Realtime Fix Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Soru cevaplandığında gönderenin chat ekranındaki soru kartının anlık olarak güncellenmesini sağla.

**Architecture:** `chatQuestionProvider`'ı API-first `FutureProvider`'dan cache-reactive `Provider`'a dönüştür. Realtime callback sadece cache'i günceller, widget cache'i watch eder ve anında rebuild olur.

**Tech Stack:** Flutter, Riverpod, Supabase Realtime, PostgreSQL

---

## File Map

| Dosya | Islem | Sorumluluk |
|-------|-------|------------|
| `qulov2/lib/providers/chat_provider.dart` | Modify (lines 266-296) | Provider tanımları: cache, fetch, reactive provider |
| `qulov2/lib/features/chat/mixins/chat_screen_mixin.dart` | Modify (lines 221-259) | Realtime callback: `ref.invalidate` kaldır, hata loglama + API fallback |
| `qulov2/lib/features/chat/widgets/chat_question_message.dart` | Modify (lines 44-53) | `_refreshQuestion` sadeleştir |
| Supabase SQL Editor | Migration | `REPLICA IDENTITY FULL` ayarla |

---

### Task 1: REPLICA IDENTITY FULL Migration

**Files:**
- Execute via Supabase SQL Editor

- [ ] **Step 1: Run migration**

Supabase Dashboard → SQL Editor → New Query:

```sql
ALTER TABLE chat_questions REPLICA IDENTITY FULL;
```

Execute et. Bu sayede Supabase Realtime UPDATE event'lerinde tum kolonlar gonderilir.

- [ ] **Step 2: Verify**

Ayni SQL Editor'da dogrula:

```sql
SELECT relreplident FROM pg_class WHERE relname = 'chat_questions';
-- Sonuc: 'f' (FULL) olmali
```

---

### Task 2: Provider Yeniden Tasarimi

**Files:**
- Modify: `qulov2/lib/providers/chat_provider.dart:266-296`

- [ ] **Step 1: Replace provider definitions**

`chat_provider.dart` dosyasinda 266-296 arasi satirlari (mevcut `chatQuestionCacheProvider` + `chatQuestionProvider`) sil ve asagidaki kodla degistir:

```dart
/// Cache for chat questions fetched by ID — realtime updates write here,
/// widgets read from here via [chatQuestionProvider].
final chatQuestionCacheProvider =
    StateProvider<Map<String, ChatQuestionModel>>((ref) => {});

/// Fetch provider — cache'de yoksa API'den ceker, cache'e yazar.
final chatQuestionFetchProvider =
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

/// Cache-reactive provider — widget'lar bunu watch eder.
/// Cache guncellenince (realtime veya API) widget otomatik rebuild olur.
final chatQuestionProvider =
    Provider.autoDispose.family<AsyncValue<ChatQuestionModel?>, String>((ref, questionId) {
  final cache = ref.watch(chatQuestionCacheProvider);
  if (cache.containsKey(questionId)) {
    return AsyncValue.data(cache[questionId]);
  }
  // Cache'de yok — fetch tetikle
  final fetch = ref.watch(chatQuestionFetchProvider(questionId));
  return fetch.when(
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
    data: (_) {
      final updated = ref.read(chatQuestionCacheProvider);
      final question = updated[questionId];
      if (question == null) return const AsyncValue.loading();
      return AsyncValue.data(question);
    },
  );
});
```

- [ ] **Step 2: Verify no compile errors**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter analyze`

Expected: No issues found

- [ ] **Step 3: Commit**

```bash
git add qulov2/lib/providers/chat_provider.dart
git commit -m "refactor: make chatQuestionProvider cache-reactive for realtime updates"
```

---

### Task 3: Realtime Callback Guncellemesi

**Files:**
- Modify: `qulov2/lib/features/chat/mixins/chat_screen_mixin.dart:221-259`

- [ ] **Step 1: Replace `_subscribeQuestionUpdates` method**

`chat_screen_mixin.dart` dosyasinda `_subscribeQuestionUpdates` metodunu (221-259 arasi) asagidakiyle degistir:

```dart
  void _subscribeQuestionUpdates() {
    _questionChannel = Supabase.instance.client
        .channel('questions:${widget.matchId}')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'chat_questions',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'match_id',
            value: widget.matchId,
          ),
          callback: (payload) {
            if (_disposed) return;
            final record = payload.newRecord;
            final questionId = record['id'] as String?;
            if (questionId != null) {
              try {
                final updated = ChatQuestionModel.fromJson(record);
                // Realtime'dan gelen veriyi direkt cache'e yaz
                // chatQuestionProvider cache'i watch ettigi icin widget aninda rebuild olur
                ref.read(chatQuestionCacheProvider.notifier).update((state) {
                  final copy = Map<String, ChatQuestionModel>.from(state);
                  copy[questionId] = updated;
                  return copy;
                });
              } catch (e) {
                debugPrint('[Realtime] Question parse failed: $e');
                // Parse basarisiz — API'den taze veri cek
                ref.read(chatRepositoryProvider).getQuestion(questionId).then((result) {
                  if (_disposed) return;
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
            }
          },
        )
        .subscribe();
  }
```

- [ ] **Step 2: Verify no compile errors**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter analyze lib/features/chat/mixins/chat_screen_mixin.dart`

Expected: No issues found

- [ ] **Step 3: Commit**

```bash
git add qulov2/lib/features/chat/mixins/chat_screen_mixin.dart
git commit -m "refactor: simplify realtime callback — remove invalidate, add error logging + API fallback"
```

---

### Task 4: Refresh Metodu Sadeleştirmesi

**Files:**
- Modify: `qulov2/lib/features/chat/widgets/chat_question_message.dart:44-53`

- [ ] **Step 1: Replace `_refreshQuestion` method**

`chat_question_message.dart` dosyasinda `_refreshQuestion` metodunu (44-53 arasi) asagidakiyle degistir:

```dart
  void _refreshQuestion(WidgetRef ref) {
    // Cache'den sil + fetch provider'i invalidate et
    // Cache temizlenince chatQuestionProvider rebuild olur,
    // fetch provider invalidate edilince API'den taze veri cekilir
    ref.read(chatQuestionCacheProvider.notifier).update((state) {
      final updated = Map<String, ChatQuestionModel>.from(state);
      updated.remove(questionId);
      return updated;
    });
    ref.invalidate(chatQuestionFetchProvider(questionId));
  }
```

- [ ] **Step 2: Verify no compile errors**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter analyze lib/features/chat/widgets/chat_question_message.dart`

Expected: No issues found

- [ ] **Step 3: Commit**

```bash
git add qulov2/lib/features/chat/widgets/chat_question_message.dart
git commit -m "refactor: simplify _refreshQuestion — only clear cache, provider handles re-fetch"
```

---

### Task 5: Full Analyze + Manuel Test

- [ ] **Step 1: Full project analyze**

Run: `cd /Users/berkantcalikusu/IdeaProjects/qulo/qulov2 && flutter analyze`

Expected: No issues found

- [ ] **Step 2: Manuel test plani**

Iki cihaz/emulator ile test et:
1. Cihaz A: Soru olustur ve gonder
2. Cihaz B: Soruyu cevapla
3. **Dogrulama:** Cihaz A'da soru karti ANINDA "Cevaplandi" durumuna gecmeli (sayfa yenileme gerekmeden)
4. Cihaz B'de solve screen'den donunce soru karti guncel olmali
5. Chat'ten cikip tekrar girince tum kartlar dogru durumlarda olmali
