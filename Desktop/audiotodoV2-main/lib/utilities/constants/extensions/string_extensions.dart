



//capatalize first letter of string
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  //check format dd-MM-yyyy
  bool isDate() {
    const datePattern = r'^\d{2}-\d{2}-\d{4}$';
    final regExp = RegExp(datePattern);
    return regExp.hasMatch(this);
  }

}