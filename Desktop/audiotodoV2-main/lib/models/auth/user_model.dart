import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../utilities/constants/enums/user/plan_type.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

typedef TodoPlatformTokens = Map<String,String>;

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    String? userId,
    @Default("")
    String? email,
    @Default("")
    String? userName,
    @Default("")
    String? surName,
    @Default("")
    String? companyName,
    @Default("")
    String? companyCountry,
    @Default("")
    String? companyCity,
    @Default("")
    String? companyId,
    String? platform,
    String? lastSignIn,
    @Default("")
    String? photoUrl,
    @Default("")
    String? planDetail,
    String? currentSubscriptionExpirationDate,
    @Default(PlanType.none)
    PlanType planType,
    @Default(0)
    int? totalRecreateCount,
    @Default(0)
    int? usedRecordSeconds,
    @Default(0)
    int? totalRecordSeconds,
    @Default(false)
    bool? firstEnter,
    @Default("")
    String? pushToken,
    @Default([])
    List<String>? friendIdList,
    @Default({})
    TodoPlatformTokens? todoPlatformTokens,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) => _$UserModelFromJson(json);
}
