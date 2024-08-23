import 'dart:io';

import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../managers/static_game_manager.dart';
import '../../../models/device/device_shuffler.dart';
import '../../../models/enums/game/sport_mentor_controls_state.dart';
import '../../../models/game/game_controls_setup.dart';
import '../../../models/game/static_game_model.dart';
import '../../../prov/exercise_provider.dart';
import '../../../prov/game/curr_game_prov.dart';
import '../../../prov/game/round_prov.dart';
import '../../../utils/consts.dart';
import '../../../utils/l10n/l10n.dart';
import '../../../utils/util_methods/util_methods.dart';

class SportMentorControlSetupWidget extends ConsumerStatefulWidget {
  const SportMentorControlSetupWidget(
      {required this.devs,
      required this.exerciseOperations,
      required this.game,
      this.doesHaveGameRound = false,
      this.randomized = true,
      Key? key})
      : super(key: key);
  final List<DiscoveredDevice> devs;
  final List<ExerciseOperation>? exerciseOperations;
  final StaticGameModel game;
  final bool doesHaveGameRound;
  final bool randomized;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SportMentorControlSetupWidgetState();
}

class _SportMentorControlSetupWidgetState
    extends ConsumerState<SportMentorControlSetupWidget> {
  Color? lastColor;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      StaticGameSetupModel setup() => ref.read(currentGameSetupProv)!;
      GameControlsSetup controls() => setup().controlsSetup;
      MentorControlsState mentorControlsState() =>
          controls().mentorControlsState;
      final AppLocalizations inst = L10n.inst(context);
      final exercises = ref.read(exerciseProvider);
      var exerciseMap = exercises.exercises;
      final devs = DeviceShuffler.readDevices(ref);
      List<Color> colorToMap = widget.game.generalPlayer!.clrs.isNotEmpty
          ? widget.game.generalPlayer!.clrs
          : widget.game.players.first.clrs;
      return Container(
        padding: const EdgeInsets.all(defPaddingSize),
        decoration: BoxDecoration(
            color: const Color(0xFF333846).withOpacity(0.8),
            borderRadius: BorderRadius.circular(defPaddingSize)),
        child: SizedBox.square(
          dimension: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (mentorControlsState() == MentorControlsState.allow)
                Text(inst.game_ui_change_pad_color),
              Flexible(
                child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    controller: ScrollController(),
                    crossAxisSpacing: defPaddingSize,
                    padding: const EdgeInsets.all(defPaddingSize),
                    cacheExtent: 30,
                    childAspectRatio: 2,
                    mainAxisSpacing: MediaQuery.of(context).size.height * 0.1,
                    children: colorToMap.map((color) {
                      Color? fakeColor = fakeColorGenerator(color);
                      String? move;
                      try {
                        move = exerciseMap.entries
                            .where((element) =>
                                element.value == color.value.toRadixString(16))
                            .first
                            .key;
                      } catch (e) {
                        move = 'Atanmadı';
                      }
                      return InkWell(
                        onTap: (mentorControlsState() ==
                                MentorControlsState.deny)
                            ? null
                            : () async {
                                /* try { */
                                final _ftrs = [];
                                for (var device in devs) {
                                  _ftrs.add(
                                    () => StaticGameManager.ledColor(
                                      device.id,
                                      SidesColorsModel.all(color),
                                      ref: ref,
                                    ),
                                  );
                                }
                                if (ref.read(gameRoundProv) !=
                                        GameRoundEnum.paused ||
                                    !widget.doesHaveGameRound ||
                                    (widget.randomized
                                        ? false
                                        : lastColor != color)) {
                                  lastColor = color;
                                  StaticGameManager.increaseScore(
                                      ref: ref, playerId: 'mentor');
                                  StaticGameManager.increaseCatchCountWithColor(
                                      ref: ref,
                                      playerId: 'mentor',
                                      color: color.value.toRadixString(16));
                                }
                                ref.read(gameRoundProv.notifier).setPaused();
                                if (Platform.isIOS) {
                                  await Future.delayed(
                                      const Duration(milliseconds: 100));
                                }
                                await Future.wait(
                                  _ftrs.map(
                                    (e) => e(),
                                  ),
                                );
                                /* } catch (e) {
                                  logger.d(e.toString());
                                } */
                              },
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.aspectRatio *
                                          100,
                                  width:
                                      MediaQuery.of(context).size.aspectRatio *
                                          100,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: fakeColor)),
                            ),
                            Text(move)
                          ],
                        ),
                      );
                    }).toList()),
              ),
            ],
          ),
        ),
      );
    });
  }
}
