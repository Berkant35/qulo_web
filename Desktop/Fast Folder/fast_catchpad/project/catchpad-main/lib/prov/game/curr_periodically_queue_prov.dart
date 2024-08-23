import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/game/period/per_period.dart';

typedef PeriodicallyQueue = Map<String, List<DiscoveredDevice>>;
typedef PeriodicallyColorQueue = Map<DiscoveredDevice, Color?>;

class CurrentPeriodicallyQueueControlNotifier
    extends StateNotifier<PeriodicallyQueue> {
  CurrentPeriodicallyQueueControlNotifier(PeriodicallyQueue state) : super({});

  PeriodicallyColorQueue periodicallyColorQueue = {};


  PerPeriod? currentPerPeriod ;


  void changeCurrentPerPeriodList(PerPeriod period) => currentPerPeriod = period;

  void changeCurrentColorQueue(PeriodicallyColorQueue val) =>
      periodicallyColorQueue = val;

  void changState(PeriodicallyQueue val) => state = val;

  Future<void> add(
      List<DiscoveredDevice?> val, String title, WidgetRef ref) async {
    try {
      int i = -1;
      final colorList =  ref.read(currentPeriodColorQueueManager).values.toList();

      assert(ref.read(currentUserProv) != null, "User is null");


      await FirebaseCollectionEnums.periods.reference
          .doc(ref.read(currentUserProv)!.uid)
          .collection(FirebaseCollectionEnums.periods.name)
          .doc(title)
          .set({
        "title": title,
        "devices": val.map((e) {


          i++;

          logger.i(colorList.toList());

          assert(e != null, "DiscoveredDevice is null");

          return e!.toJson(
              color: colorList.isNotEmpty && colorList.length > i ? colorList[i] : null);
        }).toList(),
      });
    } catch (e) {
      logger.e("Error add: $e");
    }
  }

  void update(List<DiscoveredDevice> val, String oldTitle, String title,
      WidgetRef ref) {
    try {
      delete(oldTitle, ref);
      add(val, title, ref);
    } catch (e) {
      logger.e("Error: $e");
    }
  }

  Future<void> delete(String title, WidgetRef ref) async {
    try {
      await FirebaseCollectionEnums.periods.reference
          .doc(ref.read(currentUserProv)!.uid)
          .collection(FirebaseCollectionEnums.periods.name)
          .doc(title)
          .delete();
    } catch (e) {
      logger.e("Error: $e");
    }
  }

  Future<PerPeriod> getPerPeriod(WidgetRef ref, String periodName) async {
    final result = await FirebaseCollectionEnums.periods.reference
        .doc(ref.read(currentUserProv)!.uid!)
        .collection(FirebaseCollectionEnums.periods.name)
        .doc(periodName)
        .get();

    final perPeriod = PerPeriod.fromJson(result.data()!);

    return perPeriod;
  }

  Future<List<String>> getAllPeriods(WidgetRef ref) async {
    final listOfPeriods = <String>[];

    final result = await FirebaseCollectionEnums.periods.reference
        .doc(ref.read(currentUserProv)!.uid!)
        .collection(FirebaseCollectionEnums.periods.name)
        .get();

    for (var perDoc in result.docs) {
      listOfPeriods.add(perDoc.id);
    }

    return listOfPeriods;
  }

  @Deprecated("")
  void definedDemo(WidgetRef ref) {
    final periodicList = <DiscoveredDevice>[];
    ref
        .read(currentDevicesManagerProvider.notifier)
        .connectedDevice
        .forEach((key, value) {
      periodicList.add(value);
    });
    state = {'demo': periodicList};

    logger.i(periodicList.toList());
  }
}

class IncludePeriodicallyQueueControlNotifier extends StateNotifier<bool> {
  IncludePeriodicallyQueueControlNotifier(state) : super(false);

  void changState(bool val) => state = val;
}
