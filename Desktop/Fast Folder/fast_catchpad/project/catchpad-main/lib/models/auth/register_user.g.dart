// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterUser _$RegisterUserFromJson(Map<String, dynamic> json) => RegisterUser(
      mode: $enumDecodeNullable(_$RegisterModeEnumMap, json['mode']),
      userName: json['userName'] as String,
      phoneNum: json['phoneNum'] as String?,
      email: json['email'] as String?,
      fName: json['fName'] as String?,
      lName: json['lName'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      uid: json['uid'] as String?,
    );

Map<String, dynamic> _$RegisterUserToJson(RegisterUser instance) =>
    <String, dynamic>{
      'phoneNum': instance.phoneNum,
      'email': instance.email,
      'fName': instance.fName,
      'lName': instance.lName,
      'uid': instance.uid,
      'createdAt': instance.createdAt?.toIso8601String(),
      'userName': instance.userName,
      'mode': _$RegisterModeEnumMap[instance.mode],
    };

const _$RegisterModeEnumMap = {
  RegisterMode.email: 'email',
  RegisterMode.phone: 'phone',
};
