import 'package:json_annotation/json_annotation.dart';

part 'empty_dto.g.dart';

@JsonSerializable()
class EmptyDto {
  EmptyDto();

  @override
  factory EmptyDto.fromJson(Map<String, dynamic> json) =>
      _$EmptyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EmptyDtoToJson(this);
}
