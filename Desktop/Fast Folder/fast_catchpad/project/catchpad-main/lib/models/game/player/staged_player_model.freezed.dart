// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'staged_player_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StagedPlayerModel _$StagedPlayerModelFromJson(Map<String, dynamic> json) {
  return _StagedPlayerModel.fromJson(json);
}

/// @nodoc
mixin _$StagedPlayerModel {
  @protected
  NumRange? get colorCount => throw _privateConstructorUsedError;
  NumRange? get deviceCount => throw _privateConstructorUsedError;
  bool get hasName => throw _privateConstructorUsedError;
  @protected
  bool get hasDevices => throw _privateConstructorUsedError;

  ///This parameter represents the assigned difference value, indicating
  ///what the difference value (padCount - selectedColor) should be.
  ///For example, in the central vision exercise, if the Pad Count is 4,
  /// the selected color count must be 3. Therefore, this value must always be 1
  int? get colorDeviceDifference => throw _privateConstructorUsedError;

  /// these colors will be pre selected in the player picker
  @protected
  @JsonKey(ignore: true)
  List<Color>? get defaultSelectedColors => throw _privateConstructorUsedError;

  /// these colors will be hidden from the player picker,
  /// will be used for success and error colors etc.
  @JsonKey(ignore: true)
  List<Color>? get unavailableColors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StagedPlayerModelCopyWith<StagedPlayerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StagedPlayerModelCopyWith<$Res> {
  factory $StagedPlayerModelCopyWith(
          StagedPlayerModel value, $Res Function(StagedPlayerModel) then) =
      _$StagedPlayerModelCopyWithImpl<$Res, StagedPlayerModel>;
  @useResult
  $Res call(
      {@protected NumRange? colorCount,
      NumRange? deviceCount,
      bool hasName,
      @protected bool hasDevices,
      int? colorDeviceDifference,
      @protected @JsonKey(ignore: true) List<Color>? defaultSelectedColors,
      @JsonKey(ignore: true) List<Color>? unavailableColors});

  $NumRangeCopyWith<$Res>? get colorCount;
  $NumRangeCopyWith<$Res>? get deviceCount;
}

/// @nodoc
class _$StagedPlayerModelCopyWithImpl<$Res, $Val extends StagedPlayerModel>
    implements $StagedPlayerModelCopyWith<$Res> {
  _$StagedPlayerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? colorCount = freezed,
    Object? deviceCount = freezed,
    Object? hasName = null,
    Object? hasDevices = null,
    Object? colorDeviceDifference = freezed,
    Object? defaultSelectedColors = freezed,
    Object? unavailableColors = freezed,
  }) {
    return _then(_value.copyWith(
      colorCount: freezed == colorCount
          ? _value.colorCount
          : colorCount // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      deviceCount: freezed == deviceCount
          ? _value.deviceCount
          : deviceCount // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      hasName: null == hasName
          ? _value.hasName
          : hasName // ignore: cast_nullable_to_non_nullable
              as bool,
      hasDevices: null == hasDevices
          ? _value.hasDevices
          : hasDevices // ignore: cast_nullable_to_non_nullable
              as bool,
      colorDeviceDifference: freezed == colorDeviceDifference
          ? _value.colorDeviceDifference
          : colorDeviceDifference // ignore: cast_nullable_to_non_nullable
              as int?,
      defaultSelectedColors: freezed == defaultSelectedColors
          ? _value.defaultSelectedColors
          : defaultSelectedColors // ignore: cast_nullable_to_non_nullable
              as List<Color>?,
      unavailableColors: freezed == unavailableColors
          ? _value.unavailableColors
          : unavailableColors // ignore: cast_nullable_to_non_nullable
              as List<Color>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NumRangeCopyWith<$Res>? get colorCount {
    if (_value.colorCount == null) {
      return null;
    }

    return $NumRangeCopyWith<$Res>(_value.colorCount!, (value) {
      return _then(_value.copyWith(colorCount: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NumRangeCopyWith<$Res>? get deviceCount {
    if (_value.deviceCount == null) {
      return null;
    }

    return $NumRangeCopyWith<$Res>(_value.deviceCount!, (value) {
      return _then(_value.copyWith(deviceCount: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_StagedPlayerModelCopyWith<$Res>
    implements $StagedPlayerModelCopyWith<$Res> {
  factory _$$_StagedPlayerModelCopyWith(_$_StagedPlayerModel value,
          $Res Function(_$_StagedPlayerModel) then) =
      __$$_StagedPlayerModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@protected NumRange? colorCount,
      NumRange? deviceCount,
      bool hasName,
      @protected bool hasDevices,
      int? colorDeviceDifference,
      @protected @JsonKey(ignore: true) List<Color>? defaultSelectedColors,
      @JsonKey(ignore: true) List<Color>? unavailableColors});

  @override
  $NumRangeCopyWith<$Res>? get colorCount;
  @override
  $NumRangeCopyWith<$Res>? get deviceCount;
}

/// @nodoc
class __$$_StagedPlayerModelCopyWithImpl<$Res>
    extends _$StagedPlayerModelCopyWithImpl<$Res, _$_StagedPlayerModel>
    implements _$$_StagedPlayerModelCopyWith<$Res> {
  __$$_StagedPlayerModelCopyWithImpl(
      _$_StagedPlayerModel _value, $Res Function(_$_StagedPlayerModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? colorCount = freezed,
    Object? deviceCount = freezed,
    Object? hasName = null,
    Object? hasDevices = null,
    Object? colorDeviceDifference = freezed,
    Object? defaultSelectedColors = freezed,
    Object? unavailableColors = freezed,
  }) {
    return _then(_$_StagedPlayerModel(
      colorCount: freezed == colorCount
          ? _value.colorCount
          : colorCount // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      deviceCount: freezed == deviceCount
          ? _value.deviceCount
          : deviceCount // ignore: cast_nullable_to_non_nullable
              as NumRange?,
      hasName: null == hasName
          ? _value.hasName
          : hasName // ignore: cast_nullable_to_non_nullable
              as bool,
      hasDevices: null == hasDevices
          ? _value.hasDevices
          : hasDevices // ignore: cast_nullable_to_non_nullable
              as bool,
      colorDeviceDifference: freezed == colorDeviceDifference
          ? _value.colorDeviceDifference
          : colorDeviceDifference // ignore: cast_nullable_to_non_nullable
              as int?,
      defaultSelectedColors: freezed == defaultSelectedColors
          ? _value._defaultSelectedColors
          : defaultSelectedColors // ignore: cast_nullable_to_non_nullable
              as List<Color>?,
      unavailableColors: freezed == unavailableColors
          ? _value._unavailableColors
          : unavailableColors // ignore: cast_nullable_to_non_nullable
              as List<Color>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StagedPlayerModel extends _StagedPlayerModel {
  const _$_StagedPlayerModel(
      {@protected this.colorCount,
      this.deviceCount,
      this.hasName = true,
      @protected this.hasDevices = false,
      this.colorDeviceDifference,
      @protected
      @JsonKey(ignore: true)
      final List<Color>? defaultSelectedColors,
      @JsonKey(ignore: true) final List<Color>? unavailableColors})
      : _defaultSelectedColors = defaultSelectedColors,
        _unavailableColors = unavailableColors,
        super._();

  factory _$_StagedPlayerModel.fromJson(Map<String, dynamic> json) =>
      _$$_StagedPlayerModelFromJson(json);

  @override
  @protected
  final NumRange? colorCount;
  @override
  final NumRange? deviceCount;
  @override
  @JsonKey()
  final bool hasName;
  @override
  @JsonKey()
  @protected
  final bool hasDevices;

  ///This parameter represents the assigned difference value, indicating
  ///what the difference value (padCount - selectedColor) should be.
  ///For example, in the central vision exercise, if the Pad Count is 4,
  /// the selected color count must be 3. Therefore, this value must always be 1
  @override
  final int? colorDeviceDifference;

  /// these colors will be pre selected in the player picker
  final List<Color>? _defaultSelectedColors;

  /// these colors will be pre selected in the player picker
  @override
  @protected
  @JsonKey(ignore: true)
  List<Color>? get defaultSelectedColors {
    final value = _defaultSelectedColors;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// these colors will be hidden from the player picker,
  /// will be used for success and error colors etc.
  final List<Color>? _unavailableColors;

  /// these colors will be hidden from the player picker,
  /// will be used for success and error colors etc.
  @override
  @JsonKey(ignore: true)
  List<Color>? get unavailableColors {
    final value = _unavailableColors;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'StagedPlayerModel(colorCount: $colorCount, deviceCount: $deviceCount, hasName: $hasName, hasDevices: $hasDevices, colorDeviceDifference: $colorDeviceDifference, defaultSelectedColors: $defaultSelectedColors, unavailableColors: $unavailableColors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StagedPlayerModel &&
            (identical(other.colorCount, colorCount) ||
                other.colorCount == colorCount) &&
            (identical(other.deviceCount, deviceCount) ||
                other.deviceCount == deviceCount) &&
            (identical(other.hasName, hasName) || other.hasName == hasName) &&
            (identical(other.hasDevices, hasDevices) ||
                other.hasDevices == hasDevices) &&
            (identical(other.colorDeviceDifference, colorDeviceDifference) ||
                other.colorDeviceDifference == colorDeviceDifference) &&
            const DeepCollectionEquality()
                .equals(other._defaultSelectedColors, _defaultSelectedColors) &&
            const DeepCollectionEquality()
                .equals(other._unavailableColors, _unavailableColors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      colorCount,
      deviceCount,
      hasName,
      hasDevices,
      colorDeviceDifference,
      const DeepCollectionEquality().hash(_defaultSelectedColors),
      const DeepCollectionEquality().hash(_unavailableColors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StagedPlayerModelCopyWith<_$_StagedPlayerModel> get copyWith =>
      __$$_StagedPlayerModelCopyWithImpl<_$_StagedPlayerModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StagedPlayerModelToJson(
      this,
    );
  }
}

abstract class _StagedPlayerModel extends StagedPlayerModel {
  const factory _StagedPlayerModel(
          {@protected final NumRange? colorCount,
          final NumRange? deviceCount,
          final bool hasName,
          @protected final bool hasDevices,
          final int? colorDeviceDifference,
          @protected
          @JsonKey(ignore: true)
          final List<Color>? defaultSelectedColors,
          @JsonKey(ignore: true) final List<Color>? unavailableColors}) =
      _$_StagedPlayerModel;
  const _StagedPlayerModel._() : super._();

  factory _StagedPlayerModel.fromJson(Map<String, dynamic> json) =
      _$_StagedPlayerModel.fromJson;

  @override
  @protected
  NumRange? get colorCount;
  @override
  NumRange? get deviceCount;
  @override
  bool get hasName;
  @override
  @protected
  bool get hasDevices;
  @override

  ///This parameter represents the assigned difference value, indicating
  ///what the difference value (padCount - selectedColor) should be.
  ///For example, in the central vision exercise, if the Pad Count is 4,
  /// the selected color count must be 3. Therefore, this value must always be 1
  int? get colorDeviceDifference;
  @override

  /// these colors will be pre selected in the player picker
  @protected
  @JsonKey(ignore: true)
  List<Color>? get defaultSelectedColors;
  @override

  /// these colors will be hidden from the player picker,
  /// will be used for success and error colors etc.
  @JsonKey(ignore: true)
  List<Color>? get unavailableColors;
  @override
  @JsonKey(ignore: true)
  _$$_StagedPlayerModelCopyWith<_$_StagedPlayerModel> get copyWith =>
      throw _privateConstructorUsedError;
}
