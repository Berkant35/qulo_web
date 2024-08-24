
import 'dart:math';

import 'package:audiotodo/line/db/firebase/fb_db/fb_db_base.dart';
import 'package:audiotodo/line/viewmodel/global_export.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/models/auth/user_model.dart';
import 'package:audiotodo/utilities/components/adt_widgets.dart';
import 'package:audiotodo/utilities/components/dialogs/basic_dialogs.dart';
import 'package:audiotodo/utilities/components/dialogs/record_dialogs.dart';
import 'package:audiotodo/utilities/components/dialogs/util_dialogs.dart';
import 'package:audiotodo/utilities/constants/enums/integration/todo_platforms.dart';
import 'package:audiotodo/utilities/constants/enums/service/firebase_collections.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/l10n.dart';
import '../../../../main.dart';
import '../../../../utilities/constants/exceptions/firebase_exceptions.dart';
import '../fb_db/fb_db_manager.dart';


part 'auth_service.dart';

abstract class AuthManager {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<bool> createCustomUserWithEmailAndPassword(
      String email, String password,UserModel userModel,WidgetRef ref);

  Future<UserModel?> currentUser(WidgetRef ref);

  Future<bool> updateCurrentUser(WidgetRef ref);

  Future<bool> signOut();

  Future<dynamic> signIn(String email, String password,WidgetRef ref);

  Future<void> forgotPassword(String email,WidgetRef ref);

  Future<void> updatePassword(String currentPassword,String newPassword,WidgetRef ref);

  Future<bool> updateEmail(String email,String password,WidgetRef ref);

  Future<bool> updateProfilePhoto(String photoUrl,WidgetRef ref);

  Future<bool> deleteAccount(Map<String,bool> reasons,UserModel userModel);



}
