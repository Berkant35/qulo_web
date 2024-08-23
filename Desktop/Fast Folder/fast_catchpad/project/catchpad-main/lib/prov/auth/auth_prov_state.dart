import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_prov_state.freezed.dart';

// https://zenn.dev/kingu/scraps/5216f812efc4e7
@freezed
class AuthProvState with _$AuthProvState {
  factory AuthProvState({
    @Default(AsyncValue<User?>.loading()) AsyncValue<User?> firebaseUser,
  }) = _AuthProvState;

  AuthProvState._();

  bool get isLoggedIn => firebaseUser.value != null;

  bool get isAdmin => isLoggedIn;

  late final AuthState authState = firebaseUser.when(
    data: (_) {
      if (_ == null) {
        return AuthState.unauthenticated;
      } else {
        return AuthState.authenticated;
      }
    },
    error: (_, __) {
      return AuthState.unauthenticated;
    },
    loading: () {
      return AuthState.loading;
    },
  );
}

enum AuthState {
  loading,
  authenticated,
  unauthenticated,
}
