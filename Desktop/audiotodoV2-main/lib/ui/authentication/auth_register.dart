import 'dart:io';

import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/components/buttons/mini_button.dart';
import 'package:audiotodo/utilities/components/checks/privacy_checks.dart';
import 'package:audiotodo/utilities/components/dialogs/auth_dialogs.dart';
import 'package:audiotodo/utilities/components/form_fields/row_form_field.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/edge_extension.dart';
import 'package:audiotodo/utilities/constants/extensions/icon_size_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/navigation/navigation_service.dart';
import '../../core/theme/custom_colors.dart';
import '../../generated/l10n.dart';
import '../../line/viewmodel/global_export.dart';
import '../../utilities/components/containers/custom_bar_container.dart';

part 'auth_register_mixin.dart';

class AuthRegisterPage extends ConsumerStatefulWidget {
  const AuthRegisterPage({
    super.key,
  });

  @override
  ConsumerState createState() => _AuthRegisterPageState();
}

class _AuthRegisterPageState extends ConsumerState<AuthRegisterPage>
    with _AuthRegisterMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: CustomColors.fillBlackElevationColor,
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 2,
                  child: CustomBarContainer(
                    text: S.current.sign_up,
                  )),
              Expanded(flex: 3, child: _headerOfRegister()),
              Expanded(flex: 17, child: _registerForm()),
            ],
          ),
        ),
      ),
    );
  }

  Container _registerForm() {
    return Container(
      // color: CustomColors.fillBlackElevationColor,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: EdgeExtension.highEdge.edgeValue),
        child: Form(
          key: registerKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...getFormFields(),
                GapSizedBox.miniGap,
                //Check Box Privacy Policy
                PrivacyChecks(
                  onPrivacyCheck: (onChecked) {
                    formPrivacyChecked = onChecked;
                  },
                ),
                GapSizedBox.smallGap,
                ref.watch(aLoadingStateManager) != LoadingState.loading
                    ? registerButtons()
                    : const Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: CustomColors.fillBlackElevationColor,
                        ),
                      ),
                GapSizedBox.mediumGap,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row registerButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MiniNeuSquare(
          iconData: Icons.arrow_back,
          onPressed: () => NavigationService.instance.navigatePopUp(),
        ),
        MiniNeuSquare(
          iconData: Icons.arrow_forward_rounded,
          onPressed: register,
        ),
      ],
    );
  }

  void register() {
    if (!formPrivacyChecked) {
      AuthDialogs.createUserPrivacyPolicyNotAccepted(ref);
      return;
    }

    ref.read(aLoadingStateManager.notifier).changeState(LoadingState.loading);
    registerKey.currentState!.save();
    if (registerKey.currentState!.validate()) {
      var newUser = UserModel(
        email: mailController.text,
        userName: userNameController.text,
        surName: surnameController.text,
        platform: Platform.isAndroid ? "android" : 'ios',
        planType: PlanType.trial,
        totalRecreateCount: PlanType.getRecreateCount(PlanType.trial),
        totalRecordSeconds: PlanType.getDuration(PlanType.trial),
      );

      ref.read(currentLoadingStateManager.notifier).changeState(
          _AuthRegisterMixin._registerLoginKey, LoadingState.loaded);

      ref
          .read(authManager.notifier)
          .createCustomUserWithEmailAndPassword(
              mailController.text, passwordController.text, newUser, ref)
          .then((value) =>
              value ? AuthDialogs.createUserActionSuccess(ref) : null);

      ref.read(aLoadingStateManager.notifier).changeState(LoadingState.loaded);
    } else {
      ref.read(aLoadingStateManager.notifier).changeState(LoadingState.loaded);
    }
  }

  Container _headerOfRegister() {
    return Container(
      // color: CustomColors.fillBlackElevationColor,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: EdgeExtension.hugeEdge.edgeValue),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 8,
              child: Center(
                child: Text(
                  S.current.welcome_to_audiotodo,
                  style: ThemeValueExtension.titleTextStyle
                      .copyWith(color: CustomColors.fillBlackElevationColor),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Icon(
                  Icons.person,
                  size: IconSizeExtension.huge.sizeValue,
                  color: CustomColors.fillBlackElevationColor,
                )),
          ],
        ),
      ),
    );
  }
}
