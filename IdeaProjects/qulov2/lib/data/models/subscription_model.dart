import 'package:equatable/equatable.dart';

class SubscriptionStatusResponse {
  final SubscriptionInfo subscription;
  final SubscriptionLimits limits;

  const SubscriptionStatusResponse({
    required this.subscription,
    required this.limits,
  });

  factory SubscriptionStatusResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionStatusResponse(
      subscription: json['subscription'] != null
          ? SubscriptionInfo.fromJson(json['subscription'] as Map<String, dynamic>)
          : SubscriptionInfo.free(),
      limits: json['limits'] != null
          ? SubscriptionLimits.fromJson(json['limits'] as Map<String, dynamic>)
          : const SubscriptionLimits(
              dailySwipes: 20,
              dailyUndos: 0,
              monthlyPurpleBonus: 0,
              weeklyBoosts: 0,
              canSeeWhoViewed: false,
              hasAds: true,
            ),
    );
  }
}

class SubscriptionInfo extends Equatable {
  final String? plan;
  final String? status;
  final String? expiresAt;
  final bool isActive;

  const SubscriptionInfo({
    this.plan,
    this.status,
    this.expiresAt,
    this.isActive = false,
  });

  bool get isPlus => isActive && plan == 'plus';
  bool get isPremium => isActive && plan == 'premium';
  bool get isFree => !isActive;
  bool get hasAds => isFree;
  bool get canSeeWhoViewed => isPremium;

  int get dailySwipeLimit => isPremium
      ? 999999
      : isPlus
          ? 50
          : 20;

  int get dailyUndoLimit => isPremium
      ? 999999
      : isPlus
          ? 3
          : 0;

  int get monthlyPurpleBonus => isPremium
      ? 300
      : isPlus
          ? 100
          : 0;

  factory SubscriptionInfo.fromJson(Map<String, dynamic> json) {
    return SubscriptionInfo(
      plan: json['plan'] as String?,
      status: json['status'] as String?,
      expiresAt: json['expiresAt'] as String?,
      isActive: json['isActive'] as bool? ?? false,
    );
  }

  factory SubscriptionInfo.free() => const SubscriptionInfo();

  @override
  List<Object?> get props => [plan, status, expiresAt, isActive];
}

class SubscriptionLimits extends Equatable {
  final int dailySwipes;
  final int dailyUndos;
  final int monthlyPurpleBonus;
  final int weeklyBoosts;
  final bool canSeeWhoViewed;
  final bool hasAds;

  const SubscriptionLimits({
    required this.dailySwipes,
    required this.dailyUndos,
    required this.monthlyPurpleBonus,
    required this.weeklyBoosts,
    required this.canSeeWhoViewed,
    required this.hasAds,
  });

  factory SubscriptionLimits.fromJson(Map<String, dynamic> json) {
    return SubscriptionLimits(
      dailySwipes: json['dailySwipes'] as int? ?? 20,
      dailyUndos: json['dailyUndos'] as int? ?? 0,
      monthlyPurpleBonus: json['monthlyPurpleBonus'] as int? ?? 0,
      weeklyBoosts: json['weeklyBoosts'] as int? ?? 0,
      canSeeWhoViewed: json['canSeeWhoViewed'] as bool? ?? false,
      hasAds: json['hasAds'] as bool? ?? true,
    );
  }

  @override
  List<Object?> get props => [
        dailySwipes,
        dailyUndos,
        monthlyPurpleBonus,
        weeklyBoosts,
        canSeeWhoViewed,
        hasAds,
      ];
}
