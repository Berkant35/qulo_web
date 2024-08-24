// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Meet _$MeetFromJson(Map<String, dynamic> json) {
  return _Meet.fromJson(json);
}

/// @nodoc
mixin _$Meet {
  /// This parameter reference to your meet. Also you can find any
  /// WordMatchTimes and who created for todos
  @JsonKey(name: 'meetId', required: true)
  String? get meetId => throw _privateConstructorUsedError;

  /// This parameter help to user for help which match to meet
  @JsonKey(name: 'meetTitle')
  String? get meetTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'meetSubtitle')
  String? get meetSubtitle => throw _privateConstructorUsedError;

  /// Customer may have multi disciplines so when he want any sorting with
  /// category he can use this parameter.
  @JsonKey(name: 'meetCategory')
  String? get meetCategory => throw _privateConstructorUsedError;

  /// All meet dialogs and words.
  @JsonKey(name: 'meetContent')
  String? get meetContent => throw _privateConstructorUsedError;

  /// For now idk why added to this parameter
  @JsonKey(name: 'meetLocaleFilePath')
  String? get meetLocaleFilePath => throw _privateConstructorUsedError;

  /// Meet Due Date may help to answer that when did it happen
  @JsonKey(name: 'meetDueDate')
  String? get meetDueDate => throw _privateConstructorUsedError;

  /// Auto Created Date
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;

  /// Current User
  @JsonKey(name: 'userId')
  String? get userId => throw _privateConstructorUsedError;

  /// Any created pdf or word file for this meet
  @JsonKey(name: 'createdPdfFile', defaultValue: false)
  bool? get createdPdfFile => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdWordFile', defaultValue: false)
  bool? get createdWordFile => throw _privateConstructorUsedError;

  /// You can see how long time about of meeting by minute.
  @JsonKey(name: 'recordTimeSecond')
  int? get recordTimeSecond => throw _privateConstructorUsedError;

  /// You can see how long time about of meeting by millisecond.
  @JsonKey(name: 'recordTimeMs')
  int? get recordTimeMs => throw _privateConstructorUsedError;

  /// This parameter can handle dialog word counts this
  /// field created for query from firebase.
  @JsonKey(name: 'contentWordCount')
  int? get contentWordCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'contentLetterCount')
  int? get contentLetterCount => throw _privateConstructorUsedError;

  /// When you want download audio sound file customer use this link.
  @JsonKey(name: 'likeRate')
  double? get likeRate => throw _privateConstructorUsedError;
  @JsonKey(name: 'soundFileLink')
  String? get soundFileLink => throw _privateConstructorUsedError;

  /// File type
  @JsonKey(name: 'soundFileType')
  String? get soundFileType => throw _privateConstructorUsedError;

  /// This parameter gives info people of join to meeting about they languages
  @JsonKey(name: 'lang')
  String? get lang => throw _privateConstructorUsedError;

  /// This parameter provides information about the individuals attending
  /// the meeting and their assigned tasks. It includes each person who
  /// is participating in the current meeting and what they must do
  @JsonKey(name: "responseTodo")
  ResponseTodoModel? get responseTodo => throw _privateConstructorUsedError;
  DateTime? get createdDateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MeetCopyWith<Meet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeetCopyWith<$Res> {
  factory $MeetCopyWith(Meet value, $Res Function(Meet) then) =
      _$MeetCopyWithImpl<$Res, Meet>;
  @useResult
  $Res call(
      {@JsonKey(name: 'meetId', required: true) String? meetId,
      @JsonKey(name: 'meetTitle') String? meetTitle,
      @JsonKey(name: 'meetSubtitle') String? meetSubtitle,
      @JsonKey(name: 'meetCategory') String? meetCategory,
      @JsonKey(name: 'meetContent') String? meetContent,
      @JsonKey(name: 'meetLocaleFilePath') String? meetLocaleFilePath,
      @JsonKey(name: 'meetDueDate') String? meetDueDate,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'userId') String? userId,
      @JsonKey(name: 'createdPdfFile', defaultValue: false)
      bool? createdPdfFile,
      @JsonKey(name: 'createdWordFile', defaultValue: false)
      bool? createdWordFile,
      @JsonKey(name: 'recordTimeSecond') int? recordTimeSecond,
      @JsonKey(name: 'recordTimeMs') int? recordTimeMs,
      @JsonKey(name: 'contentWordCount') int? contentWordCount,
      @JsonKey(name: 'contentLetterCount') int? contentLetterCount,
      @JsonKey(name: 'likeRate') double? likeRate,
      @JsonKey(name: 'soundFileLink') String? soundFileLink,
      @JsonKey(name: 'soundFileType') String? soundFileType,
      @JsonKey(name: 'lang') String? lang,
      @JsonKey(name: "responseTodo") ResponseTodoModel? responseTodo,
      DateTime? createdDateTime});

  $ResponseTodoModelCopyWith<$Res>? get responseTodo;
}

