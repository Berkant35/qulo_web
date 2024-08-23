//When u want see show case on info tag you must click to "?" icon.
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ShowCaseAppState { onboarding, info, specialOnBoarding}

enum Tips {
  welcome,
  padConnection,
  exercisesShowCase,
  exerciseFilters,
  favorites,
  sorting,
  profile,
  padWakeUp,
  connectToPads,
  connectedPads,
  disconnect,
  lightOnOff,
  sleepMode,
  //benchmark,
  //addToPlaylist,
  aboutExercise,
  exerciseSettingsTitle,
  duration,
  delay,
  inputDistance,

  timeout,
  captureMode,
  sensitivityAcceleration,
  sensitivityDistance,
  sensitivityAngle,
  vibration,
  padSound,
  lightSound,
  effect,
  players,
  targetColor,
  assignExercise,
  padLightBrightness,
  padsInExercise,
  station,
  repetitions,
  hitAndStart,
  control,
  targetOrder,
  level,

  range,
  none
  ;


  static Tips getFromMapKey(String mapKey,BuildContext context) {
    final l10n = L10n.inst(context);
    if (mapKey == l10n.game_ui_device_sensor) {
      return Tips.captureMode;
    }else if(mapKey == l10n.difficulty || mapKey == l10n.game_ui_delay){
      return Tips.delay;
    }

    else if (mapKey == l10n.game_ui_device_sensitivity) {
      return Tips.sensitivityAcceleration;
    } else if (mapKey == l10n.game_ui_distance) {
      return Tips.sensitivityDistance;
    } else if (mapKey == l10n.game_ui_duration) {
      return Tips.duration;
    } else if (mapKey == l10n.game_ui_timeout) {
      return Tips.timeout;
    } else if (mapKey == l10n.game_ui_radius) {
      return Tips.sensitivityAngle;
    } else if (mapKey == l10n.game_ui_vibration_active) {
      return Tips.vibration;
    } else if (mapKey == l10n.game_ui_vibration_degree) {
      return Tips.none;
    } else if (mapKey == l10n.game_ui_music) {
      return Tips.none;
    } else if (mapKey == l10n.game_ui_controls_type) {
      return Tips.control;
    } else if (mapKey == l10n.game_ui_operations) {
      return Tips.none;
    } else if (mapKey == l10n.education_type_learn) {
      return Tips.none;
    } else if (mapKey == l10n.game_ui_execution_devices) {
      return Tips.none;
    } else if (mapKey == l10n.game_ui_auto_start) {
      return Tips.hitAndStart;
    } else if (mapKey == l10n.game_ui_audio_game_audio_status) {
      return Tips.lightOnOff;
    } else if (mapKey == l10n.game_ui_audio_music_status) {
      return Tips.none;
    } else if (mapKey == l10n.game_ui_periodic_queue_status) {
      return Tips.targetOrder;
    } else if (mapKey == l10n.game_ui_periodic_queue) {
      return Tips.none;
    } else if (mapKey == l10n.game_ui_audio_change_status) {
      return Tips.lightOnOff;
    } else if (mapKey == l10n.game_ui_effect_change_status) {
      return Tips.effect;
    } else if (mapKey == l10n.game_ui_keyboard_title_for_distance) {
      return Tips.inputDistance;
    } else if (mapKey == l10n.game_ui_keyboard_title_for_pass_count) {
      return Tips.none;
    } else if (mapKey == l10n.game_ui_audio_sound_effects_status) {
      return Tips.effect;
    } else if (mapKey == l10n.game_ui_device_challenge) {
      return Tips.none;
    } else {
      return Tips.none;
    }
  }

