import 'package:catchpad/models/feedback/traces/play/game_trace.dart';
import 'package:catchpad/models/feedback/traces/play/meta_trace.dart';
import 'package:catchpad/models/feedback/traces/play/pre_trace.dart';
import 'package:catchpad/models/feedback/traces/play/result_trace.dart';
import 'package:catchpad/models/game/static_game_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'play_trace.freezed.dart';
part 'play_trace.g.dart';

/*
    MetaTrace     PreTrace     GameTrace     ResultTrace
       |             |             |             |
      \|/           \|/           \|/           \|/
       -------------------------------------------
                       [PlayTrace]*
*/

///This type created for set json format of game control setup
///Because we haven't GameControlSetup.toJson but
///i created manually a function in GameControlSetup class.
///When PlayTrace activating on state we will fill into this by this function
///[StaticGameSetupModel.toJson]
typedef FormatGameControlSetup = Map<String, dynamic>;

@freezed
class PlayTrace with _$PlayTrace {
  const factory PlayTrace({
    ///This parameter fills when start a game.This parameters show
    ///about which set conditions by user for this game.
    @JsonKey(name: 'gameControlSetup', defaultValue: {})
    @Default({})
    FormatGameControlSetup gameControlSetup,
    @JsonKey(name: 'createdTime') String? createdTime,
    /// [GameTrace] help us about user actions for  when playing game
    @JsonKey(name: 'gameTrace') @Default(GameTrace()) GameTrace? gameTrace,
    /// [MetaTrace] helps us track which game was entered by the user.
    @JsonKey(name: 'metaTrace') @Default(MetaTrace()) MetaTrace? metaTrace,
    /// [ResultTrace] assists us in tracking user actions when the game
    /// is finished.
    @JsonKey(name: 'resultTrace') @Default(ResultTrace()) ResultTrace? resultTrace,
    /// [PreTrace] assists us in tracking user actions before entering the game.
    @JsonKey(name: 'preTrace') @Default(PreTrace()) PreTrace? preTrace,
    @JsonKey(name: "millisecondEpoch") String? createdMillisecondEpoch,

  }) = _PlayTrace;

  factory PlayTrace.fromJson(Map<String, Object?> json) =>
      _$PlayTraceFromJson(json).copyWith(
          createdTime: DateTime.now().toString().substring(0,20),
          createdMillisecondEpoch: DateTime.now().millisecondsSinceEpoch.toString()
      );
}
