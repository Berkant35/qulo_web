import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// Firebase Analytics service for tracking user events
class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver? _observer;

  /// Get analytics observer for navigation tracking
  static FirebaseAnalyticsObserver get observer {
    _observer ??= FirebaseAnalyticsObserver(analytics: _analytics);
    return _observer!;
  }

  /// Log app open event
  static Future<void> logAppOpen() async {
    try {
      await _analytics.logAppOpen();
      if (kDebugMode) {
        print('Analytics: App opened');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Analytics error: $e');
      }
    }
  }

  /// Log notification toggle event
  static Future<void> logNotificationToggle(bool enabled) async {
    try {
      await _analytics.logEvent(
        name: 'notification_toggle',
        parameters: {
          'enabled': enabled,
        },
      );
      if (kDebugMode) {
        print('Analytics: Notification toggled - $enabled');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Analytics error: $e');
      }
    }
  }

  /// Log screen view
  static Future<void> logScreenView(String screenName) async {
    try {
      await _analytics.logScreenView(screenName: screenName);
      if (kDebugMode) {
        print('Analytics: Screen view - $screenName');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Analytics error: $e');
      }
    }
  }

  /// Set user property
  static Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
    } catch (e) {
      if (kDebugMode) {
        print('Analytics error: $e');
      }
    }
  }
}

