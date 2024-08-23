// To parse this JSON data, do
//
//     final quizModel = quizModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final quizModel = quizModelFromJson(jsonString);

import 'dart:convert';

class ClassModel {
  ClassModel({
    required this.classes,
    this.assigned,
  });

  final List<Class> classes;
  final bool? assigned;

  List<String> getAllStudentNickNames() {
    List<String> students = [];
    for (Class cls in classes) {
      for (Student student in cls.students) {
        if (students.contains(student.studentNickName) == false) {
          students.add(student.studentNickName);
        }
      }
    }
    return students;
  }

  ClassModel copyWith({
    List<Class>? classes,
    bool? assigned,
  }) =>
      ClassModel(classes: classes ?? this.classes, assigned: assigned);

  factory ClassModel.fromRawJson(String str) => ClassModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
        classes: List<Class>.from(json["classes"].map((x) => Class.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "classes": List<dynamic>.from(classes.map((x) => x.toJson())),
      };
}

class Class {
  Class({
    required this.classname,
    required this.students,
  });

  final String classname;
  final List<Student> students;

  Class copyWith({
    String? classname,
    List<Student>? students,
  }) =>
      Class(
        classname: classname ?? this.classname,
        students: students ?? this.students,
      );

  factory Class.fromRawJson(String str) => Class.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        classname: json["classname"],
        students: List<Student>.from(json["students"].map((x) => Student.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "classname": classname,
        "students": List<dynamic>.from(students.map((x) => x.toJson())),
      };
}

class Student {
  Student({
    required this.firstName,
    required this.lastName,
    required this.studentNumber,
    required this.studentClass,
    required this.studentNickName,
    required this.createdAt,
    this.age,
    this.index,
    this.weight,
    this.height,
    this.email,
    this.phoneNumber,
  });
  final int? index;
  final String firstName;
  final String lastName;
  final String studentNumber;
  final String studentClass;
  final String studentNickName;
  final String? age;
  final String? weight;
  final String? height;
  final String? email;
  final String? phoneNumber;
  final DateTime createdAt;

  Student copyWith(
          {String? firstName,
          String? lastName,
          String? studentNumber,
          String? studentClass,
          String? studentNickName,
          String? age,
          String? weight,
          String? height,
          String? email,
          String? phoneNumber,
          DateTime? createdAt,
          int? index}) =>
      Student(
        index: index ?? this.index,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        studentNumber: studentNumber ?? this.studentNumber,
        studentClass: studentClass ?? this.studentClass,
        studentNickName: studentNickName ?? this.studentNickName,
        age: age ?? this.age,
        weight: weight ?? this.weight,
        height: height ?? this.height,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Student.fromRawJson(String str) => Student.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        index: int.tryParse(json.keys.first),
        firstName: json["firstname"],
        lastName: json["lastname"],
        studentNumber: json["number"],
        studentClass: json["class"],
        studentNickName: json["nickname"],
        age: json["age"],
        weight: json["weight"],
        height: json["height"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstName,
        "lastname": lastName,
        "number": studentNumber,
        "class": studentClass,
        "nickname": studentNickName,
        "age": age,
        "weight": weight,
        "height": height,
        "email": email,
        "phoneNumber": phoneNumber,
        "createdAt": createdAt.toIso8601String(),
      };
}
