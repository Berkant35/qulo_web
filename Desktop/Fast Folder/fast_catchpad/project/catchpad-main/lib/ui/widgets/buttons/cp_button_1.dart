import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catchpad/models/enums/utility/dialog_parts_enum.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../prov/dialogs/game_start_condition_dialog_prov.dart';
import '../../../utils/cp_colors.dart';
import 'cp_btn.dart';

class CpButton1 extends ConsumerWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final bool fullWidth;

  final bool gameStart;

  const CpButton1({
    required this.onPressed,
    required this.child,
    this.fullWidth = false,
    this.gameStart = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => InkWell(
        onTap: onPressed == null && gameStart
            ? () {
                if (ref.watch(currentDialogTitleAndDescription)[
                            DialogParts.title] !=
                        null &&
                    ref.watch(currentDialogTitleAndDescription)[
                            DialogParts.description] !=
                        null &&
                    ref
                        .watch(currentDialogTitleAndDescription)[
                            DialogParts.title]!
                        .isNotEmpty &&
                    ref
                        .watch(currentDialogTitleAndDescription)[
                            DialogParts.description]!
                        .isNotEmpty) {
                  AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.bottomSlide,
                          title: ref.watch(currentDialogTitleAndDescription)[DialogParts.title],
                          desc: ref.watch(currentDialogTitleAndDescription)[DialogParts.description],
                          btnCancelOnPress: () {},
                          btnCancelText: L10n.inst(context).form_cancel)
                      .show().timeout(const Duration(seconds: 15), onTimeout: () {
                    Navigator.of(context).pop();
                  });
                }
              }
            : null,
        child: CpBtn(
          color: CpColors.button1Color,
          onPressed: onPressed,
          fullWidth: fullWidth,
          child: child,
        ),
      );
}
