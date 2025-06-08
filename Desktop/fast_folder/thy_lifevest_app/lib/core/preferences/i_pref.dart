import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';

part 'auth_pref.dart';
part 'ble_pref.dart';

sealed class IPref {
  static SharedPreferences? _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  SharedPreferences get sharedPreferences {
    if (_sharedPreferences == null) {
      throw StateError('SharedPreferences not initialized. Call init() first.');
    }
    return _sharedPreferences!;
  }

  /// Returns the value of the preference with the given [key].
  /// If the key does not exist, returns null.
  Future<dynamic> _get(String key) async {
    if (sharedPreferences.containsKey(key)) {
      return sharedPreferences.get(key);
    }
    return null;
  }

  /// Sets the value of the preference with the given [key].
  Future<void> _set(String key, dynamic value) async {
    if (value is String) {
      await sharedPreferences.setString(key, value);
    } else if (value is int) {
      await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      await sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      await sharedPreferences.setBool(key, value);
    } else if (value is List<String>) {
      await sharedPreferences.setStringList(key, value);
    } else {
      throw ArgumentError('Unsupported type: ${value.runtimeType}');
    }
  }

  /// Removes the preference with the given [key].
  Future<void> _remove(String key) async {
    if (sharedPreferences.containsKey(key)) {
      await sharedPreferences.remove(key);
    }
  }

  /// Clears all preferences.
  Future<void> _clear() async {
    await sharedPreferences.clear();
  }
}
