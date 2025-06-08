import 'package:flutter/material.dart';
import 'package:thy_lifevest_app/feature/auth/view/splash_page.dart';
import 'package:thy_lifevest_app/feature/bluetooth/view/bluetooth_page.dart';
import 'package:thy_lifevest_app/feature/inventory/view/inventory_page.dart';
import 'package:thy_lifevest_app/feature/home/view/home_page.dart';
import 'package:thy_lifevest_app/feature/reader/view/rfid_settings_page.dart';

import 'navigation_constants.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();

  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.splashPage:
        return normalNavigate(const SplashPage());
      case NavigationConstants.homePage:
        return normalNavigate(const HomePage());
      case NavigationConstants.bluetoothPage:
        return normalNavigate(const BluetoothPage());
      case NavigationConstants.rfidSettingsPage:
        return normalNavigate(const RfidSettingsPage());
      case NavigationConstants.inventoryPage:
        return normalNavigate(const InventoryPage());
      default:
        return MaterialPageRoute(builder: (context) => const SplashPage());
    }
  }

  PageRouteBuilder normalNavigate(Widget widget) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}
