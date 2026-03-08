import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  // Background handler — required to be top-level
}

class NotificationManager {
  NotificationManager._();
  static final NotificationManager instance = NotificationManager._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  String? _token;
  String? get token => _token;

  Future<void> init() async {
    // Register background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

    // Request permission (iOS + Android 13+)
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get token
    _token = await _messaging.getToken();

    // Listen for token refresh
    _messaging.onTokenRefresh.listen((newToken) {
      _token = newToken;
      _onTokenRefresh?.call(newToken);
    });
  }

  // Callbacks set by provider layer
  void Function(String token)? _onTokenRefresh;
  void Function(RemoteMessage message)? _onForegroundMessage;
  void Function(RemoteMessage message)? _onMessageOpenedApp;

  void setCallbacks({
    void Function(String token)? onTokenRefresh,
    void Function(RemoteMessage message)? onForegroundMessage,
    void Function(RemoteMessage message)? onMessageOpenedApp,
  }) {
    _onTokenRefresh = onTokenRefresh;
    _onForegroundMessage = onForegroundMessage;
    _onMessageOpenedApp = onMessageOpenedApp;

    // Foreground message listener
    FirebaseMessaging.onMessage.listen((message) {
      _onForegroundMessage?.call(message);
    });

    // Tap from background state
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _onMessageOpenedApp?.call(message);
    });
  }

  /// Get the notification that launched the app from terminated state (one-time)
  Future<RemoteMessage?> getInitialMessage() {
    return _messaging.getInitialMessage();
  }
}
