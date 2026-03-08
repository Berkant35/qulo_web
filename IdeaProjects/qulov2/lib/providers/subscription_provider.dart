import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../core/services/revenuecat_service.dart';
import '../data/models/subscription_model.dart';
import 'api_provider.dart';

class SubscriptionNotifier extends AsyncNotifier<SubscriptionInfo> {
  @override
  Future<SubscriptionInfo> build() async {
    return await fetchStatus();
  }

  Future<SubscriptionInfo> fetchStatus() async {
    try {
      final result = await ref.read(subscriptionRepositoryProvider).getStatus();
      return result.when(
        success: (data) => data,
        failure: (_) => SubscriptionInfo.free(),
      );
    } catch (_) {
      return SubscriptionInfo.free();
    }
  }

  Future<bool> purchasePackage(Package package) async {
    try {
      await RevenueCatService.purchasePackage(package);
      state = AsyncData(await fetchStatus());
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> restorePurchases() async {
    try {
      await RevenueCatService.restorePurchases();
      state = AsyncData(await fetchStatus());
    } catch (_) {
      // Silently fail
    }
  }
}

final subscriptionProvider =
    AsyncNotifierProvider<SubscriptionNotifier, SubscriptionInfo>(
  SubscriptionNotifier.new,
);
