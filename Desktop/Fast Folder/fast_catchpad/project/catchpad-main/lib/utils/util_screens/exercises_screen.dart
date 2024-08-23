import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/exercises_model.dart';
import '../../prov/exercise_provider.dart';
import '../../ui/widgets/default_bg.dart';
import '../consts.dart';
import '../l10n/l10n.dart';

class ExerciseScreen extends ConsumerWidget {
  const ExerciseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var exercises = ref.watch(exerciseProvider);
    final inst = L10n.inst(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(inst.profile_screen_saved_exercises),
      ),
      body: DefaultBg(
        child: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  child: ReorderableListView(
                      onReorder: (oldIndex, newIndex) {
                        if (newIndex > oldIndex) {
                          newIndex = newIndex - 1;
                        }
                        List<MapEntry<String, String?>> exercisesList =
                            exercises.getExercisesAsPaired();
                        final exercise = exercisesList.removeAt(oldIndex);
                        exercisesList.insert(newIndex, exercise);
                        Map<String, String?> newExercises = {};
                        newExercises.addEntries(exercisesList);
                        ref.read(exerciseProvider.notifier).update(
                            ExercisesModel(exercises: newExercises), ref);
                      },
                      children: exercises
                          .getExercisesAsPaired()
                          .map((e) => Slidable(
                                key: UniqueKey(),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                        onPressed: (context) {
                                          ref
                                              .read(exerciseProvider.notifier)
                                              .remove(e.key, ref);
                                        },
                                        backgroundColor: gameErrorColor,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: inst.remove),
                                  ],
                                ),

                                // The child of the Slidable is what the user sees when the
                                // component is not dragged.
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  child: Card(
                                      elevation: 9,
                                      clipBehavior: Clip.hardEdge,
                                      color: CpColors.defBgColor,
                                      margin: const EdgeInsets.all(7),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              defPaddingSize)),
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.only(
                                              left: defPaddingSize * 2),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                FontAwesomeIcons.dumbbell,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                width: defPaddingSize,
                                              ),
                                              Text(e.key),
                                            ],
                                          ))),
                                ),
                              ))
                          .toList()),
                ),
                TextButton(
                    onPressed: () async {
                      List<String>? addedExercise = await showTextInputDialog(
                          context: context,
                          cancelLabel: inst.cancel,
                          okLabel: inst.add_exercise,
                          title: inst.add_exercise,
                          style: AdaptiveStyle.material,
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                  dialogBackgroundColor: CpColors.bgGC2),
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
                    child: Text(inst.add_exercise))
              ],
            ),
          ),
        )),
      ),
    );
  }
}
