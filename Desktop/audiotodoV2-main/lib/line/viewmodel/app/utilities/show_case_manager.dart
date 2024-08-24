import 'package:audiotodo/line/viewmodel/global_export.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/constants/enums/app/show_case_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../core/navigation/navigation_service.dart';

typedef ShowCS = Map<String, GlobalKey>;

final currentAllShowCases =
    StateNotifierProvider<ShowCaseControlNotifier, Set<ShowCaseInfo>>(
        (_) => ShowCaseControlNotifier({}));

class ShowCaseControlNotifier extends StateNotifier<Set<ShowCaseInfo>> {
  ShowCaseControlNotifier(Set<ShowCaseInfo> state) : super({});

  Set<ShowCaseInfo> allShowCases = {};
  ShowCS showCSGlobalKeys = {};
  ShowCS needShowCaseGlobalKeys = {};

  List<GlobalKey> dontShowAgainTemp = [];

  bool favoriteForceOnce = false;
  bool connectedForceOnce = false;

  final formkey = GlobalKey<FormState>();

  void setTrueFavoriteForceOnce() => favoriteForceOnce = true;

  void setTrueConnectedForceOnce() => connectedForceOnce = true;

  Future<void> clearAllOnboardingShowCaseFromLocale(WidgetRef ref) async {
    final _ftr = <Future>[];
    dontShowAgainTemp.clear();

    for (var perTip in ShowCaseStates.values) {
      _ftr.add(ref
          .read(currentPreferencesControlNotifier.notifier)
          .deleteShowCaseIsSeen(ref, perTip.name));
    }
    needShowCaseGlobalKeys.clear();
    allShowCases.clear();
    showCSGlobalKeys.clear();
    dontShowAgainTemp.clear();

    await Future.wait(_ftr);
    await initializeShowCases(ref);
  }

  // Initialize if onboarding not showing any time. [onboarding]
  Future<void> initializeShowCases(WidgetRef ref) async {
    favoriteForceOnce = false;
    connectedForceOnce = false;

    // Create ShowCaseInfo models for all [ShowCaseStates]
    for (var perTip in ShowCaseStates.values) {
      allShowCases.add(ShowCaseInfo(
          key: perTip.name,
          description: perTip.getCurrentShowCaseDescription(),
          edgeInsets: perTip.getEdgeInsets(),
          tooltipPosition: perTip.getTooltipPosition(),
          showCaseStates: perTip));
    }
    // Set the state
    state = allShowCases;

    //Waiting Show Case List
    List<ShowCaseInfo> needShowCases = [];

    // Need check shared prefs
    for (var perOnBoardingCase in allShowCases.toList()) {
      final hasBeforeShownCase = await ref
          .read(currentPreferencesControlNotifier.notifier)
          .checkShowCaseIsSeen(ref, perOnBoardingCase.key);
      if (!hasBeforeShownCase) {
        needShowCases.add(perOnBoardingCase);
      }
    }

    // Okay if i have need show any 'showcase' we need add global key list
    for (var perNeedShowCase in needShowCases) {
      needShowCaseGlobalKeys.addAll({perNeedShowCase.key: GlobalKey()});
    }

    showCSGlobalKeys.addAll(needShowCaseGlobalKeys);
  }

  void forceRemove(String key) => needShowCaseGlobalKeys.remove(key);

  void showCaseIn(
      {required BuildContext context,
      List<GlobalKey>? customGlobalKeys,
      required WidgetRef ref}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final showCaseWidget = ShowCaseWidget.of(context);
      if (showCaseWidget != null) {
        showCaseWidget.startShowCase(needShowCaseGlobalKeys.values.toList());
      } else {
        print('ShowCaseWidget context is null.');
      }
    });

  }

  void showCaseCustom(
      {required BuildContext context, required GlobalKey globalKey}) {
    ShowCaseWidget.of(context).startShowCase([globalKey]);
  }

  Future<void> itsDoneShowCase(WidgetRef ref, ShowCaseInfo showCaseInfo) async {
    final res = await ref
        .read(currentPreferencesControlNotifier.notifier)
        .showCaseIsSeenSetTrue(ref, showCaseInfo.key);
    if (res) {
      needShowCaseGlobalKeys.remove(showCaseInfo.key);
      dontShowAgainTemp.add(showCSGlobalKeys[showCaseInfo.key]!);
    }
  }
}

class ShowCaseInfo {
  final String key;
  final String description;
  final EdgeInsets edgeInsets;
  final ShowCaseStates showCaseStates;
  final TooltipPosition tooltipPosition;

  ShowCaseInfo(
      {required this.key,
      required this.description,
      required this.edgeInsets,
      required this.showCaseStates,
      required this.tooltipPosition});
}
