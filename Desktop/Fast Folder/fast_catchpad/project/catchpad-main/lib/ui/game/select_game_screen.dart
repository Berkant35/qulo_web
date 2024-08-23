import 'dart:io';

import 'package:catchpad/models/bottom_bar_item.dart';
import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:catchpad/prov/class_provider.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/prov/leaderboard/leaderboard_result_prov.dart';
import 'package:catchpad/prov/quiz_provider.dart';
import 'package:catchpad/prov/system/sys_prov.dart';
import 'package:catchpad/ui/leaderboard/leaderboard_result_list.dart';
import 'package:catchpad/ui/leaderboard/leaderboard_screen_body.dart';
import 'package:catchpad/ui/widgets/dialogs/custom_show_case.dart';

import 'package:catchpad/utils/enums/background_enums.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../managers/cg_sandbox.dart';
import '../../managers/static_games_list.dart';
import '../../models/enums/utility/show_case_enum.dart';
import '../../models/game/game_model.dart';
import '../../prov/dialogs/show_case_prov.dart';
import '../../utils/cp_colors.dart';
import '../../utils/utils.dart';
import '../widgets/cp_chip.dart';
import '../widgets/default_bg.dart';
import 'game_item.dart';

class SelectGameScreen extends ConsumerStatefulWidget {
  const SelectGameScreen({super.key});

  static Set<GameModel> gamesOnLeaderboard(WidgetRef ref) => <GameModel>{
        StaticGamesList.formula(ref),
        //StaticGamesList.parkur(ref),
        //StaticGamesList.ekipIsi(ref),
        //StaticGamesList.aklindaTut(ref),
        //StaticGamesList.sprint(ref),
        //StaticGamesList.stroopTest(ref),
        //StaticGamesList.renkliBulmaca(ref),
        StaticGamesList.kolaysaYakala(ref),
        StaticGamesList.dikkatDikkat(ref),
        //StaticGamesList.dahaDunAnnemizin(ref),
        //StaticGamesList.tekAyak(ref),
        //StaticGamesList.bulBakalim(ref),
        //StaticGamesList.dengedeKal(ref),
        //StaticGamesList.boksmakinesi(ref),
        StaticGamesList.isitselReaksiyonTesti(ref),
        StaticGamesList.suratTesti(ref),
        StaticGamesList.padHero(ref)
        //StaticGamesList.korebePUBG(ref)
      };

