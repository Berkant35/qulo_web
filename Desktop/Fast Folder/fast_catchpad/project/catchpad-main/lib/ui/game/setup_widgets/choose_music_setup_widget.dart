

import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/ui/game/setup_widgets/select_music_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/buttons/cp_button_2.dart';

class ChooseMusicSetupWidget extends ConsumerWidget {
  const ChooseMusicSetupWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CpButtonWithIcon2(
        iconWidget: ref.watch(currentMelodyManager) != null
            ? const Icon(
          Icons.check,
          color: Colors.green,
        )
            : const Icon(
          Icons.cancel,
          color: Colors.red,
        ),
        onPressed: () async {
          await showGeneralDialog(
              context: context,
              pageBuilder: (BuildContext context, first, last) {
            return const SelectMusicPage();
          });
        },
        child: Text("Select Music"));
  }
}