  ShowCaseAppState getShowCaseAppState() {
    switch (this) {
      case Tips.welcome:
        return ShowCaseAppState.onboarding;
      case Tips.padConnection:
        return ShowCaseAppState.onboarding;
      case Tips.exercisesShowCase:
        return ShowCaseAppState.onboarding;
      case Tips.exerciseFilters:
        return ShowCaseAppState.onboarding;
      case Tips.favorites:
        return ShowCaseAppState.info;
      case Tips.sorting:
        return ShowCaseAppState.onboarding;
      case Tips.profile:
        return ShowCaseAppState.onboarding;
      case Tips.padWakeUp:
        return ShowCaseAppState.onboarding;
      case Tips.connectToPads:
        return ShowCaseAppState.onboarding;
      case Tips.connectedPads:
        return ShowCaseAppState.onboarding;
      case Tips.disconnect:
        return ShowCaseAppState.onboarding;
      case Tips.lightOnOff:
        return ShowCaseAppState.onboarding;
      case Tips.sleepMode:
        return ShowCaseAppState.onboarding;

      //case Tips.benchmark:
      //  return ShowCaseAppState.onboarding;
      //case Tips.addToPlaylist:
      //  return ShowCaseAppState.onboarding;
      case Tips.aboutExercise:
        return ShowCaseAppState.specialOnBoarding;
      case Tips.exerciseSettingsTitle:
        return ShowCaseAppState.specialOnBoarding;
      case Tips.duration:
        return ShowCaseAppState.info;
      case Tips.delay:
        return ShowCaseAppState.info;
      case Tips.timeout:
        return ShowCaseAppState.info;
      case Tips.captureMode:
        return ShowCaseAppState.info;
      case Tips.sensitivityAcceleration:
        return ShowCaseAppState.info;
      case Tips.sensitivityDistance:
        return ShowCaseAppState.info;
      case Tips.sensitivityAngle:
        return ShowCaseAppState.info;
      case Tips.vibration:
        return ShowCaseAppState.info;
      case Tips.padSound:
        return ShowCaseAppState.info;
      case Tips.lightSound:
        return ShowCaseAppState.info;
      case Tips.inputDistance:
        return ShowCaseAppState.info;
      case Tips.effect:
        return ShowCaseAppState.info;
      case Tips.players:
        return ShowCaseAppState.info;
      case Tips.targetColor:
        return ShowCaseAppState.info;
      case Tips.assignExercise:
        return ShowCaseAppState.info;
      case Tips.padLightBrightness:
        return ShowCaseAppState.info;
      case Tips.padsInExercise:
        return ShowCaseAppState.info;
      case Tips.station:
        return ShowCaseAppState.info;
      case Tips.repetitions:
        return ShowCaseAppState.info;
      case Tips.hitAndStart:
        return ShowCaseAppState.info;
      case Tips.control:
        return ShowCaseAppState.info;
      case Tips.targetOrder:
        return ShowCaseAppState.info;
      case Tips.level:
        return ShowCaseAppState.info;
      case Tips.range:
        return ShowCaseAppState.info;
      default:
        return ShowCaseAppState.info;
    }
  }

  String getTitle(WidgetRef ref) {
    final l10n = L10n.inst(ref.context);

    switch (this) {
      case Tips.welcome:
        return l10n.tool_tip_welcome_title;
      case Tips.padConnection:
        return l10n.tool_tip_padConnection_title;
      case Tips.exercisesShowCase:
        return l10n.tool_tip_exercises_title;
      case Tips.exerciseFilters:
        return l10n.tool_tip_exerciseFilters_title;
      case Tips.favorites:
        return l10n.tool_tip_favorites_title;
      case Tips.sorting:
        return l10n.tool_tip_sorting_title;
      case Tips.profile:
        return l10n.tool_tip_profile_title;
      case Tips.padWakeUp:
        return l10n.tool_tip_padWakeUp_title;
      case Tips.connectToPads:
        return l10n.tool_tip_connectToPads_title;
      case Tips.connectedPads:
        return l10n.tool_tip_connectedPads_title;
      case Tips.disconnect:
        return l10n.tool_tip_disconnect_title;
      case Tips.lightOnOff:
        return l10n.tool_tip_lightOnOff_title;
      case Tips.sleepMode:
        return l10n.tool_tip_sleepMode_title;
      //case Tips.benchmark:
      //  return l10n.tool_tip_benchmark_title;
      //case Tips.addToPlaylist:
      //  return l10n.tool_tip_addToPlaylist_title;
      case Tips.aboutExercise:
        return l10n.tool_tip_aboutExercise_title;
      case Tips.exerciseSettingsTitle:
        return l10n.tool_tip_exerciseSettingsTitle_title;
      case Tips.duration:
        return l10n.tool_tip_duration_title;
      case Tips.delay:
        return l10n.tool_tip_delay_title;
      case Tips.timeout:
        return l10n.tool_tip_timeout_title;
      case Tips.captureMode:
        return l10n.tool_tip_captureMode_title;
      case Tips.sensitivityAcceleration:
        return l10n.tool_tip_sensitivityAcceleration_title;
      case Tips.sensitivityDistance:
        return l10n.tool_tip_sensitivityDistance_title;
      case Tips.sensitivityAngle:
        return l10n.tool_tip_sensitivityAngle_title;
      case Tips.vibration:
        return l10n.tool_tip_vibration_title;
      case Tips.padSound:
        return l10n.tool_tip_padSound_title;
      case Tips.lightSound:
        return l10n.tool_tip_lightSound_title;
      case Tips.effect:
        return l10n.tool_tip_effect_title;
      case Tips.players:
        return l10n.tool_tip_players_title;
      case Tips.targetColor:
        return l10n.tool_tip_targetColor_title;
      case Tips.assignExercise:
        return l10n.tool_tip_assignExercise_title;
      case Tips.padLightBrightness:
        return l10n.tool_tip_padLightBrightness_title;
      case Tips.padsInExercise:
        return l10n.tool_tip_padsInExercise_title;
      case Tips.station:
        return l10n.tool_tip_station_title;
      case Tips.repetitions:
        return l10n.tool_tip_repetitions_title;
      case Tips.hitAndStart:
        return l10n.tool_tip_hitAndStart_title;
      case Tips.control:
        return l10n.tool_tip_control_title;
      case Tips.inputDistance:
        return l10n.tool_tip_enter_distance_title;
      case Tips.targetOrder:
        return l10n.tool_tip_targetOrder_title;
      case Tips.level:
        return l10n.tool_tip_level_title;
      case Tips.range:
        return l10n.tool_tip_range_title;
      default:
        return "";
    }
  }

