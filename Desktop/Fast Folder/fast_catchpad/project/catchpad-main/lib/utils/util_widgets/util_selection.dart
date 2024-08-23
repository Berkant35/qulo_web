import 'package:catchpad/catch_pad_icons_v2.dart';
import 'package:catchpad/models/num_range.dart';
import 'package:catchpad/prov/effect/show_effect_prov.dart';
import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/prov/game/detail_game_prov.dart';
import 'package:catchpad/ui/game/setup_widgets/threshhold_value_setup_widget.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/game_consts.dart';
import 'package:catchpad/utils/utils.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/enums/utility/cache_setup.dart';
import '../../prov/auth/current_user_prov.dart';
import '../../prov/global_providers.dart';
import '../../ui/game/setup_widgets/timeout_setup_widget.dart';
import '../widgets/custom_dialogs.dart';

/// TODO
/// You should move the functions that create the widget below to
/// your own classes. This place was created for 'Sandbox' so it
/// should be temporary

class CustomCatchpadSelections {
  static Widget buildSelectTimeout({
    required WidgetRef ref,
    required BuildContext context,
    double width = 100.0,
  }) {
    return dfContainer(
      leading: null,
      text: Row(
        children: [
          Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              activeColor: Colors.black,
              value: false,
              onChanged: (val) {
                ref.read(currentEffectEnableManager.notifier).changeState();
              }),
          buildText(context, "Sabit min"),
        ],
      ),
      content: TimeoutRangeSetupWidget(
        isRange: ref.watch(currentEffectEnableManager),
      ),
    );
  }

  static Widget buildSelectSensor({
    required WidgetRef ref,
    required BuildContext context,
    double width = 100.0,
    bool isExpanded = false,
    bool sensitivitySettingsIsExpanded = false,
    bool distanceSettingsIsExpanded = false,
    required Function(UsedSensorsType) onTapHeaderIcon,
    required Function(bool) onExpandedFunction,
    required Function(bool) onSensitivityExpanded,
    required Function(bool) onDistanceExpanded,
  }) {
    final setup = ref.watch(detailGameSetupProv);
    final accConfigModel = setup?.accConfig;
    final curSetup = ref.watch(currentGameSetupProv);
    final UsedSensorsType userSensorType =
        curSetup!.sensorTypes.keys.elementAt(curSetup.chosedSensorIndex);
    final gameLimitSensors =
        setup?.sensorTypes.entries.map((e) => e.key).toList();

    return Column(
      children: [
        dfContainer(
            customBorderRadius: isExpanded
                ? BorderRadius.only(
                    topLeft: customRadiusValue(), topRight: customRadiusValue())
                : null,
            leading: Center(
              child: CatchpadIconsV2.catchType,
            ),
            text: buildText(context, "Yakalama",
                questionMark: true, explainContentText: ""),
            content: buildSelectSensorContent(
                isExpanded: isExpanded,
                onTapHeaderIcon: (val) => onTapHeaderIcon(val),
                ref: ref,
                onExpanded: (val) => onExpandedFunction(val)),
            action: buildIconButton(() => onExpandedFunction(!isExpanded))),
        if (isExpanded)
          buildSettingOptionDetails(
              context, userSensorType, accConfigModel, ref,
              sensitivitySettingsIsExpanded: sensitivitySettingsIsExpanded,
              selectionDistanceColor:
                  ref.watch(currentGameProv)?.setup.chosedSensorIndex ==
                          gameLimitSensors?.indexOf(UsedSensorsType.distance)
                      ? Colors.black
                      : null,
              selectionTapColor:
                  ref.watch(currentGameProv)?.setup.chosedSensorIndex ==
                          gameLimitSensors?.indexOf(UsedSensorsType.tap)
                      ? Colors.black
                      : null,
              distanceSettingsIsExpanded: distanceSettingsIsExpanded,
              onSensitivityExpanded: (val) => onSensitivityExpanded(val),
              onDistanceExpanded: (val) => onDistanceExpanded(val),
              onTapRow: (userSensorType) => onTapHeaderIcon(userSensorType)),
        //dfContainer(
        //    text:
        //        buildText(context, "Zaman Aşımı", edgeInset: buildEdgeInsets()),
        //    content: GestureDetector(),
        //    action: buildIconButton(() {})),
      ],
    );
    //
  }

  static Radius customRadiusValue() => Radius.circular(3.w);

  static Column buildSettingOptionDetails(
    BuildContext context,
    UsedSensorsType userSensorType,
    AccConfigModel? accConfigModel,
    WidgetRef ref, {
    bool sensitivitySettingsIsExpanded = false,
    Color? selectionTapColor,
    Color? selectionDistanceColor,
    bool distanceSettingsIsExpanded = false,
    required Function(bool) onSensitivityExpanded,
    required Function(bool) onDistanceExpanded,
    required Function(UsedSensorsType) onTapRow,
  }) {
    return Column(
      children: [
        buildTapWithSensivitySettings(context, userSensorType, accConfigModel,
            sensitivitySettingsIsExpanded: sensitivitySettingsIsExpanded,
            onSensitivityExpanded: (val) => onSensitivityExpanded(val),
            selectionColor: selectionTapColor,
            onTapRow: (userSensorType) => onTapRow(userSensorType)),
        buildDistanceSettings(context, ref,
            distanceSettingsIsExpanded: distanceSettingsIsExpanded,
            onDistanceExpanded: (val) => onDistanceExpanded(val),
            selectionColor: selectionDistanceColor,
            onTapRow: (userSensorType) => onTapRow(userSensorType)),
      ],
    );
  }

  static Column buildDistanceSettings(
    BuildContext context,
    WidgetRef ref, {
    bool distanceSettingsIsExpanded = false,
    required Function(bool) onDistanceExpanded,
    required Function(UsedSensorsType) onTapRow,
    Color? selectionColor,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: () => onTapRow(UsedSensorsType.distance),
          child: dfContainer(
              customBorderRadius: distanceSettingsIsExpanded
                  ? BorderRadius.circular(0)
                  : bottomRadius(),
              text: buildText(context, "Uzaktan",
                  edgeInset: buildEdgeInsets(),
                  selectColor:
                      selectionColor != null ? CpColors.cpPrimary : null),
              content: GestureDetector(),
              action: buildIconButton(
                  () => onDistanceExpanded(!distanceSettingsIsExpanded),
                  selectionColor:
                      selectionColor != null ? CpColors.cpPrimary : null),
              selectionColor: selectionColor),
        ),
        if (distanceSettingsIsExpanded)
          CustomCatchpadSelections.buildSelectionDistance(
              text: "Mesafe", ref: ref, context: context),
      ],
    );
  }

  static Column buildTapWithSensivitySettings(
    BuildContext context,
    UsedSensorsType userSensorType,
    AccConfigModel? accConfigModel, {
    bool sensitivitySettingsIsExpanded = false,
    required Function(bool) onSensitivityExpanded,
    required Function(UsedSensorsType) onTapRow,
    Color? selectionColor,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: () => onTapRow(UsedSensorsType.tap),
          child: dfContainer(
              customBorderRadius: BorderRadius.circular(0),
              text: buildText(context, "Dokunarak",
                  edgeInset: buildEdgeInsets(),
                  selectColor:
                      selectionColor != null ? CpColors.cpPrimary : null),
              content: const SizedBox(),
              action: buildIconButton(
                  () => onSensitivityExpanded(!sensitivitySettingsIsExpanded),
                  selectionColor:
                      selectionColor != null ? CpColors.cpPrimary : null),
              selectionColor: selectionColor),
        ),
        if (sensitivitySettingsIsExpanded)
          dfContainer(
            customBorderRadius: BorderRadius.circular(0),
            text:
                buildText(context, "Hassasiyet", edgeInset: buildEdgeInsets()),
            content: ThreshHoldValueSetupWidget(
              usedSensorsType: userSensorType,
              accConfigModel: accConfigModel ?? defAccConfigModel,
              isNewVersion: true,
            ),
          ),
      ],
    );
  }

  static BorderRadius bottomRadius() {
    return BorderRadius.only(
        bottomRight: customRadiusValue(), bottomLeft: customRadiusValue());
  }

  static EdgeInsets buildEdgeInsets() =>
      EdgeInsets.only(left: buildWCatchType());

  static double buildWCatchType() => 4.w;

  static Padding buildText(BuildContext context, String text,
      {EdgeInsets? edgeInset,
      Color? selectColor,
      bool questionMark = false,
      String? explainContentText}) {
    return Padding(
      padding: edgeInset ?? EdgeInsets.zero,
      child: Row(
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: selectColor ?? Colors.black,
                fontWeight: FontWeight.w500),
          ),
          if (questionMark)
            Padding(
              padding: EdgeInsets.only(left: 0.4.w),
              child: InkWell(
                onTap: () {},
                child: CatchpadIconsV2.questionMark.copyWith(
                    iconColor: Colors.black,
                    width: questionMarkIconSize(),
                    height: questionMarkIconSize(),
                    customBoxFit: BoxFit.contain),
              ),
            )
        ],
      ),
    );
  }

  static double questionMarkIconSize() => 1.3.h;

  static IconButton buildIconButton(Function onPressed,
      {Color? selectionColor}) {
    return IconButton(
        onPressed: () => onPressed(),
        icon: Icon(
          Icons.more_vert,
          color: selectionColor ?? Colors.black,
        ));
  }

  static Widget buildSelectSensorContent(
      {required Function(UsedSensorsType) onTapHeaderIcon,
      bool isExpanded = true,
      required Function(bool) onExpanded,
      required WidgetRef ref}) {
    final setup = ref.watch(currentGameProv)?.setup;
    final gameLimitSensors =
        setup?.sensorTypes.entries.map((e) => e.key).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        buildGestureDetector(
            perSensorWidget: CatchpadIconsV2.contentTap.copyWith(
                height: customIconSize(),
                width: customIconSize(),
                iconColor:
                    ref.watch(currentGameProv)?.setup.chosedSensorIndex ==
                            gameLimitSensors?.indexOf(UsedSensorsType.tap)
                        ? activeSelectSensorColor()
                        : deactiveSelectSensorColor(), //Todo reference
                customBoxFit: customBoxFitDropIcons()),
            onTap: () => onTapHeaderIcon(UsedSensorsType.tap)),
        buildGestureDetector(
            perSensorWidget: CatchpadIconsV2.contentDistance.copyWith(
                height: customIconSize(),
                width: customIconSize(),
                iconColor:
                    ref.watch(currentGameProv)?.setup.chosedSensorIndex ==
                            gameLimitSensors?.indexOf(UsedSensorsType.distance)
                        ? activeSelectSensorColor()
                        : deactiveSelectSensorColor(),
                customBoxFit: customBoxFitDropIcons()),
            onTap: () => onTapHeaderIcon(UsedSensorsType.distance)),
        /*buildGestureDetector(
            perSensorWidget: CatchpadIconsV2.timeout.copyWith(
                height: customIconSize(),
                width: customIconSize(),
                iconColor: deactiveSelectSensorColor(),
                customBoxFit: customBoxFitDropIcons()),
            onTap: () {}),*/
        buildGestureDetector(
            perSensorWidget: Icon(
              !isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
              color: !isExpanded
                  ? deactiveSelectSensorColor()
                  : activeSelectSensorColor(),
              size: 4.25.h,
            ),
            onTap: () => onExpanded(!isExpanded)),
      ],
    );
  }

  static Color deactiveSelectSensorColor() => CpColors.cpTaupeGrey;

  static BoxFit customBoxFitDropIcons() => BoxFit.contain;

  static double customIconSize() => 3.25.h;

  static Widget buildGestureDetector(
          {required Widget perSensorWidget, required Function onTap}) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.75.w),
        child: GestureDetector(
          onTap: () => onTap(),
          child: Align(alignment: Alignment.center, child: perSensorWidget),
        ),
      );

  static Widget buildSelectionDelay({
    VoidCallback? onPressed,
    required String text,
    required WidgetRef ref,
    required BuildContext context,
    double width = 100.0,
  }) {
    final initSetup = ref.watch(detailGameSetupProv)!;
    final game = ref.watch(currentGameProv)!;

    final key = CacheSetupKeys.delay.name + game.id;

    final setup = ref.watch(currentGameSetupProv)!;

    NumRange initDelay, delay;

    if (initSetup.delay == null || initSetup.delay?.def == null) {
      assert(false);

      initDelay = NumRange.def(defaultGameDuration.inSeconds);
    } else {
      initDelay = initSetup.delay!;
    }

    if (setup.delay == null || setup.delay?.def == null) {
      assert(false);

      delay = initDelay;
    } else {
      delay = setup.delay!;
    }

    void setDuration(int sec) {
      final newSetup = setup.copyWith(
        delay: initDelay.copyWith(def: sec),
      );
      final gameId = ref.read(currentGameProv)!.id;
      ref
          .read(currentCacheSetupManager.notifier)
          .setCacheAnyValue(ref, whichSetupKey: key, val: sec, gameId: gameId);

      ref.read(currentGameProv.notifier).setSetup(newSetup);
    }

    final min = initDelay.min;
    final max = initDelay.max;
    final step = initDelay.step;

    Future(() {
      ref.read(currentCacheSetupManager.notifier).getPerValue(ref,
          whichSetupKey: key,
          typeOfVal: "int",
          cacheEnum: CacheSetupKeys.delay,
          gameId: game.id, setVal: (val) {
        setDuration(val);
      });
    });

    final sec = ((ref.watch(currentCacheSetupManager)[key] != null) &&
            (ref.watch(currentCacheSetupManager)[key] as int) < max &&
            (ref.watch(currentCacheSetupManager)[key] as int) > min)
        ? ref.watch(currentCacheSetupManager)[key]
        : delay.def!;

    return dfContainer(
        leading: Center(
          child: CatchpadIconsV2.delay,
        ),
        content: NumberPicker(
          value: sec,
          minValue: min,
          maxValue: max,
          step: step,
          itemHeight: 20,
          itemWidth: buildW(),
          axis: Axis.horizontal,
          onChanged: setDuration,
          textMapper: (val) {
            if ((game.id == 's13')) {
              switch (val) {
                case '300':
                  return L10n.inst(context).difficulty_easy;
                case '450':
                  return L10n.inst(context).difficulty_medium;
                case '600':
                  return L10n.inst(context).difficulty_hard;
                default:
              }
            }
            return val +
                L10n.inst(context).activity_duration_selection_second_unit;
          },
          textStyle: Theme.of(context).textTheme.titleSmall,
          selectedTextStyle: Theme.of(context).textTheme.titleLarge,
        ),
        text: buildText(context, text),
        action: buildIconButton(() {}));
  }

  static Widget buildSelectionDistance({
    VoidCallback? onPressed,
    required String text,
    required WidgetRef ref,
    required BuildContext context,
    double width = 100.0,
  }) {
    final initSetup = ref.watch(detailGameSetupProv)!;
    final gameId = ref.read(currentGameProv)!.id;

    final key = CacheSetupKeys.distance.name;

    final setup = ref.watch(currentGameSetupProv)!;

    NumRange initDistance, distance;

    if (initSetup.distance == null || initSetup.distance?.def == null) {
      assert(false);

      initDistance = NumRange.def(defaultGameDistanceMM.mmToCm.toInt());
    } else {
      initDistance = initSetup.distance!;
    }

    if (setup.distance == null || setup.distance?.def == null) {
      assert(false);

      distance = initDistance;
    } else {
      distance = setup.distance!;
    }

    Future<void> setDistance(int dst) async {
      dst = dst.cmToMm.toInt();

      final NumRange dis;
      if (setup.distance == null) {
        assert(false);

        dis = NumRange.def(dst);
      } else {
        dis = setup.distance!.copyWith(def: dst);
      }

      final newSetup = setup.copyWith(distance: dis);
      ref
          .read(currentCacheSetupManager.notifier)
          .setCacheAnyValue(ref, whichSetupKey: key, val: dst, gameId: gameId);

      ref.read(currentGameProv.notifier).setSetup(newSetup);
    }

    // the distance values are mm, we wanna convert to cm
    // in the selector.

    final min = initDistance.min.mmToCm.toInt();
    final max = initDistance.max.mmToCm.toInt();
    final step = initDistance.step.mmToCm.toInt();

    final sec = (ref.watch(currentCacheSetupManager)['$key/$gameId'] != null)
        ? (ref.watch(currentCacheSetupManager)['$key/$gameId'] as int)
            .mmToCm
            .toInt()
        : distance.def!.mmToCm.toInt();

    return dfContainer(
      customBorderRadius: bottomRadius(),
      leading: null,
      content: NumberPicker(
        value: sec,
        minValue: min,
        maxValue: max,
        step: step,
        itemHeight: 20,
        itemWidth: buildW(),
        axis: Axis.horizontal,
        onChanged: (dst) => setDistance(dst).then((value) async {
          final pref = await SharedPreferences.getInstance();

          final result = pref.get(PrefKeys.distanceSensorMayNotEffective);

          if (setup.distance!.def! > 200 &&
              (result == null || result == false) &&
              CustomDialogs.dontShowDialog == false) {
            CustomDialogs.sureDialogWithCheckBox(
                ref, L10n.inst(context).game_ui_dialog_title_sensor_may,
                prefKey: PrefKeys.distanceSensorMayNotEffective, pressOk: () {
              CustomDialogs.dontShowDialog = false;
            });
          }
        }),
        haptics: true,
        textMapper: (val) =>
            val + L10n.inst(context).activity_distance_selection_cm_unit,
        textStyle: Theme.of(context).textTheme.titleSmall,
        selectedTextStyle: Theme.of(context).textTheme.titleLarge,
      ),
      text: buildText(context, "Mesafe", edgeInset: buildEdgeInsets()),
    );
  }

  static double buildW() => 10.2.w;

  static Widget buildSelectionRadius({
    VoidCallback? onPressed,
    required String text,
    required WidgetRef ref,
    required BuildContext context,
    double width = 100.0,
  }) {
    final initSetup = ref.watch(detailGameSetupProv)!;
    final key = CacheSetupKeys.radius.name;
    final gameId = ref.read(currentGameProv)!.id;
    final setup = ref.watch(currentGameSetupProv)!;

    NumRange initRadius, radius;

    if (initSetup.radius == null || initSetup.radius?.def == null) {
      assert(false);

      initRadius = NumRange.def(defaultGameDuration.inSeconds);
    } else {
      initRadius = initSetup.radius!;
    }

    if (setup.radius == null || setup.radius?.def == null) {
      assert(false);

      radius = initRadius;
    } else {
      radius = setup.radius!;
    }

    void setDuration(int sec) {
      ref
          .read(currentCacheSetupManager.notifier)
          .setCacheAnyValue(ref, whichSetupKey: key, val: sec, gameId: gameId);

      final newSetup = setup.copyWith(
        radius: initRadius.copyWith(def: sec),
      );

      ref.read(currentGameProv.notifier).setSetup(newSetup);
    }

    final min = initRadius.min;
    final max = initRadius.max;
    final step = initRadius.step;

    final sec =
        ((ref.watch(currentCacheSetupManager)['$key/$gameId'] != null) &&
                (ref.watch(currentCacheSetupManager)['$key/$gameId'] as int) <
                    max &&
                (ref.watch(currentCacheSetupManager)['$key/$gameId'] as int) >
                    min)
            ? ref.watch(currentCacheSetupManager)['$key/$gameId']
            : radius.def!;

    return dfContainer(
        leading: Center(
          child: CatchpadIconsV2.degree,
        ),
        content: NumberPicker(
          value: sec,
          minValue: min,
          maxValue: max,
          step: step,
          itemHeight: 20,
          itemWidth: buildW(),
          axis: Axis.horizontal,
          onChanged: setDuration,
          textMapper: (val) =>
              val +
              L10n.inst(ref.context).activity_radius_selection_second_unit,
          textStyle: Theme.of(context).textTheme.titleSmall,
          selectedTextStyle: Theme.of(context).textTheme.titleLarge,
        ),
        text: buildText(context, text),
        action: buildIconButton(() {}));
  }

  static Widget buildSelectionTime({
    VoidCallback? onPressed,
    required String text,
    required WidgetRef ref,
    required BuildContext context,
    double width = 100.0,
  }) {
    final initSetup = ref.watch(detailGameSetupProv)!;
    final key = CacheSetupKeys.gameDuration.name;

    final setup = ref.watch(currentGameSetupProv)!;

    final game = ref.watch(currentGameProv)!;
    NumRange initDuration, duration;

    if (initSetup.duration == null || initSetup.duration?.duration == null) {
      assert(false);

      initDuration = NumRange.def(defaultGameDuration.inSeconds);
    } else {
      initDuration = initSetup.duration!;
    }

    if (setup.duration == null || setup.duration?.duration == null) {
      assert(false);

      duration = initDuration;
    } else {
      duration = setup.duration!;
    }
    final gameId = ref.read(currentGameProv)!.id;

    void setDuration(int sec) {
      ref
          .read(currentCacheSetupManager.notifier)
          .setCacheAnyValue(ref, whichSetupKey: key, val: sec, gameId: gameId);

      final newSetup = setup.copyWith(
        duration: initDuration.copyWith(def: sec),
      );

      ref.read(currentGameProv.notifier).setSetup(newSetup);
    }

    final min = initDuration.min;
    final max = initDuration.max;
    final step = initDuration.step;

    final sec = ((ref.watch(currentCacheSetupManager)['$key/$gameId'] != null))
        ? ref.watch(currentCacheSetupManager)['$key/$gameId']
        : duration.def!;
    print('sec: $sec');
    return dfContainer(
        leading: Center(
          child: CatchpadIconsV2.time,
        ),
        content: NumberPicker(
          value: sec,
          minValue: min,
          maxValue: max,
          step: step,
          itemHeight: 20,
          itemWidth: buildW(),
          axis: Axis.horizontal,
          onChanged: setDuration,
          textMapper: (val) {
            //for fair
            if ((game.id == 's16' || game.id == 's14') &&
                ((game.id == 's14' && val == '40') ||
                    (game.id == 's16' && val == '120')) &&
                adminIdList.contains(ref.read(currentUserProv)!.uid)) {
              return 'Sınırsız';
            }

            return val +
                L10n.inst(context).activity_duration_selection_second_unit;
          },
          textStyle: Theme.of(context).textTheme.titleSmall,
          selectedTextStyle: Theme.of(context).textTheme.titleLarge,
        ),
        text: buildText(context, text),
        action: buildIconButton(() {}));
  }

  static Widget dfSwitch(
      {required String titleOfSwitch,
      required Function(bool) onChangedFunction,
      required WidgetRef ref,
      required Widget icon,
      required ProviderListenable<bool> listenProvider}) {
    return dfContainer(
        leading: Center(child: icon),
        text: buildText(ref.context, titleOfSwitch),
        content: Align(
          alignment: Alignment.centerRight,
          child: Switch(
              activeColor: CpColors.cpPrimary,
              value: ref.watch(listenProvider),
              onChanged: (val) => onChangedFunction(val)),
        ),
        action: buildIconButton(() {}));
  }

  static Widget dfContainerFromStatus(
      {Widget? content,
      Widget? content2,
      BorderRadius? customBorderRadius,
      Color? selectionColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
      child: Container(
        decoration: dfContainerDecoartion(selectionColor, customBorderRadius),
        height: 8.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              content ?? const SizedBox(),
              if (content2 != null) content2
            ],
          ),
        ),
      ),
    );
  }

  static Widget dfContainer(
      {Widget? leading,
      Widget? text,
      Widget? content,
      Widget? action,
      BorderRadius? customBorderRadius,
      Color? selectionColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
      child: Container(
        decoration: dfContainerDecoartion(selectionColor, customBorderRadius),
        height: 8.h,
        child: Row(
          children: [
            if (leading != null)
              Expanded(
                  flex: 2,
                  child: Align(alignment: Alignment.center, child: leading)),
            Expanded(
                flex: leading != null ? 4 : 5, child: text ?? const SizedBox()),
            Expanded(
                flex: 8,
                child: Align(
                    alignment: Alignment.center,
                    child: content ?? const SizedBox())),
            if (action != null)
              Expanded(
                  flex: 2,
                  child: Align(alignment: Alignment.center, child: action)),
          ],
        ),
      ),
    );
  }

  static ShapeDecoration dfContainerDecoartion(
      Color? selectionColor, BorderRadius? customBorderRadius) {
    return ShapeDecoration(
      color: selectionColor ?? CpColors.cpAntiFlashLight,
      shape: RoundedRectangleBorder(
        borderRadius: customBorderRadius ?? BorderRadius.circular(3.w),
      ),
      shadows: const [
        BoxShadow(
          color: Color(0x19000000),
          blurRadius: 4,
          offset: Offset(0, 4),
          spreadRadius: 0,
        )
      ],
    );
  }

  static int flex() => 2;

  static Color activeSelectSensorColor() => Colors.black;
}
