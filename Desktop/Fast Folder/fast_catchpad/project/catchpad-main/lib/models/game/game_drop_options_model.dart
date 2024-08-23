class GameDropOptionsModel  {
  final String? dropOptionTitle;
  final List<DropOption>? options;

  GameDropOptionsModel({this.dropOptionTitle, this.options});
}
class DropOption  {
  final String optionTitle;
  final dynamic optionValue;

  DropOption({required this.optionTitle, this.optionValue});
}