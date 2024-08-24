import 'package:audiotodo/line/db/firebase/fb_db/fb_db_manager.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/constants/enums/user/plan_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

// This provider allows us to change which plan a user has and make changes to
// this plan on firebase.

class CurrentPlanControlNotifier extends StateNotifier<PlanType> {
  CurrentPlanControlNotifier(PlanType state) : super(PlanType.none);
  final fbDbManager = FirebaseDbManager();

  Future<void> initializeListenPlans(WidgetRef ref) async {
    //ad listener for purchases
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();

    // logger.w(customerInfo.toJson());

    final user = ref.read(authManager);

    final expirationDate = user?.currentSubscriptionExpirationDate;
    DateTime? dateTime;
    if (user!.planType != PlanType.none && user!.planType != PlanType.trial) {
      dateTime = DateTime.parse(expirationDate!);
    }

    // if user has active subscription and it is not admin control and it is not expired
    if (customerInfo.activeSubscriptions.isEmpty &&
        !ref.read(currentAdminControlState) &&
        dateTime != null &&
        dateTime.isBefore(DateTime.now())) {
      state = PlanType.none;
      if (user != null && user.planType != PlanType.none) {
        final newAttributeForUser = ref.read(authManager)!.copyWith(
              planType: state,
              planDetail: PlanType.none.name,
              totalRecordSeconds: PlanType.getDuration(state),
              totalRecreateCount: PlanType.getRecreateCount(state),
              // currentSubscriptionExpirationDate: PlanType.getExpirationDateFromToday(planType)
            );

        ref.read(authManager.notifier).changeUser(newAttributeForUser);

        await fbDbManager.updatePlanForUser(ref,
            planType: state, planDetail: PlanType.none.name);
      }
    }

    // logger.w(customerInfo.toJson());
  }

  void changState(PlanType val) => state = val;

  Future<bool> subscriptionAfterUpdate(WidgetRef ref, String planDetail) async {
    try {
      final newAttributeForUser = ref.read(authManager)!.copyWith(
          planType: state,
          planDetail: planDetail,
          totalRecordSeconds: PlanType.getDuration(state),
          totalRecreateCount: PlanType.getRecreateCount(state),
          currentSubscriptionExpirationDate:
              PlanType.getExpirationDateFromToday(planDetail));

      ref.read(authManager.notifier).changeUser(newAttributeForUser);

      assert(ref.read(authManager)!.totalRecordSeconds ==
          PlanType.getDuration(state));

      await fbDbManager.updatePlanForUser(ref,
          planType: state, planDetail: planDetail);
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }
}
