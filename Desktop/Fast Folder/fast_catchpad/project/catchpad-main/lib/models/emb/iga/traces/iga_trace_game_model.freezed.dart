// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'iga_trace_game_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IgaGameTraceModel _$IgaGameTraceModelFromJson(Map<String, dynamic> json) {
  return _IgaGameTraceModel.fromJson(json);
}

/// @nodoc
mixin _$IgaGameTraceModel {
  @JsonKey(name: 'traceId')
  String? get traceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'selectedColors')
  List<String>? get selectedColors => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'endTime')
  String? get endTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'gameId')
  String? get gameId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IgaGameTraceModelCopyWith<IgaGameTraceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IgaGameTraceModelCopyWith<$Res> {
  factory $IgaGameTraceModelCopyWith(
          IgaGameTraceModel value, $Res Function(IgaGameTraceModel) then) =
      _$IgaGameTraceModelCopyWithImpl<$Res, IgaGameTraceModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'traceId') String? traceId,
      @JsonKey(name: 'selectedColors') List<String>? selectedColors,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'endTime') String? endTime,
      @JsonKey(name: 'gameId') String? gameId});
}

/// @nodoc
class _$IgaGameTraceModelCopyWithImpl<$Res, $Val extends IgaGameTraceModel>
    implements $IgaGameTraceModelCopyWith<$Res> {
  _$IgaGameTraceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? traceId = freezed,
    Object? selectedColors = freezed,
    Object? createdAt = freezed,
    Object? endTime = freezed,
    Object? gameId = freezed,
  }) {
    return _then(_value.copyWith(
      traceId: freezed == traceId
          ? _value.traceId
          : traceId // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedColors: freezed == selectedColors
          ? _value.selectedColors
          : selectedColors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
      gameId: freezed == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IgaGameTraceModelCopyWith<$Res>
    implements $IgaGameTraceModelCopyWith<$Res> {
  factory _$$_IgaGameTraceModelCopyWith(_$_IgaGameTraceModel value,
          $Res Function(_$_IgaGameTraceModel) then) =
      __$$_IgaGameTraceModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'traceId') String? traceId,
      @JsonKey(name: 'selectedColors') List<String>? selectedColors,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'endTime') String? endTime,
      @JsonKey(name: 'gameId') String? gameId});
}

/// @nodoc
class __$$_IgaGameTraceModelCopyWithImpl<$Res>
    extends _$IgaGameTraceModelCopyWithImpl<$Res, _$_IgaGameTraceModel>
    implements _$$_IgaGameTraceModelCopyWith<$Res> {
  __$$_IgaGameTraceModelCopyWithImpl(
      _$_IgaGameTraceModel _value, $Res Function(_$_IgaGameTraceModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? traceId = freezed,
    Object? selectedColors = freezed,
    Object? createdAt = freezed,
    Object? endTime = freezed,
    Object? gameId = freezed,
  }) {
    return _then(_$_IgaGameTraceModel(
      traceId: freezed == traceId
          ? _value.traceId
          : traceId // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedColors: freezed == selectedColors
          ? _value._selectedColors
          : selectedColors // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
      gameId: freezed == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IgaGameTraceModel implements _IgaGameTraceModel {
  const _$_IgaGameTraceModel(
      {@JsonKey(name: 'traceId') this.traceId,
      @JsonKey(name: 'selectedColors') final List<String>? selectedColors,
      @JsonKey(name: 'createdAt') this.createdAt,
      @JsonKey(name: 'endTime') this.endTime,
      @JsonKey(name: 'gameId') this.gameId})
      : _selectedColors = selectedColors;

  factory _$_IgaGameTraceModel.fromJson(Map<String, dynamic> json) =>
      _$$_IgaGameTraceModelFromJson(json);

  @override
  @JsonKey(name: 'traceId')
  final String? traceId;
  final List<String>? _selectedColors;
  @override
  @JsonKey(name: 'selectedColors')
  List<String>? get selectedColors {
    final value = _selectedColors;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @override
  @JsonKey(name: 'endTime')
  final String? endTime;
  @override
  @JsonKey(name: 'gameId')
  final String? gameId;

  @override
  String toString() {
    return 'IgaGameTraceModel(traceId: $traceId, selectedColors: $selectedColors, createdAt: $createdAt, endTime: $endTime, gameId: $gameId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IgaGameTraceModel &&
            (identical(other.traceId, traceId) || other.traceId == traceId) &&
            const DeepCollectionEquality()
                .equals(other._selectedColors, _selectedColors) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.gameId, gameId) || other.gameId == gameId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      traceId,
      const DeepCollectionEquality().hash(_selectedColors),
      createdAt,
      endTime,
      gameId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IgaGameTraceModelCopyWith<_$_IgaGameTraceModel> get copyWith =>
      __$$_IgaGameTraceModelCopyWithImpl<_$_IgaGameTraceModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IgaGameTraceModelToJson(
      this,
    );
  }
}

abstract class _IgaGameTraceModel implements IgaGameTraceModel {
  const factory _IgaGameTraceModel(
      {@JsonKey(name: 'traceId') final String? traceId,
      @JsonKey(name: 'selectedColors') final List<String>? selectedColors,
      @JsonKey(name: 'createdAt') final String? createdAt,
      @JsonKey(name: 'endTime') final String? endTime,
      @JsonKey(name: 'gameId') final String? gameId}) = _$_IgaGameTraceModel;

  factory _IgaGameTraceModel.fromJson(Map<String, dynamic> json) =
      _$_IgaGameTraceModel.fromJson;

  @override
  @JsonKey(name: 'traceId')
  String? get traceId;
  @override
  @JsonKey(name: 'selectedColors')
  List<String>? get selectedColors;
  @override
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  @JsonKey(name: 'endTime')
  String? get endTime;
  @override
  @JsonKey(name: 'gameId')
  String? get gameId;
  @override
  @JsonKey(ignore: true)
  _$$_IgaGameTraceModelCopyWith<_$_IgaGameTraceModel> get copyWith =>
      throw _privateConstructorUsedError;
}
