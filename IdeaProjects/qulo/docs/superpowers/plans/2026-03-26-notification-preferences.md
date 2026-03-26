# Notification Preferences Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Kullanıcıların bildirim kategorilerini (mesajlar, eşleşmeler, kampanyalar) settings ekranından açıp kapatabilmesi. Kapatılan kategori push+banner almaz, inbox'a yazılmaya devam eder. Sistem bildirimleri kapatılamaz.

**Architecture:** Server-side JSONB kolonu (`users.notification_preferences`) + 2 API endpoint (GET/PATCH) + Flutter provider + settings alt sayfası. `sendPush()` FCM göndermeden önce tercihi kontrol eder.

**Tech Stack:** Node.js/Express/TypeScript (server), Supabase PostgreSQL (DB), Flutter/Riverpod/Retrofit (mobile), Zod (validation)

---

## File Structure

### Server (qulo-server)
| File | Action | Responsibility |
|------|--------|---------------|
| `supabase/migrations/008_notification_preferences.sql` | Create | DB migration: JSONB kolonu |
| `src/validators/user.validator.ts` | Modify | Zod schema: notificationPreferencesSchema |
| `src/services/user.service.ts` | Modify | `getNotificationPreferences()`, `updateNotificationPreferences()` |
| `src/controllers/user.controller.ts` | Modify | 2 yeni handler |
| `src/routes/user.routes.ts` | Modify | 2 yeni route |
| `src/services/notification.service.ts` | Modify | `sendPush()` tercih kontrolü |

### Flutter (qulov2)
| File | Action | Responsibility |
|------|--------|---------------|
| `lib/data/models/notification_preferences_model.dart` | Create | JSONB model |
| `lib/core/network/services/user_service.dart` | Modify | 2 Retrofit method |
| `lib/data/repositories/user_repository.dart` | Modify | 2 repository method |
| `lib/providers/notification_preferences_provider.dart` | Create | State + Notifier |
| `lib/features/settings/widgets/notification_preference_tile.dart` | Create | Reusable SwitchListTile |
| `lib/features/settings/screens/notification_settings_screen.dart` | Create | Alt sayfa UI |
| `lib/routing/route_names.dart` | Modify | Yeni route name |
| `lib/routing/app_routes.dart` | Modify | Yeni GoRoute |
| `lib/features/settings/screens/settings_screen.dart` | Modify | Yeni tile ekleme |
| `lib/core/l10n/translations/tr.dart` | Modify | Türkçe çeviri key'leri |
| `lib/core/l10n/translations/en.dart` | Modify | İngilizce çeviri key'leri |

---

## Task 1: DB Migration

**Files:**
- Create: `qulo-server/supabase/migrations/008_notification_preferences.sql`

- [ ] **Step 1: Migration dosyası oluştur**

```sql
-- 008_notification_preferences.sql
-- Bildirim tercihleri: mesajlar, eşleşmeler, kampanyalar
ALTER TABLE users
ADD COLUMN IF NOT EXISTS notification_preferences JSONB
DEFAULT '{"messages": true, "matches": true, "campaigns": true}'::jsonb;

COMMENT ON COLUMN users.notification_preferences IS 'Push notification preferences per category. NULL = all enabled.';
```

- [ ] **Step 2: Migration'ı Supabase SQL Editor'da çalıştır**

Supabase Dashboard → SQL Editor → yukarıdaki SQL'i yapıştır ve çalıştır.
Expected: `ALTER TABLE` başarılı, mevcut kullanıcılar default değeri alır.

- [ ] **Step 3: Doğrula**

```sql
SELECT id, notification_preferences FROM users LIMIT 3;
```

Expected: Her satırda `{"messages": true, "matches": true, "campaigns": true}` görünür.

- [ ] **Step 4: Commit**

```bash
cd qulo-server
git add supabase/migrations/008_notification_preferences.sql
git commit -m "feat(db): add notification_preferences JSONB column to users"
```

---

## Task 2: Server — Validator + Service

