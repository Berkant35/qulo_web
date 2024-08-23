import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/device/device_shuffler.dart';
import '../ui/device/debug/dev_debug_options.dart';

abstract class AudioManager {
  static Future<bool> playDevAudio({
    required WidgetRef ref,
    required String deviceId,
  }) async {
    final device = DeviceShuffler.getDeviceWithId(
      ref,
      deviceId: deviceId,
    );
    if (device == null) {
      assert(false);
      return false;
    }

    final stickerId = await device.deviceStickerId(ref);

    if (stickerId == null) {
      assert(false);
      return false;
    }

    final playResult = await CustomDevDebugOperations.playAudio(
      deviceId,
      ref,
      val: stickerId,
    );

    return playResult;
  }
}
