import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel extends Equatable {
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'order_num')
  final int orderNum;
  @JsonKey(name: 'question_text')
  final String questionText;
  @JsonKey(name: 'correct_answer')
  final int correctAnswer;
  @JsonKey(name: 'answer_1')
  final String answer1;
  @JsonKey(name: 'answer_2')
  final String answer2;
  @JsonKey(name: 'answer_3')
  final String answer3;
  @JsonKey(name: 'answer_4')
  final String answer4;
  @JsonKey(name: 'hint_text')
  final String? hintText;
  @JsonKey(name: 'stats_correct')
  final int statsCorrect;
  @JsonKey(name: 'stats_wrong')
  final int statsWrong;
  @JsonKey(name: 'created_at')
  final String? createdAt;

  const QuestionModel({
    required this.id,
    required this.userId,
    required this.orderNum,
    required this.questionText,
    required this.correctAnswer,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    this.hintText,
    this.statsCorrect = 0,
    this.statsWrong = 0,
    this.createdAt,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);

  @override
  List<Object?> get props => [id, orderNum];
}
