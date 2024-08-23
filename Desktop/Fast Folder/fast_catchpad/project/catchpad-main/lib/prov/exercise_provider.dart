import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';

import 'auth/current_user_prov.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/exercises_model.dart';

export '../models/permission/permission_manager.dart';

final exerciseProvider =
    StateNotifierProvider<ExerciseProvider, ExercisesModel>(
  (_) => ExerciseProvider(const ExercisesModel(exercises: {})),
);

class ExerciseProvider extends StateNotifier<ExercisesModel> {
  ExerciseProvider(super.state);

  void addNew(Map<String, String?> exercise, WidgetRef ref) {
    logger.i("Add new exercise");
    Map<String, String?> newExercises = Map.from(state.exercises);
    newExercises.addAll(exercise);
    state = ExercisesModel(exercises: newExercises);
    saveToSharedPref(ref);
  }

  void update(ExercisesModel exercisesModel, WidgetRef ref) {
    state = exercisesModel;
    saveToSharedPref(ref);
  }

  void reset() {
    state = const ExercisesModel(exercises: {});
  }

  void setColorToMove(String key, String color) {
    logger.i("Add new exercise setColorToMove");
    Map<String, String?> newExercises = Map.from(state.exercises);
    if (!newExercises.values.contains(color)) {
      newExercises[key] = color;
      state = ExercisesModel(exercises: newExercises);
    }
  }

  void removeColorFromMove(String key) {
    Map<String, String?> newExercises = Map.from(state.exercises);
    newExercises[key] = null;
    state = ExercisesModel(exercises: newExercises);
  }

  void remove(String key, WidgetRef ref) {
    Map<String, String?> newExercises = Map.from(state.exercises);
    newExercises.remove(key);
    state = ExercisesModel(exercises: newExercises);
    saveToSharedPref(ref);
  }

  saveToSharedPref(WidgetRef ref) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    ref
        .read(currentUserAssetsProv.notifier)
        .updateAssets(exercisesModel: state);
    sharedPreferences.setStringList('exercises', state.exercises.keys.toList());
  }

  Future<bool> loadMoves(WidgetRef ref) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final List<String>? exercises =
        sharedPreferences.getStringList('exercises');
    if (exercises != null) {
      Map<String, String?> exerciseMap = {};
      for (var exercise in exercises) {
        exerciseMap[exercise] = null;
      }
      state = ExercisesModel(exercises: exerciseMap);
    }
    ref
        .read(currentUserAssetsProv.notifier)
        .updateAssets(exercisesModel: state);
    return true;
  }
}
