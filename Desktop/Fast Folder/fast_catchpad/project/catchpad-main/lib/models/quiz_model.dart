// To parse this JSON data, do
//
//     final quizModel = quizModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final quizModel = quizModelFromJson(jsonString);

import 'dart:convert';

class QuizModel {
  QuizModel({
    required this.quizes,
    this.assigned,
  });

  final List<Quize> quizes;
  final bool? assigned;
  QuizModel copyWith({
    List<Quize>? quizes,
    bool? assigned,
  }) =>
      QuizModel(quizes: quizes ?? this.quizes, assigned: assigned);

  factory QuizModel.fromRawJson(String str) =>
      QuizModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        quizes: List<Quize>.from(json["quizes"].map((x) => Quize.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "quizes": List<dynamic>.from(quizes.map((x) => x.toJson())),
      };
}

class Quize {
  Quize({
    required this.quizname,
    required this.questions,
  });

  final String quizname;
  final List<Question> questions;

  Quize copyWith({
    String? quizname,
    List<Question>? questions,
  }) =>
      Quize(
        quizname: quizname ?? this.quizname,
        questions: questions ?? this.questions,
      );

  factory Quize.fromRawJson(String str) => Quize.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Quize.fromJson(Map<String, dynamic> json) => Quize(
        quizname: json["quizname"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "quizname": quizname,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  Question({
    required this.question,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.correctAnswer,
  });

  final String question;
  final String a;
  final String b;
  final String c;
  final String d;
  final String correctAnswer;

  Question copyWith({
    String? question,
    String? a,
    String? b,
    String? c,
    String? d,
    String? correctAnswer,
  }) =>
      Question(
        question: question ?? this.question,
        a: a ?? this.a,
        b: b ?? this.b,
        c: c ?? this.c,
        d: d ?? this.d,
        correctAnswer: correctAnswer ?? this.correctAnswer,
      );

  factory Question.fromRawJson(String str) =>
      Question.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["Question"],
        a: json["A"],
        b: json["B"],
        c: json["C"],
        d: json["D"],
        correctAnswer: json["CorrectAnswer"],
      );

  Map<String, dynamic> toJson() => {
        "Question": question,
        "A": a,
        "B": b,
        "C": c,
        "D": d,
        "CorrectAnswer": correctAnswer,
      };
}
