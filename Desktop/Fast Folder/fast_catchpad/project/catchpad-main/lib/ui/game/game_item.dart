import 'package:catchpad/data/api/user_api.dart';
import 'package:catchpad/models/enums/game/game_badge_types.dart';
import 'package:catchpad/models/enums/product/variants_type.dart';
import 'package:catchpad/models/enums/traces/play_traces_enum.dart';
import 'package:catchpad/models/enums/utility/cache_setup.dart';
import 'package:catchpad/models/enums/utility/show_case_enum.dart';
import 'package:catchpad/models/extensions/extensions.dart';
import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:catchpad/prov/class_provider.dart';
import 'package:catchpad/prov/dialogs/show_case_prov.dart';
import 'package:catchpad/prov/sticker_match_provider.dart';
import 'package:catchpad/ui/widgets/dialogs/custom_show_case.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/game/game_model.dart';
import '../../models/game/static_game_model.dart';
import '../../prov/game/detail_game_prov.dart';
import '../../prov/global_providers.dart';
import '../../utils/cp_colors.dart';
import '../../utils/cp_icons.dart';
import '../../utils/route_table.dart';
import '../../utils/utils.dart';
import '../device/debug/dev_debug_options.dart';
import '../widgets/cp_chip.dart';
import 'select_game_screen.dart';

typedef GameForWidget = MapEntry<String, Future Function(WidgetRef)>;

class GameItem extends ConsumerStatefulWidget {
  const GameItem(
    this.gameCreator, {
    super.key,
  });

  final GameModel Function() gameCreator;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameItemState();
}

class _GameItemState extends ConsumerState<GameItem> {
  bool selectable = true;

  /// the reason we're using a Creator Function
  /// here is we want the bare game each time.
  /// e.g. imagine you've played this game first time,
  /// so the game object's players now are full with
  /// this play. when you play again, you want to
  /// have the players empty and then init your
  /// players with the new play.

  List<String> newPhotoPathIds = [
    "84",
    "48",
    "1",
    "4",
    "13",
    "14",
    "16",
    "22",
    "38",
    "39",
    "40",
    "44",
    "45",
    "47",
    "49",
    "50",
    "52",
    "53",
    "54",
    "56",
    "57",
    "58",
    "66",
    "67",
    "68",
    "69",
    "70",
    "71",
    "72",
    "73",
    "74",
    "75",
    "79",
  ];

