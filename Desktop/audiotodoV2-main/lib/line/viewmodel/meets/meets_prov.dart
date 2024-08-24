import 'package:audiotodo/line/repository/fb_repository/storage_repository.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/models/meet/meet_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repository/fb_repository/db_meet_repository.dart';
import '../global_providers.dart';

final class CurrentSelectMeetControlNotifier extends StateNotifier<Meet?> {
  CurrentSelectMeetControlNotifier(Meet? state, this._dbMeetRepository)
      : super(null);

  final DbMeetRepository? _dbMeetRepository;

  DbMeetRepository get dpMeetRepo => _dbMeetRepository ?? DbMeetRepository();

  void changState(Meet? val) => state = val;

  Future<List<Meet>> getMeetList(WidgetRef ref,{Meet? lastMeet}) async {
    return await dpMeetRepo.getAllMeet(ref,lastMeet: lastMeet);
  }

  //get meetCount
  Future<int> getMeetCount(WidgetRef ref) async {
    return await dpMeetRepo.getMeetCount(ref);
  }

  //last 7 day meet count
  Future<int> getLast7daysMeetCount(WidgetRef ref) async {
    return await dpMeetRepo.getLast7daysMeetCount(ref);
  }

  Future<int> getSumDurationOfMeetings(WidgetRef ref) async {
    return await dpMeetRepo.getSumDurationOfMeetings(ref);
  }

  Future<bool> deleteMeet(String meetId, WidgetRef ref) async {



    final deletedFile = await StorageRepository().deleteFileFromFirebase(
        ref.read(currentMeetControllerManager)!.soundFileLink ?? "", ref);
    if (deletedFile) {
      await dpMeetRepo.deleteMeet(meetId, ref);
      return true;
    } else {
      return false;
    }
  }
}
