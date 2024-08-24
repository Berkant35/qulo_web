import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/models/auth/user_model.dart';
import 'package:audiotodo/utilities/constants/enums/service/firebase_collections.dart';
import 'package:audiotodo/utilities/constants/enums/user/plan_type.dart';
import 'package:audiotodo/utilities/constants/enums/utilities/contact_us_problems.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utilities/constants/exceptions/firebase_exceptions.dart';
import 'fb_db_base.dart';

class FirebaseDbManager extends FirebaseDbBase {
  @override
  Future<UserModel?> readUser(String userID, WidgetRef ref) async {
    try {
      final docSnap = await dbBase.collection("users").doc(userID).get();

      if (!docSnap.exists) return null;

      return UserModel.fromJson(docSnap.data()!);
    } on Exception catch (e) {
      FirebaseExceptions.handleFirebaseException(e.toString(), ref);
    }
    return null;
  }

  @override
  Future<bool> saveUser(UserModel user, String? userID, WidgetRef ref) async {
    try {
      // logger.i(userID == null);
      // logger.i(user == null);

      await dbBase.collection("users").doc(userID).set(user.toJson());
      return true;
    } catch (e) {
      logger.e("Error $e");

      throw FirebaseException(plugin: "save_user");
    }
  }

  @override
  Future<bool> updateUser(UserModel user, String? userID, WidgetRef ref) async {
    try {
      await dbBase.collection("users").doc(userID).update(user.toJson());
      return true;
    } catch (e) {
      logger.e("Error $e");

      throw FirebaseException(plugin: "update_user");
    }
  }

  @override
  Future<bool> updatePlanForUser(WidgetRef ref,
      {required PlanType planType, required String planDetail}) async {
    try {
      final user = ref.read(authManager);
      await dbBase.collection("users").doc(user!.userId).update({
        "planType": planType.name,
        "totalRecordSeconds": PlanType.getDuration(planType),
        "totalRecreateCount": PlanType.getRecreateCount(planType),
        "planDetail": planDetail
      });
      return true;
    } catch (e) {
      throw FirebaseException(plugin: "update_plan_user");
    }
  }

  @override
  Future<bool> contactUs(String email, String message, ProblemType problemType,
      WidgetRef ref) async {
    try {
      logger.w("Firebase uploading....");
      await FirebaseCollectionEnums.contact_us.reference.add({
        "email": email,
        "message": message,
        "problemType": problemType.name,
        "createdAt": FieldValue.serverTimestamp()
      });
      logger.w("Heroku Server uploading....");
      await herokuServer!.sendContactUsMail(ref, message, problemType, email);
      return true;
    } catch (e) {
      FirebaseExceptions.handleFirebaseException(e.toString(), ref);
      return false;
    }
  }
}
