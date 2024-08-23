// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'iga_trace_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IgaTraceModel _$IgaTraceModelFromJson(Map<String, dynamic> json) {
  return _IgaTraceModel.fromJson(json);
}

/// @nodoc
mixin _$IgaTraceModel {
  @JsonKey(name: 'traceId')
  String? get traceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'igaMetaTrace')
  IgaMetaTraceModel? get igaMetaTraceModel =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'igaPreTrace')
  IgaPreTraceModel? get igaPreTraceModel => throw _privateConstructorUsedError;
  @JsonKey(name: 'igaGameTrace')
  IgaGameTraceModel? get igaGameTraceModel =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'igaResultTrace')
  IgaResultTraceModel? get igaResultTraceModel =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'igaRegisterTrace')
  IgaRegisterTraceModel? get igaRegisterTraceModel =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IgaTraceModelCopyWith<IgaTraceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IgaTraceModelCopyWith<$Res> {
  factory $IgaTraceModelCopyWith(
          IgaTraceModel value, $Res Function(IgaTraceModel) then) =
      _$IgaTraceModelCopyWithImpl<$Res, IgaTraceModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'traceId') String? traceId,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'igaMetaTrace') IgaMetaTraceModel? igaMetaTraceModel,
      @JsonKey(name: 'igaPreTrace') IgaPreTraceModel? igaPreTraceModel,
      @JsonKey(name: 'igaGameTrace') IgaGameTraceModel? igaGameTraceModel,
      @JsonKey(name: 'igaResultTrace') IgaResultTraceModel? igaResultTraceModel,
      @JsonKey(name: 'igaRegisterTrace')
      IgaRegisterTraceModel? igaRegisterTraceModel});

  $IgaMetaTraceModelCopyWith<$Res>? get igaMetaTraceModel;
  $IgaPreTraceModelCopyWith<$Res>? get igaPreTraceModel;
  $IgaGameTraceModelCopyWith<$Res>? get igaGameTraceModel;
  $IgaResultTraceModelCopyWith<$Res>? get igaResultTraceModel;
  $IgaRegisterTraceModelCopyWith<$Res>? get igaRegisterTraceModel;
}

