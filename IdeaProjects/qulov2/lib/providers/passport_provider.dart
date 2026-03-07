import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_provider.dart';

class PassportState {
  final String? city;
  final double? lat;
  final double? lng;
  final bool isActive;
  final bool isLoading;

  const PassportState({this.city, this.lat, this.lng, this.isActive = false, this.isLoading = false});

  PassportState copyWith({String? city, double? lat, double? lng, bool? isActive, bool? isLoading}) {
    return PassportState(
      city: city ?? this.city,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      isActive: isActive ?? this.isActive,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class PassportNotifier extends Notifier<PassportState> {
  @override
  PassportState build() => const PassportState();

  Future<void> activate({required String city, required double lat, required double lng}) async {
    state = state.copyWith(isLoading: true);
    try {
      final repo = ref.read(passportRepositoryProvider);
      await repo.activate(city: city, lat: lat, lng: lng);
      state = PassportState(city: city, lat: lat, lng: lng, isActive: true);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  Future<void> deactivate() async {
    state = state.copyWith(isLoading: true);
    try {
      final repo = ref.read(passportRepositoryProvider);
      await repo.deactivate();
      state = const PassportState();
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  void syncFromUser(String? city, double? lat, double? lng) {
    if (city != null) {
      state = PassportState(city: city, lat: lat, lng: lng, isActive: true);
    }
  }
}

final passportProvider = NotifierProvider<PassportNotifier, PassportState>(PassportNotifier.new);
