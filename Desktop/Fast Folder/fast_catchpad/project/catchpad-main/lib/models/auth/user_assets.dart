import '../class_model.dart';
import '../exercises_model.dart';
import '../quiz_model.dart';

class UserAssets {
  const UserAssets(
      {this.exercisesModel, this.quizModel, this.classModel, this.favorites});
  final ExercisesModel? exercisesModel;
  final QuizModel? quizModel;
  final ClassModel? classModel;
  final List<String>? favorites;

  UserAssets copyWith(
          {ExercisesModel? exercisesModel,
          QuizModel? quizModel,
          ClassModel? classModel,
          List<String>? favorites}) =>
      UserAssets(
        exercisesModel: exercisesModel ?? this.exercisesModel,
        quizModel: quizModel ?? this.quizModel,
        classModel: classModel ?? this.classModel,
        favorites: favorites ?? this.favorites,
      );

  Map<String, dynamic> toJson() {
    return {
      'exercises': exercisesModel?.toJson(),
      'quizes': quizModel?.toJson(),
      'classes': classModel?.toJson(),
      'favorites': List<dynamic>.from(
          (favorites == null) ? [] : favorites!.map((x) => x)),
    };
  }

  factory UserAssets.fromJson(Map<String, dynamic> json) {
    ExercisesModel? exercisesModel;
    QuizModel? quizModel;
    ClassModel? classModel;
    List<String>? favorites;
    if (json["exercises"] == null) {
      exercisesModel = const ExercisesModel(exercises: {});
    } else {
      exercisesModel = ExercisesModel.fromJson(json["exercises"]);
    }
    if (json["quizes"] == null) {
      quizModel = QuizModel(quizes: []);
    } else {
      quizModel = QuizModel.fromJson(json["quizes"]);
    }
    if (json["classes"] == null) {
      classModel = ClassModel(classes: []);
    } else {
      classModel = ClassModel.fromJson(json["classes"]);
    }
    if (json["favorites"] == null) {
      favorites = [];
    } else {
      favorites = List<String>.from(json["favorites"].map((x) => x));
    }
    return UserAssets(
        exercisesModel: exercisesModel,
        quizModel: quizModel,
        classModel: classModel,
        favorites: favorites);
  }
}
