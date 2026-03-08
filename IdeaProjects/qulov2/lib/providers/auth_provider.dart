import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/error/error_manager.dart';
import '../core/network/result.dart';
import '../core/services/revenuecat_service.dart';
import '../data/models/auth_model.dart';
import 'api_provider.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final String? userId;
  final bool isLoading;
  final AppFailure? failure;

  const AuthState({
    this.status = AuthStatus.initial,
    this.userId,
    this.isLoading = false,
    this.failure,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? userId,
    bool? isLoading,
    AppFailure? failure,
  }) {
    return AuthState(
      status: status ?? this.status,
      userId: userId ?? this.userId,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  final _storage = const FlutterSecureStorage();

  @override
  AuthState build() {
    _checkAuth();
    return const AuthState();
  }

  Future<void> _checkAuth() async {
    try {
      final token = await _storage.read(key: 'access_token');
      final userId = await _storage.read(key: 'user_id');
      if (token != null && userId != null) {
        ErrorManager.setUser(userId);
        state = state.copyWith(status: AuthStatus.authenticated, userId: userId);
      } else {
        state = state.copyWith(status: AuthStatus.unauthenticated);
      }
    } catch (_) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }

  Future<Result<RegisterResponse>> register({
    required String email,
    required String password,
    required String name,
    required String surname,
    required int age,
    required String gender,
    double? lat,
    double? lng,
    String locale = 'tr',
  }) async {
    state = state.copyWith(isLoading: true, failure: null);
    final result = await ref.read(authRepositoryProvider).register(
      email: email,
      password: password,
      name: name,
      surname: surname,
      age: age,
      gender: gender,
      lat: lat,
      lng: lng,
      locale: locale,
    );
    result.when(
      success: (_) => state = state.copyWith(isLoading: false),
      failure: (f) => state = state.copyWith(isLoading: false, failure: f),
    );
    return result;
  }

  Future<Result<AuthTokens>> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, failure: null);
    final result = await ref.read(authRepositoryProvider).login(
      email: email,
      password: password,
    );
    switch (result) {
      case Success(:final data):
        await _saveTokens(data);
        ErrorManager.setUser(data.userId);
        try {
          await RevenueCatService.init(data.userId);
          await RevenueCatService.logIn(data.userId);
        } catch (_) {
          // RevenueCat init failure shouldn't block login
        }
        state = state.copyWith(
          status: AuthStatus.authenticated,
          userId: data.userId,
          isLoading: false,
        );
      case Failure(:final failure):
        state = state.copyWith(isLoading: false, failure: failure);
    }
    return result;
  }

  Future<void> logout() async {
    try {
      final refreshToken = await _storage.read(key: 'refresh_token');
      await ref.read(authRepositoryProvider).logout(refreshToken: refreshToken);
    } catch (_) {
      // API call may fail (expired token etc.) — still clear local state
    }
    try {
      await RevenueCatService.logOut();
    } catch (_) {
      // RevenueCat logout failure shouldn't block logout
    }
    await _clearTokens();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  Future<Result<void>> forgotPassword(String email) async {
    return ref.read(authRepositoryProvider).forgotPassword(email);
  }

  Future<Result<void>> resetPassword({
    required String token,
    required String password,
  }) async {
    return ref.read(authRepositoryProvider).resetPassword(
      token: token,
      password: password,
    );
  }

  Future<void> _saveTokens(AuthTokens tokens) async {
    await Future.wait([
      _storage.write(key: 'access_token', value: tokens.accessToken),
      _storage.write(key: 'refresh_token', value: tokens.refreshToken),
      _storage.write(key: 'user_id', value: tokens.userId),
    ]);
  }

  Future<void> _clearTokens() async {
    await _storage.deleteAll();
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
