import 'package:json_annotation/json_annotation.dart';

part 'pagination_param.g.dart';

@JsonSerializable()
class PaginationParam {
  @JsonKey(name: 'PageNumber')
  final int page;
  @JsonKey(name: 'PageSize')
  final int? pageSize;

  PaginationParam({required this.page, this.pageSize = 10});

  @override
  factory PaginationParam.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParamToJson(this);
}
