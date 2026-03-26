# Notification Preferences — Design Spec

## Amaç
Kullanıcıların bildirim kategorilerini ayrı ayrı açıp kapatabilmesi. Kapatılan kategoriler push ve in-app banner almaz, ancak inbox'ta görünmeye devam eder.

## Kararlar

| Karar | Seçim |
|-------|-------|
| Etki alanı | Sadece push + in-app banner kapanır, inbox'a yazılmaya devam eder |
| Sistem bildirimleri | Kapatılamaz (her zaman gönderilir) |
| Veri saklama | Server-side, `users.notification_preferences` JSONB kolonu |
| Default | Tüm kategoriler açık (`true`) |

## Bildirim Kategorileri

| Kategori key | Toggle Başlığı | İçerdiği tipler | Kapatılabilir |
|-------------|----------------|-----------------|:---:|
| `messages` | Mesajlar | `new_message`, `new_message_image` | Evet |
| `matches` | Eşleşmeler | `new_match`, `new_match_solver`, `chat_question_answered` | Evet |
| `campaigns` | Kampanyalar | `campaign` | Evet |
| *(sistem)* | — | `passport_expired` | Hayır |

## 1. Veritabanı

### Migration
```sql
ALTER TABLE users
ADD COLUMN notification_preferences JSONB
DEFAULT '{"messages": true, "matches": true, "campaigns": true}'::jsonb;
```

Mevcut kullanıcılar default değeri alır. `NULL` durumunda server tarafında da default olarak hepsi açık kabul edilir.

## 2. Server API

### Endpoint'ler
```
GET   /api/v1/users/notification-preferences
PATCH /api/v1/users/notification-preferences
```

Her ikisi de auth middleware gerektirir.

### GET Response
```json
{ "messages": true, "matches": true, "campaigns": true }
```

`NULL` veya eksik alan durumunda default `true` döner.

### PATCH Request (partial update)
```json
{ "campaigns": false }
```

Sadece gönderilen alanlar güncellenir, diğerleri korunur. Validation: sadece `messages`, `matches`, `campaigns` key'leri kabul edilir, değerler boolean olmalı.

### PATCH Response
```json
{ "messages": true, "matches": true, "campaigns": false }
```

Güncel tüm tercihler döner.

## 3. Server Push Kontrolü

`notification.service.ts` → `sendPush()` içinde, FCM göndermeden önce:

### Tip → Kategori Mapping
```typescript
const TYPE_TO_CATEGORY: Record<string, string> = {
  new_message: 'messages',
  new_message_image: 'messages',
  new_match: 'matches',
  new_match_solver: 'matches',
  chat_question_answered: 'matches',
  campaign: 'campaigns',
};
// passport_expired → map'te yok → her zaman gönder
```

### Akış
1. Kullanıcının `push_token`, `locale` ve `notification_preferences` bilgisi çekilir (mevcut sorguya bir alan eklenir)
2. Bildirim tipi `TYPE_TO_CATEGORY`'den kategori bulunur
3. Kategori bulunamazsa (sistem bildirimi) → her zaman DB'ye yaz + FCM gönder
4. Kategori bulunursa → DB'ye her zaman yaz (inbox), tercih `false` ise FCM gönderme
5. Tercih `true` veya `notification_preferences` NULL ise → FCM gönder

## 4. Flutter — Model

### `NotificationPreferencesModel`
Dosya: `lib/data/models/notification_preferences_model.dart`

```dart
class NotificationPreferencesModel {
  final bool messages;    // default: true
  final bool matches;     // default: true
  final bool campaigns;   // default: true

  factory fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
```

## 5. Flutter — State Yönetimi

### Provider: `notification_preferences_provider.dart`

**State:**
```dart
class NotificationPreferencesState {
  final NotificationPreferencesModel preferences;
  final bool isLoading;
}
```

**Notifier metotları:**
- `fetch()` — GET endpoint'ini çağırır, settings ekranı açılınca tetiklenir
- `update(String category, bool value)` — Optimistic update: önce UI güncellenir, PATCH çağrılır, hata olursa geri alınır + snackbar gösterilir

