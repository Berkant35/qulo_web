// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fields.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Fields _$FieldsFromJson(Map<String, dynamic> json) {
  return _Fields.fromJson(json);
}

/// @nodoc
mixin _$Fields {
  @JsonKey(name: 'project')
  Project? get project => throw _privateConstructorUsedError;
  @JsonKey(name: 'summary')
  String? get summary => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  Description? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'labels')
  List<String>? get labels => throw _privateConstructorUsedError;
  @JsonKey(name: 'issuetype')
  Issuetype? get issuetype => throw _privateConstructorUsedError;
  @JsonKey(name: 'customfield_10016')
  int? get customfield10016 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FieldsCopyWith<Fields> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldsCopyWith<$Res> {
  factory $FieldsCopyWith(Fields value, $Res Function(Fields) then) =
      _$FieldsCopyWithImpl<$Res, Fields>;
  @useResult
  $Res call(
      {@JsonKey(name: 'project') Project? project,
      @JsonKey(name: 'summary') String? summary,
      @JsonKey(name: 'description') Description? description,
      @JsonKey(name: 'labels') List<String>? labels,
      @JsonKey(name: 'issuetype') Issuetype? issuetype,
      @JsonKey(name: 'customfield_10016') int? customfield10016});

  $ProjectCopyWith<$Res>? get project;
  $DescriptionCopyWith<$Res>? get description;
  $IssuetypeCopyWith<$Res>? get issuetype;
}

/// @nodoc
class _$FieldsCopyWithImpl<$Res, $Val extends Fields>
    implements $FieldsCopyWith<$Res> {
  _$FieldsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? project = freezed,
    Object? summary = freezed,
    Object? description = freezed,
    Object? labels = freezed,
    Object? issuetype = freezed,
    Object? customfield10016 = freezed,
  }) {
    return _then(_value.copyWith(
      project: freezed == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as Project?,
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as Description?,
      labels: freezed == labels
          ? _value.labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      issuetype: freezed == issuetype
          ? _value.issuetype
          : issuetype // ignore: cast_nullable_to_non_nullable
              as Issuetype?,
      customfield10016: freezed == customfield10016
          ? _value.customfield10016
          : customfield10016 // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProjectCopyWith<$Res>? get project {
    if (_value.project == null) {
      return null;
    }

    return $ProjectCopyWith<$Res>(_value.project!, (value) {
      return _then(_value.copyWith(project: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DescriptionCopyWith<$Res>? get description {
    if (_value.description == null) {
      return null;
    }

    return $DescriptionCopyWith<$Res>(_value.description!, (value) {
      return _then(_value.copyWith(description: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IssuetypeCopyWith<$Res>? get issuetype {
    if (_value.issuetype == null) {
      return null;
    }

    return $IssuetypeCopyWith<$Res>(_value.issuetype!, (value) {
      return _then(_value.copyWith(issuetype: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FieldsImplCopyWith<$Res> implements $FieldsCopyWith<$Res> {
  factory _$$FieldsImplCopyWith(
          _$FieldsImpl value, $Res Function(_$FieldsImpl) then) =
      __$$FieldsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'project') Project? project,
      @JsonKey(name: 'summary') String? summary,
      @JsonKey(name: 'description') Description? description,
      @JsonKey(name: 'labels') List<String>? labels,
      @JsonKey(name: 'issuetype') Issuetype? issuetype,
      @JsonKey(name: 'customfield_10016') int? customfield10016});

  @override
  $ProjectCopyWith<$Res>? get project;
  @override
  $DescriptionCopyWith<$Res>? get description;
  @override
  $IssuetypeCopyWith<$Res>? get issuetype;
}

/// @nodoc
class __$$FieldsImplCopyWithImpl<$Res>
    extends _$FieldsCopyWithImpl<$Res, _$FieldsImpl>
    implements _$$FieldsImplCopyWith<$Res> {
  __$$FieldsImplCopyWithImpl(
      _$FieldsImpl _value, $Res Function(_$FieldsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? project = freezed,
    Object? summary = freezed,
    Object? description = freezed,
    Object? labels = freezed,
    Object? issuetype = freezed,
    Object? customfield10016 = freezed,
  }) {
    return _then(_$FieldsImpl(
      project: freezed == project
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as Project?,
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as Description?,
      labels: freezed == labels
          ? _value._labels
          : labels // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      issuetype: freezed == issuetype
          ? _value.issuetype
          : issuetype // ignore: cast_nullable_to_non_nullable
              as Issuetype?,
      customfield10016: freezed == customfield10016
          ? _value.customfield10016
          : customfield10016 // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FieldsImpl implements _Fields {
  const _$FieldsImpl(
      {@JsonKey(name: 'project') this.project,
      @JsonKey(name: 'summary') this.summary,
      @JsonKey(name: 'description') this.description,
      @JsonKey(name: 'labels') final List<String>? labels,
      @JsonKey(name: 'issuetype') this.issuetype,
      @JsonKey(name: 'customfield_10016') this.customfield10016})
      : _labels = labels;

  factory _$FieldsImpl.fromJson(Map<String, dynamic> json) =>
      _$$FieldsImplFromJson(json);

  @override
  @JsonKey(name: 'project')
  final Project? project;
  @override
  @JsonKey(name: 'summary')
  final String? summary;
  @override
  @JsonKey(name: 'description')
  final Description? description;
  final List<String>? _labels;
  @override
  @JsonKey(name: 'labels')
  List<String>? get labels {
    final value = _labels;
    if (value == null) return null;
    if (_labels is EqualUnmodifiableListView) return _labels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'issuetype')
  final Issuetype? issuetype;
  @override
  @JsonKey(name: 'customfield_10016')
  final int? customfield10016;

  @override
  String toString() {
    return 'Fields(project: $project, summary: $summary, description: $description, labels: $labels, issuetype: $issuetype, customfield10016: $customfield10016)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FieldsImpl &&
            (identical(other.project, project) || other.project == project) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._labels, _labels) &&
            (identical(other.issuetype, issuetype) ||
                other.issuetype == issuetype) &&
            (identical(other.customfield10016, customfield10016) ||
                other.customfield10016 == customfield10016));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      project,
      summary,
      description,
      const DeepCollectionEquality().hash(_labels),
      issuetype,
      customfield10016);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldsImplCopyWith<_$FieldsImpl> get copyWith =>
      __$$FieldsImplCopyWithImpl<_$FieldsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FieldsImplToJson(
      this,
    );
  }
}

abstract class _Fields implements Fields {
  const factory _Fields(
          {@JsonKey(name: 'project') final Project? project,
          @JsonKey(name: 'summary') final String? summary,
          @JsonKey(name: 'description') final Description? description,
          @JsonKey(name: 'labels') final List<String>? labels,
          @JsonKey(name: 'issuetype') final Issuetype? issuetype,
          @JsonKey(name: 'customfield_10016') final int? customfield10016}) =
      _$FieldsImpl;

  factory _Fields.fromJson(Map<String, dynamic> json) = _$FieldsImpl.fromJson;

  @override
  @JsonKey(name: 'project')
  Project? get project;
  @override
  @JsonKey(name: 'summary')
  String? get summary;
  @override
  @JsonKey(name: 'description')
  Description? get description;
  @override
  @JsonKey(name: 'labels')
  List<String>? get labels;
  @override
  @JsonKey(name: 'issuetype')
  Issuetype? get issuetype;
  @override
  @JsonKey(name: 'customfield_10016')
  int? get customfield10016;
  @override
  @JsonKey(ignore: true)
  _$$FieldsImplCopyWith<_$FieldsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
