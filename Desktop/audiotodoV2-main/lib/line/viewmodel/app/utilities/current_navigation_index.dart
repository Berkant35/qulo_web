import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/components/adt_widgets.dart';
import 'package:audiotodo/utilities/constants/enums/meet/audio_steppers.dart';
import 'package:audiotodo/utilities/constants/enums/meet/record_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentNavigationIndex extends StateNotifier<int> {
  CurrentNavigationIndex(int state) : super(1);

  changeState(int currentIndex, WidgetRef ref) {
    // logger.i(ref.read(currentAudioStepManager).name);

    if (ref.read(currentRecordStateManager) == RecordStates.recording ||
        ref.read(currentAudioStepManager) == AudioToDoSteps.waitingResponse ||
        ref.read(currentAudioStepManager) == AudioToDoSteps.responseTodoList) {

      // Process(AudioToDoSteps) not finished yet STATES
      if (ref.read(currentAudioStepManager) == AudioToDoSteps.waitingResponse) {

        RecordDialogs.sendingGptPleaseWait();
      }
      //Process not finished yet
      else if (ref.read(currentAudioStepManager) ==
          AudioToDoSteps.responseTodoList) {
        RecordDialogs.pleaseEndCurrentMeeting();
      }

      else {
        RecordDialogs.sureChangeCurrentTap(ref, currentIndex);
      }
      return;
    }
    state = currentIndex;
  }
}
