import 'package:audiotodo/core/navigation/navigation_constants.dart';
import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/models/auth/user_model.dart';
import 'package:audiotodo/utilities/constants/custom_assets/asset_paths.dart';
import 'package:audiotodo/utilities/constants/enums/user/plan_type.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/edge_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/int_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/string_extensions.dart';
import 'package:audiotodo/utilities/constants/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/theme/custom_colors.dart';
import '../../../generated/l10n.dart';
import '../../../line/viewmodel/global_providers.dart';
import '../adt_widgets.dart';

part 'profile_drawer_mixin.dart';

class ProfileDrawer extends ConsumerStatefulWidget {
  const ProfileDrawer({
    super.key,
  });

  @override
  ConsumerState createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends ConsumerState<ProfileDrawer>
    with ProfileDrawerMixin {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: CustomColors.primaryColor,
      width: 60.w,
      shadowColor: CustomColors.profileGreyColor.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(25.w)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerOfDrawer(ref),
          contentsOfDrawer(ref),
        ],
      ),
    );
  }

  Expanded contentsOfDrawer(WidgetRef ref) {
    return Expanded(
        flex: 8,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: drawerItems(ref),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: dynamicPlanType(ref),
              ),
            ],
          ),
        ));
  }

  Widget dynamicPlanType(WidgetRef ref) {
    final authUser = ref.read(authManager);

    // logger.w("Total Record Second: ${authUser!.totalRecordSeconds}");

    return authUser!.planType != PlanType.none
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearHeader(
                leftText: ref.read(authManager)!.planType.label.capitalize(),
                rightText: PlanType.getPlanDurationString(
                    ref.read(authManager)!.planDetail!),
              ),

              SizedBox(
                height: 6.h,
                child: NeuTextButton(
                  text: S.current.subscription_upgrade,
                  onPressed: () => Sheets.offersBottomSheet(ref.context),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              LinearProgressIndicator(
                value: ((authUser.totalRecordSeconds ?? 0).divideBySixty /
                    (getMaxByPlanTypeMinute(ref))),
                borderRadius: BorderRadius.all(
                    Radius.circular(EdgeExtension.normalEdge.edgeValue)),
                minHeight: 2.h,
                color: CustomColors.accentColor,
              ),
              //TODO if second less than 60, show second, else show minute

              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                child: Text(
                  recordTimeByFormat(authUser, ref),
                  style: Theme.of(ref.context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              LinearProgressIndicator(
                value: ((authUser.totalRecreateCount ?? 0) /
                    getMaxByPlanTypeRecreate(ref)),
                borderRadius: BorderRadius.all(
                    Radius.circular(EdgeExtension.normalEdge.edgeValue)),
                minHeight: 2.h,
                color: CustomColors.accentColor,
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                child: Text(
                  " ${(authUser.totalRecreateCount ?? 0)} / ${getMaxByPlanTypeRecreate(ref)}",
                  style: Theme.of(ref.context).textTheme.titleSmall!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          )
        : NeuStadiumTextButton(
            customWidth: 80.w,
            customHeight: 6.h,
            text: S.current.subscription_upgrade,
            onPressed: () => Sheets.offersBottomSheet(ref.context),
          );
  }

  String recordTimeByFormat(UserModel authUser, WidgetRef ref) {
    //if total record seconds less than 60, show second
    if (authUser.totalRecordSeconds! < 60) {
      return "${authUser.totalRecordSeconds ?? 0} / ${getMaxByPlanTypeSecond(ref)} ${S.current.second}";
    }

    return "${(authUser.totalRecordSeconds ?? 0).divideBySixty} / ${getMaxByPlanTypeMinute(ref)} ${S.current.minute}";
  }

  int getMaxByPlanTypeMinute(WidgetRef ref) {
    switch (ref.read(authManager)!.planType) {
      case PlanType.none:
        return 0;
      case PlanType.basic:
        return PlanType.basicDuration.divideBySixty;
      case PlanType.trial:
        return PlanType.trialDuration.divideBySixty;
      case PlanType.pro:
        return PlanType.proDuration.divideBySixty;
    }
  }

  int getMaxByPlanTypeSecond(WidgetRef ref) {
    switch (ref.read(authManager)!.planType) {
      case PlanType.none:
        return 0;
      case PlanType.basic:
        return PlanType.basicDuration;
      case PlanType.trial:
        return PlanType.trialDuration;
      case PlanType.pro:
        return PlanType.proDuration;
    }
  }

  int getMaxByPlanTypeRecreate(WidgetRef ref) {
    switch (ref.read(authManager)!.planType) {
      case PlanType.none:
        return 0;
      case PlanType.basic:
        return PlanType.basicRecreateMax;
      case PlanType.trial:
        return PlanType.trialRecreateMax;
      case PlanType.pro:
        return PlanType.proRecreateMax;
    }
  }

  Expanded headerOfDrawer(WidgetRef ref) {
    return Expanded(
        flex: 1,
        child: Column(
          children: [
            const Spacer(
              flex: 9,
            ),
            headerContent(ref)
          ],
        ));
  }

  Expanded headerContent(WidgetRef ref) {
    return Expanded(
        flex: MediaQuery.of(context).size.height > 600 ? 10 : 9,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ref.read(authManager)?.userName ?? "-",
                  style: ThemeValueExtension.headline6.copyWith(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
