import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:catchpad/managers/static_games_list.dart';
import 'package:catchpad/models/game/static_game_model.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/prov/game/detail_game_prov.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad/utils/widgets/emb/iga/icons/iga_navigator_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';

class OnboardingFourSelectGamePageView extends ConsumerStatefulWidget {
  const OnboardingFourSelectGamePageView({
    super.key,
  });

  @override
  ConsumerState createState() => _OnboardingFourSelectGamePageViewState();
}

class _OnboardingFourSelectGamePageViewState
    extends ConsumerState<OnboardingFourSelectGamePageView> {
  late VideoPlayerController firstVideoController;
  late VideoPlayerController secondVideoController;
  late VideoPlayerController thirdVideoController;
  late VideoPlayerController fourthVideoController;
  late VideoPlayerController fifthVideoController;
  late VideoPlayerController sixthVideoController;
  late List<VideoPlayerController> initalController;
  final SwiperController swiperController = SwiperController();
  List<_GameDetail> gameList = [];

  @override
  void initState() {
    firstVideoController =
        VideoPlayerController.asset('assets/iga/iga_formula.mp4');
    firstVideoController.setLooping(true);
    firstVideoController.initialize();

    secondVideoController = VideoPlayerController.asset(
      'assets/iga/iga_dikkat_dikkat.mp4',
    );
    secondVideoController.setLooping(true);
    secondVideoController.initialize();

    thirdVideoController = VideoPlayerController.asset(
      'assets/iga/iga_dinle_yakala.mp4',
    );
    thirdVideoController.setLooping(true);
    thirdVideoController.initialize();

    fourthVideoController =
        VideoPlayerController.asset('assets/iga/iga_bul_bakalim.mp4');
    fourthVideoController.setLooping(true);
    fourthVideoController.initialize();

    fifthVideoController =
        VideoPlayerController.asset('assets/iga/iga_formula_yarisi.mp4');
    fifthVideoController.setLooping(true);
    fifthVideoController.initialize();

    sixthVideoController = VideoPlayerController.asset(
      'assets/iga/iga_ekip_isi.mp4',
    );
    sixthVideoController.setLooping(true);
    sixthVideoController.initialize();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    firstVideoController.pause();
    firstVideoController.removeListener(() {});
    firstVideoController.dispose();
    secondVideoController.dispose();
    secondVideoController.pause();
    secondVideoController.removeListener(() { });
    thirdVideoController.dispose();
    thirdVideoController.pause();
    thirdVideoController.removeListener(() { });
    fourthVideoController.dispose();
    fourthVideoController.pause();
    fourthVideoController.removeListener(() { });
    fifthVideoController.dispose();
    fifthVideoController.pause();
    fifthVideoController.removeListener(() { });
    sixthVideoController.dispose();
    sixthVideoController.pause();
    sixthVideoController.removeListener(() { });

  }

  @override
  void didChangeDependencies() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    super.didChangeDependencies();
    setGameList();
    _changeState(0);
  }

  _changeState(int index) {
    Future(
          () {
        ref.read(detailGameProv.notifier).setState(gameList[index].gameModel);
      },
    );

    if (gameList.length == 4) {
      if (index == 0) {
        firstVideoController.play();
        firstVideoController.setVolume(0);
      } else {
        firstVideoController.pause();
      }
      if (index == 1) {
        secondVideoController.play();
        secondVideoController.setVolume(0);
      } else {
        secondVideoController.pause();
      }
      if (index == 2) {
        thirdVideoController.play();
        thirdVideoController.setVolume(0);
      } else {
        thirdVideoController.pause();
      }
      if (index == 3) {
        fourthVideoController.play();
        fourthVideoController.setVolume(0);
      } else {
        fourthVideoController.pause();
      }
    } else {
      if (index == 0) {
        fifthVideoController.play();
        fifthVideoController.setVolume(0);
      } else {
        fifthVideoController.pause();
      }
      if (index == 1) {
        sixthVideoController.play();
        sixthVideoController.setVolume(0);
      } else {
        sixthVideoController.pause();
      }
    }
  }

  setGameList() {
    if (ref.read(currentIgaPlayerModeManager) == IGAPlayerModes.singlePlayer) {
      gameList = [
        _GameDetail(
            path: IgaAssets.f1.getPath,
            gameModel: StaticGamesList.formula(ref)),
        _GameDetail(
            path: IgaAssets.attention.getPath,
            gameModel: StaticGamesList.dikkatDikkat(ref)),
        _GameDetail(
            path: IgaAssets.listen_and_catch.getPath,
            gameModel: StaticGamesList.dinleYakala(ref)),
        _GameDetail(
            path: IgaAssets.pad_match.getPath,
            gameModel: StaticGamesList.bulBakalim(ref)),
      ];

      initalController = [
        firstVideoController,
        secondVideoController,
        thirdVideoController,
        fourthVideoController
      ];

    } else {
      gameList = [
        _GameDetail(
            path: IgaAssets.formula_race.getPath,
            gameModel: StaticGamesList.formulaYarisiSecond(ref)),
        _GameDetail(
            path: IgaAssets.team_work.getPath,
            gameModel: StaticGamesList.ekipIsi(ref)),
      ];
      initalController = [fifthVideoController, sixthVideoController];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 75.h,
          width: 57.w,
          child: Stack(
            children: [
              Swiper(
                controller: swiperController,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child:
                      // Image.asset(
                      //   gameList[index].gameModel.metaData.fullImgPath,
                      //   fit: BoxFit.cover,
                      // )
                      VideoPlayer(initalController[index]),
                    ),
                  );
                },
                indicatorLayout: PageIndicatorLayout.DROP,
                viewportFraction: 0.2,
                pagination: SwiperCustomPagination(builder:
                    (BuildContext context, SwiperPluginConfig config) {
                  return Positioned(
                    bottom: 0,
                    right: 20.w,
                    height: 50,
                    width: 15.w,
                    child: ListView.builder(
                      itemCount: gameList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        if (config.activeIndex == index) {
                          _changeState(index);
                        }
                        return Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                            child: config.activeIndex == index
                                ? const Icon(
                              Icons.circle,
                              size: 18,
                              color: Colors.white,
                            )
                                : const Icon(
                              Icons.circle_outlined,
                              size: 18,
                              color: Colors.white,
                            ));
                      },
                    ),
                  );
                }),
                axisDirection: AxisDirection.right,
                physics: const BouncingScrollPhysics(),
                itemCount: gameList.length,
                itemWidth: 40.w,
                itemHeight: 58.h,
                layout: SwiperLayout.TINDER,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 2.w),
                  child: IgaNavigatorIconWidget(
                      isRight: true,
                      onTap: () {
                        swiperController.next();
                      }),
                ),
              ),
            ],
          ),
        ),

        Gap(10.h)
      ],
    );
  }
}

class _GameDetail {
  final String path;
  final StaticGameModel gameModel;

  _GameDetail({required this.path, required this.gameModel});
}