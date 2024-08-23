import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SelectLevel extends ConsumerStatefulWidget {
  final bool? isSelected;
  final Function()? onPressed;
  final String cardImagePath;

  const SelectLevel(
      {required this.cardImagePath,
      required this.isSelected,
      required this.onPressed,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectLevelState();
}

class _SelectLevelState extends ConsumerState<SelectLevel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          clipBehavior: Clip.hardEdge,
          style: ButtonStyle(
              overlayColor: const MaterialStatePropertyAll(CpColors.cpPrimary),
              backgroundColor: const MaterialStatePropertyAll(CpColors.cpLead),
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(34)))),
              fixedSize: MaterialStatePropertyAll(Size(35.w, 60.h))),
          onPressed: widget.onPressed,
          onLongPress: widget.onPressed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.cardImagePath,
                width: 35.w,
                height: 40.h,
              ),
              if (ref.watch(currentIgaPlayerModeManager) ==
                  IGAPlayerModes.multiPlayer)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        buildImage('assets/iga/button_detail.png'),
                        Row(
                          children: [
                            const Text(
                              '1.',
                              style: TextStyle(color: CpColors.cpPrimary),
                            ),
                            Text(
                              inst.player,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/iga/vs.png',
                      height: 40,
                      width: 40,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        buildImage('assets/iga/button_detail.png'),
                        Row(
                          children: [
                            const Text(
                              '2.',
                              style: TextStyle(color: CpColors.cpPrimary),
                            ),
                            Text(
                              inst.player,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              else
                const SizedBox()
            ],
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        IconButton(
          onPressed: widget.onPressed,
          iconSize: 10.h,
          icon: Image.asset(
            (widget.isSelected ?? true)
                ? 'assets/iga/radio_button_active.png'
                : 'assets/iga/radio_button.png',
          ),
        )
      ],
    );
  }

  Image buildImage(String path) {
    return Image.asset(
      path,
      height: 15.h,
      width: 10.w,
    );
  }
}
