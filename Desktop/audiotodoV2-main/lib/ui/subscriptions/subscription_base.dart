import 'package:audiotodo/utilities/constants/enums/user/plan_type.dart';
import 'package:audiotodo/utilities/constants/enums/user/product_plans.dart';
import 'package:audiotodo/utilities/constants/extensions/edge_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/icon_size_extensions.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dialog_shower/dialog/dialog_shower.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/theme/custom_colors.dart';
import '../../generated/l10n.dart';
import '../../line/viewmodel/global_providers.dart';
import '../../utilities/components/dialogs/basic_dialogs.dart';
import '../../utilities/constants/exceptions/buy_exceptions.dart';


part 'subscription_base_mixin.dart';

class SubscriptionBase extends ConsumerStatefulWidget {
  const SubscriptionBase({
    super.key,
  });

  @override
  ConsumerState createState() => _SubscriptionBaseState();
}

class _SubscriptionBaseState extends ConsumerState<SubscriptionBase>
    with SingleTickerProviderStateMixin,SubscriptionBaseMixin{
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_handleTabSelection);
    Future((){
      getAllProducts();
      ref.read(currentPlanControlNotifier.notifier).initializeListenPlans(ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      child: Column(
        children: [
          Expanded(child: _header()),
          _tabView(),
          Expanded(flex: 8, child: _tabContent()),
        ],
      ),
    );
  }

  Widget _header() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: 18.w,
      ),

      Text(
        S.current.subscription_select_a_plan,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.w700),
      ),
      Padding(
        padding: EdgeInsets.only(right: 4.w),
        child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon:  Icon(Icons.cancel_outlined,size: IconSizeExtension.medium.sizeValue,)),
      ),
    ],
  );

  Widget _tabView() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _tabButton("Basic", 0),
            SizedBox(width: 2.w),
            _tabButton("Pro", 1),
          ],
        ),
        SizedBox(height: 1.h),
      ],
    );
  }

  Widget _tabButton(String title, int index) {
    bool isSelected = tabController.index == index;
    return Column(
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              tabController.index = index;
            });
          },
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: isSelected ? CustomColors.primaryColor : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _tabContent() {
    return TabBarView(
      controller: tabController,
      children: [
        contentOfPlan(basicPlan(), PlanType.basic),
        contentOfPlan(proPlan(), PlanType.pro),
      ],
    );
  }

  Container contentOfPlan(Widget content, PlanType planType) {
    return Container(
      color: CustomColors.grey2Color.withOpacity(0.2),
      child: SingleChildScrollView(
        child: Column(
          children: [content, pay(planType)],
        ),
      ),
    );
  }

  Padding pay(PlanType planType) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: EdgeExtension.normalEdge.edgeValue,
          vertical: EdgeExtension.hugeEdge.edgeValue),
      child: Column(
        children: [
          monthly(planType),
          SizedBox(
            height: 2.h,
          ),
          yearly(planType)
        ],
      ),
    );
  }

  NeumorphicButton yearly(PlanType planType) {
    return NeumorphicButton(
      onPressed: () => subscriptionYearly(planType: planType),
      style: const NeumorphicStyle(
        color: CustomColors.accentColor,
        shadowLightColor: CustomColors.fillBlackElevationColor,
        intensity: 0.5,
      ),
      child: SizedBox(
        height: 5.h,
        child: Center(
          child: Text(
            planType == PlanType.basic
                ? S.current.subscription_upgrade_yearly_basic
                : S.current.subscription_upgrade_yearly_pro,
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: CustomColors.fillWhiteColor),
          ),
        ),
      ),
    );
  }

  NeumorphicButton monthly(PlanType planType) {
    return NeumorphicButton(
      onPressed: () => subscriptionMonthly(planType: planType),
      style: const NeumorphicStyle(
        color: CustomColors.primaryColor,
        shadowLightColor: CustomColors.fillBlackElevationColor,
        intensity: 0.5,
      ),
      child: SizedBox(
        height: 5.h,
        child: Center(
          child: Text(
            planType == PlanType.basic
                ? S.current.subscription_upgrade_monthly_basic
                : S.current.subscription_upgrade_monthly_pro,
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: CustomColors.fillWhiteColor),
          ),
        ),
      ),
    );
  }

}
