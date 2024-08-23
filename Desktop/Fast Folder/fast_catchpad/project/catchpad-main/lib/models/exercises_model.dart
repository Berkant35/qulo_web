class ExercisesModel {
  const ExercisesModel({required this.exercises});
  final Map<String, String?> exercises;

  List<String> getExercises() {
    return exercises.keys.toList();
  }

  List<String?> getColorsOfExercies() {
    return exercises.values.toList();
  }

  List<MapEntry<String, String?>> getExercisesAsPaired() {
    return exercises.entries.toList();
  }

  Map<String, String?> toJson() {
    return exercises;
  }

  factory ExercisesModel.fromJson(Map<String, dynamic> json) {
    try {
      return ExercisesModel(
        exercises: Map<String, String?>.from(json),
      );
    } catch (e) {
      return const ExercisesModel(exercises: {});
    }
  }
}