**Files:**
- Modify: `qulo-server/src/validators/user.validator.ts` (line ~51 sonrası)
- Modify: `qulo-server/src/services/user.service.ts` (dosya sonuna)

- [ ] **Step 1: Zod schema ekle**

`qulo-server/src/validators/user.validator.ts` dosyasının sonuna ekle:

```typescript
export const notificationPreferencesSchema = z.object({
  messages: z.boolean().optional(),
  matches: z.boolean().optional(),
  campaigns: z.boolean().optional(),
}).refine(
  (data) => Object.keys(data).length > 0,
  { message: 'At least one preference must be provided' },
);

export type NotificationPreferencesInput = z.infer<typeof notificationPreferencesSchema>;
```

- [ ] **Step 2: Service metotları ekle**

`qulo-server/src/services/user.service.ts` → `UserService` class'ının sonuna (son `}` öncesine) ekle:

```typescript
  private static readonly DEFAULT_NOTIFICATION_PREFERENCES = {
    messages: true,
    matches: true,
    campaigns: true,
  };

  async getNotificationPreferences(userId: string) {
    const { data, error } = await supabase
      .from('users')
      .select('notification_preferences')
      .eq('id', userId)
      .single();

    if (error || !data) {
      throw Errors.USER_NOT_FOUND();
    }

    return {
      ...UserService.DEFAULT_NOTIFICATION_PREFERENCES,
      ...(data.notification_preferences ?? {}),
    };
  }

  async updateNotificationPreferences(
    userId: string,
    input: { messages?: boolean; matches?: boolean; campaigns?: boolean },
  ) {
    // Merge with existing preferences
    const current = await this.getNotificationPreferences(userId);
    const merged = { ...current, ...input };

    const { error } = await supabase
      .from('users')
      .update({ notification_preferences: merged })
      .eq('id', userId);

    if (error) {
      throw Errors.USER_NOT_FOUND();
    }

    return merged;
  }
```

- [ ] **Step 3: Doğrula — TypeScript compile**

```bash
cd qulo-server && npx tsc --noEmit
```

Expected: Hata yok.

- [ ] **Step 4: Commit**

```bash
git add src/validators/user.validator.ts src/services/user.service.ts
git commit -m "feat(server): add notification preferences service + validator"
```

---

## Task 3: Server — Controller + Routes

**Files:**
- Modify: `qulo-server/src/controllers/user.controller.ts` (line 129 öncesine)
- Modify: `qulo-server/src/routes/user.routes.ts` (line 77 öncesine, `/:id/profile` öncesine)

- [ ] **Step 1: Controller handler'ları ekle**

`qulo-server/src/controllers/user.controller.ts` → import'a `NotificationPreferencesInput` ekle (line 8):

```typescript
import type {
  UpdateProfileInput,
  UpdateDetailsInput,
  UpdateLocationInput,
  UpdatePushTokenInput,
  NotificationPreferencesInput,
} from "../validators/user.validator.js";
```

Dosyanın sonuna (`deleteAccountHandler` sonrasına) ekle:

```typescript
export async function getNotificationPreferencesHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const result = await userService.getNotificationPreferences(req.user!.userId);
    res.json(result);
  } catch (err) {
    next(err);
  }
}

export async function updateNotificationPreferencesHandler(req: Request, res: Response, next: NextFunction) {
  try {
    const data = req.body as NotificationPreferencesInput;
    const result = await userService.updateNotificationPreferences(req.user!.userId, data);
    res.json(result);
  } catch (err) {
    next(err);
  }
}
```

- [ ] **Step 2: Routes ekle**

`qulo-server/src/routes/user.routes.ts` → import'a ekle:

```typescript
import {
  getMeHandler,
  updateProfileHandler,
  updateDetailsHandler,
  updateLocationHandler,
  updatePushTokenHandler,
  uploadPhotoHandler,
  deletePhotoHandler,
  boostHandler,
  claimBadgeRewardHandler,
  getPublicProfileHandler,
  deleteAccountHandler,
  getNotificationPreferencesHandler,
  updateNotificationPreferencesHandler,
} from "../controllers/user.controller.js";
```

