import 'package:catchpad/managers/static_games_list.dart';
import 'package:catchpad/models/game/static_game_model.dart';
import 'package:catchpad/prov/game/detail_game_prov.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/widgets/cp_counter.dart';
import 'package:catchpad/utils/widgets/cp_headline_with_icon.dart';
import 'package:catchpad/utils/widgets/text_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class IgaGameStartCounter extends ConsumerStatefulWidget {
  const IgaGameStartCounter({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IgaGameStartCounterState();
}

class _IgaGameStartCounterState extends ConsumerState<IgaGameStartCounter> {
  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    final gameMetaData = ref.watch(detailGameProv);
    StaticGameModel tempData = StaticGamesList.ekipIsi(ref);
    int currentIndex = 2;
    final text = tempData.metaData.igaCountDownTextSpans[currentIndex];
    bool isGame = (tempData.id == 's1' ||
            tempData.id == 's4' ||
            tempData.id == 's16' ||
            tempData.id == 's14' ||
            tempData.id == '86') &&
        (currentIndex == 2);
    bool isGameSecond = (tempData.id == 's4') && (currentIndex == 2);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          if (tempData.id == 's1' || tempData.id == 's4')
            Image.asset(
              IgaAssets.iga_in_game_background.getPath,
              width: 100.w,
              height: 100.h,
              fit: BoxFit.fill,
            ),
          if (tempData.id != 's1' && tempData.id != 's4')
            Image.asset(
              IgaAssets.background.getPath,
              width: 100.w,
              height: 100.h,
              fit: BoxFit.fill,
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CpHeadlineWithIcon(
                texts: text,
                iconPathSecond: isGameSecond ? IgaAssets.pad_tap.getPath : '',
                iconPath: isGame ? IgaAssets.pad_tap.getPath : '',
              ),
              Gap(7.h),
              CpCounter(
                size: 36.h,
                centerText: (3 - currentIndex).toString(),
                currentIndex: currentIndex,
              ),
              Gap(10.h),
              const TextLogoWidget()
            ],
          )
        ],
      ),
    );
  }
}
