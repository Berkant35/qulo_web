



import 'package:catchpad/models/pad_ota_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/enums/firebase/collenction_enums.dart';

class PadConfigNumberNotifier extends StateNotifier<PadOtaConfig> {
  PadConfigNumberNotifier(PadOtaConfig state)
      : super(const PadOtaConfig());

  Future<void> getCurrentPadVersions() async {
    final padOtaConfig = await FirebaseCollectionEnums.pad_config.reference
        .withConverter<PadOtaConfig>(
        fromFirestore: (snapshot, options) =>
            PadOtaConfig.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson())
        .doc("configs")
        .get();

    state = padOtaConfig.data()!;
  }
}