Validator import'una ekle:

```typescript
import {
  updateProfileSchema,
  updateDetailsSchema,
  updateLocationSchema,
  updatePushTokenSchema,
  notificationPreferencesSchema,
} from "../validators/user.validator.js";
```

`router.delete("/me/photos/:index", deletePhotoHandler);` satırından sonra (line 54 sonrası), languages bölümünden önce ekle:

```typescript
router.get("/me/notification-preferences", getNotificationPreferencesHandler);
router.patch("/me/notification-preferences", validate(notificationPreferencesSchema), updateNotificationPreferencesHandler);
```

- [ ] **Step 3: Doğrula — TypeScript compile**

```bash
cd qulo-server && npx tsc --noEmit
```

Expected: Hata yok.

- [ ] **Step 4: Doğrula — Server başlat**

```bash
cd qulo-server && npm run dev
```

Expected: Server hatasız başlar.

- [ ] **Step 5: Commit**

```bash
git add src/controllers/user.controller.ts src/routes/user.routes.ts
git commit -m "feat(server): add notification preferences API endpoints"
```

---

## Task 4: Server — Push Preference Check

**Files:**
- Modify: `qulo-server/src/services/notification.service.ts`

- [ ] **Step 1: Type-to-category mapping ekle**

`notification.service.ts` → `ACTION_URL_MAP` tanımından sonra (line 18 sonrası) ekle:

```typescript
const TYPE_TO_CATEGORY: Partial<Record<PushType, string>> = {
  new_message: 'messages',
  new_message_image: 'messages',
  new_match: 'matches',
  new_match_solver: 'matches',
  chat_question_answered: 'matches',
  campaign: 'campaigns',
};
```

- [ ] **Step 2: sendPush() sorgusuna notification_preferences ekle**

`sendPush()` içindeki Supabase sorgusunu (line 64-68) güncelle:

```typescript
      const { data: user, error } = await supabase
        .from('users')
        .select('push_token, locale, notification_preferences')
        .eq('id', userId)
        .single();
```

- [ ] **Step 3: FCM göndermeden önce tercih kontrolü ekle**

DB'ye yazma (line 107-120) ile FCM gönderme (line 122) arasına, yani `const { data: notification }` bloğundan sonra, `if (!user.push_token)` kontrolünden önce ekle:

```typescript
      // Check notification preferences — if category disabled, skip push but keep DB record
      const category = TYPE_TO_CATEGORY[type];
      if (category) {
        const prefs = user.notification_preferences as Record<string, boolean> | null;
        const enabled = prefs?.[category] ?? true; // NULL = all enabled
        if (!enabled) {
          console.log(`[NotificationService] Push suppressed: user=${userId} disabled category=${category} (type=${type})`);
          return false;
        }
      }
      // System notifications (no category mapping) always send push
```

- [ ] **Step 4: Doğrula — TypeScript compile**

```bash
cd qulo-server && npx tsc --noEmit
```

Expected: Hata yok.

- [ ] **Step 5: Commit**

```bash
git add src/services/notification.service.ts
git commit -m "feat(server): check notification preferences before sending FCM push"
```

---

## Task 5: Flutter — Model

**Files:**
- Create: `qulov2/lib/data/models/notification_preferences_model.dart`

- [ ] **Step 1: Model oluştur**

```dart
import 'package:equatable/equatable.dart';

class NotificationPreferencesModel extends Equatable {
  final bool messages;
  final bool matches;
  final bool campaigns;

  const NotificationPreferencesModel({
    this.messages = true,
    this.matches = true,
    this.campaigns = true,
  });

  factory NotificationPreferencesModel.fromJson(Map<String, dynamic> json) {
    return NotificationPreferencesModel(
      messages: json['messages'] as bool? ?? true,
      matches: json['matches'] as bool? ?? true,
      campaigns: json['campaigns'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() => {
        'messages': messages,
        'matches': matches,
        'campaigns': campaigns,
      };

  NotificationPreferencesModel copyWith({
    bool? messages,
    bool? matches,
    bool? campaigns,
  }) {
    return NotificationPreferencesModel(
      messages: messages ?? this.messages,
      matches: matches ?? this.matches,
      campaigns: campaigns ?? this.campaigns,
    );
  }

  @override
  List<Object?> get props => [messages, matches, campaigns];
}
```