  String getDescription(WidgetRef ref) {
    final l10n = L10n.inst(ref.context);

    switch (this) {
      case Tips.welcome:
        return l10n.tool_tip_welcome_description;
      case Tips.padConnection:
        return l10n.tool_tip_padConnection_description;
      case Tips.exercisesShowCase:
        return l10n.tool_tip_exercises_description;
      case Tips.exerciseFilters:
        return l10n.tool_tip_exerciseFilters_description;
      case Tips.favorites:
        return l10n.tool_tip_favorites_description;
      case Tips.sorting:
        return l10n.tool_tip_sorting_description;
      case Tips.profile:
        return l10n.tool_tip_profile_description;
      case Tips.padWakeUp:
        return l10n.tool_tip_padWakeUp_description;
      case Tips.connectToPads:
        return l10n.tool_tip_connectToPads_description;
      case Tips.connectedPads:
        return l10n.tool_tip_connectedPads_description;
      case Tips.inputDistance:
        return l10n.tool_tip_enter_distance_description;
      case Tips.disconnect:
        return l10n.tool_tip_disconnect_description;
      case Tips.lightOnOff:
        return l10n.tool_tip_lightOnOff_description;
      case Tips.sleepMode:
        return l10n.tool_tip_sleepMode_description;
      //case Tips.benchmark:
      //  return l10n.tool_tip_benchmark_description;
      //case Tips.addToPlaylist:
      //  return l10n.tool_tip_addToPlaylist_description;
      case Tips.aboutExercise:
        return l10n.tool_tip_aboutExercise_description;
      case Tips.exerciseSettingsTitle:
        return l10n.tool_tip_exerciseSettingsTitle_description;
      case Tips.duration:
        return l10n.tool_tip_duration_description;
      case Tips.delay:
        return l10n.tool_tip_delay_description;
      case Tips.timeout:
        return l10n.tool_tip_timeout_description;
      case Tips.captureMode:
        return l10n.tool_tip_captureMode_description;
      case Tips.sensitivityAcceleration:
        return l10n.tool_tip_sensitivityAcceleration_description;
      case Tips.sensitivityDistance:
        return l10n.tool_tip_sensitivityDistance_description;
      case Tips.sensitivityAngle:
        return l10n.tool_tip_sensitivityAngle_description;
      case Tips.vibration:
        return l10n.tool_tip_vibration_description;
      case Tips.padSound:
        return l10n.tool_tip_padSound_description;
      case Tips.lightSound:
        return l10n.tool_tip_lightSound_description;
      case Tips.effect:
        return l10n.tool_tip_effect_description;
      case Tips.players:
        return l10n.tool_tip_players_description;
      case Tips.targetColor:
        return l10n.tool_tip_targetColor_description;
      case Tips.assignExercise:
        return l10n.tool_tip_assignExercise_description;
      case Tips.padLightBrightness:
        return l10n.tool_tip_padLightBrightness_description;
      case Tips.padsInExercise:
        return l10n.tool_tip_padsInExercise_description;
      case Tips.station:
        return l10n.tool_tip_station_description;
      case Tips.repetitions:
        return l10n.tool_tip_repetitions_description;
      case Tips.hitAndStart:
        return l10n.tool_tip_hitAndStart_description;
      case Tips.control:
        return l10n.tool_tip_control_description;
      case Tips.targetOrder:
        return l10n.tool_tip_targetOrder_description;
      case Tips.level:
        return l10n.tool_tip_level_description;
      case Tips.range:
        return l10n.tool_tip_range_description;
      default:
        return "";
    }
  }
}