### Retrofit Service Eklentisi
`notification_service.dart`'a 2 yeni method:
```dart
@GET('/users/notification-preferences')
Future<dynamic> getNotificationPreferences();

@PATCH('/users/notification-preferences')
Future<dynamic> updateNotificationPreferences(@Body() Map<String, dynamic> body);
```

### Repository
`notification_repository.dart`'a 2 yeni method, `Result<T>` wrapper ile.

## 6. Flutter — UI

### Settings Ekranı Değişikliği
`settings_screen.dart` → Dil ve Tema tile'larının altına yeni tile:
- Icon: `Icons.notifications_outlined`
- Başlık: lokalize "Bildirim Ayarları"
- Trailing: chevron (`>`)
- Tıklanınca: `/settings/notifications` route'una git

### Bildirim Ayarları Ekranı
Dosya: `lib/features/settings/screens/notification_settings_screen.dart`
Route: `/settings/notifications`

**Yapı:**
1. AppBar: "Bildirim Ayarları"
2. Açıklama metni (küçük, `onSurfaceVariant` renk): "Kapatılan bildirimler gelen kutunuzda görünmeye devam eder"
3. Toggle'lar (mevcut settings tile stiliyle uyumlu `SwitchListTile`):
   - **Mesajlar** — subtitle: "Yeni mesaj bildirimleri"
   - **Eşleşmeler** — subtitle: "Eşleşme ve soru cevap bildirimleri"
   - **Kampanyalar** — subtitle: "Promosyon ve kampanya bildirimleri"

**Davranış:**
- Ekran açılınca `fetch()` çağrılır
- Toggle tıklanınca optimistic update → PATCH → hata durumunda rollback + snackbar
- Loading state'te toggle'lar disabled

### Widget Dosyası
`lib/features/settings/widgets/notification_preference_tile.dart` — reusable SwitchListTile wrapper, mevcut tile stiline uygun.

## 7. Lokalizasyon

### Yeni Key'ler

**TR (`tr.json`):**
```json
{
  "settings": {
    "notification_settings": "Bildirim Ayarları",
    "notification_settings_desc": "Kapatılan bildirimler gelen kutunuzda görünmeye devam eder",
    "notif_messages": "Mesajlar",
    "notif_messages_desc": "Yeni mesaj bildirimleri",
    "notif_matches": "Eşleşmeler",
    "notif_matches_desc": "Eşleşme ve soru cevap bildirimleri",
    "notif_campaigns": "Kampanyalar",
    "notif_campaigns_desc": "Promosyon ve kampanya bildirimleri"
  }
}
```

**EN (`en.json`):** Aynı key'lerin İngilizce karşılıkları.

## Dosya Değişiklik Özeti

### Server (qulo-server)
| Dosya | Değişiklik |
|-------|-----------|
| `migrations/` | Yeni migration: `notification_preferences` JSONB kolonu |
| `routes/user.routes.ts` | 2 yeni endpoint (GET + PATCH preferences) |
| `controllers/user.controller.ts` | 2 yeni handler |
| `services/user.service.ts` | `getPreferences()`, `updatePreferences()` metotları |
| `services/notification.service.ts` | `sendPush()` içinde tercih kontrolü eklenir |

### Flutter (qulov2)
| Dosya | Değişiklik |
|-------|-----------|
| `data/models/notification_preferences_model.dart` | Yeni model |
| `core/network/services/notification_service.dart` | 2 yeni Retrofit method |
| `data/repositories/notification_repository.dart` | 2 yeni repository method |
| `providers/notification_preferences_provider.dart` | Yeni provider + notifier |
| `features/settings/screens/settings_screen.dart` | Yeni tile eklenir |
| `features/settings/screens/notification_settings_screen.dart` | Yeni ekran |
| `features/settings/widgets/notification_preference_tile.dart` | Yeni widget |
| `core/router/` | Yeni route tanımı |
| `locales/tr.json`, `locales/en.json` | Yeni key'ler |
