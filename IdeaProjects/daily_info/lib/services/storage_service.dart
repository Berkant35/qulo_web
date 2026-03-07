import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/app_constants.dart';

/// Simple storage service - SharedPreferences wrapper
class StorageService {
  static SharedPreferences? _prefs;

  /// Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save notification status
  static Future<void> setNotificationEnabled(bool enabled) async {
    await _prefs?.setBool(AppConstants.notificationEnabledKey, enabled);
  }

  /// Read notification status
  static bool getNotificationEnabled() {
    return _prefs?.getBool(AppConstants.notificationEnabledKey) ?? true;
  }

  /// Save FCM token
  static Future<void> setFcmToken(String token) async {
    await _prefs?.setString(AppConstants.fcmTokenKey, token);
  }

  /// Read FCM token
  static String? getFcmToken() {
    return _prefs?.getString(AppConstants.fcmTokenKey);
  }
}