  void saveTrace() {
    Future(() {
      if (ref.read(currentPlayTraceManager)?.preTrace != null) {
        ref.read(currentPlayTraceManager.notifier).saveToFirebaseNewTrace(ref);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.gameCreator();
    saveTrace();

    return InkWell(
      onTap: selectable
          ? () async {
              setState(() {
                selectable = false;
              });
              if (ref.read(currentPlayTraceManager) != null) {
                await ref
                    .read(currentPlayTraceManager.notifier)
                    .changePlayTraceState(PlayTraceStates.idle, ref);
              }

              ref
                  .read(currentPlayTraceManager.notifier)
                  .initializePlayTrace(ref);

              ref
                  .read(buzzerManagerProvider.notifier)
                  .changeBuzzerStatus(ref, customValue: false);

              UsersApi.instance.getAllUsers().then((value) =>
                  ref.read(classProvider.notifier).checkAndLoad(ref, context));

              final lastgame = ref.read(detailGameProv)?.id ?? '';

              ref
                  .read(detailGameProv.notifier)
                  .setState(game as StaticGameModel);

              if (game.id != lastgame) {
                ref.read(stickerProvider.notifier).reset();
              }
              for (int i = 0;
                  i < ref.read(currentDevicesManagerProvider).keys.length;
                  i++) {
                final deviceId =
                    ref.read(currentDevicesManagerProvider).keys.toList()[i];

                if ((ref.read(currentAudioProvManager)[deviceId] == null ||
                        !ref
                            .read(currentAudioProvManager)[deviceId]!
                            .contains("bip")) &&
                    (ref
                                .read(currentDevicesManagerProvider)[deviceId]!
                                .variantId
                                .toString() !=
                            VariantsType.SPORT.getModeNumber().toString() &&
                        ref
                                .read(currentDevicesManagerProvider)[deviceId]!
                                .variantId
                                .toString() !=
                            VariantsType.GO.getModeNumber().toString() &&
                        ref
                                .read(currentDevicesManagerProvider)[deviceId]!
                                .variantId
                                .toString() !=
                            VariantsType.EMB.getModeNumber().toString())) {
                  logger.i("Upload before $deviceId");
                  // Sometimes the beep sound does not work on the pads. For more reliability,
                  // we provide the temporary loading of the beep sound twice.
                  await CustomDevDebugOperations.uploadBip(ref, deviceId);
                }
              }

              ref.read(currentCacheSetupManager.notifier).getSensor(ref,
                  whichSetupKey: CacheSetupKeys.sensor.name, gameId: game.id);

              GoRouter.of(context).pushNamed(RouteTable.rGameDetailScreen);

              //GoRouter.of(context).pushNamed(RouteTable.rSandbox);

              setState(() {
                selectable = true;
              });
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(
                newPhotoPathIds.contains(game.metaData.imagePath) &&
                        !context.isTablet
                    ? game.metaData.verticalFullImgPath
                    : game.metaData.fullImgPath),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: .2,
                child: Container(
                  decoration: BoxDecoration(
                    color: CpColors.appbarColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(halfDefPaddingSize),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(game.title),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            gameAttributeRow(
                              context,
                              game,
                              CpIcons.profile,
                              game.metaData.playerCount
                                  .rangeStr /* +
                                    ' ' +
                                    // TODO: implement this functionality in the ARB file
                                    // awaiting a response in
                                    // https://stackoverflow.com/questions/72696680/flutter-l10n-using-arb-logic-translations
                                    (game.metaData.playerCount.min < 2
                                        ? L10n.inst(context)
                                            .game_ui_player_count_player
                                        : L10n.inst(context)
                                            .game_ui_player_count_players) */
                              ,
                            ),
                            /*
                            I think this widgets appear in future
                            const Text("\u2022"),

                            gameAttributeRow(
                              context,
                              game,
                              CatchPadIcons.cpCircle,CpIcons.profile
                              game.metaData.playerCount
                                  .rangeStr /* +
                                    ' ' +
                                    // TODO: implement this functionality in the ARB file
                                    // awaiting a response in
                                    // https://stackoverflow.com/questions/72696680/flutter-l10n-using-arb-logic-translations
                                    (game.metaData.playerCount.min < 2
                                        ? L10n.inst(context)
                                            .game_ui_player_count_player
                                        : L10n.inst(context)
                                            .game_ui_player_count_players) */
                              ,
                            ),*/
                          ],
                        ),
                        Flexible(
                          child: CpChip(
                            isTogglable: false,
                            text: game.metaData.tag.textNotation(context),
                            /* fontSize:
                                Theme.of(context).textTheme.caption?.fontSize, */
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: CustomShowCaseWidget(
                  showCaseInfo: ref.read(currentAllShowCases).firstWhere(
                      (element) => element.key == Tips.favorites.name),
                  showCaseContentWidget: IconButton(
                      onPressed: () async {
                        final favoriteGames =
                            ref.read(currentUserAssetsProv).favorites!;
                        if (favoriteGames.contains(game.id)) {
                          ref
                              .read(currentUserAssetsProv.notifier)
                              .removeFromFavorites(game.id);
                        } else {
                          ref
                              .read(currentUserAssetsProv.notifier)
                              .addToFavorites(game.id);
                        }
                        if (ref.read(selectedGameCategoryProv) ==
                            GameCategory.favorites) {
                          ref.read(selectedGameCategoryIsFav.notifier).state =
                              !ref.read(selectedGameCategoryIsFav);
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: (ref
                                .read(currentUserAssetsProv)
                                .favorites!
                                .contains(game.id))
                            ? Colors.red
                            : null,
                      )),
                )),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Badge(
                  backgroundColor: game.metaData.badgeType.getBadgeColor,
                  largeSize: MediaQuery.of(context).size.width * 0.06,
                  isLabelVisible:
                      game.metaData.badgeType != GameBadgeTypes.none,
                  label: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.width * 0.06,
                    child: Center(
                      child: Text(
                        game.metaData.badgeType
                            .getNameLocalization(L10n.inst(context))
                            .toUpperCase(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row gameAttributeRow(
      BuildContext context, GameModel game, IconData iconData, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          iconData,
          size: Theme.of(context).textTheme.bodySmall?.fontSize,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: CpColors.defTextColor,
              ),
        ),
      ],
    );
  }
}
