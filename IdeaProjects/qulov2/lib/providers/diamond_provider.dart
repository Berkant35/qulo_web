import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../core/network/result.dart';
import '../core/services/revenuecat_service.dart';
import '../data/models/diamond_model.dart';
import 'api_provider.dart';

class DiamondNotifier extends AsyncNotifier<DiamondBalance> {
  @override
  Future<DiamondBalance> build() async {
    return const DiamondBalance(green: 0, purple: 0);
  }

  Future<void> fetchBalance() async {
    state = const AsyncLoading();
    final result = await ref.read(diamondRepositoryProvider).getBalance();
    state = result.when(
      success: (data) => AsyncData(data),
      failure: (f) => AsyncError(f, StackTrace.current),
    );
  }

  Future<Result<DiamondHistoryResponse>> fetchHistory({int page = 1}) async {
    return ref.read(diamondRepositoryProvider).getHistory(page: page);
  }

  Future<Result<void>> purchase(String productId) async {
    final result = await ref.read(diamondRepositoryProvider).purchase(productId);
    result.when(success: (_) => fetchBalance(), failure: (_) {});
    return result;
  }

  Future<bool> purchaseConsumable(Package package) async {
    try {
      await RevenueCatService.purchasePackage(package);
      // Webhook will credit diamonds — just refresh balance
      await fetchBalance();
      return true;
    } catch (_) {
      return false;
    }
  }
}

final diamondProvider = AsyncNotifierProvider<DiamondNotifier, DiamondBalance>(DiamondNotifier.new);
