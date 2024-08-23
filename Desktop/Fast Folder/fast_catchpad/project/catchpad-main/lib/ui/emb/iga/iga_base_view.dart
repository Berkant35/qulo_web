import 'package:catchpad/managers/asset_manager.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'buttons/select_level.dart';
import 'buttons/select_player_count.dart';
import 'buttons/wake_up_button.dart';

class IgaBaseView extends ConsumerStatefulWidget {
  const IgaBaseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IgaBaseViewState();
}

class _IgaBaseViewState extends ConsumerState<IgaBaseView> {
  @override
  Widget build(BuildContext context) {
    final widgetList = [
      const WakeUpButton(),
      SelectPlayerCount(
          cardTitle: 'cardTitle',
          cardImagePath: 'cardImagePath',
          isSelected: false,
          onPressed: () {}),
      SelectLevel(
          cardImagePath: 'cardImagePath', isSelected: false, onPressed: () {}),
    ];
    return Scaffold(
      backgroundColor: const Color.fromARGB(108, 45, 43, 43),
      body: Stack(
        children: [
          Image.asset(IgaAssets.landing_background.getPath),
          Center(
            child: PageView.builder(
              itemCount: 3,

              itemBuilder: (BuildContext context, int index) {
                return widgetList[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
