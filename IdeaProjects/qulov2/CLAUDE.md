# Qulo V2 - Dating App

## Project Structure
- **Mobile**: Flutter + Riverpod + GoRouter (lib/)
- **Backend**: Node.js + Express + TypeScript (server/)
- **DB**: Supabase PostgreSQL + PostGIS + Realtime
- **Auth**: Custom JWT (bcrypt + access/refresh tokens)
- **Firebase**: FCM (push), Crashlytics, Analytics

## Key Directories
- `lib/features/` — Feature-based Flutter modules (auth, discover, chat, profile, etc.)
- `lib/providers/` — Riverpod providers
- `lib/routing/` — GoRouter configuration
- `lib/core/` — Shared utilities, error handling, l10n
- `lib/core/navigation/` — NavigationService, observers, dialog/sheet models
- `lib/data/` — Models, repositories, API layer
- `server/src/routes/` — Express route modules
- `server/src/services/` — Business logic
- `server/src/middleware/` — Auth, rate limiting, validation

## Development Commands
- **Backend dev**: `cd server && npm run dev` (tsx watch)
- **Backend build**: `cd server && npm run build`
- **Flutter run**: `flutter run`
- **Flutter analyze**: `flutter analyze`
- **Tests**: `cd server && npm test` (vitest)

## Conventions
- Language: Turkish for communication, English for code
- Backend uses ESM (`"type": "module"`)
- Supabase uses service_role (RLS disabled)
- i18n: Custom AppLocalizations (lib/core/l10n/)
- State management: Riverpod (Notifier pattern)
- Routing: GoRouter with named routes, wrapped by NavigationService
- Navigation: Always use `ref.read(navigationServiceProvider)` — never direct GoRouter/Navigator calls in screens
- Dialogs: Use `ConfirmDialog`, `InfoDialog`, or `CustomDialog` via `NavigationService.showAppDialog()`
- BottomSheets: Use `ListBottomSheet` or `CustomBottomSheet` via `NavigationService.showAppBottomSheet()`
- API base URL configured via environment

## Design & Component Rules
- UI bileşenleri her zaman ortak komponent olarak yazılmalı (lib/core/widgets/)
- Tüm renkler, text style'lar, spacing'ler theme dosyasından gelmeli — hardcoded değer kullanma
- Hata mesajları inline gösterilmeli (input altında kırmızı yazı)
- Tasarımsal değişikliklerde önce theme'i güncelle, sonra widget'ı yaz
- Yeni widget = önce lib/core/widgets/'a ortak komponent, sonra feature'da kullan

## Important Notes
- Never commit .env files
- Supabase migrations run manually via SQL Editor
- Firebase config files are in the repo (firebase_options.dart, google-services.json, GoogleService-Info.plist)
