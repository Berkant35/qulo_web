import 'package:catchpad/models/auth/register_user.dart';
import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/models/event/catchpad_event.dart';
import 'package:catchpad/models/event/catchpad_event_result.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/event/event_customer.dart';

///You can CRUD operations about catchpad events at fairs.
class CatchpadEventControllerNotifier extends StateNotifier<CatchpadEvent?> {
  CatchpadEventControllerNotifier(CatchpadEvent? state) : super(null);

  ///You can choose current catchpad for app state
  void chooseCurrentEvent(WidgetRef ref,
          {required CatchpadEvent? catchpadEvent}) =>
      state = catchpadEvent;

  Future<bool> create(WidgetRef ref,
      {required CatchpadEvent catchPadEvent}) async {
    try {
      await FirebaseCollectionEnums.catchpad_events.reference
          .doc(catchPadEvent.eventId)
          .set(catchPadEvent.toJson());
      return true;
    } catch (e) {
      logger.e("Create Error: ${e.toString()}");
      return false;
    }
  }

  Future<bool> update(WidgetRef ref,
      {required CatchpadEvent catchPadEvent}) async {
    try {
      await FirebaseCollectionEnums.catchpad_events.reference
          .doc(catchPadEvent.eventId)
          .update(catchPadEvent.toJson());
      return true;
    } catch (e) {
      logger.e("Update Error: ${e.toString()}");
      return false;
    }
  }

  Future<bool> delete(WidgetRef ref, {required String eventId}) async {
    try {
      await FirebaseCollectionEnums.catchpad_events.reference
          .doc(eventId)
          .delete();
      return true;
    } catch (e) {
      logger.e("Create Error: ${e.toString()}");
      return false;
    }
  }

  Future<List<CatchpadEvent>> getCatchpadEventList(WidgetRef ref) async {
    List<CatchpadEvent> tempList = [];

    try {
      final events =
          await FirebaseCollectionEnums.catchpad_events.reference.get();
      for (var perDoc in events.docs) {
        tempList
            .add(CatchpadEvent.fromJson(perDoc.data() as Map<String, dynamic>));
      }
      return tempList;
    } catch (e) {
      logger.e("Create Error: ${e.toString()}");
      return [];
    }
  }

  Future<bool> addResultUser(WidgetRef ref,
      {required CatchpadEventResult result}) async {
    try {


      CatchpadEventResult updateRes = result;
      final currentResultFromServer = await FirebaseCollectionEnums
          .catchpad_event_results.reference
          .doc(result.eventId)
          .collection(result.gameId!)
          .doc(result.userId)
          .get();
      if (currentResultFromServer.exists) {
        CatchpadEventResult currentResult = CatchpadEventResult.fromJson(
            currentResultFromServer.data() as Map<String, dynamic>);
        if ((currentResult.userPrimaryScore ?? 0.0) <
            (updateRes.userPrimaryScore ?? 0.0)) {
          updateRes = currentResult;
        }

        await saveResult(result, updateRes);
      } else {
        await saveResult(result, updateRes);
      }

      return true;
    } catch (e) {
      logger.e("Create Error: ${e.toString()}");
      return false;
    }
  }

  Future<void> saveResult(
      CatchpadEventResult result, CatchpadEventResult updateRes) async {
    final path = FirebaseCollectionEnums.catchpad_event_results.reference
        .doc(result.eventId)
        .collection(updateRes.gameId!);
    final lastResultPath = FirebaseCollectionEnums.catchpad_event_results.reference
        .doc(updateRes.eventId)
        .collection("last_result_${updateRes.eventId}");

    final _ftrList = [
      path.doc(result.userId).set(updateRes.toJson()),
      lastResultPath.doc("result").set(updateRes.toJson())
    ];
    await Future.wait(_ftrList);
  }

  Future<List<RegisterUser>> getLoginUsers(WidgetRef ref) async {
    List<RegisterUser> tempList = [];

    try {
      final events = await FirebaseCollectionEnums.users.reference
          .orderBy("createdAt", descending: true)
          .limit(50)
          .get();
      for (var perDoc in events.docs) {
        tempList
            .add(RegisterUser.fromJson(perDoc.data() as Map<String, dynamic>));
      }




      return tempList;
    } catch (e) {
      logger.e("Create Error: ${e.toString()}");
      return [];
    }
  }

  Future<List<EventCustomer>> getEventCustomers(WidgetRef ref) async {
    List<EventCustomer> tempList = [];

    try {
      final events = await FirebaseCollectionEnums.event_users.reference.orderBy("createdAt",descending: true)
          .get();
      for (var perDoc in events.docs) {
        tempList
            .add(EventCustomer.fromJson(perDoc.data() as Map<String, dynamic>));
      }




      return tempList;
    } catch (e) {
      logger.e("Create Error: ${e.toString()}");
      return [];
    }
  }

}

class EventCompetitorNotifier extends StateNotifier<EventCustomer?> {
  EventCompetitorNotifier(EventCustomer? state) : super(null);

  void choose(EventCustomer? eventCustomer) => state = eventCustomer;
}