/// @nodoc
class _$IgaTraceModelCopyWithImpl<$Res, $Val extends IgaTraceModel>
    implements $IgaTraceModelCopyWith<$Res> {
  _$IgaTraceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? traceId = freezed,
    Object? createdAt = freezed,
    Object? igaMetaTraceModel = freezed,
    Object? igaPreTraceModel = freezed,
    Object? igaGameTraceModel = freezed,
    Object? igaResultTraceModel = freezed,
    Object? igaRegisterTraceModel = freezed,
  }) {
    return _then(_value.copyWith(
      traceId: freezed == traceId
          ? _value.traceId
          : traceId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      igaMetaTraceModel: freezed == igaMetaTraceModel
          ? _value.igaMetaTraceModel
          : igaMetaTraceModel // ignore: cast_nullable_to_non_nullable
              as IgaMetaTraceModel?,
      igaPreTraceModel: freezed == igaPreTraceModel
          ? _value.igaPreTraceModel
          : igaPreTraceModel // ignore: cast_nullable_to_non_nullable
              as IgaPreTraceModel?,
      igaGameTraceModel: freezed == igaGameTraceModel
          ? _value.igaGameTraceModel
          : igaGameTraceModel // ignore: cast_nullable_to_non_nullable
              as IgaGameTraceModel?,
      igaResultTraceModel: freezed == igaResultTraceModel
          ? _value.igaResultTraceModel
          : igaResultTraceModel // ignore: cast_nullable_to_non_nullable
              as IgaResultTraceModel?,
      igaRegisterTraceModel: freezed == igaRegisterTraceModel
          ? _value.igaRegisterTraceModel
          : igaRegisterTraceModel // ignore: cast_nullable_to_non_nullable
              as IgaRegisterTraceModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $IgaMetaTraceModelCopyWith<$Res>? get igaMetaTraceModel {
    if (_value.igaMetaTraceModel == null) {
      return null;
    }

    return $IgaMetaTraceModelCopyWith<$Res>(_value.igaMetaTraceModel!, (value) {
      return _then(_value.copyWith(igaMetaTraceModel: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IgaPreTraceModelCopyWith<$Res>? get igaPreTraceModel {
    if (_value.igaPreTraceModel == null) {
      return null;
    }

    return $IgaPreTraceModelCopyWith<$Res>(_value.igaPreTraceModel!, (value) {
      return _then(_value.copyWith(igaPreTraceModel: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IgaGameTraceModelCopyWith<$Res>? get igaGameTraceModel {
    if (_value.igaGameTraceModel == null) {
      return null;
    }

    return $IgaGameTraceModelCopyWith<$Res>(_value.igaGameTraceModel!, (value) {
      return _then(_value.copyWith(igaGameTraceModel: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IgaResultTraceModelCopyWith<$Res>? get igaResultTraceModel {
    if (_value.igaResultTraceModel == null) {
      return null;
    }

    return $IgaResultTraceModelCopyWith<$Res>(_value.igaResultTraceModel!,
        (value) {
      return _then(_value.copyWith(igaResultTraceModel: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IgaRegisterTraceModelCopyWith<$Res>? get igaRegisterTraceModel {
    if (_value.igaRegisterTraceModel == null) {
      return null;
    }

    return $IgaRegisterTraceModelCopyWith<$Res>(_value.igaRegisterTraceModel!,
        (value) {
      return _then(_value.copyWith(igaRegisterTraceModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_IgaTraceModelCopyWith<$Res>
    implements $IgaTraceModelCopyWith<$Res> {
  factory _$$_IgaTraceModelCopyWith(
          _$_IgaTraceModel value, $Res Function(_$_IgaTraceModel) then) =
      __$$_IgaTraceModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'traceId') String? traceId,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'igaMetaTrace') IgaMetaTraceModel? igaMetaTraceModel,
      @JsonKey(name: 'igaPreTrace') IgaPreTraceModel? igaPreTraceModel,
      @JsonKey(name: 'igaGameTrace') IgaGameTraceModel? igaGameTraceModel,
      @JsonKey(name: 'igaResultTrace') IgaResultTraceModel? igaResultTraceModel,
      @JsonKey(name: 'igaRegisterTrace')
      IgaRegisterTraceModel? igaRegisterTraceModel});

  @override
  $IgaMetaTraceModelCopyWith<$Res>? get igaMetaTraceModel;
  @override
  $IgaPreTraceModelCopyWith<$Res>? get igaPreTraceModel;
  @override
  $IgaGameTraceModelCopyWith<$Res>? get igaGameTraceModel;
  @override
  $IgaResultTraceModelCopyWith<$Res>? get igaResultTraceModel;
  @override
  $IgaRegisterTraceModelCopyWith<$Res>? get igaRegisterTraceModel;
}

/// @nodoc
class __$$_IgaTraceModelCopyWithImpl<$Res>
    extends _$IgaTraceModelCopyWithImpl<$Res, _$_IgaTraceModel>
    implements _$$_IgaTraceModelCopyWith<$Res> {
  __$$_IgaTraceModelCopyWithImpl(
      _$_IgaTraceModel _value, $Res Function(_$_IgaTraceModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? traceId = freezed,
    Object? createdAt = freezed,
    Object? igaMetaTraceModel = freezed,
    Object? igaPreTraceModel = freezed,
    Object? igaGameTraceModel = freezed,
    Object? igaResultTraceModel = freezed,
    Object? igaRegisterTraceModel = freezed,
  }) {
    return _then(_$_IgaTraceModel(
      traceId: freezed == traceId
          ? _value.traceId
          : traceId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      igaMetaTraceModel: freezed == igaMetaTraceModel
          ? _value.igaMetaTraceModel
          : igaMetaTraceModel // ignore: cast_nullable_to_non_nullable
              as IgaMetaTraceModel?,
      igaPreTraceModel: freezed == igaPreTraceModel
          ? _value.igaPreTraceModel
          : igaPreTraceModel // ignore: cast_nullable_to_non_nullable
              as IgaPreTraceModel?,
      igaGameTraceModel: freezed == igaGameTraceModel
          ? _value.igaGameTraceModel
          : igaGameTraceModel // ignore: cast_nullable_to_non_nullable
              as IgaGameTraceModel?,
      igaResultTraceModel: freezed == igaResultTraceModel
          ? _value.igaResultTraceModel
          : igaResultTraceModel // ignore: cast_nullable_to_non_nullable
              as IgaResultTraceModel?,
      igaRegisterTraceModel: freezed == igaRegisterTraceModel
          ? _value.igaRegisterTraceModel
          : igaRegisterTraceModel // ignore: cast_nullable_to_non_nullable
              as IgaRegisterTraceModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IgaTraceModel with DiagnosticableTreeMixin implements _IgaTraceModel {
  const _$_IgaTraceModel(
      {@JsonKey(name: 'traceId') this.traceId,
      @JsonKey(name: 'createdAt') this.createdAt,
      @JsonKey(name: 'igaMetaTrace') this.igaMetaTraceModel = null,
      @JsonKey(name: 'igaPreTrace') this.igaPreTraceModel = null,
      @JsonKey(name: 'igaGameTrace') this.igaGameTraceModel = null,
      @JsonKey(name: 'igaResultTrace') this.igaResultTraceModel = null,
      @JsonKey(name: 'igaRegisterTrace') this.igaRegisterTraceModel = null});

  factory _$_IgaTraceModel.fromJson(Map<String, dynamic> json) =>
      _$$_IgaTraceModelFromJson(json);

  @override
  @JsonKey(name: 'traceId')
  final String? traceId;
  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @override
  @JsonKey(name: 'igaMetaTrace')
  final IgaMetaTraceModel? igaMetaTraceModel;
  @override
  @JsonKey(name: 'igaPreTrace')
  final IgaPreTraceModel? igaPreTraceModel;
  @override
  @JsonKey(name: 'igaGameTrace')
  final IgaGameTraceModel? igaGameTraceModel;
  @override
  @JsonKey(name: 'igaResultTrace')
  final IgaResultTraceModel? igaResultTraceModel;
  @override
  @JsonKey(name: 'igaRegisterTrace')
  final IgaRegisterTraceModel? igaRegisterTraceModel;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IgaTraceModel(traceId: $traceId, createdAt: $createdAt, igaMetaTraceModel: $igaMetaTraceModel, igaPreTraceModel: $igaPreTraceModel, igaGameTraceModel: $igaGameTraceModel, igaResultTraceModel: $igaResultTraceModel, igaRegisterTraceModel: $igaRegisterTraceModel)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IgaTraceModel'))
      ..add(DiagnosticsProperty('traceId', traceId))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('igaMetaTraceModel', igaMetaTraceModel))
      ..add(DiagnosticsProperty('igaPreTraceModel', igaPreTraceModel))
      ..add(DiagnosticsProperty('igaGameTraceModel', igaGameTraceModel))
      ..add(DiagnosticsProperty('igaResultTraceModel', igaResultTraceModel))
      ..add(
          DiagnosticsProperty('igaRegisterTraceModel', igaRegisterTraceModel));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IgaTraceModel &&
            (identical(other.traceId, traceId) || other.traceId == traceId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.igaMetaTraceModel, igaMetaTraceModel) ||
                other.igaMetaTraceModel == igaMetaTraceModel) &&
            (identical(other.igaPreTraceModel, igaPreTraceModel) ||
                other.igaPreTraceModel == igaPreTraceModel) &&
            (identical(other.igaGameTraceModel, igaGameTraceModel) ||
                other.igaGameTraceModel == igaGameTraceModel) &&
            (identical(other.igaResultTraceModel, igaResultTraceModel) ||
                other.igaResultTraceModel == igaResultTraceModel) &&
            (identical(other.igaRegisterTraceModel, igaRegisterTraceModel) ||
                other.igaRegisterTraceModel == igaRegisterTraceModel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      traceId,
      createdAt,
      igaMetaTraceModel,
      igaPreTraceModel,
      igaGameTraceModel,
      igaResultTraceModel,
      igaRegisterTraceModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IgaTraceModelCopyWith<_$_IgaTraceModel> get copyWith =>
      __$$_IgaTraceModelCopyWithImpl<_$_IgaTraceModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IgaTraceModelToJson(
      this,
    );
  }
}

abstract class _IgaTraceModel implements IgaTraceModel {
  const factory _IgaTraceModel(
      {@JsonKey(name: 'traceId') final String? traceId,
      @JsonKey(name: 'createdAt') final String? createdAt,
      @JsonKey(name: 'igaMetaTrace') final IgaMetaTraceModel? igaMetaTraceModel,
      @JsonKey(name: 'igaPreTrace') final IgaPreTraceModel? igaPreTraceModel,
      @JsonKey(name: 'igaGameTrace') final IgaGameTraceModel? igaGameTraceModel,
      @JsonKey(name: 'igaResultTrace')
      final IgaResultTraceModel? igaResultTraceModel,
      @JsonKey(name: 'igaRegisterTrace')
      final IgaRegisterTraceModel? igaRegisterTraceModel}) = _$_IgaTraceModel;

  factory _IgaTraceModel.fromJson(Map<String, dynamic> json) =
      _$_IgaTraceModel.fromJson;

  @override
  @JsonKey(name: 'traceId')
  String? get traceId;
  @override
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  @JsonKey(name: 'igaMetaTrace')
  IgaMetaTraceModel? get igaMetaTraceModel;
  @override
  @JsonKey(name: 'igaPreTrace')
  IgaPreTraceModel? get igaPreTraceModel;
  @override
  @JsonKey(name: 'igaGameTrace')
  IgaGameTraceModel? get igaGameTraceModel;
  @override
  @JsonKey(name: 'igaResultTrace')
  IgaResultTraceModel? get igaResultTraceModel;
  @override
  @JsonKey(name: 'igaRegisterTrace')
  IgaRegisterTraceModel? get igaRegisterTraceModel;
  @override
  @JsonKey(ignore: true)
  _$$_IgaTraceModelCopyWith<_$_IgaTraceModel> get copyWith =>
      throw _privateConstructorUsedError;
}