/// @nodoc
class _$MeetCopyWithImpl<$Res, $Val extends Meet>
    implements $MeetCopyWith<$Res> {
  _$MeetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetId = freezed,
    Object? meetTitle = freezed,
    Object? meetSubtitle = freezed,
    Object? meetCategory = freezed,
    Object? meetContent = freezed,
    Object? meetLocaleFilePath = freezed,
    Object? meetDueDate = freezed,
    Object? createdAt = freezed,
    Object? userId = freezed,
    Object? createdPdfFile = freezed,
    Object? createdWordFile = freezed,
    Object? recordTimeSecond = freezed,
    Object? recordTimeMs = freezed,
    Object? contentWordCount = freezed,
    Object? contentLetterCount = freezed,
    Object? likeRate = freezed,
    Object? soundFileLink = freezed,
    Object? soundFileType = freezed,
    Object? lang = freezed,
    Object? responseTodo = freezed,
    Object? createdDateTime = freezed,
  }) {
    return _then(_value.copyWith(
      meetId: freezed == meetId
          ? _value.meetId
          : meetId // ignore: cast_nullable_to_non_nullable
              as String?,
      meetTitle: freezed == meetTitle
          ? _value.meetTitle
          : meetTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      meetSubtitle: freezed == meetSubtitle
          ? _value.meetSubtitle
          : meetSubtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      meetCategory: freezed == meetCategory
          ? _value.meetCategory
          : meetCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      meetContent: freezed == meetContent
          ? _value.meetContent
          : meetContent // ignore: cast_nullable_to_non_nullable
              as String?,
      meetLocaleFilePath: freezed == meetLocaleFilePath
          ? _value.meetLocaleFilePath
          : meetLocaleFilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      meetDueDate: freezed == meetDueDate
          ? _value.meetDueDate
          : meetDueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdPdfFile: freezed == createdPdfFile
          ? _value.createdPdfFile
          : createdPdfFile // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdWordFile: freezed == createdWordFile
          ? _value.createdWordFile
          : createdWordFile // ignore: cast_nullable_to_non_nullable
              as bool?,
      recordTimeSecond: freezed == recordTimeSecond
          ? _value.recordTimeSecond
          : recordTimeSecond // ignore: cast_nullable_to_non_nullable
              as int?,
      recordTimeMs: freezed == recordTimeMs
          ? _value.recordTimeMs
          : recordTimeMs // ignore: cast_nullable_to_non_nullable
              as int?,
      contentWordCount: freezed == contentWordCount
          ? _value.contentWordCount
          : contentWordCount // ignore: cast_nullable_to_non_nullable
              as int?,
      contentLetterCount: freezed == contentLetterCount
          ? _value.contentLetterCount
          : contentLetterCount // ignore: cast_nullable_to_non_nullable
              as int?,
      likeRate: freezed == likeRate
          ? _value.likeRate
          : likeRate // ignore: cast_nullable_to_non_nullable
              as double?,
      soundFileLink: freezed == soundFileLink
          ? _value.soundFileLink
          : soundFileLink // ignore: cast_nullable_to_non_nullable
              as String?,
      soundFileType: freezed == soundFileType
          ? _value.soundFileType
          : soundFileType // ignore: cast_nullable_to_non_nullable
              as String?,
      lang: freezed == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String?,
      responseTodo: freezed == responseTodo
          ? _value.responseTodo
          : responseTodo // ignore: cast_nullable_to_non_nullable
              as ResponseTodoModel?,
      createdDateTime: freezed == createdDateTime
          ? _value.createdDateTime
          : createdDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ResponseTodoModelCopyWith<$Res>? get responseTodo {
    if (_value.responseTodo == null) {
      return null;
    }

    return $ResponseTodoModelCopyWith<$Res>(_value.responseTodo!, (value) {
      return _then(_value.copyWith(responseTodo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MeetImplCopyWith<$Res> implements $MeetCopyWith<$Res> {
  factory _$$MeetImplCopyWith(
          _$MeetImpl value, $Res Function(_$MeetImpl) then) =
      __$$MeetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'meetId', required: true) String? meetId,
      @JsonKey(name: 'meetTitle') String? meetTitle,
      @JsonKey(name: 'meetSubtitle') String? meetSubtitle,
      @JsonKey(name: 'meetCategory') String? meetCategory,
      @JsonKey(name: 'meetContent') String? meetContent,
      @JsonKey(name: 'meetLocaleFilePath') String? meetLocaleFilePath,
      @JsonKey(name: 'meetDueDate') String? meetDueDate,
      @JsonKey(name: 'createdAt') String? createdAt,
      @JsonKey(name: 'userId') String? userId,
      @JsonKey(name: 'createdPdfFile', defaultValue: false)
      bool? createdPdfFile,
      @JsonKey(name: 'createdWordFile', defaultValue: false)
      bool? createdWordFile,
      @JsonKey(name: 'recordTimeSecond') int? recordTimeSecond,
      @JsonKey(name: 'recordTimeMs') int? recordTimeMs,
      @JsonKey(name: 'contentWordCount') int? contentWordCount,
      @JsonKey(name: 'contentLetterCount') int? contentLetterCount,
      @JsonKey(name: 'likeRate') double? likeRate,
      @JsonKey(name: 'soundFileLink') String? soundFileLink,
      @JsonKey(name: 'soundFileType') String? soundFileType,
      @JsonKey(name: 'lang') String? lang,
      @JsonKey(name: "responseTodo") ResponseTodoModel? responseTodo,
      DateTime? createdDateTime});

  @override
  $ResponseTodoModelCopyWith<$Res>? get responseTodo;
}

/// @nodoc
class __$$MeetImplCopyWithImpl<$Res>
    extends _$MeetCopyWithImpl<$Res, _$MeetImpl>
    implements _$$MeetImplCopyWith<$Res> {
  __$$MeetImplCopyWithImpl(_$MeetImpl _value, $Res Function(_$MeetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetId = freezed,
    Object? meetTitle = freezed,
    Object? meetSubtitle = freezed,
    Object? meetCategory = freezed,
    Object? meetContent = freezed,
    Object? meetLocaleFilePath = freezed,
    Object? meetDueDate = freezed,
    Object? createdAt = freezed,
    Object? userId = freezed,
    Object? createdPdfFile = freezed,
    Object? createdWordFile = freezed,
    Object? recordTimeSecond = freezed,
    Object? recordTimeMs = freezed,
    Object? contentWordCount = freezed,
    Object? contentLetterCount = freezed,
    Object? likeRate = freezed,
    Object? soundFileLink = freezed,
    Object? soundFileType = freezed,
    Object? lang = freezed,
    Object? responseTodo = freezed,
    Object? createdDateTime = freezed,
  }) {
    return _then(_$MeetImpl(
      meetId: freezed == meetId
          ? _value.meetId
          : meetId // ignore: cast_nullable_to_non_nullable
              as String?,
      meetTitle: freezed == meetTitle
          ? _value.meetTitle
          : meetTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      meetSubtitle: freezed == meetSubtitle
          ? _value.meetSubtitle
          : meetSubtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      meetCategory: freezed == meetCategory
          ? _value.meetCategory
          : meetCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      meetContent: freezed == meetContent
          ? _value.meetContent
          : meetContent // ignore: cast_nullable_to_non_nullable
              as String?,
      meetLocaleFilePath: freezed == meetLocaleFilePath
          ? _value.meetLocaleFilePath
          : meetLocaleFilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      meetDueDate: freezed == meetDueDate
          ? _value.meetDueDate
          : meetDueDate // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdPdfFile: freezed == createdPdfFile
          ? _value.createdPdfFile
          : createdPdfFile // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdWordFile: freezed == createdWordFile
          ? _value.createdWordFile
          : createdWordFile // ignore: cast_nullable_to_non_nullable
              as bool?,
      recordTimeSecond: freezed == recordTimeSecond
          ? _value.recordTimeSecond
          : recordTimeSecond // ignore: cast_nullable_to_non_nullable
              as int?,
      recordTimeMs: freezed == recordTimeMs
          ? _value.recordTimeMs
          : recordTimeMs // ignore: cast_nullable_to_non_nullable
              as int?,
      contentWordCount: freezed == contentWordCount
          ? _value.contentWordCount
          : contentWordCount // ignore: cast_nullable_to_non_nullable
              as int?,
      contentLetterCount: freezed == contentLetterCount
          ? _value.contentLetterCount
          : contentLetterCount // ignore: cast_nullable_to_non_nullable
              as int?,
      likeRate: freezed == likeRate
          ? _value.likeRate
          : likeRate // ignore: cast_nullable_to_non_nullable
              as double?,
      soundFileLink: freezed == soundFileLink
          ? _value.soundFileLink
          : soundFileLink // ignore: cast_nullable_to_non_nullable
              as String?,
      soundFileType: freezed == soundFileType
          ? _value.soundFileType
          : soundFileType // ignore: cast_nullable_to_non_nullable
              as String?,
      lang: freezed == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String?,
      responseTodo: freezed == responseTodo
          ? _value.responseTodo
          : responseTodo // ignore: cast_nullable_to_non_nullable
              as ResponseTodoModel?,
      createdDateTime: freezed == createdDateTime
          ? _value.createdDateTime
          : createdDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeetImpl with DiagnosticableTreeMixin implements _Meet {
  const _$MeetImpl(
      {@JsonKey(name: 'meetId', required: true) this.meetId,
      @JsonKey(name: 'meetTitle') this.meetTitle,
      @JsonKey(name: 'meetSubtitle') this.meetSubtitle,
      @JsonKey(name: 'meetCategory') this.meetCategory,
      @JsonKey(name: 'meetContent') this.meetContent,
      @JsonKey(name: 'meetLocaleFilePath') this.meetLocaleFilePath,
      @JsonKey(name: 'meetDueDate') this.meetDueDate,
      @JsonKey(name: 'createdAt') this.createdAt,
      @JsonKey(name: 'userId') this.userId,
      @JsonKey(name: 'createdPdfFile', defaultValue: false) this.createdPdfFile,
      @JsonKey(name: 'createdWordFile', defaultValue: false)
      this.createdWordFile,
      @JsonKey(name: 'recordTimeSecond') this.recordTimeSecond,
      @JsonKey(name: 'recordTimeMs') this.recordTimeMs,
      @JsonKey(name: 'contentWordCount') this.contentWordCount,
      @JsonKey(name: 'contentLetterCount') this.contentLetterCount,
      @JsonKey(name: 'likeRate') this.likeRate,
      @JsonKey(name: 'soundFileLink') this.soundFileLink,
      @JsonKey(name: 'soundFileType') this.soundFileType,
      @JsonKey(name: 'lang') this.lang,
      @JsonKey(name: "responseTodo") this.responseTodo,
      this.createdDateTime});

  factory _$MeetImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeetImplFromJson(json);

  /// This parameter reference to your meet. Also you can find any
  /// WordMatchTimes and who created for todos
  @override
  @JsonKey(name: 'meetId', required: true)
  final String? meetId;

  /// This parameter help to user for help which match to meet
  @override
  @JsonKey(name: 'meetTitle')
  final String? meetTitle;
  @override
  @JsonKey(name: 'meetSubtitle')
  final String? meetSubtitle;

  /// Customer may have multi disciplines so when he want any sorting with
  /// category he can use this parameter.
  @override
  @JsonKey(name: 'meetCategory')
  final String? meetCategory;

  /// All meet dialogs and words.
  @override
  @JsonKey(name: 'meetContent')
  final String? meetContent;

  /// For now idk why added to this parameter
  @override
  @JsonKey(name: 'meetLocaleFilePath')
  final String? meetLocaleFilePath;

  /// Meet Due Date may help to answer that when did it happen
  @override
  @JsonKey(name: 'meetDueDate')
  final String? meetDueDate;

  /// Auto Created Date
  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;

  /// Current User
  @override
  @JsonKey(name: 'userId')
  final String? userId;

  /// Any created pdf or word file for this meet
  @override
  @JsonKey(name: 'createdPdfFile', defaultValue: false)
  final bool? createdPdfFile;
  @override
  @JsonKey(name: 'createdWordFile', defaultValue: false)
  final bool? createdWordFile;

  /// You can see how long time about of meeting by minute.
  @override
  @JsonKey(name: 'recordTimeSecond')
  final int? recordTimeSecond;

  /// You can see how long time about of meeting by millisecond.
  @override
  @JsonKey(name: 'recordTimeMs')
  final int? recordTimeMs;

  /// This parameter can handle dialog word counts this
  /// field created for query from firebase.
  @override
  @JsonKey(name: 'contentWordCount')
  final int? contentWordCount;
  @override
  @JsonKey(name: 'contentLetterCount')
  final int? contentLetterCount;

  /// When you want download audio sound file customer use this link.
  @override
  @JsonKey(name: 'likeRate')
  final double? likeRate;
  @override
  @JsonKey(name: 'soundFileLink')
  final String? soundFileLink;

  /// File type
  @override
  @JsonKey(name: 'soundFileType')
  final String? soundFileType;

  /// This parameter gives info people of join to meeting about they languages
  @override
  @JsonKey(name: 'lang')
  final String? lang;

  /// This parameter provides information about the individuals attending
  /// the meeting and their assigned tasks. It includes each person who
  /// is participating in the current meeting and what they must do
  @override
  @JsonKey(name: "responseTodo")
  final ResponseTodoModel? responseTodo;
  @override
  final DateTime? createdDateTime;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Meet(meetId: $meetId, meetTitle: $meetTitle, meetSubtitle: $meetSubtitle, meetCategory: $meetCategory, meetContent: $meetContent, meetLocaleFilePath: $meetLocaleFilePath, meetDueDate: $meetDueDate, createdAt: $createdAt, userId: $userId, createdPdfFile: $createdPdfFile, createdWordFile: $createdWordFile, recordTimeSecond: $recordTimeSecond, recordTimeMs: $recordTimeMs, contentWordCount: $contentWordCount, contentLetterCount: $contentLetterCount, likeRate: $likeRate, soundFileLink: $soundFileLink, soundFileType: $soundFileType, lang: $lang, responseTodo: $responseTodo, createdDateTime: $createdDateTime)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Meet'))
      ..add(DiagnosticsProperty('meetId', meetId))
      ..add(DiagnosticsProperty('meetTitle', meetTitle))
      ..add(DiagnosticsProperty('meetSubtitle', meetSubtitle))
      ..add(DiagnosticsProperty('meetCategory', meetCategory))
      ..add(DiagnosticsProperty('meetContent', meetContent))
      ..add(DiagnosticsProperty('meetLocaleFilePath', meetLocaleFilePath))
      ..add(DiagnosticsProperty('meetDueDate', meetDueDate))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('createdPdfFile', createdPdfFile))
      ..add(DiagnosticsProperty('createdWordFile', createdWordFile))
      ..add(DiagnosticsProperty('recordTimeSecond', recordTimeSecond))
      ..add(DiagnosticsProperty('recordTimeMs', recordTimeMs))
      ..add(DiagnosticsProperty('contentWordCount', contentWordCount))
      ..add(DiagnosticsProperty('contentLetterCount', contentLetterCount))
      ..add(DiagnosticsProperty('likeRate', likeRate))
      ..add(DiagnosticsProperty('soundFileLink', soundFileLink))
      ..add(DiagnosticsProperty('soundFileType', soundFileType))
      ..add(DiagnosticsProperty('lang', lang))
      ..add(DiagnosticsProperty('responseTodo', responseTodo))
      ..add(DiagnosticsProperty('createdDateTime', createdDateTime));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeetImpl &&
            (identical(other.meetId, meetId) || other.meetId == meetId) &&
            (identical(other.meetTitle, meetTitle) ||
                other.meetTitle == meetTitle) &&
            (identical(other.meetSubtitle, meetSubtitle) ||
                other.meetSubtitle == meetSubtitle) &&
            (identical(other.meetCategory, meetCategory) ||
                other.meetCategory == meetCategory) &&
            (identical(other.meetContent, meetContent) ||
                other.meetContent == meetContent) &&
            (identical(other.meetLocaleFilePath, meetLocaleFilePath) ||
                other.meetLocaleFilePath == meetLocaleFilePath) &&
            (identical(other.meetDueDate, meetDueDate) ||
                other.meetDueDate == meetDueDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdPdfFile, createdPdfFile) ||
                other.createdPdfFile == createdPdfFile) &&
            (identical(other.createdWordFile, createdWordFile) ||
                other.createdWordFile == createdWordFile) &&
            (identical(other.recordTimeSecond, recordTimeSecond) ||
                other.recordTimeSecond == recordTimeSecond) &&
            (identical(other.recordTimeMs, recordTimeMs) ||
                other.recordTimeMs == recordTimeMs) &&
            (identical(other.contentWordCount, contentWordCount) ||
                other.contentWordCount == contentWordCount) &&
            (identical(other.contentLetterCount, contentLetterCount) ||
                other.contentLetterCount == contentLetterCount) &&
            (identical(other.likeRate, likeRate) ||
                other.likeRate == likeRate) &&
            (identical(other.soundFileLink, soundFileLink) ||
                other.soundFileLink == soundFileLink) &&
            (identical(other.soundFileType, soundFileType) ||
                other.soundFileType == soundFileType) &&
            (identical(other.lang, lang) || other.lang == lang) &&
            (identical(other.responseTodo, responseTodo) ||
                other.responseTodo == responseTodo) &&
            (identical(other.createdDateTime, createdDateTime) ||
                other.createdDateTime == createdDateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        meetId,
        meetTitle,
        meetSubtitle,
        meetCategory,
        meetContent,
        meetLocaleFilePath,
        meetDueDate,
        createdAt,
        userId,
        createdPdfFile,
        createdWordFile,
        recordTimeSecond,
        recordTimeMs,
        contentWordCount,
        contentLetterCount,
        likeRate,
        soundFileLink,
        soundFileType,
        lang,
        responseTodo,
        createdDateTime
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MeetImplCopyWith<_$MeetImpl> get copyWith =>
      __$$MeetImplCopyWithImpl<_$MeetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeetImplToJson(
      this,
    );
  }
}

abstract class _Meet implements Meet {
  const factory _Meet(
      {@JsonKey(name: 'meetId', required: true) final String? meetId,
      @JsonKey(name: 'meetTitle') final String? meetTitle,
      @JsonKey(name: 'meetSubtitle') final String? meetSubtitle,
      @JsonKey(name: 'meetCategory') final String? meetCategory,
      @JsonKey(name: 'meetContent') final String? meetContent,
      @JsonKey(name: 'meetLocaleFilePath') final String? meetLocaleFilePath,
      @JsonKey(name: 'meetDueDate') final String? meetDueDate,
      @JsonKey(name: 'createdAt') final String? createdAt,
      @JsonKey(name: 'userId') final String? userId,
      @JsonKey(name: 'createdPdfFile', defaultValue: false)
      final bool? createdPdfFile,
      @JsonKey(name: 'createdWordFile', defaultValue: false)
      final bool? createdWordFile,
      @JsonKey(name: 'recordTimeSecond') final int? recordTimeSecond,
      @JsonKey(name: 'recordTimeMs') final int? recordTimeMs,
      @JsonKey(name: 'contentWordCount') final int? contentWordCount,
      @JsonKey(name: 'contentLetterCount') final int? contentLetterCount,
      @JsonKey(name: 'likeRate') final double? likeRate,
      @JsonKey(name: 'soundFileLink') final String? soundFileLink,
      @JsonKey(name: 'soundFileType') final String? soundFileType,
      @JsonKey(name: 'lang') final String? lang,
      @JsonKey(name: "responseTodo") final ResponseTodoModel? responseTodo,
      final DateTime? createdDateTime}) = _$MeetImpl;

  factory _Meet.fromJson(Map<String, dynamic> json) = _$MeetImpl.fromJson;

  @override

  /// This parameter reference to your meet. Also you can find any
  /// WordMatchTimes and who created for todos
  @JsonKey(name: 'meetId', required: true)
  String? get meetId;
  @override

  /// This parameter help to user for help which match to meet
  @JsonKey(name: 'meetTitle')
  String? get meetTitle;
  @override
  @JsonKey(name: 'meetSubtitle')
  String? get meetSubtitle;
  @override

  /// Customer may have multi disciplines so when he want any sorting with
  /// category he can use this parameter.
  @JsonKey(name: 'meetCategory')
  String? get meetCategory;
  @override

  /// All meet dialogs and words.
  @JsonKey(name: 'meetContent')
  String? get meetContent;
  @override

  /// For now idk why added to this parameter
  @JsonKey(name: 'meetLocaleFilePath')
  String? get meetLocaleFilePath;
  @override

  /// Meet Due Date may help to answer that when did it happen
  @JsonKey(name: 'meetDueDate')
  String? get meetDueDate;
  @override

  /// Auto Created Date
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override

  /// Current User
  @JsonKey(name: 'userId')
  String? get userId;
  @override

  /// Any created pdf or word file for this meet
  @JsonKey(name: 'createdPdfFile', defaultValue: false)
  bool? get createdPdfFile;
  @override
  @JsonKey(name: 'createdWordFile', defaultValue: false)
  bool? get createdWordFile;
  @override

  /// You can see how long time about of meeting by minute.
  @JsonKey(name: 'recordTimeSecond')
  int? get recordTimeSecond;
  @override

  /// You can see how long time about of meeting by millisecond.
  @JsonKey(name: 'recordTimeMs')
  int? get recordTimeMs;
  @override

  /// This parameter can handle dialog word counts this
  /// field created for query from firebase.
  @JsonKey(name: 'contentWordCount')
  int? get contentWordCount;
  @override
  @JsonKey(name: 'contentLetterCount')
  int? get contentLetterCount;
  @override

  /// When you want download audio sound file customer use this link.
  @JsonKey(name: 'likeRate')
  double? get likeRate;
  @override
  @JsonKey(name: 'soundFileLink')
  String? get soundFileLink;
  @override

  /// File type
  @JsonKey(name: 'soundFileType')
  String? get soundFileType;
  @override

  /// This parameter gives info people of join to meeting about they languages
  @JsonKey(name: 'lang')
  String? get lang;
  @override

  /// This parameter provides information about the individuals attending
  /// the meeting and their assigned tasks. It includes each person who
  /// is participating in the current meeting and what they must do
  @JsonKey(name: "responseTodo")
  ResponseTodoModel? get responseTodo;
  @override
  DateTime? get createdDateTime;
  @override
  @JsonKey(ignore: true)
  _$$MeetImplCopyWith<_$MeetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
