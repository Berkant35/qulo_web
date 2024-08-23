import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../../../utils/emb/iga/iga_enums.dart';
    
    /// it keeps player mode (single or multiplayer)
class IgaChoosePlayerControlNotifier extends StateNotifier<IGAPlayerModes> {
  IgaChoosePlayerControlNotifier(IGAPlayerModes state)
      : super(IGAPlayerModes.singlePlayer);
  void changState(IGAPlayerModes val) => state = val;
}
