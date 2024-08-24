import 'package:audiotodo/line/db/api/heroku_server/heroku_server_manager.dart';
import 'package:audiotodo/models/auth/user_model.dart';
import 'package:audiotodo/models/meet/meet_model.dart';
import 'package:audiotodo/utilities/constants/enums/user/plan_type.dart';
import 'package:audiotodo/utilities/constants/enums/utilities/contact_us_problems.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class FirebaseDbBase {
  FirebaseDbBase();
  final herokuServer = HerokuServerManager.instance;
  final FirebaseFirestore _dbBase = FirebaseFirestore.instance;

  FirebaseFirestore get dbBase => _dbBase;

  Future<UserModel?> readUser(String userID, WidgetRef ref);

  Future<bool> saveUser(UserModel user, String? userID, WidgetRef ref);

  Future<bool> updateUser(UserModel user, String? userID, WidgetRef ref);

  Future<bool> updatePlanForUser(WidgetRef ref,
      {required PlanType planType, required String planDetail});

  Future<bool> contactUs(
      String email, String message, ProblemType problemType, WidgetRef ref);
}

abstract class FirebaseDbForMeetingBase {
  FirebaseDbForMeetingBase();

  Future<bool> updateCurrentRecreateCount(WidgetRef ref);

  Future<bool> saveMeetToCloud(Meet meet, WidgetRef ref,
      {bool isRecreateAgain = false});

  Future<List<Meet>> getAllMeet(WidgetRef ref, {Meet? lastMeet});

  Future<int> getMeetCount(WidgetRef ref);

  Future<int> getLast7daysMeetCount(WidgetRef ref);

  Future<int> getSumDurationOfMeetings(WidgetRef ref);

  Future<bool> giveRateToMeet(String meetId, double rate, WidgetRef ref);

  Future<bool> deleteMeet(String meetId, WidgetRef ref);
}
