// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'iga_trace_pre_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IgaPreTraceModel _$IgaPreTraceModelFromJson(Map<String, dynamic> json) {
  return _IgaPreTraceModel.fromJson(json);
}

/// @nodoc
mixin _$IgaPreTraceModel {
// we track user how much time spent in app.
// select which lang, mode, playerMode, passedTime and is play game
  @JsonKey(name: 'traceId')
  String? get traceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'selectLanguage')
  String? get selectLanguage => throw _privateConstructorUsedError;
  @JsonKey(name: 'selectPlayer')
  String? get selectPlayer => throw _privateConstructorUsedError;
  @JsonKey(name: 'selectMode')
  String? get selectMode => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'endTime')
  String? get endTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'passedTime')
  int? get passedTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'isEnterGame')
  bool? get isEnterGame => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IgaPreTraceModelCopyWith<IgaPreTraceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IgaPreTraceModelCopyWith<$Res> {
  factory $IgaPreTraceModelCopyWith(
          IgaPreTraceModel value, $Res Function(IgaPreTraceModel) then) =
      _$IgaPreTraceModelCopyWithImpl<$Res, IgaPreTraceModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'traceId') String? traceId,
      @JsonKey(name: 'selectLanguage') String? selectLanguage,
      @JsonKey(name: 'selectPlayer') String? selectPlayer,
      @JsonKey(name: 'selectMode') String? selectMode,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'endTime') String? endTime,
      @JsonKey(name: 'passedTime') int? passedTime,
      @JsonKey(name: 'isEnterGame') bool? isEnterGame});
}

/// @nodoc
class _$IgaPreTraceModelCopyWithImpl<$Res, $Val extends IgaPreTraceModel>
    implements $IgaPreTraceModelCopyWith<$Res> {
  _$IgaPreTraceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? traceId = freezed,
    Object? selectLanguage = freezed,
    Object? selectPlayer = freezed,
    Object? selectMode = freezed,
    Object? createdAt = freezed,
    Object? endTime = freezed,
    Object? passedTime = freezed,
    Object? isEnterGame = freezed,
  }) {
    return _then(_value.copyWith(
      traceId: freezed == traceId
          ? _value.traceId
          : traceId // ignore: cast_nullable_to_non_nullable
              as String?,
      selectLanguage: freezed == selectLanguage
          ? _value.selectLanguage
          : selectLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      selectPlayer: freezed == selectPlayer
          ? _value.selectPlayer
          : selectPlayer // ignore: cast_nullable_to_non_nullable
              as String?,
      selectMode: freezed == selectMode
          ? _value.selectMode
          : selectMode // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
      passedTime: freezed == passedTime
          ? _value.passedTime
          : passedTime // ignore: cast_nullable_to_non_nullable
              as int?,
      isEnterGame: freezed == isEnterGame
          ? _value.isEnterGame
          : isEnterGame // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IgaPreTraceModelCopyWith<$Res>
    implements $IgaPreTraceModelCopyWith<$Res> {
  factory _$$_IgaPreTraceModelCopyWith(
          _$_IgaPreTraceModel value, $Res Function(_$_IgaPreTraceModel) then) =
      __$$_IgaPreTraceModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'traceId') String? traceId,
      @JsonKey(name: 'selectLanguage') String? selectLanguage,
      @JsonKey(name: 'selectPlayer') String? selectPlayer,
      @JsonKey(name: 'selectMode') String? selectMode,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'endTime') String? endTime,
      @JsonKey(name: 'passedTime') int? passedTime,
      @JsonKey(name: 'isEnterGame') bool? isEnterGame});
}

