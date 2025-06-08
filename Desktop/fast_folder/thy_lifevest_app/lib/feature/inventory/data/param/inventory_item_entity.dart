import 'package:thy_lifevest_app/core/extension/string_extension.dart';

class InventoryItemEntity {
  final String? epc;
  

  InventoryItemEntity({this.epc});

  String toJson() {
    return epc.getValueOrDefault;
  }
}
