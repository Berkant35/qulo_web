import 'package:audiotodo/core/navigation/navigation_constants.dart';
import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/line/db/firebase/auth/auth_manager.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/models/auth/user_model.dart';
import 'package:audiotodo/utilities/constants/enums/integration/todo_platforms.dart';
import 'package:audiotodo/utilities/constants/exceptions/firebase_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../main.dart';
import '../../../utilities/constants/enums/app/loading_states.dart';

class AuthManagerProvider extends StateNotifier<UserModel?>
    implements AuthManager {
  AuthManagerProvider(UserModel? userModel) : super(null);
  final _authService = AuthService();

  changeUser(UserModel? userModel) {
    // logger.i("Stack Trace: ${StackTrace.current.toString()}");
    state = userModel;
  }

  @override
  Future<bool> createCustomUserWithEmailAndPassword(
      String email, String password, UserModel userModel, WidgetRef ref) async {
    try {
      return await _authService.createCustomUserWithEmailAndPassword(
          email, password, userModel, ref);
    } catch (e) {
      logger.e(e);
      return false;
    } finally {
      ref.read(aLoadingStateManager.notifier).changeState(LoadingState.idle);
    }
  }

  @override
  Future<UserModel?> currentUser(WidgetRef ref) async {
    try {
      var currentUser = await _authService.currentUser(ref);
      state = currentUser;
      return currentUser;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  @override
  Future<void> forgotPassword(String email, WidgetRef ref) async {
     await _authService.forgotPassword(email, ref);
  }

  @override
  Future<UserModel?> signIn(
      String email, String password, WidgetRef ref) async {
    try {
      var currentUser = await _authService.signIn(email, password, ref);
      state = currentUser;

      if (state != null) {
        await NavigationService.instance
            .navigateToPageClear(path: NavigationConstants.mainBase);
      }

      return state;
    } catch (e) {
      logger.e("Error: $e");
    } finally {
      ref.read(aLoadingStateManager.notifier).changeState(LoadingState.loaded);
    }
    return null;
  }

  @override
  Future<bool> signOut() async {
    await NavigationService.instance
        .navigateToPageClear(path: NavigationConstants.authLoginPage);
    changeUser(null);
    final isSignOuted = await _authService.signOut();

    return isSignOuted;
  }

  @override
  Future<bool> updateEmail(String email, String password, WidgetRef ref) async {
    // TODO: implement updateEmail
    throw UnimplementedError();
  }

  @override
  Future<void> updatePassword(
      String currentPassword, String newPassword, WidgetRef ref) async {
    // TODO: implement updateEmail
    throw UnimplementedError();

  }

  @override
  // TODO: implement firebaseAuth
  FirebaseAuth get firebaseAuth => throw UnimplementedError();

  Future<bool> addNewPlatformLink(
      WidgetRef ref, String apiKey, TodoPlatforms platform) async {
    try {
      ref.read(aLoadingStateManager.notifier).changeState(LoadingState.loading);
      Map<String, String>? currentPlatforms =
          Map<String, String>.from(state!.todoPlatformTokens ?? {});
      currentPlatforms.addAll({platform.name: apiKey});

      state = state!.copyWith(todoPlatformTokens: currentPlatforms);
      return await _authService.updateCurrentUser(ref);
    } finally {
      ref.read(aLoadingStateManager.notifier).changeState(LoadingState.loaded);
    }
  }

  @override
  Future<bool> updateProfilePhoto(String photoUrl, WidgetRef ref) async {
    final currentUser = state;

    state = currentUser!.copyWith(
      photoUrl: photoUrl,
    );

    try {
      return await _authService.updateProfilePhoto(photoUrl, ref);
    } catch (e) {
      logger.e(e.toString());
      return false;
    }
  }

  @override
  Future<bool> deleteAccount(
      Map<String, bool> reasons, UserModel userModel) async {
    try {
      return await _authService.deleteAccount(reasons, userModel);
    } catch (e) {
      logger.e(e.toString());
      return false;
    }
  }

  @override
  Future<bool> updateCurrentUser(WidgetRef ref) async {
    try {
      return await _authService.updateCurrentUser(ref);
    } catch (e) {
      FirebaseExceptions.handleFirebaseException(e.toString(), ref,
          title: "Failed to update user");
      return false;
    }
  }
}
