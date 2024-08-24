// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'response_todo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ResponseTodoModel _$ResponseTodoModelFromJson(Map<String, dynamic> json) {
  return _ResponseTodoModel.fromJson(json);
}

/// @nodoc
mixin _$ResponseTodoModel {
  @JsonKey(name: 'meet_id')
  String get meetId => throw _privateConstructorUsedError;
  @JsonKey(name: 'language')
  String? get language => throw _privateConstructorUsedError;
  @JsonKey(name: 'meet_pure_text')
  String? get meetPureText => throw _privateConstructorUsedError;
  @JsonKey(name: 'meet_suggested_title')
  String? get meetSuggestedTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'meet_content_summarize')
  String? get meetContentSummarize => throw _privateConstructorUsedError;
  @JsonKey(name: 'recognize_person_names')
  List<String>? get recognizePersonNames => throw _privateConstructorUsedError;
  @JsonKey(name: 'todos')
  List<ResponsePerTodoModel>? get todos => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResponseTodoModelCopyWith<ResponseTodoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResponseTodoModelCopyWith<$Res> {
  factory $ResponseTodoModelCopyWith(
          ResponseTodoModel value, $Res Function(ResponseTodoModel) then) =
      _$ResponseTodoModelCopyWithImpl<$Res, ResponseTodoModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'meet_id') String meetId,
      @JsonKey(name: 'language') String? language,
      @JsonKey(name: 'meet_pure_text') String? meetPureText,
      @JsonKey(name: 'meet_suggested_title') String? meetSuggestedTitle,
      @JsonKey(name: 'meet_content_summarize') String? meetContentSummarize,
      @JsonKey(name: 'recognize_person_names')
      List<String>? recognizePersonNames,
      @JsonKey(name: 'todos') List<ResponsePerTodoModel>? todos});
}

/// @nodoc
class _$ResponseTodoModelCopyWithImpl<$Res, $Val extends ResponseTodoModel>
    implements $ResponseTodoModelCopyWith<$Res> {
  _$ResponseTodoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetId = null,
    Object? language = freezed,
    Object? meetPureText = freezed,
    Object? meetSuggestedTitle = freezed,
    Object? meetContentSummarize = freezed,
    Object? recognizePersonNames = freezed,
    Object? todos = freezed,
  }) {
    return _then(_value.copyWith(
      meetId: null == meetId
          ? _value.meetId
          : meetId // ignore: cast_nullable_to_non_nullable
              as String,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      meetPureText: freezed == meetPureText
          ? _value.meetPureText
          : meetPureText // ignore: cast_nullable_to_non_nullable
              as String?,
      meetSuggestedTitle: freezed == meetSuggestedTitle
          ? _value.meetSuggestedTitle
          : meetSuggestedTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      meetContentSummarize: freezed == meetContentSummarize
          ? _value.meetContentSummarize
          : meetContentSummarize // ignore: cast_nullable_to_non_nullable
              as String?,
      recognizePersonNames: freezed == recognizePersonNames
          ? _value.recognizePersonNames
          : recognizePersonNames // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      todos: freezed == todos
          ? _value.todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<ResponsePerTodoModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResponseTodoModelImplCopyWith<$Res>
    implements $ResponseTodoModelCopyWith<$Res> {
  factory _$$ResponseTodoModelImplCopyWith(_$ResponseTodoModelImpl value,
          $Res Function(_$ResponseTodoModelImpl) then) =
      __$$ResponseTodoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'meet_id') String meetId,
      @JsonKey(name: 'language') String? language,
      @JsonKey(name: 'meet_pure_text') String? meetPureText,
      @JsonKey(name: 'meet_suggested_title') String? meetSuggestedTitle,
      @JsonKey(name: 'meet_content_summarize') String? meetContentSummarize,
      @JsonKey(name: 'recognize_person_names')
      List<String>? recognizePersonNames,
      @JsonKey(name: 'todos') List<ResponsePerTodoModel>? todos});
}

