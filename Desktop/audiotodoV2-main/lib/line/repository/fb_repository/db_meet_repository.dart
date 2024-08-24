import 'package:audiotodo/line/db/api/heroku_server/heroku_server_manager.dart';
import 'package:audiotodo/line/db/firebase/fb_db/fb_db_base.dart';
import 'package:audiotodo/line/db/firebase/fb_db/fb_db_meet_manager.dart';
import 'package:audiotodo/models/meet/meet_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DbMeetRepository extends FirebaseDbForMeetingBase {
  final _fbDbMeetManager = FirebaseDbMeetManager();
  final _herokuServer = HerokuServerManager.instance;
  @override
  Future<bool> saveMeetToCloud(Meet meet, WidgetRef ref,{bool isRecreateAgain = false}) async {
    //TODO: You initialize connect api with server
    // logger.i("Is Recreate Again: $isRecreateAgain");
    return await _fbDbMeetManager.saveMeetToCloud(meet, ref,isRecreateAgain: isRecreateAgain);
  }

  @override
  Future<List<Meet>> getAllMeet(WidgetRef ref,{Meet? lastMeet}) async {
    return await _fbDbMeetManager.getAllMeet(ref,lastMeet: lastMeet);
  }

  @override
  Future<int> getMeetCount(WidgetRef ref) async {
    return await _fbDbMeetManager.getMeetCount(ref);
  }

  @override
  Future<int> getSumDurationOfMeetings(WidgetRef ref) async {
    return await _fbDbMeetManager.getSumDurationOfMeetings(ref);
  }

  @override
  Future<bool> deleteMeet(String meetId, WidgetRef ref) async {

    return await _fbDbMeetManager.deleteMeet(meetId, ref);
  }

  @override
  Future<int> getLast7daysMeetCount(WidgetRef ref) async{
    return await _fbDbMeetManager.getLast7daysMeetCount(ref);
  }

  @override
  Future<bool> updateCurrentRecreateCount(WidgetRef ref) async {
    return await _fbDbMeetManager.updateCurrentRecreateCount(ref);
  }

  @override
  Future<bool> giveRateToMeet(String meetId, double rate, WidgetRef ref) async {
    return await _fbDbMeetManager.giveRateToMeet(meetId, rate, ref);
  }
}