/// @nodoc
class __$$_IgaPreTraceModelCopyWithImpl<$Res>
    extends _$IgaPreTraceModelCopyWithImpl<$Res, _$_IgaPreTraceModel>
    implements _$$_IgaPreTraceModelCopyWith<$Res> {
  __$$_IgaPreTraceModelCopyWithImpl(
      _$_IgaPreTraceModel _value, $Res Function(_$_IgaPreTraceModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? traceId = freezed,
    Object? selectLanguage = freezed,
    Object? selectPlayer = freezed,
    Object? selectMode = freezed,
    Object? createdAt = freezed,
    Object? endTime = freezed,
    Object? passedTime = freezed,
    Object? isEnterGame = freezed,
  }) {
    return _then(_$_IgaPreTraceModel(
      traceId: freezed == traceId
          ? _value.traceId
          : traceId // ignore: cast_nullable_to_non_nullable
              as String?,
      selectLanguage: freezed == selectLanguage
          ? _value.selectLanguage
          : selectLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      selectPlayer: freezed == selectPlayer
          ? _value.selectPlayer
          : selectPlayer // ignore: cast_nullable_to_non_nullable
              as String?,
      selectMode: freezed == selectMode
          ? _value.selectMode
          : selectMode // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
      passedTime: freezed == passedTime
          ? _value.passedTime
          : passedTime // ignore: cast_nullable_to_non_nullable
              as int?,
      isEnterGame: freezed == isEnterGame
          ? _value.isEnterGame
          : isEnterGame // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IgaPreTraceModel
    with DiagnosticableTreeMixin
    implements _IgaPreTraceModel {
  const _$_IgaPreTraceModel(
      {@JsonKey(name: 'traceId') this.traceId,
      @JsonKey(name: 'selectLanguage') this.selectLanguage,
      @JsonKey(name: 'selectPlayer') this.selectPlayer,
      @JsonKey(name: 'selectMode') this.selectMode,
      @JsonKey(name: 'createdAt') this.createdAt,
      @JsonKey(name: 'endTime') this.endTime,
      @JsonKey(name: 'passedTime') this.passedTime,
      @JsonKey(name: 'isEnterGame') this.isEnterGame});

  factory _$_IgaPreTraceModel.fromJson(Map<String, dynamic> json) =>
      _$$_IgaPreTraceModelFromJson(json);

// we track user how much time spent in app.
// select which lang, mode, playerMode, passedTime and is play game
  @override
  @JsonKey(name: 'traceId')
  final String? traceId;
  @override
  @JsonKey(name: 'selectLanguage')
  final String? selectLanguage;
  @override
  @JsonKey(name: 'selectPlayer')
  final String? selectPlayer;
  @override
  @JsonKey(name: 'selectMode')
  final String? selectMode;
  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @override
  @JsonKey(name: 'endTime')
  final String? endTime;
  @override
  @JsonKey(name: 'passedTime')
  final int? passedTime;
  @override
  @JsonKey(name: 'isEnterGame')
  final bool? isEnterGame;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IgaPreTraceModel(traceId: $traceId, selectLanguage: $selectLanguage, selectPlayer: $selectPlayer, selectMode: $selectMode, createdAt: $createdAt, endTime: $endTime, passedTime: $passedTime, isEnterGame: $isEnterGame)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IgaPreTraceModel'))
      ..add(DiagnosticsProperty('traceId', traceId))
      ..add(DiagnosticsProperty('selectLanguage', selectLanguage))
      ..add(DiagnosticsProperty('selectPlayer', selectPlayer))
      ..add(DiagnosticsProperty('selectMode', selectMode))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('endTime', endTime))
      ..add(DiagnosticsProperty('passedTime', passedTime))
      ..add(DiagnosticsProperty('isEnterGame', isEnterGame));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IgaPreTraceModel &&
            (identical(other.traceId, traceId) || other.traceId == traceId) &&
            (identical(other.selectLanguage, selectLanguage) ||
                other.selectLanguage == selectLanguage) &&
            (identical(other.selectPlayer, selectPlayer) ||
                other.selectPlayer == selectPlayer) &&
            (identical(other.selectMode, selectMode) ||
                other.selectMode == selectMode) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.passedTime, passedTime) ||
                other.passedTime == passedTime) &&
            (identical(other.isEnterGame, isEnterGame) ||
                other.isEnterGame == isEnterGame));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, traceId, selectLanguage,
      selectPlayer, selectMode, createdAt, endTime, passedTime, isEnterGame);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IgaPreTraceModelCopyWith<_$_IgaPreTraceModel> get copyWith =>
      __$$_IgaPreTraceModelCopyWithImpl<_$_IgaPreTraceModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IgaPreTraceModelToJson(
      this,
    );
  }
}

abstract class _IgaPreTraceModel implements IgaPreTraceModel {
  const factory _IgaPreTraceModel(
          {@JsonKey(name: 'traceId') final String? traceId,
          @JsonKey(name: 'selectLanguage') final String? selectLanguage,
          @JsonKey(name: 'selectPlayer') final String? selectPlayer,
          @JsonKey(name: 'selectMode') final String? selectMode,
          @JsonKey(name: 'createdAt') final String? createdAt,
          @JsonKey(name: 'endTime') final String? endTime,
          @JsonKey(name: 'passedTime') final int? passedTime,
          @JsonKey(name: 'isEnterGame') final bool? isEnterGame}) =
      _$_IgaPreTraceModel;

  factory _IgaPreTraceModel.fromJson(Map<String, dynamic> json) =
      _$_IgaPreTraceModel.fromJson;

  @override // we track user how much time spent in app.
// select which lang, mode, playerMode, passedTime and is play game
  @JsonKey(name: 'traceId')
  String? get traceId;
  @override
  @JsonKey(name: 'selectLanguage')
  String? get selectLanguage;
  @override
  @JsonKey(name: 'selectPlayer')
  String? get selectPlayer;
  @override
  @JsonKey(name: 'selectMode')
  String? get selectMode;
  @override
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  @JsonKey(name: 'endTime')
  String? get endTime;
  @override
  @JsonKey(name: 'passedTime')
  int? get passedTime;
  @override
  @JsonKey(name: 'isEnterGame')
  bool? get isEnterGame;
  @override
  @JsonKey(ignore: true)
  _$$_IgaPreTraceModelCopyWith<_$_IgaPreTraceModel> get copyWith =>
      throw _privateConstructorUsedError;
}
