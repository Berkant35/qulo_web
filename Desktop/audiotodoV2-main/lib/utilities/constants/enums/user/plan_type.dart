
import 'package:audiotodo/utilities/constants/extensions/time_extension.dart';

import '../../../../generated/l10n.dart';

enum PlanType {
  none("none"),
  basic("basic"),
  trial("trial"),
  pro("pro");


  static const basicDuration = 48000;
  static const proDuration = 96000;
  static const trialDuration = 7200;

  static const basicRecreateMax = 25;
  static const trialRecreateMax = 1;
  static const proRecreateMax = 50;

  ///From string to [PlanType]
  final String label; // define a private field

  const PlanType(this.label); // constructor

  static PlanType fromString(String label) { // static parser method
    return values.firstWhere(
          (v) => v.label == label,
      orElse: () => PlanType.none,
    );
  }

  // Get Monthly Or Yearly String by planDetail
  static String getPlanDurationString(String planType) {
    switch (planType) {
      case "BASIC_PLAN_MONTHLY":
      case "PRO_PLAN_MONTHLY":
        return S.current.monthly;
      case "BASIC_PLAN_YEARLY":
      case "PRO_PLAN_YEARLY":
        return S.current.yearly;
      default:
        return "";
    }
  }

  // Get Monthly Or Yearly String by planDetail
  static Duration getPlanExpirationDiff(String planType) {
    switch (planType) {
      case "BASIC_PLAN_MONTHLY":
        return const Duration(days: 30);
      case "PRO_PLAN_MONTHLY":
        return const Duration(days: 30);
      case "BASIC_PLAN_YEARLY":
        return const Duration(days: 365);
      case "PRO_PLAN_YEARLY":
        return const Duration(days: 365);
      default:
        return Duration.zero;
    }
  }

  static String getExpirationDateFromToday(String planType) {
    final now = DateTime.now();
    final expirationDate = now.add(getPlanExpirationDiff(planType));
    return expirationDate.forceExpirationServerFormat;
  }




  static int getDuration(PlanType planType) {
    switch (planType) {
      case PlanType.basic:
        return basicDuration;
      case PlanType.pro:
        return proDuration;
      case PlanType.trial:
        return trialDuration;
      default:
        return 0;
    }
  }
  static int getRecreateCount(PlanType planType) {
    switch (planType) {
      case PlanType.basic:
        return basicRecreateMax;
      case PlanType.pro:
        return proRecreateMax;
      case PlanType.trial:
        return trialRecreateMax;
      default:
        return 0;
    }
  }
}


