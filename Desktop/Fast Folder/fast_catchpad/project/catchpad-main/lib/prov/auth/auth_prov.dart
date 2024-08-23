import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_prov_state.dart';

final authProvider =
    StateNotifierProvider<SignProvider, AuthProvState>((ref) => SignProvider());

class SignProvider extends StateNotifier<AuthProvState> {
  SignProvider()
      : _auth = FirebaseAuth.instance,
        super(AuthProvState()) {
    if (kIsWeb) {
      _auth.setPersistence(Persistence.LOCAL);
    }

    _auth.authStateChanges().listen(
      (event) {
        state = state.copyWith(
          firebaseUser: AsyncValue.data(event),
        );
      },
    );
  }

  final FirebaseAuth _auth;

  Future<UserCredential> login(String email, String password) {
    return _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

}
