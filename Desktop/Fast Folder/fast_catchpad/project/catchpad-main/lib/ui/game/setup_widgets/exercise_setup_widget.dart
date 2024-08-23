import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_saver_extensions/life_saver_extensions.dart';

import '../../../models/game/player/player_model.dart';
import '../../../models/game/player/selected_player_model.dart';
import '../../../prov/exercise_provider.dart';
import '../../../prov/game/selected_players_prov.dart';
import '../../../utils/consts.dart';
import '../../../utils/cp_colors.dart';
import '../../../utils/l10n/l10n.dart';
import '../../../utils/util_methods/util_methods.dart';
import '../../widgets/buttons/cp_button_1.dart';
import '../../widgets/buttons/cp_button_2.dart';

class ExerciseSetup extends ConsumerWidget {
  const ExerciseSetup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inst = L10n.inst(context);
    final SelectedPlayerModel? selectedPlayer =
        ref.watch(selectedGeneralPlayerProv);
    final Set<SelectedPlayerModel>? selectedPlayers =
        ref.watch(selectedPlayersProv);
    final moves = ref.watch(exerciseProvider);

    PlayerModel? player = selectedPlayer?.player;
    List<String> playerClrs = [];

    if (player != null) {
      for (var color in player.clrs) {
        if(!playerClrs.contains(color.value.toRadixString(16))){
          playerClrs.add(color.value.toRadixString(16));
        }

      }
    }

    if (selectedPlayers != null) {
      for (var player in selectedPlayers) {
        for (var color in player.player.clrs) {
          if(!playerClrs.contains(color.value.toRadixString(16))){
            playerClrs.add(color.value.toRadixString(16));
          }
        }
      }
    }


    return CpButtonWithIcon2(
      iconWidget: (moves.exercises.values
                  .toSet()
                  .intersection(playerClrs.toSet())
                  .length ==
              playerClrs.length)
          ? const Icon(
              Icons.check,
              color: Colors.green,
            )
          : const Icon(
              Icons.cancel,
              color: Colors.red,
            ),
      onPressed: () {
        showGeneralDialog(
            context: context,
            pageBuilder: (BuildContext context, first, last) {
              return AssignColorToMoveDialog(clrs: playerClrs);
            });
      },
      child: Text(
        inst.game_ui_set_colors_with_exercises,
        style: const TextStyle(fontSize: 10),
      ),
    );
  }
}

class AssignColorToMoveDialog extends ConsumerStatefulWidget {
  const AssignColorToMoveDialog({super.key, required this.clrs});
  final List<String> clrs;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AssignColorToMoveDialogState();
}

class _AssignColorToMoveDialogState
    extends ConsumerState<AssignColorToMoveDialog> {
  List<Color> get clrs =>
      widget.clrs.map((e) => Color(int.parse(e, radix: 16))).toList();
  List<ScrollController> controllers = [];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < clrs.length; i++) {
      controllers.add(ScrollController(initialScrollOffset: 0));
    }
  }

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    final SelectedPlayerModel? selectedPlayer =
        ref.watch(selectedGeneralPlayerProv);
    final Set<SelectedPlayerModel>? selectedPlayers =
        ref.watch(selectedPlayersProv);
    final moves = ref.watch(exerciseProvider);
    final exercises = ref.watch(exerciseProvider).exercises.keys.toList();
    final exercisestoremove = moves.exercises.entries.toList();
    logger.i(
        "Exercises: ${exercises.toList()}\nMoves: $moves\nExercisesToRemove: $exercisestoremove");

    for (var exec in exercisestoremove) {
      if (exec.value != null) {
        exercises.remove(exec.key);
      }
    }
    PlayerModel? player = selectedPlayer?.player;
    return Material(
      child: Consumer(
        builder: (context, ref, child) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          width: double.infinity,
          child: ListView(
              padding: const EdgeInsets.only(top: defPaddingSize * 1.75),
              children: (player != null || selectedPlayers!.isNotEmpty)
                  ? [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.arrow_back)),
                        ],
                      ),
                      ...clrs.map((clr) {
                        final index = clrs.indexOf(clr);
                        Color clrToShow = fakeColorGenerator(clr);
                        bool visibility = true;
                        String? assignedMove;

                        try {
                          assignedMove = moves.exercises.entries
                              .firstWhere((element) =>
                                  element.value == clr.value.toRadixString(16))
                              .key;
                        } catch (e) {
                          logger.d(e.toString());
                        }

                        if (assignedMove != null) {
                          visibility = false;
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defPaddingSize),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: defPaddingSize),
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: clrToShow,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  if (assignedMove != null)
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Card(
                                          elevation: 9,
                                          color:
                                              CpColors.green.withOpacity(0.4),
                                          child: InkWell(
                                            onTap: () {
                                              ref
                                                  .read(
                                                      exerciseProvider.notifier)
                                                  .removeColorFromMove(
                                                      assignedMove!);
                                            },
                                            child: Container(
                                                alignment: Alignment.center,
                                                child: Text(assignedMove)),
                                          )),
                                    )
                                ],
                              ),
                              Visibility(
                                visible: visibility,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  child: Scrollbar(
                                    thumbVisibility: true,
                                    trackVisibility: true,
                                    interactive: false,
                                    controller: controllers[index],
                                    child: ListView(
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      controller: controllers[index],
                                      children: exercises
                                          .map((move) => SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.25,
                                                child: Card(
                                                    elevation: 9,
                                                    color:
                                                        CpColors.bottomBarColor,
                                                    child: InkWell(
                                                      onLongPress: () async {
                                                        bool? isConfirmed =
                                                            await showConfirmationDialog(
                                                                context:
                                                                    context,
                                                                initialSelectedActionKey:
                                                                    true,
                                                                onWillPop:
                                                                    () async {
                                                                  return true;
                                                                },
                                                                message: inst
                                                                    .delete_warning_description,
                                                                title: inst
                                                                    .warning);
                                                        if (isConfirmed ==
                                                            true) {
                                                          ref
                                                              .read(
                                                                  exerciseProvider
                                                                      .notifier)
                                                              .remove(
                                                                  move, ref);
                                                        }
                                                      },
                                                      onTap: () {
                                                        ref
                                                            .read(
                                                                exerciseProvider
                                                                    .notifier)
                                                            .setColorToMove(
                                                                move,
                                                                clr.value
                                                                    .toRadixString(
                                                                        16));
                                                        setState(() {
                                                          visibility = false;
                                                        });
                                                      },
                                                      child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(move)),
                                                    )),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                      Text(
                        inst.color_warning_description,
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CpButton1(
                              onPressed: () async {
                                List<String>? addedExercise =
                                    await showTextInputDialog(
                                        context: context,
                                        cancelLabel: inst.cancel,
                                        okLabel: inst.add_exercise,
                                        title: inst.add_exercise,
                                        style: AdaptiveStyle.material,
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                                dialogBackgroundColor:
                                                    CpColors.bgGC2),
                                            child: child,
                                          );
                                        },
                                        textFields: [const DialogTextField()]);
                                if (addedExercise != null) {
                                  ref
                                      .read(exerciseProvider.notifier)
                                      .addNew({addedExercise.first: null}, ref);
                                }
                              },
                              child: Text(inst.add_exercise)),
                          CpButton1(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(inst.save))
                        ],
                      )
                    ].joinWidgetList(
                      (index) => const SizedBox(
                        height: defPaddingSize * 2,
                      ),
                    )
                  : [
                      Center(
                        child: Text(inst.color_warning),
                      )
                    ]),
        ),
      ),
    );
  }
}