  static Set<GameModel> initGames(WidgetRef ref) => <GameModel>{
        // StaticGamesList.attentionGame(ref),
        // StaticGamesList.languageGame(ref),
        // StaticGamesList.musicGame(ref),
        // StaticGamesList.memoryGameDuration(ref),
        // StaticGamesList.memoryGameRepeat(ref),
        // StaticGamesList.catchThePadGame(ref),
        // StaticGamesList.teamSyncCatchingPadGame(ref),
        // StaticGamesList.speedGame(ref),
        // StaticGamesList.xoGame(ref),
        // StaticGamesList.catchDiffPadGame(ref),
        // StaticGamesList.jumpOverThePad(ref),
        // StaticGamesList.standingKneePull(ref),
        //SPOR SIRALAMA ÖNEMLİ!-EĞLENCE
        //StaticGamesList.parkur(ref),
        //StaticGamesList.boksmakinesi(ref),

        //StaticGamesList.formulaYarisiSecond(ref),

        StaticGamesList.goCenter(ref),
        StaticGamesList.seeCenter(ref),
        // StaticGamesList.demo2(ref),
        StaticGamesList.padHero(ref),
        StaticGamesList.isitselReaksiyonTesti(ref),
        StaticGamesList.patlayiciGucTesti(ref),
        StaticGamesList.atisSerbest(ref),
        StaticGamesList.takimEgzersiz(ref),
        StaticGamesList.ilkGelen(ref),
        StaticGamesList.renkliYaris(ref),
        StaticGamesList.formulaYarisi(ref),

        //Hardcode Test Games
        //if (kDebugMode) StaticGamesList.testFormulaYarisi(ref),
        //if (kDebugMode) StaticGamesList.testformula(ref),
        StaticGamesList.dikkatYarisi(ref),
        StaticGamesList.grupEgzersiz(ref),
        StaticGamesList.grupEgzersiziki(ref),
        /***/ StaticGamesList.hamstringAndSpagat(ref,
            id: '44',
            name: instForGameScreen.game_title_61,
            onleaderboard: false,
            orderNumbers: [21, 12],
            description: instForGameScreen.game_description_61),
        StaticGamesList.hamstringAndSpagat(ref,
            id: '45',
            name: instForGameScreen.game_title_63,
            orderNumbers: [22, 11],
            onleaderboard: false,
            description: instForGameScreen.game_description_63),
        StaticGamesList.padKapmaca(ref),
        StaticGamesList.yuzMetre(ref),
        StaticGamesList.dengedeKal(ref),
        StaticGamesList.tekAyak(ref),
        StaticGamesList.sinav(ref),
        StaticGamesList.squat(ref),
        StaticGamesList.russianTwist(ref),
        StaticGamesList.ekipIsi(ref),
        StaticGamesList.dahaDunAnnemizin(ref),
        StaticGamesList.aklindaTut(ref),
        StaticGamesList.formula(ref),
        StaticGamesList.dikkatDikkat(ref),
        // StaticGamesList.dikkatDikkat2G(ref),
        // StaticGamesList.dikkatDikkat4G(ref),
        // StaticGamesList.dikkatDikkat8G(ref),
        StaticGamesList.dikkatTesti(ref),
        StaticGamesList.dengeTesti(ref),
        StaticGamesList.harfler(ref),
        StaticGamesList.harfleriGor(ref),
        StaticGamesList.harfleriBul(ref),
        StaticGamesList.emojiler(ref),
        //-----END-------
        //EĞİTİM
        StaticGamesList.meyveler(ref),
        StaticGamesList.tasitlar(ref),
        StaticGamesList.sekiller(ref),
        StaticGamesList.safari(ref),
        //StaticGamesList.sebzeler(ref),
        //StaticGamesList.carpimTablosu(ref),
        //-----END-------
        StaticGamesList.padquizGame(ref),
        StaticGamesList.sayBakalim(ref),
        //StaticGamesList.listenAndCatch(ref),
        StaticGamesList.stroopTest(ref),
        StaticGamesList.bulBakalim(ref),
        //StaticGamesList.sprint(ref),
        StaticGamesList.renkliBulmaca(ref),
        //StaticGamesList.drill(ref),
        StaticGamesList.dortIslem(ref),
        StaticGamesList.kolaysaYakala(ref),
        StaticGamesList.suratTesti(ref),
        StaticGamesList.sayilariGor(ref),
        StaticGamesList.yankosuvetekayakformula(ref,
            id: '56',
            categoriesOrder: 19,
            tag: GameTag.agility,
            onLeaderBoard: false,
            name: instForGameScreen.game_title_56,
            description: instForGameScreen.game_description_56,
            earnings: [GameEarning.speed, GameEarning.resistance],
            padCount: NumRange.padCount(min: 4, max: 12)),
        StaticGamesList.yankosuvetekayakformula(ref,
            id: '58',
            categoriesOrder: 20,
            onLeaderBoard: false,
            tag: GameTag.balance,
            name: instForGameScreen.game_title_58,
            description: instForGameScreen.game_description_58,
            earnings: [GameEarning.reflex, GameEarning.balance],
            padCount: NumRange.padCount(min: 4, max: 12)),
        Platform.isIOS
            ? StaticGamesList.testOdak(ref)
            : StaticGamesList.odak(ref),
        //StaticGamesList.boksmakinesi(ref),
        StaticGamesList.ozelantrenman(ref),
        StaticGamesList.siraliYakalama(ref),
        // in prog
        //
        // StaticGamesList.xox(ref),
        // not started
        StaticGamesList.sayilar(ref),
        StaticGamesList.hayvanlar(ref),
        //StaticGamesList.esliKapmaca(ref),
        //StaticGamesList.renginiGoster(ref),
        //StaticGamesList.duyguIfadeleri(ref),
        //StaticGamesList.yuzIfadesi(ref),
        //
        //,
        //StaticGamesList.ritmikSayma(ref),
        //StaticGamesList.oruntu(ref),
        //StaticGamesList.renkler(ref),
        //StaticGamesList.emojiler(ref),
        StaticGamesList.notalar(ref),
        //StaticGamesList.korebe(ref),
        //StaticGamesList.padSende(ref),
        //StaticGamesList.padGuresi(ref),
        //StaticGamesList.rengarenk(ref),
        //StaticGamesList.zipla(ref),
        //StaticGamesList.zipZip(ref),
        // Belki distance mesefasi 3-4 metre olur
        //StaticGamesList.korebePUBG(ref)
        StaticGamesList.sutTesti(ref),
        StaticGamesList.pasTesti(ref)
      };

