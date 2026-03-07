import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'api_provider.dart';

class LocationState {
  final double? lat;
  final double? lng;
  final bool isLoading;
  final String? error;

  const LocationState({this.lat, this.lng, this.isLoading = false, this.error});

  LocationState copyWith({double? lat, double? lng, bool? isLoading, String? error}) {
    return LocationState(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class LocationNotifier extends Notifier<LocationState> {
  @override
  LocationState build() => const LocationState();

  Future<void> getCurrentLocation() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = state.copyWith(isLoading: false, error: 'LOCATION_SERVICE_DISABLED');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          state = state.copyWith(isLoading: false, error: 'LOCATION_PERMISSION_DENIED');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        state = state.copyWith(isLoading: false, error: 'LOCATION_PERMISSION_DENIED_FOREVER');
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.medium),
      );

      state = state.copyWith(lat: position.latitude, lng: position.longitude, isLoading: false);

      final repo = ref.read(userRepositoryProvider);
      await repo.updateLocation(lat: position.latitude, lng: position.longitude);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final locationProvider = NotifierProvider<LocationNotifier, LocationState>(LocationNotifier.new);
