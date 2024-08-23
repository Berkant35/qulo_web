import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IgaChooseLevelControlNotifier extends StateNotifier<IGALevelModes> {
  IgaChooseLevelControlNotifier(IGALevelModes state)
      : super(IGALevelModes.hard);
  /// It keeps the number and sequence of pads
  void changState(IGALevelModes val) => state = val;


}
