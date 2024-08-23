import 'package:catchpad/catch_pad_icons_v2.dart';
import 'package:catchpad/models/game/static_game_model.dart';
import 'package:catchpad/ui/game/setup_widgets/sensor_type_setup_widget_v2.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/v2/utils/enums/project_padding.dart';
import 'package:catchpad/v2/utils/enums/project_radius.dart';
import 'package:catchpad/v2/utils/widgets/base_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:kartal/kartal.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GameSetupScreen extends ConsumerStatefulWidget {
  const GameSetupScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GameSetupScreenState();
}

class _GameSetupScreenState extends ConsumerState<GameSetupScreen> {
  @override
  Widget build(BuildContext context) {
    final earnings = ['Strateji', 'Dikkat', 'Hafiza', 'Gorsel'];
    final size = MediaQuery.of(context).size;
    return BaseBackground(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: size.height * 0.55,
                    width: size.width,
                  ),

                  Image.asset(
                    'assets/images/games/vertical_91.jpeg',
                    height: size.height * 0.3,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        BaseBackground(
                          borderRadius: ProjectRadius.extraLarge.radius,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: ProjectPadding.extraLarge.value,
                                vertical: ProjectPadding.medium.value),
                            decoration: BoxDecoration(
                                borderRadius: ProjectRadius.large.radius),
                            width: context.general.mediaSize.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Dikkat dikkat',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: 20),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                        onTap: () {},
                                        child: CatchpadIconsV2.share),
                                    normalGap,
                                    GestureDetector(
                                        onTap: () {},
                                        child: CatchpadIconsV2.favorites),
                                  ],
                                ),
                                normalGap,
                                const PlayedXTimes(
                                  playedTimes: 1350,
                                ),
                                normalGap,
                                const PlayerAndPadCount(
                                    playerCount: '2-4',
                                    minPadCount: 2,
                                    maxPadCount: 4),
                                normalGap,
                                Text(
                                  'Arkadaşınla beraber seçtiğiniz hedef rengini aynı anda yakalamaya çalış. Arkadaşınla ne kadar uyumlu olduğunu gör! Diğer arkadaşarına meydan oku. ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          color: Colors.white, fontSize: 10),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text('Detayli bilgi al',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: CpColors.cpFrenchLime,
                                              fontSize: 7)),
                                ),
                                normalGap,
                                Text(
                                  'Kazanimlar',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                          color: Colors.white, fontSize: 20),
                                ),
                                normalGap,
                                Wrap(
                                  spacing: 8.0,
                                  runSpacing: 12.0,
                                  alignment: WrapAlignment.start,
                                  children: earnings.map((item) {
                                    return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 4.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.12),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          border: Border.all(
                                            color: CpColors.cpPrimary,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.sp),
                                        ));
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SensorTypeSetupWidgetV2()
            ],
          ),
        ),
      ),
    );
  }

  Widget get normalGap => const Gap(8);
}

class PlayerAndPadCount extends ConsumerWidget {
  final String playerCount;
  final int minPadCount;
  final int maxPadCount;
  const PlayerAndPadCount({
    super.key,
    required this.playerCount,
    required this.minPadCount,
    required this.maxPadCount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double size = 15;
    return Row(
      children: [
        Image.asset(
          'assets/v2/icons/user.png',
          height: size,
          width: size,
        ),
        const Gap(4),
        Text(
          '$playerCount Oyuncu',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 12, color: Colors.white),
        ),
        Text(
          '  ·  ',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Colors.white),
        ),
        Image.asset(
          'assets/v2/icons/pad.png',
          height: size,
          width: size,
        ),
        const Gap(4),
        Text(
          '$minPadCount-$maxPadCount Pad',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 12, color: Colors.white),
        ),
      ],
    );
  }
}

class PlayedXTimes extends ConsumerWidget {
  final int playedTimes;
  const PlayedXTimes({super.key, this.playedTimes = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final inst = L10n.inst(context);
    return Row(
      children: [
        Image.asset(
          'assets/v2/icons/group.png',
          height: 12,
          width: 12,
        ),
        const Gap(4),
        Text(
          '$playedTimes kez oynandi',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 8, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }
}
