import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/models/meet/meet_model.dart';
import 'package:audiotodo/utilities/constants/enums/service/firebase_collections.dart';
import 'package:audiotodo/utilities/constants/exceptions/firebase_exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'fb_db_base.dart';

class FirebaseDbMeetManager implements FirebaseDbForMeetingBase {
  @override
  Future<bool> saveMeetToCloud(Meet meet, WidgetRef ref,
      {bool isRecreateAgain = false}) async {
    try {
      await FirebaseCollectionEnums.meets.reference
          .doc(meet.meetId)
          .set(meet.toJson());

      final currentUser = ref.read(authManager);

      await FirebaseCollectionEnums.users.reference
          .doc(ref.read(authManager)!.userId)
          .update({
        "totalRecordSeconds": isRecreateAgain
            ? currentUser!.totalRecordSeconds
            : FieldValue.increment(-meet.recordTimeSecond!),
        "usedRecordSeconds" : isRecreateAgain
            ? currentUser!.usedRecordSeconds
            : FieldValue.increment(meet.recordTimeSecond!),
      });

      // logger.d("Meeting Saved Successfully!");
      return true;
    } catch (e) {
      // logger.e(e.toString());
      FirebaseExceptions.handleFirebaseException("save_meet_firebase", ref);
      return false;
    }
  }

  @override
  Future<List<Meet>> getAllMeet(WidgetRef ref, {Meet? lastMeet}) async {
    try {
      final List<Meet> meets = [];
      Query query = FirebaseCollectionEnums.meets.reference
          .where("userId", isEqualTo: ref.read(authManager)!.userId)
          .orderBy("createdAt", descending: true)
          .limit(20);

      if (lastMeet != null) {
        query = query.startAfter([lastMeet.createdAt]);
      }

      final snapshot = await query.get();

      for (var perDoc in snapshot.docs) {
        meets.add(Meet.fromJson(perDoc.data() as Map<String, dynamic>));
      }

      // Sorting createdAtTime
      meets.sort((a, b) => b.createdDateTime!.compareTo(a.createdDateTime!));

      return meets;
    } catch (e) {
      logger.e(e.toString());
      FirebaseExceptions.handleFirebaseException("get_all_meet_firebase", ref);
      return [];
    }
  }


  @override
  Future<int> getMeetCount(WidgetRef ref) async {
    try {
      final List<Meet> meets = [];
      AggregateQuery aggregateQuery = FirebaseCollectionEnums.meets.reference
          .where(
            "userId",
            isEqualTo: ref.read(authManager)!.userId,
          )
          .count();
      final count =
          await aggregateQuery.get().then((value) => value.count ?? 0);

      return count;
    } catch (e) {
      logger.e(e.toString());
      FirebaseExceptions.handleFirebaseException(
          "get_all_meet_firebase_count", ref);
      return 0;
    }
  }

  @override
  Future<int> getSumDurationOfMeetings(WidgetRef ref) async {
    try {
      final List<Meet> meets = [];
      final snapshot = await FirebaseCollectionEnums.meets.reference
          .where(
            "userId",
            isEqualTo: ref.read(authManager)!.userId,
          )
          .get();

      for (var element in snapshot.docs) {
        meets.add(Meet.fromJson(element.data() as Map<String, dynamic>));
      }

      int sumDurationMs = 0;

      for (var meet in meets) {
        sumDurationMs += meet.recordTimeMs ?? 0;
      }

      return sumDurationMs;
    } catch (e) {
      logger.e(e.toString());
      FirebaseExceptions.handleFirebaseException(
          "get_all_meet_firebase_count", ref);
      return 0;
    }
  }

  @override
  Future<bool> deleteMeet(String meetId, WidgetRef ref) async {
    try {
      await FirebaseCollectionEnums.meets.reference.doc(meetId).delete();
      return true;
    } catch (e) {
      logger.e(e.toString());
      FirebaseExceptions.handleFirebaseException("delete_meet_firebase", ref);
      return false;
    }
  }

  @override
  Future<int> getLast7daysMeetCount(WidgetRef ref) async {
    try {
      final dateFormat = DateFormat( 'dd-MM-yyyy HH:mm');
      DateTime sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
      String sevenDaysAgoString = dateFormat.format(sevenDaysAgo);

      AggregateQuery aggregateQuery = FirebaseCollectionEnums.meets.reference
          .where(
        "userId",
        isEqualTo: ref.read(authManager)!.userId,
      )
          .where(
        "createdAt",
        isGreaterThanOrEqualTo: sevenDaysAgoString,
      )
          .count();

      final count = await aggregateQuery.get().then((value) => value.count ?? 0);



      // logger.i("Firebase last 7: $count");

      return count;
    } catch (e) {
      logger.e(e.toString());
      FirebaseExceptions.handleFirebaseException(
          "get_last_7_days_meet_count", ref);
      return 0;
    }
  }

  @override
  Future<bool> updateCurrentRecreateCount(WidgetRef ref) async {
    try {
      await FirebaseCollectionEnums.users.reference
          .doc(ref.read(authManager)!.userId)
          .update({
        "totalRecreateCount": FieldValue.increment(-1),
      });

      logger.d("Recreate Count decreased by 1");
      return true;
    } catch (e) {
      logger.e(e.toString());
      FirebaseExceptions.handleFirebaseException("save_meet_firebase", ref);
      return false;
    }
  }

  @override
  Future<bool> giveRateToMeet(String meetId, double rate, WidgetRef ref) async {
    try {
      await FirebaseCollectionEnums.meets.reference.doc(meetId).update({
        "likeRate": rate,
      });

      logger.d("Rate Given Successfully!");
      return true;
    } catch (e) {
      logger.e(e.toString());
      FirebaseExceptions.handleFirebaseException("give_rate_firebase", ref);
      return false;
    }
  }
}
