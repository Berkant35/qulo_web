import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/diamond_model.dart';
import 'api_provider.dart';

class DiamondNotifier extends AsyncNotifier<DiamondBalance> {
  @override
  Future<DiamondBalance> build() async {
    return const DiamondBalance(green: 0, purple: 0);
  }

  Future<void> fetchBalance() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(diamondRepositoryProvider).getBalance());
  }

  Future<DiamondHistoryResponse> fetchHistory({int page = 1}) async {
    final repo = ref.read(diamondRepositoryProvider);
    return repo.getHistory(page: page);
  }

  Future<void> purchase(String productId) async {
    final repo = ref.read(diamondRepositoryProvider);
    await repo.purchase(productId);
    await fetchBalance();
  }
}

final diamondProvider = AsyncNotifierProvider<DiamondNotifier, DiamondBalance>(DiamondNotifier.new);
