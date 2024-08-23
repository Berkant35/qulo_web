import 'package:catchpad/models/game/game_drop_options_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentDropOptionControlNotifier extends StateNotifier<DropOption?> {
  CurrentDropOptionControlNotifier(DropOption? state) : super(null);
  void changState(DropOption? val) => state = val;

}
