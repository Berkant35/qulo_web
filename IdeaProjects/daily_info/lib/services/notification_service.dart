import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'storage_service.dart';

/// Firebase Cloud Messaging service
class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Whether service is initialized
  static bool _isInitialized = false;

  /// Initialize notification service
  static Future<void> init() async {
    if (_isInitialized) return;

    if (kDebugMode) {
      print('NotificationService: Initializing...');
    }

    // Request notification permission
    await _requestPermission();

    // iOS: Enable foreground notification display
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    if (kDebugMode) {
      print('NotificationService: Foreground options set');
    }

    // Get and save FCM token
    await _getAndSaveToken();

    // Setup foreground message listener
    _setupForegroundListener();

    // Setup notification tap handler (when user taps notification)
    _setupNotificationTapHandler();

    // Setup background message handler
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

    // Subscribe to topic by default
    await _messaging.subscribeToTopic('daily_history');
    if (kDebugMode) {
      print('NotificationService: Subscribed to daily_history topic');
    }

    _isInitialized = true;
    if (kDebugMode) {
      print('NotificationService: Initialization complete');
    }
  }

  /// Request notification permission
  static Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (kDebugMode) {
      print('Notification permission status: ${settings.authorizationStatus}');
    }
  }

  /// Get FCM token and save to storage
  static Future<String?> _getAndSaveToken() async {
    try {
      // First check APNs token (iOS only)
      final apnsToken = await _messaging.getAPNSToken();
      if (kDebugMode) {
        print('APNs Token: ${apnsToken ?? "NOT AVAILABLE"}');
      }
      
      final token = await _messaging.getToken();
      if (token != null) {
        await StorageService.setFcmToken(token);
        if (kDebugMode) {
          print('FCM Token: $token');
        }
      }
      return token;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to get FCM token: $e');
      }
      return null;
    }
  }

  /// Foreground message listener
  static void _setupForegroundListener() {
    if (kDebugMode) {
      print('NotificationService: Setting up foreground listener...');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('=== FOREGROUND MESSAGE RECEIVED ===');
        print('Title: ${message.notification?.title}');
        print('Body: ${message.notification?.body}');
        print('Data: ${message.data}');
        print('Message ID: ${message.messageId}');
        print('===================================');
      }
    });

    // Token refresh listener
    _messaging.onTokenRefresh.listen((newToken) async {
      await StorageService.setFcmToken(newToken);
      if (kDebugMode) {
        print('Token refreshed: $newToken');
      }
    });

    if (kDebugMode) {
      print('NotificationService: Foreground listener ready');
    }
  }

  /// Handle notification tap (when app is in background/terminated)
  static void _setupNotificationTapHandler() {
    // When app is opened from terminated state via notification
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null && kDebugMode) {
        print('App opened from terminated state via notification: ${message.notification?.title}');
      }
    });

    // When app is in background and notification is tapped
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('App opened from background via notification: ${message.notification?.title}');
      }
    });
  }

  /// Subscribe/unsubscribe from notifications
  static Future<void> toggleNotifications(bool enabled) async {
    await StorageService.setNotificationEnabled(enabled);

    if (enabled) {
      // Enable notifications - subscribe to topic
      await _messaging.subscribeToTopic('daily_history');
      if (kDebugMode) {
        print('Notifications enabled');
      }
    } else {
      // Disable notifications - unsubscribe from topic
      await _messaging.unsubscribeFromTopic('daily_history');
      if (kDebugMode) {
        print('Notifications disabled');
      }
    }
  }

  /// Check notification status
  static bool isNotificationEnabled() {
    return StorageService.getNotificationEnabled();
  }
}

/// Background message handler - must be top-level function
@pragma('vm:entry-point')
Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  // Simple background processing
  if (kDebugMode) {
    print('Background message received: ${message.notification?.title}');
  }
}
