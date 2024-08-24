import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/constants/enums/meet/record_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecordStateManagerNotifier extends StateNotifier<RecordStates> {
  RecordStateManagerNotifier(RecordStates states) : super(RecordStates.idle);

  void changeRecordState(RecordStates newState) {
    // logger.i('Record State change: $newState ${StackTrace.current.toString()}');
    state = newState;
  }
}
