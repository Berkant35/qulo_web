import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../routing/app_router.dart';
import 'navigation_service.dart';
import 'observers/logging_observer.dart';

final navigationServiceProvider = Provider<NavigationService>((ref) {
  final router = ref.read(routerProvider);
  return NavigationService(
    router: router,
    rootNavigatorKey: rootNavigatorKey,
    observers: [LoggingObserver()],
  );
});
