import 'dart:math';

import 'package:catchpad/utils/route_table.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/api/user_api.dart';
import '../../models/auth/register_user.dart';
import '../../models/auth/user_assets.dart';
import '../../models/class_model.dart';
import '../../models/exercises_model.dart';
import '../../models/quiz_model.dart';
import '../class_provider.dart';
import '../exercise_provider.dart';
import '../quiz_provider.dart';

final currentUserProv =
    StateNotifierProvider<CurrentUserProvider, RegisterUser?>(
        (_) => CurrentUserProvider(null));

class CurrentUserProvider extends StateNotifier<RegisterUser?> {
  CurrentUserProvider(super.state);

  update(RegisterUser? user) {
    state = user;
  }

  logOut(WidgetRef ref) async {
    await FirebaseAuth.instance.signOut();
    ref.read(currentUserAssetsProv.notifier).resetAssets(ref);
    state = null;
  }

  Future<void> deleteAccount(WidgetRef ref) async {
    final curUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: curUser!.uid)
        .get()
        .then((querySnapshot) {
      for (var perUser in querySnapshot.docs) {
        perUser.reference.delete();
      }

      curUser.delete();
      ref.context.goNamed(RouteTable.rLogin);
    });
  }

  Future<bool> resetPassword() async {
    try {
      if (state?.email != null) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: state!.email!);
      } else {
        logger.e("Email Null!");
        return false;
      }
      return true;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }

  Future<bool> resetPasswordWithoutLogin(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      logger.d(e.toString());
      return false;
    }
  }
}

final currentUserAssetsProv =
    StateNotifierProvider<UserAssetProvider, UserAssets>(
        (_) => UserAssetProvider(const UserAssets(favorites: [])));

final currentUserCredential = StateProvider<UserCredential?>((_) => null);

class UserAssetProvider extends StateNotifier<UserAssets> {
  UserAssetProvider(UserAssets state) : super(state);

  Future<void> addToFavorites(String gameid) async {
    try {
      state = state.copyWith(favorites: [...state.favorites!, gameid]);
      await updateAssets();
    } catch (e) {
      logger.d('an error occured while adding to favorites $e');
    }
    return;
  }

  Future<void> removeFromFavorites(String gameid) async {
    try {
      state = state.copyWith(
          favorites:
              state.favorites!.where((element) => element != gameid).toList());
      await updateAssets();
    } on Exception catch (e) {
      logger.d('an error occured while removing from favorites $e');
    }
    return;
  }

  void resetAssets(WidgetRef ref) {
    ref.read(exerciseProvider.notifier).reset();
    ref.read(quizProvider.notifier).reset();
    ref.read(classProvider.notifier).reset();
  }

  List<String> getAllStudentNickNames() {
    List<String> nicknames = [];
    if (state.classModel != null) {
      for (Class cls in state.classModel!.classes) {
        for (Student student in cls.students) {
          nicknames.add(student.studentNickName);
        }
      }
    }
    return nicknames;
  }

  Future<bool> updateAssets(
      {ExercisesModel? exercisesModel,
      QuizModel? quizModel,
      ClassModel? classModel,
      List<String>? favorites,
      String? studentNickName,

      bool adding = true}) async {
    state = state.copyWith(
        exercisesModel: exercisesModel,
        quizModel: quizModel,
        classModel: classModel,
        favorites: favorites);
    if (classModel != null && studentNickName != null) {
      try {
        final nicknames = classModel.getAllStudentNickNames();

        if (nicknames.contains('egehancetinel')) {
          logger.d('contains egehancetinel true update assets');
        }
        logger.i("Update Assets $studentNickName ");
        final usernamepool = await UsersApi.instance.getUserNamePool();
        nicknames.addAll(usernamepool);
        final setnickpool = nicknames.toSet().toList();
        if (!adding) {
          setnickpool.remove(studentNickName);
        }
        await UsersApi.instance.setUserNamePool(setnickpool);
      } catch (e) {
        logger.e(e.toString());
      }
    }
    try {
      await UsersApi.instance
          .userAssets()
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(state.toJson());
      return true;
    } catch (e) {
      logger.e('Unable to set user assets for the current user: $e');
      return false;
    }
  }

  void setAssets(WidgetRef ref) {
    if (state.exercisesModel != null) {
      ref.read(exerciseProvider.notifier).update(state.exercisesModel!, ref);
    } else {
      logger.e('exercise model was null');
    }
    if (state.quizModel != null) {
      ref.read(quizProvider.notifier).update(state.quizModel!, ref);
    } else {
      logger.e('quiz model was null');
    }
    if (state.classModel != null) {
      ref.read(classProvider.notifier).update(state.classModel!, ref);
    } else {
      logger.e('class model was null');
    }
  }

  Future<bool> loadAssets(WidgetRef ref) async {
    /*  try { */
    final userAssets = await UsersApi.instance
        .getUserAssets(FirebaseAuth.instance.currentUser!.uid);
    if (userAssets == null) {
      return false;
    }
    state = userAssets;
    /* } catch (e) {
      logger.e('Unable to fetch user assets for the current user: $e');
      return false;
    } */
    try {
      setAssets(ref);
      return true;
    } catch (e) {
      logger.e('Unable to load user assets for the current user: $e');
      return false;
    }
  }
}
