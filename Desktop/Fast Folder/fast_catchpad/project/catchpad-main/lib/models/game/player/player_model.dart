// ignore_for_file: invalid_annotation_target

import 'package:catchpad/models/auth/register_user.dart';
import 'package:catchpad/models/enums/utility/dialog_parts_enum.dart';
import 'package:catchpad/models/game/dynamic_games/dynamic_game_model.dart';
import 'package:catchpad/prov/dialogs/game_start_condition_dialog_prov.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xrandom/xrandom.dart';

import 'staged_player_model.dart';

part 'player_model.freezed.dart';
part 'player_model.g.dart';

Map<String, dynamic>? _userToJson(RegisterUser? user) {
  return user?.toJson();
}

RegisterUser? _userFromJson(dynamic c) {
  if (c == null || c is! Map<String, dynamic>) {
    return null;
  }

  return RegisterUser.fromJson(c);
}

List<String> _colorsToJson(List<Color>? clrs) {
  return clrs?.map((e) => e.toJson()).toList() ?? [];
}

List<Color> _colorsFromJson(List<dynamic> c) {
  return c
      .map(
        (e) => CpColorExt.fromJson(
          e.toString(),
        ),
      )
      .toList();
}

List<Map<String, dynamic>> _devicesToJson(List<DiscoveredDevice>? devs) {
  return devs?.map((d) => d.toJson()).toList() ?? [];
}

List<DeviceModel> _devicesFromJson(List d) {
  return d.map((e) {
    return CpDiscoveredDevice.fromJson(e as Map<String, dynamic>);
  }).toList();
}

@freezed
class PlayerModel with _$PlayerModel {
  static const _generalPlayerId = 'general_player';
  static int _generatedId = 1;

  static String get generatedId => (_generatedId++).toString();

  static void resetId() => _generatedId = 1;

  static void decreaseId() => _generatedId--;

  const PlayerModel._();

  factory PlayerModel.id() => PlayerModel(
        id: generatedId,
        createdAt: DateTime.now(),
      );

  factory PlayerModel.general() => PlayerModel(
        id: _generalPlayerId,
        createdAt: DateTime.now(),
      );

  const factory PlayerModel({
    required String id,

    /// this will be used for sorting the players,
    /// as our id is a string, we cant sort using it
    /// because when we want 2 to be before 10, '10'
    /// actually comes before '2' in the string.
    required DateTime? createdAt,
    String? name,

    /// this indicates the user id associated
    /// with the player.
    @JsonKey(
      toJson: _userToJson,
      fromJson: _userFromJson,
    )
    RegisterUser? user,
    @JsonKey(
      toJson: _colorsToJson,
      fromJson: _colorsFromJson,
    )
    @Default([])
    @protected
    List<Color> colors,
    @JsonKey(
      toJson: _devicesToJson,
      fromJson: _devicesFromJson,
    )
    @Default([])
    @protected
    List<DeviceModel> devices,
  }) = _PlayerModel;

  // what's going on here???
  // so, as the games may use the
  // devices and colors to shuffle,
  // we have to provide a copy of them
  // always and not let the game change
  // them.
  // so we've added a protected annotation
  // on the fields as we can't add private
  // properties in freezed for some reason
  // https://stackoverflow.com/questions/70629963/dart-flutteradd-private-fileds-in-freezed-data-class
  List<DeviceModel> get devs {
    List<DiscoveredDevice> deviceList = List.from(devices);
    deviceList.sort((a, b) => a.deviceNameId!.compareTo(b.deviceNameId!));
    return deviceList;
  }

  int get devCount => devices.length;

  List<Color> get clrs => List.from(colors);

  int get clrCount => colors.length;

  Iterable<DeviceModel>? getDevices(PlayerDevice? d) {
    if (d == null) return null;

    if (d == PlayerDevice.random) {
      final idx = Xrandom().nextInt(devices.length);
      return [devices[idx]];
    }

    final idx = d.index;

    if (idx < 0 || idx >= devices.length) return null;

    return [devices[d.index]];
  }

  String? getColor(ColorIndex? c) {
    if (c == null) {
      return null;
    }

    int idx;

    if (c == ColorIndex.random) {
      idx = Xrandom().nextInt(colors.length);
    } else {
      idx = c.index;
    }

    if (idx < 0 || idx >= colors.length) {
      return null;
    }

    return colors[c.index].toJson();
  }

  // String _generateName() => getStr('player') + ' ' + id.toString();

  bool _satisfiesConditionsColors(StagedPlayerModel staged, {WidgetRef? ref}) {
    if (!staged.hasColors) {
      return true;
    }
    final map = {DialogParts.title: "", DialogParts.description: ""};
    final res = staged.minClrCount! <= clrs.length &&
        staged.maxClrCount! >= clrs.length;

    if (!res && ref != null) {
      final l10n = L10n.inst(ref.context);

      map.update(DialogParts.title,
          (value) => l10n.dialog_game_condition_color_empty_title);
      map.update(DialogParts.description,
          (value) => l10n.dialog_game_condition_color_empty_content);
      Future((){
        ref.read(currentDialogTitleAndDescription.notifier).changState(map);
      });
    }
    // hasColors means minClrCount and maxClrCount
    // are not null
    return res;
  }



  bool _satisfiesConditionsDevs(StagedPlayerModel staged, {WidgetRef? ref}) {
    if (!staged.hasDevs) {
      return true;
    }
    final res = staged.minDevCount! <= devs.length &&
        staged.maxDevCount! >= devs.length;
    final map = {DialogParts.title: "", DialogParts.description: ""};

    if (!res && ref != null) {
      final l10n = L10n.inst(ref.context);

      map.update(DialogParts.title,
          (value) => l10n.dialog_game_condition_devs_empty_title);
      map.update(DialogParts.description,
          (value) => l10n.dialog_game_condition_devs_empty_content);
      Future((){
        ref.read(currentDialogTitleAndDescription.notifier).changState(map);
      });
    }
    // hasDevs means minDevCount and maxDevCount
    // are not null
    return res;
  }

  bool _satisfiesConditionsName(StagedPlayerModel staged, {WidgetRef? ref}) {
    final res =
        (!staged.hasName || (playerName != null && playerName!.isNotEmpty));

    final map = {DialogParts.title: "", DialogParts.description: ""};

    if (!res && ref != null) {
      final l10n = L10n.inst(ref.context);

      map.update(DialogParts.title,
          (value) => l10n.dialog_game_condition_name_empty_title);
      map.update(DialogParts.description,
          (value) => l10n.dialog_game_condition_name_empty_content);

      Future((){
        ref.read(currentDialogTitleAndDescription.notifier).changState(map);
      });
    }



    return res;
  }

  /// we had to split the 2 methods
  /// [satisfiesConditionsNoName] [_satisfiesConditionsName] as
  /// our name and other fields selection are not at the same place,
  /// so sometimes we need to check for only one of them.
  bool satisfiesConditions(StagedPlayerModel staged, {WidgetRef? ref,bool isIga = false}) {
    if(isIga) return _satisfiesConditionsColors(staged,ref: ref);
    return (_satisfiesConditionsName(staged, ref: ref) &&
        _satisfiesConditionsColors(staged, ref: ref) &&
        _satisfiesConditionsDevs(staged, ref: ref));
  }

  String? get playerName {
    return user?.userName ?? name;
  }

  factory PlayerModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerModelFromJson(json);
// Map<String, dynamic> toJson() => _$PlayerModelToJson(this);
}
