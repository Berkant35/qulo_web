import 'package:audiotodo/line/viewmodel/app/utilities/show_case_manager.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/ui/base/audiotodo_page.dart';
import 'package:audiotodo/ui/base/meets.dart';
import 'package:audiotodo/ui/base/profile.dart';
import 'package:audiotodo/utilities/components/bars/custom_button_navigation_bar.dart';
import 'package:audiotodo/utilities/components/sheets/sheets.dart';
import 'package:audiotodo/utilities/constants/enums/app/loading_states.dart';
import 'package:audiotodo/utilities/constants/enums/user/plan_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utilities/components/fabs/bottom_middle_fab.dart';

class MainBase extends ConsumerStatefulWidget {
  const MainBase({
    super.key,
  });

  @override
  ConsumerState createState() => _MainBaseState();
}

class _MainBaseState extends ConsumerState<MainBase> {

  //loading state
  ValueNotifier<LoadingState> loadingState =
      ValueNotifier(LoadingState.loading);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

      await ref.read(currentAllShowCases.notifier).initializeShowCases(ref);

      await ref.read(currentAdminControlState.notifier).initializeAdminControl(ref);
      ref.read(currentPlanControlNotifier.notifier).initializeListenPlans(ref);
      ref
          .read(currentAllShowCases.notifier)
          .showCaseIn(context: context, ref: ref);
      Future(() {
        ref
            .read(aLoadingStateManager.notifier)
            .changeState(LoadingState.loaded);
      });
      loadingState.value = LoadingState.loaded;
      loadingState.notifyListeners();
    });
  }

  @override
  Widget build(BuildContext context) {





    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const BottomMiddleFab(),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: ValueListenableBuilder(
          valueListenable: loadingState,
          builder: (context, LoadingState value, child) {
            if (value == LoadingState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return showPage(ref.watch(currentNavigationIndex));
            }
          }),
    );
  }

  showPage(int selectedItemPosition) {
    switch (selectedItemPosition) {
      case 0:
        return const Profile();
      case 1:
        return const AudioToDoPage();
      case 2:
        return const Plans();
      default:
        return const SizedBox.shrink();
    }
  }
}
