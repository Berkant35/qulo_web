import 'dart:io';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatService {
  static const _appleApiKey = 'appl_XXXX'; // TODO: Replace with actual key
  static const _googleApiKey = 'goog_XXXX'; // TODO: Replace with actual key

  static Future<void> init(String userId) async {
    final apiKey = Platform.isIOS ? _appleApiKey : _googleApiKey;
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
