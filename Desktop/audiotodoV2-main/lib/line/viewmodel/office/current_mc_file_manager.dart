import 'package:audiotodo/utilities/constants/enums/utilities/mc_files.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentMcFileControlNotifier extends StateNotifier<MicrosoftFiles> {
  CurrentMcFileControlNotifier(MicrosoftFiles state) : super(MicrosoftFiles.unknown);
  void changState(MicrosoftFiles val) => state = val;
}
