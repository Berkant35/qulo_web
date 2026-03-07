// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) =>
    QuestionModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      orderNum: (json['order_num'] as num).toInt(),
      questionText: json['question_text'] as String,
      correctAnswer: (json['correct_answer'] as num).toInt(),
      answer1: json['answer_1'] as String,
      answer2: json['answer_2'] as String,
      answer3: json['answer_3'] as String,
      answer4: json['answer_4'] as String,
      hintText: json['hint_text'] as String?,
      statsCorrect: (json['stats_correct'] as num?)?.toInt() ?? 0,
      statsWrong: (json['stats_wrong'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'order_num': instance.orderNum,
      'question_text': instance.questionText,
      'correct_answer': instance.correctAnswer,
      'answer_1': instance.answer1,
      'answer_2': instance.answer2,
      'answer_3': instance.answer3,
      'answer_4': instance.answer4,
      'hint_text': instance.hintText,
      'stats_correct': instance.statsCorrect,
      'stats_wrong': instance.statsWrong,
      'created_at': instance.createdAt,
    };
