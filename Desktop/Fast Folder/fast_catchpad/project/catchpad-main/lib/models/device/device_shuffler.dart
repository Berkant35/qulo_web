import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xrandom/xrandom.dart';

class DeviceShuffler {
  final WidgetRef ref;
  final List<DeviceModel> devs;

  final List<DeviceModel> shuffledDevs = [];

  DeviceShuffler(this.ref) : devs = readDevices(ref);

  List<DeviceModel> getDevicesBetween(int startIndex, int endIndex) {
    final dvcs = <DeviceModel>[];

    for (var i = startIndex; i < endIndex; i++) {
      dvcs.add(getDevice(i));
    }

    return dvcs;
  }

// TODO: use the current players of the game
  DeviceModel getDevice(int index) {
    if (index >= shuffledDevs.length) {
      final shuf = [
        ...devs,
        // ...devs,
      ]..shuffle(Xrandom());

      shuffledDevs.addAll(shuf);

      // maybe this round of shuffling is not enough,
      // so we will just recurse and let our method do the rest
      return getDevice(index);
    }

    if (index < 0) {
      assert(false);
      index = 0;
    }

    return shuffledDevs[index];
  }

  List<DeviceModel> getOtherThan(int index) {
    final dvcs = <DeviceModel>[];

    for (var i = 0; i < shuffledDevs.length; i++) {
      if (i != index) {
        dvcs.add(getDevice(i));
      }
    }

    return dvcs;
  }

  /// shuffled devices will be divided into devs.length chunks
  List<DeviceModel> getRound(int index) {
    final idx = index * devs.length;

    return getDevicesBetween(idx, idx + devs.length);
  }

  static List<DeviceModel> readDevices(WidgetRef ref) =>
      ref.read(bleConPr).keys.toList();

  static DeviceModel? getDeviceWithId(
    WidgetRef ref, {
    required String deviceId,
  }) {
    final devs = readDevices(ref);
    try {
      return devs.firstWhere((e) => e.id == deviceId);
    } catch (e) {
      logger.e(e);
      assert(false);
      return null;
    }
  }

  static List<DeviceModel> shuffleDevicesUniquely(List<DeviceModel> devs) {
    return shuffleUniquely(
      devs,
      (p0, p1) => p0.id == p1.id,
    );
  }

  static List<Color> shuffleColorsUniquely(List<Color> devs) {
    return shuffleUniquely(
      devs,
      (p0, p1) => p0 == p1,
    );
  }

  static List<T> shuffleUniquely<T>(
    List<T> items,
    bool Function(T, T) predicate,
  ) {
    if (items.length == 1) {
      return items;
    }

    final ran = Xrandom();

    final itms = List<T>.from(items);
    final prevItms = List<T>.from(items);

    while (true) {
      itms.shuffle(ran);

      bool foundAny = false;

      for (var i = 0; i < itms.length; i++) {
        final prevDev = prevItms[i];
        final dev = itms[i];

        if (predicate(prevDev, dev)) {
          foundAny = true;
          break;
        }
      }

      if (foundAny) {
        continue;
      }

      return itms;
    }
  }
}