- [ ] **Step 2: Commit**

```bash
cd qulov2
git add lib/data/models/notification_preferences_model.dart
git commit -m "feat(flutter): add NotificationPreferencesModel"
```

---

## Task 6: Flutter — Retrofit Service + Repository

**Files:**
- Modify: `qulov2/lib/core/network/services/user_service.dart` (line 33 öncesine)
- Modify: `qulov2/lib/data/repositories/user_repository.dart`

- [ ] **Step 1: Retrofit service'e 2 method ekle**

`qulov2/lib/core/network/services/user_service.dart` → son `}` öncesine ekle:

```dart
  @GET('/users/me/notification-preferences')
  Future<dynamic> getNotificationPreferences();

  @PATCH('/users/me/notification-preferences')
  Future<dynamic> updateNotificationPreferences(
    @Body() Map<String, dynamic> body,
  );
```

- [ ] **Step 2: Retrofit code generation çalıştır**

```bash
cd qulov2 && dart run build_runner build --delete-conflicting-outputs
```

Expected: `user_service.g.dart` yeniden üretilir, hata yok.

- [ ] **Step 3: Repository'ye 2 method ekle**

`qulov2/lib/data/repositories/user_repository.dart` dosyasına import ekle:

```dart
import 'package:qulo_v2/data/models/notification_preferences_model.dart';
```

Class'ın sonuna ekle:

```dart
  Future<Result<NotificationPreferencesModel>> getNotificationPreferences() async {
    try {
      final response = await _service.getNotificationPreferences();
      final model = NotificationPreferencesModel.fromJson(
        response as Map<String, dynamic>,
      );
      return Success(model);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }

  Future<Result<NotificationPreferencesModel>> updateNotificationPreferences(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await _service.updateNotificationPreferences(body);
      final model = NotificationPreferencesModel.fromJson(
        response as Map<String, dynamic>,
      );
      return Success(model);
    } on DioException catch (e) {
      return Failure(e.toAppFailure());
    }
  }
```

Not: `user_repository.dart`'ta mevcut import'ların `Result`, `DioException`, `Success`, `Failure` içerdiğini kontrol et. Eksikse `result.dart` import'unu ekle.

- [ ] **Step 4: Doğrula**

```bash
cd qulov2 && flutter analyze
```

Expected: Hata yok.

- [ ] **Step 5: Commit**

```bash
git add lib/core/network/services/user_service.dart lib/core/network/services/user_service.g.dart lib/data/repositories/user_repository.dart
git commit -m "feat(flutter): add notification preferences API methods"
```

---

## Task 7: Flutter — Provider

**Files:**
- Create: `qulov2/lib/providers/notification_preferences_provider.dart`

- [ ] **Step 1: Provider oluştur**

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/data/models/notification_preferences_model.dart';
import 'package:qulo_v2/providers/api_provider.dart';

class NotificationPreferencesState {
  final NotificationPreferencesModel preferences;
  final bool isLoading;

  const NotificationPreferencesState({
    this.preferences = const NotificationPreferencesModel(),
    this.isLoading = false,
  });

