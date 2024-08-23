import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'version_model.freezed.dart'; // Generated code for freezed
part 'version_model.g.dart'; // Generated code for json_serializable

@freezed // Generates a union class using freezed package
class VersionModel with _$VersionModel {
  const factory VersionModel({
    @JsonKey(name: 'buildNumber') int? buildNumber, // JSON key for build number
    @JsonKey(name: 'forceRequired') bool? forceRequired, // JSON key for force requirement
    @JsonKey(name: 'version') String? version, // JSON key for version number
    @JsonKey(name: 'link') String? link, // JSON key for link
  }) = _VersionModel; // Constructor for union class

  factory VersionModel.fromJson(Map<String, Object?> json) =>
      _$VersionModelFromJson(json); // Generates factory constructor using json_serializable package
}
