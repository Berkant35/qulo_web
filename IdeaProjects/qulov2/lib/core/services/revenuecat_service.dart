import 'dart:io';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../config/env.dart';

class RevenueCatService {
  static Future<void> init(String userId) async {
    final apiKey = Platform.isIOS
        ? Env.revenueCatAppleKey
        : Env.revenueCatGoogleKey;

    if (apiKey.isEmpty) return;

    final config = PurchasesConfiguration(apiKey)..appUserID = userId;
    await Purchases.configure(config);
  }

  static Future<Offerings> getOfferings() async {
    return await Purchases.getOfferings();
  }

  static Future<CustomerInfo> purchasePackage(Package package) async {
    return await Purchases.purchasePackage(package);
  }

  static Future<CustomerInfo> restorePurchases() async {
    return await Purchases.restorePurchases();
  }

  static Future<CustomerInfo> getCustomerInfo() async {
    return await Purchases.getCustomerInfo();
  }

  static Future<void> logIn(String userId) async {
    await Purchases.logIn(userId);
  }

  static Future<void> logOut() async {
    await Purchases.logOut();
  }
}