/// @nodoc
class __$$ResponseTodoModelImplCopyWithImpl<$Res>
    extends _$ResponseTodoModelCopyWithImpl<$Res, _$ResponseTodoModelImpl>
    implements _$$ResponseTodoModelImplCopyWith<$Res> {
  __$$ResponseTodoModelImplCopyWithImpl(_$ResponseTodoModelImpl _value,
      $Res Function(_$ResponseTodoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetId = null,
    Object? language = freezed,
    Object? meetPureText = freezed,
    Object? meetSuggestedTitle = freezed,
    Object? meetContentSummarize = freezed,
    Object? recognizePersonNames = freezed,
    Object? todos = freezed,
  }) {
    return _then(_$ResponseTodoModelImpl(
      meetId: null == meetId
          ? _value.meetId
          : meetId // ignore: cast_nullable_to_non_nullable
              as String,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      meetPureText: freezed == meetPureText
          ? _value.meetPureText
          : meetPureText // ignore: cast_nullable_to_non_nullable
              as String?,
      meetSuggestedTitle: freezed == meetSuggestedTitle
          ? _value.meetSuggestedTitle
          : meetSuggestedTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      meetContentSummarize: freezed == meetContentSummarize
          ? _value.meetContentSummarize
          : meetContentSummarize // ignore: cast_nullable_to_non_nullable
              as String?,
      recognizePersonNames: freezed == recognizePersonNames
          ? _value._recognizePersonNames
          : recognizePersonNames // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      todos: freezed == todos
          ? _value._todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<ResponsePerTodoModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResponseTodoModelImpl
    with DiagnosticableTreeMixin
    implements _ResponseTodoModel {
  const _$ResponseTodoModelImpl(
      {@JsonKey(name: 'meet_id') this.meetId = "",
      @JsonKey(name: 'language') this.language,
      @JsonKey(name: 'meet_pure_text') this.meetPureText,
      @JsonKey(name: 'meet_suggested_title') this.meetSuggestedTitle,
      @JsonKey(name: 'meet_content_summarize') this.meetContentSummarize,
      @JsonKey(name: 'recognize_person_names')
      final List<String>? recognizePersonNames,
      @JsonKey(name: 'todos') final List<ResponsePerTodoModel>? todos})
      : _recognizePersonNames = recognizePersonNames,
        _todos = todos;

  factory _$ResponseTodoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResponseTodoModelImplFromJson(json);

  @override
  @JsonKey(name: 'meet_id')
  final String meetId;
  @override
  @JsonKey(name: 'language')
  final String? language;
  @override
  @JsonKey(name: 'meet_pure_text')
  final String? meetPureText;
  @override
  @JsonKey(name: 'meet_suggested_title')
  final String? meetSuggestedTitle;
  @override
  @JsonKey(name: 'meet_content_summarize')
  final String? meetContentSummarize;
  final List<String>? _recognizePersonNames;
  @override
  @JsonKey(name: 'recognize_person_names')
  List<String>? get recognizePersonNames {
    final value = _recognizePersonNames;
    if (value == null) return null;
    if (_recognizePersonNames is EqualUnmodifiableListView)
      return _recognizePersonNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ResponsePerTodoModel>? _todos;
  @override
  @JsonKey(name: 'todos')
  List<ResponsePerTodoModel>? get todos {
    final value = _todos;
    if (value == null) return null;
    if (_todos is EqualUnmodifiableListView) return _todos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ResponseTodoModel(meetId: $meetId, language: $language, meetPureText: $meetPureText, meetSuggestedTitle: $meetSuggestedTitle, meetContentSummarize: $meetContentSummarize, recognizePersonNames: $recognizePersonNames, todos: $todos)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ResponseTodoModel'))
      ..add(DiagnosticsProperty('meetId', meetId))
      ..add(DiagnosticsProperty('language', language))
      ..add(DiagnosticsProperty('meetPureText', meetPureText))
      ..add(DiagnosticsProperty('meetSuggestedTitle', meetSuggestedTitle))
      ..add(DiagnosticsProperty('meetContentSummarize', meetContentSummarize))
      ..add(DiagnosticsProperty('recognizePersonNames', recognizePersonNames))
      ..add(DiagnosticsProperty('todos', todos));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResponseTodoModelImpl &&
            (identical(other.meetId, meetId) || other.meetId == meetId) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.meetPureText, meetPureText) ||
                other.meetPureText == meetPureText) &&
            (identical(other.meetSuggestedTitle, meetSuggestedTitle) ||
                other.meetSuggestedTitle == meetSuggestedTitle) &&
            (identical(other.meetContentSummarize, meetContentSummarize) ||
                other.meetContentSummarize == meetContentSummarize) &&
            const DeepCollectionEquality()
                .equals(other._recognizePersonNames, _recognizePersonNames) &&
            const DeepCollectionEquality().equals(other._todos, _todos));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      meetId,
      language,
      meetPureText,
      meetSuggestedTitle,
      meetContentSummarize,
      const DeepCollectionEquality().hash(_recognizePersonNames),
      const DeepCollectionEquality().hash(_todos));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResponseTodoModelImplCopyWith<_$ResponseTodoModelImpl> get copyWith =>
      __$$ResponseTodoModelImplCopyWithImpl<_$ResponseTodoModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResponseTodoModelImplToJson(
      this,
    );
  }
}

abstract class _ResponseTodoModel implements ResponseTodoModel {
  const factory _ResponseTodoModel(
      {@JsonKey(name: 'meet_id') final String meetId,
      @JsonKey(name: 'language') final String? language,
      @JsonKey(name: 'meet_pure_text') final String? meetPureText,
      @JsonKey(name: 'meet_suggested_title') final String? meetSuggestedTitle,
      @JsonKey(name: 'meet_content_summarize')
      final String? meetContentSummarize,
      @JsonKey(name: 'recognize_person_names')
      final List<String>? recognizePersonNames,
      @JsonKey(name: 'todos')
      final List<ResponsePerTodoModel>? todos}) = _$ResponseTodoModelImpl;

  factory _ResponseTodoModel.fromJson(Map<String, dynamic> json) =
      _$ResponseTodoModelImpl.fromJson;

  @override
  @JsonKey(name: 'meet_id')
  String get meetId;
  @override
  @JsonKey(name: 'language')
  String? get language;
  @override
  @JsonKey(name: 'meet_pure_text')
  String? get meetPureText;
  @override
  @JsonKey(name: 'meet_suggested_title')
  String? get meetSuggestedTitle;
  @override
  @JsonKey(name: 'meet_content_summarize')
  String? get meetContentSummarize;
  @override
  @JsonKey(name: 'recognize_person_names')
  List<String>? get recognizePersonNames;
  @override
  @JsonKey(name: 'todos')
  List<ResponsePerTodoModel>? get todos;
  @override
  @JsonKey(ignore: true)
  _$$ResponseTodoModelImplCopyWith<_$ResponseTodoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
