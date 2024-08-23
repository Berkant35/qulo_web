

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../prov/global_providers.dart';
import '../../../../utils/cp_colors.dart';
import '../../../../utils/l10n/l10n.dart';
import '../../../widgets/buttons/cp_button_1.dart';

class StartChronometerWidget extends ConsumerWidget {
  const StartChronometerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.18,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  border: Border.all(color: CpColors.yellow, width: 2),
                  borderRadius:
                  const BorderRadius.all(Radius.circular(20))),
              child: Center(
                child: Text(
                  L10n.inst(context).game_ui_timer_explain,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CpButton1(
                  onPressed: () => ref
                      .read(currentFirstActionTimeManager.notifier)
                      .changState(DateTime.now()),
                  child: Text(
                    L10n.inst(context).game_ui_timer_start,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
