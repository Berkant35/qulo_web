import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/ui/base/parts/audiotodo_parts/idle_and_record.dart';
import 'package:audiotodo/ui/base/parts/audiotodo_parts/response_todo_list.dart';
import 'package:audiotodo/ui/base/parts/audiotodo_parts/waiting_response.dart';
import 'package:audiotodo/utilities/components/dialogs/custom_show_case_dialog.dart';
import 'package:audiotodo/utilities/constants/enums/app/show_case_states.dart';
import 'package:audiotodo/utilities/constants/enums/meet/audio_steppers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../line/viewmodel/app/utilities/show_case_manager.dart';

class AudioToDoPage extends ConsumerStatefulWidget {
  const AudioToDoPage({
    super.key,
  });

  @override
  ConsumerState createState() => _AudioToDoPageState();
}

class _AudioToDoPageState extends ConsumerState<AudioToDoPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _slideAnimation;
  Animation<double>? _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, customRef, child) {
        final audioState = ref.watch(currentAudioStepManager);

        switch (audioState) {
          case AudioToDoSteps.idle:
          case AudioToDoSteps.record:
          case AudioToDoSteps.reviewMeet:
            return IdleAndRecord(ref);
          //case AudioToDoSteps.reviewMeet:
          // return const ReviewMeeting();
          case AudioToDoSteps.waitingResponse:
            _animationController!.forward();
            return const WaitingResponse();
          case AudioToDoSteps.responseTodoList:
            return ResponseTodoList(parentRef: ref,createForDetail: false,);
          case AudioToDoSteps.shareWith:
            return const SizedBox();
        }
      },
    );
  }
}
