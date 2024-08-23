// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'iga_trace_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IgaResultTraceModel _$IgaResultTraceModelFromJson(Map<String, dynamic> json) {
  return _IgaResultTraceModel.fromJson(json);
}

/// @nodoc
mixin _$IgaResultTraceModel {
// we collect is user enter register page and registered
  @JsonKey(name: 'traceId')
  String? get traceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'isEnterRegistered')
  bool? get isEnterRegistered => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'endTime')
  String? get endTime =>
      throw _privateConstructorUsedError; // track how much time spent in app
  @JsonKey(name: 'passedTime')
  int? get passedTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IgaResultTraceModelCopyWith<IgaResultTraceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IgaResultTraceModelCopyWith<$Res> {
  factory $IgaResultTraceModelCopyWith(
          IgaResultTraceModel value, $Res Function(IgaResultTraceModel) then) =
      _$IgaResultTraceModelCopyWithImpl<$Res, IgaResultTraceModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'traceId') String? traceId,
      @JsonKey(name: 'isEnterRegistered') bool? isEnterRegistered,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'endTime') String? endTime,
      @JsonKey(name: 'passedTime') int? passedTime});
}

/// @nodoc
class _$IgaResultTraceModelCopyWithImpl<$Res, $Val extends IgaResultTraceModel>
    implements $IgaResultTraceModelCopyWith<$Res> {
  _$IgaResultTraceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? traceId = freezed,
    Object? isEnterRegistered = freezed,
    Object? createdAt = freezed,
    Object? endTime = freezed,
    Object? passedTime = freezed,
  }) {
    return _then(_value.copyWith(
      traceId: freezed == traceId
          ? _value.traceId
          : traceId // ignore: cast_nullable_to_non_nullable
              as String?,
      isEnterRegistered: freezed == isEnterRegistered
          ? _value.isEnterRegistered
          : isEnterRegistered // ignore: cast_nullable_to_non_nullable
              as bool?,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IgaResultTraceModelCopyWith<$Res>
    implements $IgaResultTraceModelCopyWith<$Res> {
  factory _$$_IgaResultTraceModelCopyWith(_$_IgaResultTraceModel value,
          $Res Function(_$_IgaResultTraceModel) then) =
      __$$_IgaResultTraceModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'traceId') String? traceId,
      @JsonKey(name: 'isEnterRegistered') bool? isEnterRegistered,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'endTime') String? endTime,
      @JsonKey(name: 'passedTime') int? passedTime});
}

/// @nodoc
class __$$_IgaResultTraceModelCopyWithImpl<$Res>
    extends _$IgaResultTraceModelCopyWithImpl<$Res, _$_IgaResultTraceModel>
    implements _$$_IgaResultTraceModelCopyWith<$Res> {
  __$$_IgaResultTraceModelCopyWithImpl(_$_IgaResultTraceModel _value,
      $Res Function(_$_IgaResultTraceModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? traceId = freezed,
    Object? isEnterRegistered = freezed,
    Object? createdAt = freezed,
    Object? endTime = freezed,
    Object? passedTime = freezed,
  }) {
    return _then(_$_IgaResultTraceModel(
      traceId: freezed == traceId
          ? _value.traceId
          : traceId // ignore: cast_nullable_to_non_nullable
              as String?,
      isEnterRegistered: freezed == isEnterRegistered
          ? _value.isEnterRegistered
          : isEnterRegistered // ignore: cast_nullable_to_non_nullable
              as bool?,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IgaResultTraceModel
    with DiagnosticableTreeMixin
    implements _IgaResultTraceModel {
  const _$_IgaResultTraceModel(
      {@JsonKey(name: 'traceId') this.traceId,
      @JsonKey(name: 'isEnterRegistered') this.isEnterRegistered,
      @JsonKey(name: 'createdAt') this.createdAt,
      @JsonKey(name: 'endTime') this.endTime,
      @JsonKey(name: 'passedTime') this.passedTime});

  factory _$_IgaResultTraceModel.fromJson(Map<String, dynamic> json) =>
      _$$_IgaResultTraceModelFromJson(json);

// we collect is user enter register page and registered
  @override
  @JsonKey(name: 'traceId')
  final String? traceId;
  @override
  @JsonKey(name: 'isEnterRegistered')
  final bool? isEnterRegistered;
  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @override
  @JsonKey(name: 'endTime')
  final String? endTime;
// track how much time spent in app
  @override
  @JsonKey(name: 'passedTime')
  final int? passedTime;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IgaResultTraceModel(traceId: $traceId, isEnterRegistered: $isEnterRegistered, createdAt: $createdAt, endTime: $endTime, passedTime: $passedTime)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IgaResultTraceModel'))
      ..add(DiagnosticsProperty('traceId', traceId))
      ..add(DiagnosticsProperty('isEnterRegistered', isEnterRegistered))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('endTime', endTime))
      ..add(DiagnosticsProperty('passedTime', passedTime));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IgaResultTraceModel &&
            (identical(other.traceId, traceId) || other.traceId == traceId) &&
            (identical(other.isEnterRegistered, isEnterRegistered) ||
                other.isEnterRegistered == isEnterRegistered) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.passedTime, passedTime) ||
                other.passedTime == passedTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, traceId, isEnterRegistered, createdAt, endTime, passedTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IgaResultTraceModelCopyWith<_$_IgaResultTraceModel> get copyWith =>
      __$$_IgaResultTraceModelCopyWithImpl<_$_IgaResultTraceModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IgaResultTraceModelToJson(
      this,
    );
  }
}

abstract class _IgaResultTraceModel implements IgaResultTraceModel {
  const factory _IgaResultTraceModel(
          {@JsonKey(name: 'traceId') final String? traceId,
          @JsonKey(name: 'isEnterRegistered') final bool? isEnterRegistered,
          @JsonKey(name: 'createdAt') final String? createdAt,
          @JsonKey(name: 'endTime') final String? endTime,
          @JsonKey(name: 'passedTime') final int? passedTime}) =
      _$_IgaResultTraceModel;

  factory _IgaResultTraceModel.fromJson(Map<String, dynamic> json) =
      _$_IgaResultTraceModel.fromJson;

  @override // we collect is user enter register page and registered
  @JsonKey(name: 'traceId')
  String? get traceId;
  @override
  @JsonKey(name: 'isEnterRegistered')
  bool? get isEnterRegistered;
  @override
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  @JsonKey(name: 'endTime')
  String? get endTime;
  @override // track how much time spent in app
  @JsonKey(name: 'passedTime')
  int? get passedTime;
  @override
  @JsonKey(ignore: true)
  _$$_IgaResultTraceModelCopyWith<_$_IgaResultTraceModel> get copyWith =>
      throw _privateConstructorUsedError;
}