  NotificationPreferencesState copyWith({
    NotificationPreferencesModel? preferences,
    bool? isLoading,
  }) {
    return NotificationPreferencesState(
      preferences: preferences ?? this.preferences,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class NotificationPreferencesNotifier
    extends Notifier<NotificationPreferencesState> {
  @override
  NotificationPreferencesState build() {
    return const NotificationPreferencesState();
  }

  Future<void> fetch() async {
    state = state.copyWith(isLoading: true);

    final result =
        await ref.read(userRepositoryProvider).getNotificationPreferences();

    result.when(
      success: (data) {
        state = state.copyWith(preferences: data, isLoading: false);
      },
      failure: (_) {
        state = state.copyWith(isLoading: false);
      },
    );
  }

  Future<bool> update(String category, bool value) async {
    final oldPrefs = state.preferences;

    // Optimistic update
    final newPrefs = NotificationPreferencesModel(
      messages: category == 'messages' ? value : oldPrefs.messages,
      matches: category == 'matches' ? value : oldPrefs.matches,
      campaigns: category == 'campaigns' ? value : oldPrefs.campaigns,
    );
    state = state.copyWith(preferences: newPrefs);

    final result = await ref
        .read(userRepositoryProvider)
        .updateNotificationPreferences({category: value});

    return result.when(
      success: (data) {
        state = state.copyWith(preferences: data);
        return true;
      },
      failure: (_) {
        // Rollback
        state = state.copyWith(preferences: oldPrefs);
        return false;
      },
    );
  }
}

final notificationPreferencesProvider = NotifierProvider<
    NotificationPreferencesNotifier, NotificationPreferencesState>(
  NotificationPreferencesNotifier.new,
);
```

- [ ] **Step 2: Doğrula**

```bash
cd qulov2 && flutter analyze
```

Expected: Hata yok.

- [ ] **Step 3: Commit**

```bash
git add lib/providers/notification_preferences_provider.dart
git commit -m "feat(flutter): add notification preferences provider"
```

---

## Task 8: Flutter — Localization

**Files:**
- Modify: `qulov2/lib/core/l10n/translations/tr.dart` (line 178 sonrası)
- Modify: `qulov2/lib/core/l10n/translations/en.dart` (line 178 sonrası)

- [ ] **Step 1: Türkçe key'ler ekle**

`tr.dart` → `'delete_account_desc'` satırından sonra (line 178 sonrası) ekle:

```dart
  'notification_settings': 'Bildirim Ayarları',
  'notification_settings_desc': 'Kapatılan bildirimler gelen kutunuzda görünmeye devam eder',
  'notif_messages': 'Mesajlar',
  'notif_messages_desc': 'Yeni mesaj bildirimleri',
  'notif_matches': 'Eşleşmeler',
  'notif_matches_desc': 'Eşleşme ve soru cevap bildirimleri',
  'notif_campaigns': 'Kampanyalar',
  'notif_campaigns_desc': 'Promosyon ve kampanya bildirimleri',
```

- [ ] **Step 2: İngilizce key'ler ekle**

`en.dart` → aynı yere (line 178 sonrası) ekle:

```dart
  'notification_settings': 'Notification Settings',
  'notification_settings_desc': 'Disabled notifications will still appear in your inbox',
  'notif_messages': 'Messages',
  'notif_messages_desc': 'New message notifications',
  'notif_matches': 'Matches',
  'notif_matches_desc': 'Match and question answer notifications',
  'notif_campaigns': 'Campaigns',
  'notif_campaigns_desc': 'Promotional and campaign notifications',
```

- [ ] **Step 3: Diğer diller (de, fr, es, ar, ru, pt, it, ja, ko, zh, nl, pl, sv, hi)**

Her dil dosyasına aynı key'lerin İngilizce karşılığını ekle (fallback). Daha sonra ihtiyaç oldukça çevrilebilir.

- [ ] **Step 4: Commit**

```bash
git add lib/core/l10n/translations/
git commit -m "feat(l10n): add notification preferences translations"
```

---

## Task 9: Flutter — Widget + Screen

**Files:**
- Create: `qulov2/lib/features/settings/widgets/notification_preference_tile.dart`
- Create: `qulov2/lib/features/settings/screens/notification_settings_screen.dart`

- [ ] **Step 1: Reusable tile widget oluştur**

```dart
import 'package:flutter/material.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';

class NotificationPreferenceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  const NotificationPreferenceTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    this.enabled = true,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: SwitchListTile(
        secondary: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
        title: Text(
          title,
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        subtitle: Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        value: value,
        onChanged: enabled ? (v) => onChanged(v) : null,
      ),
    );
  }
}
```

- [ ] **Step 2: Screen oluştur**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qulo_v2/core/l10n/l10n.dart';
import 'package:qulo_v2/core/theme/app_spacing.dart';
import 'package:qulo_v2/core/widgets/app_scaffold.dart';
import 'package:qulo_v2/features/settings/widgets/notification_preference_tile.dart';
import 'package:qulo_v2/providers/notification_preferences_provider.dart';

class NotificationSettingsScreen extends ConsumerStatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  ConsumerState<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends ConsumerState<NotificationSettingsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(notificationPreferencesProvider.notifier).fetch(),
    );
  }

  Future<void> _onToggle(String category, bool value) async {
    final success = await ref
        .read(notificationPreferencesProvider.notifier)
        .update(category, value);

    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.tr('error')),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = ref.watch(notificationPreferencesProvider);
    final prefs = state.preferences;

    return AppScaffold(
      title: context.tr('notification_settings'),
      isLoading: state.isLoading,
      padding: EdgeInsets.zero,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Text(
              context.tr('notification_settings_desc'),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          NotificationPreferenceTile(
            icon: Icons.chat_bubble_outline,
            title: context.tr('notif_messages'),
            subtitle: context.tr('notif_messages_desc'),
            value: prefs.messages,
            enabled: !state.isLoading,
            onChanged: (v) => _onToggle('messages', v),
          ),
          NotificationPreferenceTile(
            icon: Icons.favorite_outline,
            title: context.tr('notif_matches'),
            subtitle: context.tr('notif_matches_desc'),
            value: prefs.matches,
            enabled: !state.isLoading,
            onChanged: (v) => _onToggle('matches', v),
          ),
          NotificationPreferenceTile(
            icon: Icons.campaign_outlined,
            title: context.tr('notif_campaigns'),
            subtitle: context.tr('notif_campaigns_desc'),
            value: prefs.campaigns,
            enabled: !state.isLoading,
            onChanged: (v) => _onToggle('campaigns', v),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: Doğrula**

```bash
cd qulov2 && flutter analyze
```

Expected: Hata yok.

- [ ] **Step 4: Commit**

```bash
git add lib/features/settings/widgets/notification_preference_tile.dart lib/features/settings/screens/notification_settings_screen.dart
git commit -m "feat(flutter): add notification settings screen + tile widget"
```

---

## Task 10: Flutter — Route + Settings Integration

**Files:**
- Modify: `qulov2/lib/routing/route_names.dart` (line 30 civarı)
- Modify: `qulov2/lib/routing/app_routes.dart` (line 318 civarı, settings route sonrası)
- Modify: `qulov2/lib/features/settings/screens/settings_screen.dart` (line 52 civarı)

- [ ] **Step 1: Route name ekle**

`route_names.dart` → `static const notifications = 'notifications';` satırından sonra ekle:

```dart
  static const notificationSettings = 'notification-settings';
```

- [ ] **Step 2: GoRoute ekle**

`app_routes.dart` → settings GoRoute tanımından sonra (line 318 sonrası), notifications GoRoute'undan önce ekle:

```dart
            GoRoute(
              path: 'notification-settings',
              name: RouteNames.notificationSettings,
              builder: (context, state) => const NotificationSettingsScreen(),
            ),
```

Dosya başına import ekle:

```dart
import 'package:qulo_v2/features/settings/screens/notification_settings_screen.dart';
```

- [ ] **Step 3: Settings screen'e tile ekle**

`settings_screen.dart` → import'lara ekle:

```dart
import 'package:qulo_v2/core/navigation/navigation.dart';
import 'package:qulo_v2/routing/route_names.dart';
```

`_HapticTile()` satırından sonra (line 52 sonrası), `const SizedBox(height: AppSpacing.sm)` öncesine ekle:

```dart
          _NotificationSettingsTile(),
```

Dosyanın sonuna (son `}` sonrası) yeni widget ekle:

```dart
class _NotificationSettingsTile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: ListTile(
        leading: Icon(
          Icons.notifications_outlined,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        title: Text(
          context.tr('notification_settings'),
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        onTap: () {
          ref.read(navigationServiceProvider).push(RouteNames.notificationSettings);
        },
      ),
    );
  }
}
```

- [ ] **Step 4: Doğrula**

```bash
cd qulov2 && flutter analyze
```

Expected: Hata yok.

- [ ] **Step 5: Commit**

```bash
git add lib/routing/route_names.dart lib/routing/app_routes.dart lib/features/settings/screens/settings_screen.dart
git commit -m "feat(flutter): integrate notification settings into settings screen"
```

---

## Task 11: In-App Banner Suppression

**Files:**
- Modify: `qulov2/lib/providers/notification_provider.dart`

Bu task opsiyonel — in-app banner'ın da tercih kontrolüne tabi olması için. Şu an server push göndermezse banner zaten gelmeyecek (push tetikler). Ancak eğer local notification gösterimi ayrı yönetiliyorsa, burada da kontrol eklenebilir.

- [ ] **Step 1: Foreground message handler'da tercih kontrolü ekle**

`notification_provider.dart` → `_handleForegroundMessage` metodunda, mevcut suppression logic'ten sonra (banner göstermeden önce) ek kontrol ekle:

```dart
    // Check if notification category is disabled by user preferences
    final type = message.data['type'] as String?;
    if (type != null) {
      const typeToCategory = {
        'new_message': 'messages',
        'new_message_image': 'messages',
        'new_match': 'matches',
        'new_match_solver': 'matches',
        'chat_question_answered': 'matches',
        'campaign': 'campaigns',
      };
      final category = typeToCategory[type];
      if (category != null) {
        final prefs = ref.read(notificationPreferencesProvider).preferences;
        final enabled = switch (category) {
          'messages' => prefs.messages,
          'matches' => prefs.matches,
          'campaigns' => prefs.campaigns,
          _ => true,
        };
        if (!enabled) return; // Suppress banner
      }
    }
