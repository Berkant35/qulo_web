import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/core/extension/generic_extension.dart';

import 'i_navigation_service.dart';

class NavigationService implements INavigationService {
  static final NavigationService _instance = NavigationService._init();

  static NavigationService get instance => _instance;

  NavigationService._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  get removeAllOldRoutes => (Route<dynamic> route) => false;

  @override
  Future<void> navigateToPage({String? path, Object? data}) async {
    if (path.isNull || navigatorKey.currentState.isNull) return;

    await navigatorKey.currentState!.pushNamed(path!, arguments: data);
  }

  @override
  Future<void> navigateToPageClear({String? path, Object? data}) async {
    if (path.isNull || navigatorKey.currentState.isNull) return;

    await navigatorKey.currentState!.pushNamedAndRemoveUntil(
      path!,
      removeAllOldRoutes,
      arguments: data,
    );
  }

  @override
  Future<void> navigatePopUp({String? path, Object? data}) async {
    if (navigatorKey.currentState.isNull) return;
    navigatorKey.currentState!.pop();
  }

  @override
  Future<void> navigatePopUpUntilPath({String? path, Object? data}) async {
    if (navigatorKey.currentState.isNull) return;

    navigatorKey.currentState!.popUntil((route) => route.settings.name == path);
  }
}
