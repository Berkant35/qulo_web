import 'package:audiotodo/core/navigation/navigation_constants.dart';
import 'package:audiotodo/core/navigation/navigation_service.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/theme/custom_colors.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({
    super.key,
  });

  @override
  ConsumerState createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: CustomColors.primaryColor, // Durum çubuğunu şeffaf yap
    ));

    //Check app version

    ref
        .read(currentVerisonManagerNotifier.notifier)
        .initializeGetApplicationVersion(ref)
        .then((value) {
      ref.read(authManager.notifier).currentUser(ref).then((value) {
        //This function initialize to recognition language
        //from local if is there save any language
        //Authentication
        if (value != null) {
          NavigationService.instance
              .navigateToPageClear(path: NavigationConstants.mainBase);
          // logger.i("First Enter: ${value.firstEnter}");
        } else {
          NavigationService.instance
              .navigateToPageClear(path: NavigationConstants.authLoginPage);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 100.h,
      color: CustomColors.primaryColor,
      child: const Center(
        child: CircularProgressIndicator.adaptive(
          backgroundColor: CustomColors.fillWhiteColor,
        ),
      ),
    );
  }
}