```

Not: Bu provider'a `notification_preferences_provider.dart` import'u eklenmelidir.

- [ ] **Step 2: Doğrula**

```bash
cd qulov2 && flutter analyze
```

Expected: Hata yok.

- [ ] **Step 3: Commit**

```bash
git add lib/providers/notification_provider.dart
git commit -m "feat(flutter): suppress in-app banner for disabled notification categories"
```

---

## Task 12: End-to-End Doğrulama

- [ ] **Step 1: Server build**

```bash
cd qulo-server && npm run build
```

Expected: Hata yok.

- [ ] **Step 2: Flutter analyze**

```bash
cd qulov2 && flutter analyze
```

Expected: Hata yok.

- [ ] **Step 3: Manuel test — API**

Server çalışırken:
```bash
# GET — default değerler
curl -H "Authorization: Bearer <token>" http://localhost:3000/api/v1/users/me/notification-preferences

# PATCH — kampanyaları kapat
curl -X PATCH -H "Authorization: Bearer <token>" -H "Content-Type: application/json" \
  -d '{"campaigns": false}' \
  http://localhost:3000/api/v1/users/me/notification-preferences
```

Expected GET: `{"messages":true,"matches":true,"campaigns":true}`
Expected PATCH: `{"messages":true,"matches":true,"campaigns":false}`

- [ ] **Step 4: Manuel test — Flutter**

1. Settings → Bildirim Ayarları tile'ına tıkla → alt sayfa açılır
2. Toggle'ları aç/kapat → anında UI değişir
3. Sayfayı kapatıp tekrar aç → değişiklik persist etmiş olmalı
4. Kapalı kategoride push gönder → inbox'ta var ama push gelmiyor

- [ ] **Step 5: Final commit (gerekirse)**

Tüm değişiklikler commit edilmişse bu adım atlanabilir.
