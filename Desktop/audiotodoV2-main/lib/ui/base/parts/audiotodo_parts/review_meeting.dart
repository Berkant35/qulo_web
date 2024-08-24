import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/utilities/components/containers/custom_bar_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewMeeting extends ConsumerStatefulWidget {
  const ReviewMeeting({
    super.key,
  });

  @override
  ConsumerState createState() => _ReviewMeetingState();
}

class _ReviewMeetingState extends ConsumerState<ReviewMeeting> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 2,
              child: CustomBarContainer(
                text: S.current.mode_review,
              )),
          Expanded(flex: 18, child: Container()),
        ],
      ),
    );
  }
}
