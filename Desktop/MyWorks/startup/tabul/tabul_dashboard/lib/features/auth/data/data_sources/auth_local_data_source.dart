import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

/// Auth local data source abstract class
abstract class AuthLocalDataSource {
  Future<void> saveToken(AuthTokenModel token);
  Future<AuthTokenModel?> getToken();
  Future<void> clearToken();
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearUser();
  Future<bool> isLoggedIn();
}

/// Auth local data source implementation
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'auth_user';

  @override
  Future<void> saveToken(AuthTokenModel token) async {
    final tokenJson = json.encode(token.toJson());
    await sharedPreferences.setString(_tokenKey, tokenJson);
  }

  @override
  Future<AuthTokenModel?> getToken() async {
    final tokenJson = sharedPreferences.getString(_tokenKey);
    if (tokenJson != null) {
      final tokenMap = json.decode(tokenJson) as Map<String, dynamic>;
      return AuthTokenModel.fromJson(tokenMap);
    }
    return null;
  }

  @override
  Future<void> clearToken() async {
    await sharedPreferences.remove(_tokenKey);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final userJson = json.encode(user.toJson());
    await sharedPreferences.setString(_userKey, userJson);
  }

  @override
  Future<UserModel?> getUser() async {
    final userJson = sharedPreferences.getString(_userKey);
    if (userJson != null) {
      final userMap = json.decode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  @override
  Future<void> clearUser() async {
    await sharedPreferences.remove(_userKey);
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}
