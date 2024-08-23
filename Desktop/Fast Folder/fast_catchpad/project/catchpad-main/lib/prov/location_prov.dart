import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

class CurrentLocationNotifier extends StateNotifier<LocationData?> {
  CurrentLocationNotifier(LocationData? state) : super(null);

  Location? _location;

  Future<Location?> initialize(WidgetRef ref) async {
    _location = Location();
    return _location!;
  }

  Future<void> getLocationAndUpdate(WidgetRef ref) async {
    if (_location == null) await initialize(ref);

    final currentLocation = await _location!.getLocation();

    updateLocation(ref, currentLocation);
  }

  void updateLocation(WidgetRef ref, LocationData locationData) =>
      state = locationData;
}
