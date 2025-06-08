// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationParam _$PaginationParamFromJson(Map<String, dynamic> json) =>
    PaginationParam(
      page: (json['PageNumber'] as num).toInt(),
      pageSize: (json['PageSize'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$PaginationParamToJson(PaginationParam instance) =>
    <String, dynamic>{
      'PageNumber': instance.page,
      'PageSize': instance.pageSize,
    };
