import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../features/splash/splash_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/auth/screens/forgot_password_screen.dart';
import '../features/onboarding/screens/onboarding_screen.dart';
import '../features/discover/screens/discover_screen.dart';
import '../features/quiz/screens/quiz_screen.dart';
import '../features/chat/screens/matches_screen.dart';
import '../features/chat/screens/chat_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/profile/screens/questions_screen.dart';
import '../features/diamonds/screens/diamonds_screen.dart';
import '../features/passport/screens/passport_screen.dart';
import '../features/settings/screens/settings_screen.dart';
import 'route_names.dart';
import '../core/widgets/q_icon.dart';
import '../core/constants/q_icons.dart';

part 'app_routes.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class _AuthNotifierListenable extends ChangeNotifier {
  _AuthNotifierListenable(Ref ref) {
    ref.listen<AuthState>(authProvider, (_, __) => notifyListeners());
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final listenable = _AuthNotifierListenable(ref);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: listenable,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isAuth = authState.status == AuthStatus.authenticated;
      final isAuthRoute = state.matchedLocation.startsWith('/auth');
      final isSplash = state.matchedLocation == '/';

      if (authState.status == AuthStatus.initial) return null;

      if (!isAuth && !isAuthRoute) return '/auth/login';
      if (isAuth && (isAuthRoute || isSplash)) return '/discover';

      return null;
    },
    routes: _routes,
  );
});
