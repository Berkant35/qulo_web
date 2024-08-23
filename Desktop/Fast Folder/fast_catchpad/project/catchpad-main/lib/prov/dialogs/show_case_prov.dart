import 'package:catchpad/models/enums/utility/show_case_enum.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../models/bottom_bar_item.dart';

typedef TipGlobalKeys = Map<String, GlobalKey>;

final currentAllShowCases =
    StateNotifierProvider<ShowCaseControlNotifier, Set<ShowCaseInfo>>(
        (_) => ShowCaseControlNotifier({}));

class ShowCaseControlNotifier extends StateNotifier<Set<ShowCaseInfo>> {
  ShowCaseControlNotifier(Set<ShowCaseInfo> state) : super({});
  late SharedPreferences sPref;
  Set<ShowCaseInfo> allShowCases = {};
  TipGlobalKeys tipGlobalKeys = {};
  TipGlobalKeys needShowCaseGlobalKeys = {};

  List<GlobalKey> dontShowAgainTemp = [];

  bool favoriteForceOnce = false;
  bool connectedForceOnce = false;

  final formkey = GlobalKey<FormState>();

  void setTrueFavoriteForceOnce() => favoriteForceOnce = true;

  void setTrueConnectedForceOnce() => connectedForceOnce = true;


  Future<void> clearAllOnboardingShowCaseFromLocale(WidgetRef ref) async {
    final _ftr = <Future>[];
    dontShowAgainTemp.clear();

    for (var perTip in Tips.values) {
      _ftr.add(sPref.remove(perTip.name));
    }
    needShowCaseGlobalKeys.clear();
    allShowCases.clear();
    tipGlobalKeys.clear();
    dontShowAgainTemp.clear();

    await Future.wait(_ftr);
    await initializeShowCases(ref);
  }


  // Initialize if onboarding not showing any time. [onboarding]
  Future<void> initializeShowCases(WidgetRef ref) async {
    sPref = await SharedPreferences.getInstance();
    //REMOVE THIS CODE ------
    /*
    for (var perTip in Tips.values) {
      sPref.remove(perTip.name);
    }*/
    //REMOVE THIS CODE ------
    favoriteForceOnce = false;
    connectedForceOnce = false;
    //Fill all Show Case Content

    for (var perTip in Tips.values) {
      allShowCases.add(ShowCaseInfo(
          key: perTip.name,
          showCaseAppState: perTip.getShowCaseAppState(),
          title: perTip.getTitle(ref),
          description: perTip.getDescription(ref)));
    }


    state = allShowCases;


    final onBoardingCaseStates = allShowCases.where(
        (element) => element.showCaseAppState == ShowCaseAppState.onboarding);

    final onBoardingSpecialCaseStates = allShowCases.where((element) =>
        element.showCaseAppState == ShowCaseAppState.specialOnBoarding);

    //Waiting Show Case List
    List<ShowCaseInfo> needShowCases = [];

    // Need check shared prefs
    for (var perOnBoardingCase in onBoardingCaseStates.toList()) {
      final hasBeforeShownCase = sPref.getBool(perOnBoardingCase.key);
      if (hasBeforeShownCase == null || !hasBeforeShownCase) {
        needShowCases.add(perOnBoardingCase);
      }
    }

    // Okay if i have need show any 'showcase' we need add global key list
    for (var perNeedShowCase in needShowCases) {
      needShowCaseGlobalKeys.addAll({perNeedShowCase.key: GlobalKey()});
    }

    for (var perShowInfo in state) {
      if (!needShowCaseGlobalKeys.containsKey(perShowInfo.key)) {
        tipGlobalKeys.addAll({perShowInfo.key: GlobalKey()});
      }
    }

    tipGlobalKeys.addAll(needShowCaseGlobalKeys);

    // Need check shared prefs
    for (var perOnBoardingCase in onBoardingSpecialCaseStates.toList()) {
      final hasBeforeShownCase = sPref.getBool(perOnBoardingCase.key);
      if (hasBeforeShownCase != null && hasBeforeShownCase) {
        dontShowAgainTemp.add(tipGlobalKeys[perOnBoardingCase.key]!);
      }
    }
  }

  void forceRemove(String key) => needShowCaseGlobalKeys.remove(key);

  void showCaseIn(
      {required BuildContext context,
      List<GlobalKey>? customGlobalKeys,
      required WidgetRef ref}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final globalKeys = customGlobalKeys ?? [];
      if (globalKeys.isNotEmpty) {

        globalKeys
            .removeWhere((element) => dontShowAgainTemp.contains(element));

        if (globalKeys.isNotEmpty) {
          ShowCaseWidget.of(context).startShowCase(globalKeys);
          dontShowAgainTemp.addAll(globalKeys);
        }

        /*for (var globalKey in globalKeys) {
          if (dontShowAgainTemp.contains(globalKey)) {
            globalKeys.remove(globalKey);
          }
        }
        if (globalKeys.isNotEmpty) {
          ShowCaseWidget.of(context).startShowCase(globalKeys);
        }*/
      } else if (needShowCaseGlobalKeys.isNotEmpty) {
        ShowCaseWidget.of(context)
            .startShowCase(needShowCaseGlobalKeys.values.toList());
      }
    });
  }

  void showCaseCustom(
      {required BuildContext context, required GlobalKey globalKey}) {
    ShowCaseWidget.of(context).startShowCase([globalKey]);

  }

  Future<void> itsDoneShowCase(WidgetRef ref, ShowCaseInfo showCaseInfo) async {

    if (showCaseInfo.showCaseAppState == ShowCaseAppState.onboarding) {
      final res = await sPref.setBool(showCaseInfo.key, true);
      if (res) {
        needShowCaseGlobalKeys.remove(showCaseInfo.key);
      }

      if(showCaseInfo.key == Tips.exercisesShowCase.name){
        ref.read(bottomBarProvider.notifier)
            .setBottomBarItem(0, ref);
      }
      if(showCaseInfo.key == Tips.profile.name){
        ref.read(bottomBarProvider.notifier)
            .setBottomBarItem(1, ref);
      }

    } else if (showCaseInfo.showCaseAppState ==
        ShowCaseAppState.specialOnBoarding) {
      print(showCaseInfo.key);
      final res = await sPref.setBool(showCaseInfo.key, true);
      if (res) {
        dontShowAgainTemp.add(tipGlobalKeys[showCaseInfo.key]!);
      }
    }
  }

// When u want see show case on info tag you must click to "?" icon. [info]

// Widget need global keys! and also must have a title and description 3 parameter. idk we should use model or map

// Has it been shown before
}

class ShowCaseInfo {
  final String key;
  final ShowCaseAppState showCaseAppState;
  final String title;
  final String description;

  ShowCaseInfo(
      {required this.key,
      required this.showCaseAppState,
      required this.title,
      required this.description});
}