  @override
  ConsumerState<SelectGameScreen> createState() => _SelectGameScreenState();
}

class _SelectGameScreenState extends ConsumerState<SelectGameScreen> {
  bool isLeft = false;
  bool isRight = false;
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref
        .read(searchFilterProvider.notifier)
        .setScrollController(scrollController);
  }

  @override
  Widget build(BuildContext context) {
    SystemInfoControlNotifier.initalizeAndSet(ref);

    return Scaffold(
      body: DefaultBg(
        backgroundEnum: BackgroundEnums.typeOne,
        child: Column(
          children: [
            const GameCategoryList(),
            const GameTagsSelector(),
            Expanded(
                child: GestureDetector(
                    onHorizontalDragEnd: (details) async {
                      if (isLeft) {
                        isLeft = false;
                        final cat = ref.read(selectedGameCategoryProv);
                        if (cat.index != 0) {
                          ref.read(selectedGameCategoryProv.notifier).state =
                              GameCategory.values.elementAt(cat.index - 1);
                        }
                      }
                      if (isRight) {
                        isRight = false;
                        final cat = ref.read(selectedGameCategoryProv);
                        if (cat.index != GameCategory.values.length - 1) {
                          ref.read(selectedGameCategoryProv.notifier).state =
                              GameCategory.values.elementAt(cat.index + 1);
                        }
                      }
                    },
                    onHorizontalDragUpdate: (details) {
                      // Sola
                      if (details.delta.direction == 0.0) {
                        isLeft = true;
                        isRight = false;
                      }
                      // Sağa
                      if (details.delta.direction > 0) {
                        isLeft = false;
                        isRight = true;
                      }
                    },
                    child: GameListWid(
                      scrollController: scrollController,
                    ))),
          ],
        ),
      ),
    );
  }
}

final selectedTagsProv = StateProvider<Set<GameTag>>(
  (ref) => {},
);

final showTagSelectionProv = StateProvider<bool>(
  (ref) => false,
);

