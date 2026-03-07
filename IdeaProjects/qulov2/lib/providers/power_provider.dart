import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/power_model.dart';
import 'api_provider.dart';

class PowerNotifier extends AsyncNotifier<List<PowerModel>> {
  @override
  Future<List<PowerModel>> build() async => [];

  Future<void> fetchPowers() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(powerRepositoryProvider).getPowers());
  }
}

final powerProvider = AsyncNotifierProvider<PowerNotifier, List<PowerModel>>(PowerNotifier.new);
