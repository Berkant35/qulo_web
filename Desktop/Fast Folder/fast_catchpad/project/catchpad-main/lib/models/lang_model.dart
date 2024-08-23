import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';

part 'lang_model.freezed.dart';
part 'lang_model.g.dart';

@freezed
class LanguageModel with _$LanguageModel {
  const LanguageModel._();

  const factory LanguageModel({
    required String id,
    required String code,
    required String name,
    required bool isRtl,
  }) = _LanguageModel;

  factory LanguageModel.fromLocale(Locale locale) {
    return L10n.allLangModels().firstWhere(
      (element) {
        return element.code == locale.languageCode;
      },
    );
  }

  Locale get locale {
    return Locale(code);
  }

  TextDirection get textDirection {
    return isRtl ? TextDirection.rtl : TextDirection.ltr;
  }

  static const String _seperator = '*&()';
  @override
  String toString() {
    return [code, id, name, isRtl].join(_seperator);
  }

  static LanguageModel fromString(String s) {
    final List ls = s.split(_seperator);
    return LanguageModel(
      code: ls[0],
      id: ls[1],
      name: ls[2],
      isRtl: ls[3].toString() == true.toString(),
    );
  }

  static LanguageModel getFromPrefs(SharedPreferences prefs) {
    return LanguageModel.fromString(prefs.getString(L10n.selectedLanguageKey)!);
  }

  factory LanguageModel.fromJson(Map<String, dynamic> json) =>
      _$LanguageModelFromJson(json);

  @override
  operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageModel &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          id == other.id &&
          name == other.name &&
          isRtl == other.isRtl;

  @override
  int get hashCode =>
      code.hashCode ^ id.hashCode ^ name.hashCode ^ isRtl.hashCode;
}
