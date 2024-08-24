import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/components/bars/app_bars/basic_back_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../../generated/l10n.dart';

class HelpIntegration extends ConsumerWidget {
  const HelpIntegration({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BasicBackAppBar(
        contentTitle:
            ref.read(currentIntegrationHelpState.notifier).titleOfIntegration,
      ),
      body: ref
              .read(currentIntegrationHelpState.notifier)
              .currentPageViewModels
              .isEmpty
          ? const SizedBox()
          : IntroductionScreen(
              pages: ref
                  .watch(currentIntegrationHelpState.notifier)
                  .currentPageViewModels,
              showDoneButton: false,
              showNextButton: false,

              dotsDecorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(20.0, 10.0),
                activeColor: Theme.of(context).colorScheme.secondary,
                color: Colors.black26,
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
              ),
              done: Text(S.current.done),
              onDone: () {
                // On button pressed
              },
            ),
    );
  }
}