class GameTagsSelector extends ConsumerWidget {
  const GameTagsSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final show = ref.watch(showTagSelectionProv);
    TextEditingController textEditingController = TextEditingController();
    final l10n = L10n.inst(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: show ? null : 0,
      child: Builder(
        builder: (context) {
          final tags = <GameTag, String>{};

          for (var tag in GameTag.values) {
            tags[tag] = tag.textNotation(context);
          }
          final values = tags.values.toList();
          final tagKeys = tags.keys.toList();

          tagKeys.sort((a, b) =>
              a.textNotation(context).compareTo(b.textNotation(context)));

          values.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

          final keys = tagKeys;

          final selectedOnes = ref.watch(selectedTagsProv);

          return Column(
            children: [
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: keys.length,
                  itemBuilder: (context, index) {
                    final tag = keys.elementAt(index);
                    final name = values.elementAt(index);
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      child: CpChip(
                        text: name,
                        initialSelected: selectedOnes.contains(tag),
                        onSelected: (selected) {
                          var newVal = <GameTag>[];

                          newVal = List.from(ref.read(selectedTagsProv));

                          if (selected) {
                            newVal.add(tag);
                          } else {
                            newVal.remove(tag);
                          }

                          ref.read(selectedTagsProv.notifier).state =
                              newVal.toSet();
                        },
                        // on
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 1.w, right: 1.w),
                child: SearchBar(
                  controller: textEditingController,
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => CpColors.appbarColor,
                  ),
                  onTap: () async {},
                  onChanged: (text) {
                    ref
                        .read(searchFilterProvider.notifier)
                        .updateFilterText(text);
                  },
                  hintText: l10n.search,
                  leading: const Icon(Icons.search),
                  trailing: [
                    IconButton(
                      onPressed: () {
                        ref
                            .read(searchFilterProvider.notifier)
                            .clearFilterText(textEditingController);
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class GameListWid extends ConsumerStatefulWidget {
  final ScrollController scrollController;

  const GameListWid({super.key, required this.scrollController});

  @override
  ConsumerState createState() => _GameListWidState();
}

class _GameListWidState extends ConsumerState<GameListWid> {
  bool waitingFillList = true;

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(() {
      if (ref.read(searchFilterProvider.notifier).requiredRefreshList) { 
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final gms = SelectGameScreen.initGames(ref);

    var filterText = ref.watch(searchFilterProvider);

    final cat = ref.watch(selectedGameCategoryProv);

    final tags = ref.watch(selectedTagsProv);

    // ignore: unused_local_variable
    final isFav = ref.watch(selectedGameCategoryIsFav);

    // each game has a map of categories and
    // the index of them in that category.

    // first we wanna find the ones that have
    // the selected category,
    // and also contain the selected tags.
    var filteredGms = gms.where(
      (gm) {
        final meta = gm.metaData;

        final contTag = tags.contains(meta.tag);
        var contCats = meta.categories.keys.contains(cat) || contTag;

        if (cat == GameCategory.favorites) {
          return ref.read(currentUserAssetsProv).favorites!.contains(gm.id) &&
              (tags.isEmpty || contTag);
        }

        if (tags.isEmpty &&
            (filterText.isEmpty ||
                gm.title.toLowerCase().contains(filterText.toLowerCase()))) {
          return true;
        }

        return contCats &&
            contTag &&
            (filterText.isEmpty ||
                gm.title.toLowerCase().contains(filterText.toLowerCase()));
      },
    ).toList();

    filteredGms.sort(
      (a, b) {
        if (a.prioritized) {
          return -1;
        }

        if (b.prioritized) {
          return 1;
        }

        final ac = a.metaData.categories[cat];
        final bc = b.metaData.categories[cat];

        if (ac == null) {
          return 1;
        }

        if (bc == null) {
          return -1;
        }

        return ac.compareTo(bc);
      },
    );
    //SearchText

    // now we wanna sort them by the index of the
    // selected category
    /* ; */
    final selectedCategory = ref.read(selectedGameCategoryProv.notifier);
    if (cat != GameCategory.favorites && tags.isEmpty) {
      filteredGms.removeWhere((element) =>
          !element.metaData.categories.keys.contains(selectedCategory.state));
    }
    if (cat == GameCategory.favorites && tags.isEmpty) {
      final favs = ref.read(currentUserAssetsProv).favorites!;
      filteredGms
          .sort((a, b) => favs.indexOf(b.id).compareTo(favs.indexOf(a.id)));
    }

    return GridView.builder(
      controller: widget.scrollController,
      padding: const EdgeInsets.all(defPaddingSize * 1.5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: defPaddingSize * 1.5,
        crossAxisSpacing: defPaddingSize * 1.5,
        mainAxisExtent: 225,
      ),
      shrinkWrap: true,
      itemCount: filteredGms.length,
      itemBuilder: (context, index) {
        final game = filteredGms.elementAt(index);
        return GameItem(
          () => game.copy(),
        );
      },
    );
  }
}

/* class CategoryList<T> extends ConsumerWidget {
  const CategoryList<T>({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
} */
class CategoryList<T> extends ConsumerWidget {
  final T selectedOption;
  final Set<T> options;
  final String Function(T) getTitle;
  final void Function(T) onSelected;

  const CategoryList(
      {required this.selectedOption,
      required this.options,
      required this.getTitle,
      required this.onSelected,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          height: 40,
          padding: const EdgeInsetsDirectional.only(start: defPaddingSize),
          decoration: const BoxDecoration(
            color: CpColors.appbarColor,
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(30),
            ),
          ),
          child: Row(
            children: [
              /*if (ref.read(appSettingsToggleProvider).enableLeaderboardViewer)
                IconButton(
                    onPressed: () {
                      ref.read(bottomBarProvider.notifier).setBottomBarItem(0);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                )),*/
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: options.length,
                  itemBuilder: (context, idx) {
                    final option = options.elementAt(idx);
                    final title = getTitle(option);
                    final isSelected = option == selectedOption;

                    return InkWell(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: halfDefPaddingSize),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                color: isSelected
                                    ? CpColors.defTextColor
                                    : CpColors.defDisabledColor,
                              ),
                            ),
                            Container(
                              height: 3,
                              width: title.length * 8,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? CpColors.defTextColor
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                            ),
                          ].joinWidgetList(
                            (e) {
                              return const SizedBox(
                                height: quarterDefPaddingSize,
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (ref.read(bottomBarProvider).index == 2)
                Switch.adaptive(
                  value: ref.watch(groupFilterProvider),
                  onChanged: (value) {
                    ref.read(groupFilterProvider.notifier).switchState();
                    if (ref.read(selectedClassProvider) != null) {
                      EasyLoading.show();
                      lastDocs.clear();
                      final temp = ref.read(selectedLeaderboardGame);
                      ref
                          .read(leaderBoardResultProv.notifier)
                          .clearGameId(temp!.id);
                      onSelected(selectedOption);
                      Future.delayed(const Duration(milliseconds: 300))
                          .then((value) => EasyLoading.dismiss());
                    }
                  },
                )
            ],
          ),
        ),
      ],
    );
  }
}

final selectedGameCategoryProv = StateProvider<GameCategory>(
  (ref) => GameCategory.values[0],
);

final selectedGameCategoryIsFav = StateProvider<bool>((ref) => false);

class GameCategoryList extends ConsumerWidget {
  const GameCategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: CategoryList<GameCategory>(
            selectedOption: ref.watch(selectedGameCategoryProv),
            options: GameCategory.values.toSet(),
            getTitle: (cat) => cat.textNotation(context),
            onSelected: (cat) {
              ref.read(selectedGameCategoryProv.notifier).state = cat;
            },
          ),
        ),
        Container(
          color: CpColors.appbarColor,
          width: 60,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: defPaddingSize),
          child: CustomShowCaseWidget(
            showCaseInfo: ref.read(currentAllShowCases).firstWhere(
                (element) => element.key == Tips.exerciseFilters.name),
            showCaseContentWidget: IconButton(
              icon: const Icon(Icons.filter_alt),
              onPressed: () {
                ref.read(showTagSelectionProv.notifier).state ^= true;
              },
            ),
          ),
        ),
      ],
    );
  }
}

// TODO: move to integration tests
// void testAudio(BuildContext context, WidgetRef ref) async {
//   const paths = [
//     'assets/audio/cardinal_1.mp3',
//     'assets/audio/cardinal_2.mp3',
//     'assets/audio/cardinal_3.mp3',
//     'assets/audio/cardinal_4.mp3',
//   ];
//   final player = CpAudioPlayer();

//   for (var element in paths) {
//     await player.play(element);
//   }

//   await player.dispose();
// }
