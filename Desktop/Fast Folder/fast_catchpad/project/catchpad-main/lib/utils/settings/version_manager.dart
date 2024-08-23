import 'package:catchpad/utils/exceptions/custom_exception.dart';

class VersionManager {
  String deviceValue;
  String databaseValue;

  VersionManager({required this.deviceValue, required this.databaseValue});

  bool isNeedUpdate() {
    final deviceValueSplit = deviceValue.split('.').join();
    final databaseValueSplit = databaseValue.split('.').join();

    final deviceNumber = int.tryParse(deviceValueSplit);
    final databaseNumber = int.tryParse(databaseValueSplit);

    if (deviceNumber == null || databaseNumber == null) {
      throw VersionCustomException(
          '$deviceValue or $databaseValue is not valid for parse');
    }
    return deviceNumber < databaseNumber;
  }
}
