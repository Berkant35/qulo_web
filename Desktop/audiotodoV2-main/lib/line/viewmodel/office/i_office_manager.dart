///This abstract class create to help for when we want share to current
///meet with office elements

enum OfficesType { pdf }

abstract class IOfficeManager {
  Future<bool> saveFormat(
      Map<String, dynamic> officeAttributes, OfficesType officesType);

  Future<bool> shareToFile();
}
