import 'dart:developer';

// Importing necessary packages for the application
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// Importing global providers from the parent directory
import '../../../../prov/global_providers.dart';
import '../buttons/select_language.dart';

// OnboardingOnePage is a ConsumerStatefulWidget that handles the first onboarding page
class OnboardingOnePage extends ConsumerStatefulWidget {
  const OnboardingOnePage({
    super.key,
  });

  // Overriding the createState method to return the _OnboardingOnePageState
  @override
  ConsumerState createState() => _OnboardingOnePageState();
}

// _OnboardingOnePageState is the state class for OnboardingOnePage
class _OnboardingOnePageState extends ConsumerState<OnboardingOnePage> {
  // Initializing the state
  @override
  void initState() {
    super.initState();
    // Setting the system UI mode to manual and disabling overlays
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  // Called when the dependencies of this widget change
  @override
  void didChangeDependencies() {
    // Setting the system UI mode to manual and disabling overlays
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.didChangeDependencies();
  }

  // Building the widget tree for the onboarding page
  @override
  Widget build(BuildContext context) {
    // Getting all language models
    final langs = L10n.allLangModels();
    
    // If the current safe in-game toggle state is true, change it to false
    // if(ref.read(currentSafeInGameToggleState)){
    //   Future((){
    //     ref.read(currentSafeInGameToggleState.notifier).changState(false,ref);
    //   });
    // }

    // Returning a Scaffold with a transparent background
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SelectLanguage(
        // On press handler for the Turkish language button
        onPressedTr: () {
          // Setting the application language to Turkish
          ref.watch(appLangProv.notifier).setLanguage(langs[1]);
          
          // Changing the current IGA page manager state to onBoardingTwo
          ref
           .read(currentIgaPageManager.notifier)
           .changState(IGAStates.onBoardingTwo,ref: ref);
        },
        // On press handler for the English language button
        onPressedEn: () {
          // Setting the application language to English
          ref.watch(appLangProv.notifier).setLanguage(langs[0]);
          
          // Changing the current IGA page manager state to onBoardingTwo
          ref
           .read(currentIgaPageManager.notifier)
           .changState(IGAStates.onBoardingTwo,ref: ref);
        },
      ),
    );
  }
}