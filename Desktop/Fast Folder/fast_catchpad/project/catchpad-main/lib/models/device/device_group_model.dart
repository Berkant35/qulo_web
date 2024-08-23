import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';

/// this is a view model
/// that defines the DeviceGroup widget
class DeviceGroupModel {
  final String title;
  final bool connected;
  final Iterable<DeviceModel> devices;

  const DeviceGroupModel({
    required this.title,
    required this.connected,
    required this.devices,
  });
}
