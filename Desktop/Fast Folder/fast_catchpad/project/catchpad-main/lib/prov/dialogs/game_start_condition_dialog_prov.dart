import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/enums/utility/dialog_parts_enum.dart';

final currentDialogTitleAndDescription = StateNotifierProvider<
        GameStartConditionDialogProvControlNotifier, Map<DialogParts, String>>(
    (_) => GameStartConditionDialogProvControlNotifier(dfState()));

Map<DialogParts, String> dfState() =>
    {DialogParts.title: "", DialogParts.description: ""};

class GameStartConditionDialogProvControlNotifier
    extends StateNotifier<Map<DialogParts, String>> {
  GameStartConditionDialogProvControlNotifier(state) : super(dfState());

  void changState(val) => state = val;
}
