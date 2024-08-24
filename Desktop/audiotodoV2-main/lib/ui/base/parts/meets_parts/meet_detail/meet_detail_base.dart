import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../audiotodo_parts/response_todo_list.dart';

part 'meet_detail_base_mixin.dart';

final class MeetDetailBase extends ConsumerStatefulWidget {
  const MeetDetailBase({
    super.key,
  });

  @override
  ConsumerState createState() => _MeetDetailBaseState();
}

class _MeetDetailBaseState extends ConsumerState<MeetDetailBase>
    with MeetDetailBaseMixin {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ResponseTodoList(
        parentRef: ref,
        createForDetail: true,
      ),
    );
  }
}

