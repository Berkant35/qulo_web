// ignore_for_file: invalid_annotation_target

import 'package:catchpad/models/game/game_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'staged_player_model.freezed.dart';
part 'staged_player_model.g.dart';

/// the game initially will have this model stored in the database,
/// but will need [PlayerModel]s to play. the [PlayerModel]s info
/// will be requested from the user on game start.
///
/// [hasName]: if `true`, we will show the user picking a name option,
/// with initially setting the name to the default name.
/// else, we will just use the default name, and not even show it to the user.
@freezed
class StagedPlayerModel with _$StagedPlayerModel {
  const StagedPlayerModel._();

  const factory StagedPlayerModel({
    @protected NumRange? colorCount,
    NumRange? deviceCount,
    @Default(true) bool hasName,
    @protected @Default(false) bool hasDevices,

    ///This parameter represents the assigned difference value, indicating
    ///what the difference value (padCount - selectedColor) should be.
    ///For example, in the central vision exercise, if the Pad Count is 4,
    /// the selected color count must be 3. Therefore, this value must always be 1
    int? colorDeviceDifference,

    /// these colors will be pre selected in the player picker
    @protected @JsonKey(ignore: true) List<Color>? defaultSelectedColors,

    /// these colors will be hidden from the player picker,
    /// will be used for success and error colors etc.
    @JsonKey(ignore: true) List<Color>? unavailableColors,
  }) = _StagedPlayerModel;

  factory StagedPlayerModel.general({
    NumRange? colorCount,
    NumRange? deviceCount,
    bool hasDevices = false,
    List<Color>? defaultSelectedColors,
    List<Color>? unavailableColors,
    int? colorDeviceDifference,

  }) {
    return StagedPlayerModel(
      colorCount: colorCount,
      deviceCount: deviceCount,
      colorDeviceDifference: colorDeviceDifference,
      hasName: false,
      hasDevices: hasDevices,
      defaultSelectedColors: defaultSelectedColors,
      unavailableColors: unavailableColors,
    );
  }

  bool get hasColors => minClrCount != null && minClrCount! > 0;
  bool get hasDevs => hasDevices || deviceCount != null;

  List<Color>? get defSelectedColors {
    return defaultSelectedColors
        ?.where(
          (e) => unavailableColors?.contains(e) == false,
        )
        .toList();
  }

  int? get minClrCount {
    return colorCount?.min;
  }

  int? get maxClrCount {
    return colorCount?.max;
  }

  int? get minDevCount {
    return deviceCount?.min;
  }

  int? get maxDevCount {
    return deviceCount?.max;
  }

  factory StagedPlayerModel.fromJson(Map<String, dynamic> json) =>
      _$StagedPlayerModelFromJson(json);
}
