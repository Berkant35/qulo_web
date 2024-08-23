import 'package:catchpad/models/enums/traces/play_traces_enum.dart';
import 'package:catchpad/models/event/catchpad_event.dart';
import 'package:catchpad/models/event/event_customer.dart';
import 'package:catchpad/models/feedback/traces/ble/ble_flow_tracker.dart';
import 'package:catchpad/models/feedback/traces/connections/connection_by_customer.dart';
import 'package:catchpad/models/feedback/traces/play/game_trace.dart';
import 'package:catchpad/models/feedback/traces/play/meta_trace.dart';
import 'package:catchpad/models/pad_ota_config.dart';
import 'package:catchpad/prov/auto_ble_disconnect_prov.dart';
import 'package:catchpad/prov/buzzer_manager_prov.dart';
import 'package:catchpad/prov/cache/setup/cache_setup_manager.dart';
import 'package:catchpad/prov/catchpad_event_manager.dart';
import 'package:catchpad/prov/current_battery_voltage_prov.dart';
import 'package:catchpad/prov/game/curr_periodically_queue_prov.dart';
import 'package:catchpad/prov/game/first_action_date_time_prov.dart';
import 'package:catchpad/prov/give_rate_prov.dart';
import 'package:catchpad/prov/main_base_pad_prov.dart';
import 'package:catchpad/prov/new_version_prov.dart';
import 'package:catchpad/prov/ota/pad_ota_config_prov.dart';
import 'package:catchpad/prov/ota/update_ota_file_prov.dart';
import 'package:catchpad/prov/safe_in_game_toggle_prov.dart';
import 'package:catchpad/prov/safe_scor_prov.dart';
import 'package:catchpad/prov/search_filter_prov.dart';
import 'package:catchpad/prov/system/current_emb_mode.dart';
import 'package:catchpad/prov/system/current_orientation_prov.dart';
import 'package:catchpad/prov/system/phone_information_prov.dart';
import 'package:catchpad/prov/traces/play/current_game_trace_prov.dart';
import 'package:catchpad/prov/traces/play/current_play_trace_prov.dart';
import 'package:catchpad/prov/traces/play/current_play_traces_state_prov.dart';
import 'package:catchpad/prov/version_number_prov.dart';
import 'package:catchpad/utils/settings/version_manager.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter_midi_pro/flutter_midi_pro.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:screenshot/screenshot.dart';

import '../models/audio/melody.dart';
import '../models/enums/utility/loading_status.dart';
import '../models/feedback/traces/play/play_trace.dart';
import '../models/feedback/traces/play/pre_trace.dart';
import '../models/feedback/traces/play/result_trace.dart';
import '../models/game/game_drop_options_model.dart';
import '../models/system/phone_information_model.dart';
import 'audio/audio_dev_prov.dart';
import 'audio/pro_midi_prov.dart';
import 'current_all_connection_prov.dart';
import 'current_battery_check.dart';
import 'current_devices_manager.dart';
import 'current_product_manager.dart';
import 'current_screenshot_controller_prov.dart';
import 'custom_finish_prov.dart';
import 'dead_list_prov.dart';
import 'dev_led_prov.dart';
import 'effect/show_effect_prov.dart';
import 'error/pad_errors_prov.dart';
import 'game/curr_periodically_color_queue_prov.dart';
import 'game/current_drop_option.dart';
import 'loading_state_manager.dart';
import 'location_prov.dart';
import 'ota/ota_percent_manager.dart';
import 'traces/ble/ble_flow_tracker_prov.dart';
import 'traces/check/pad_connection_check.dart';
import 'traces/play/current_meta_trace_prov.dart';
import 'traces/play/current_pre_trace_prov.dart';
import 'traces/play/current_result_trace_prov.dart';

/*
    --------------- GLOBAL PROVIDER GOAL ------------------------

    This class helps with all projects. What does that mean? Whenever
    you want to write a state management for any scenario, your state
    provider needs a reference, and you can access this reference
    through this class.

    ---------------------- PROVIDERS ----------------------------

 */

final currentShareController = StateNotifierProvider<
    CurrentShareControllerManager,
    ScreenshotController>(
      (ref) => CurrentShareControllerManager(ScreenshotController()),
);

//This provider control your what typing to edit field
final searchFilterProvider =
StateNotifierProvider<SearchFilterProvider, String>(
        (_) => SearchFilterProvider(""));

//This provider control your pad buzzer when you tapping to any pad
final buzzerManagerProvider =
StateNotifierProvider<BuzzerManagerProvider, bool>(
        (_) => BuzzerManagerProvider(false));

//This provider control current connected devices of info.
final currentDevicesManagerProvider = StateNotifierProvider<
    CurrentDeviceManagerProvider,
    Map<String, DevInfoModel>>((_) {
  return CurrentDeviceManagerProvider({});
});

final currentLocationProvider =
StateNotifierProvider<CurrentLocationNotifier, LocationData?>(
        (_) => CurrentLocationNotifier(null));

//This provider control products for pads
//This provider control current connected devices of info.
final currentDevicesProductManager =
StateNotifierProvider<CurrentPadProductManagerNotifier, AllPadsProductInfo>(
        (_) => CurrentPadProductManagerNotifier({}));

//This provider can handle loading states!
final currentLoadingManager =
StateNotifierProvider<LoadingStateManager, LoadingStates>(
        (_) => LoadingStateManager(LoadingStates.loaded));

//This provider can handle ota loading states!
final currentOtaLoadingManager =
StateNotifierProvider<UpdateOtaFileNotifier, LoadingStates>(
        (_) => UpdateOtaFileNotifier(LoadingStates.loaded));

final currentVersionManager =
StateNotifierProvider<VersionNumberNotifier, VersionManager>((_) =>
    VersionNumberNotifier(
        VersionManager(deviceValue: "", databaseValue: "")));

//You can get currentVersion from Firebase for must pad versions
final currentPadOtaConfigManager =
StateNotifierProvider<PadConfigNumberNotifier, PadOtaConfig>(
        (_) => PadConfigNumberNotifier(const PadOtaConfig()));

final currentUpdatePercentManager =
StateNotifierProvider<UpdateFilePercentNotifier, UpdateFilePercent>(
        (_) => UpdateFilePercentNotifier({}));

final currentAllDeviceUploadingManager = StateNotifierProvider<
    AllDeviceUploadingStatesNotifier,
    AllDeviceUploadingStates>((_) => AllDeviceUploadingStatesNotifier({}));

final currentPadErrorProvManager = StateNotifierProvider<PadErrorsProvNotifier,
    DeviceMatchToPadErrorConfigList>((_) => PadErrorsProvNotifier({}));

final currentAudioProvManager =
StateNotifierProvider<AudioDevsNotifier, CurrentAudioFilesOnPad>(
        (_) => AudioDevsNotifier({}));

final currentAutoDisposeTimerManager =
StateNotifierProvider<AutoBleDisconnectProvNotifier, RemainingTime>(
        (_) => AutoBleDisconnectProvNotifier({}));

//You can handle midi actions
final currentMidiManager = StateNotifierProvider<MidiProNotifier, MidiPro?>(
        (_) => MidiProNotifier(null));

final currentMelodyManager =
StateNotifierProvider<MelodyNotifier, Melody?>((_) => MelodyNotifier(null));

final currentEffectConditionManager =
StateNotifierProvider<EffectConditionManagerProvider, EffectConditionMap?>(
        (_) => EffectConditionManagerProvider({}));

final currentDeadListManager =
StateNotifierProvider<DeadListManagerNotifier, List<String>>(
        (_) => DeadListManagerNotifier([]));

final currentDevLedManager =
StateNotifierProvider<DevLedManagerNotifier, Map<String, bool>>(
        (_) => DevLedManagerNotifier({"all": false}));

final currentFirstActionTimeManager =
StateNotifierProvider<FirstActionDateTimeControlNotifier, DateTime?>(
        (_) => FirstActionDateTimeControlNotifier(null));

final currentFirstActionStateManager =
StateNotifierProvider<FirstActionStateControlNotifier, bool>(
        (_) => FirstActionStateControlNotifier(true));

// - Game Features Start -

final currentPeriodicallyQueueManager = StateNotifierProvider<
    CurrentPeriodicallyQueueControlNotifier,
    PeriodicallyQueue>((_) => CurrentPeriodicallyQueueControlNotifier({}));


final currentPeriodColorQueueManager
= StateNotifierProvider<
    CurrentPeriodicallyColorQueueNotifier,
    DeviceSetColor>((_) => CurrentPeriodicallyColorQueueNotifier({}));

final currentDropOptionManager = StateNotifierProvider<
    CurrentDropOptionControlNotifier,
    DropOption?>((_) => CurrentDropOptionControlNotifier(null));


final currentIncludePeriodicallyQueueManager =
StateNotifierProvider<IncludePeriodicallyQueueControlNotifier, bool>(
        (_) => IncludePeriodicallyQueueControlNotifier(false));

// - Game Features End -

// - Trace-Start -
final currentPlayTraceManager =
StateNotifierProvider<CurrentPlayTraceNotifier, PlayTrace?>(
        (_) => CurrentPlayTraceNotifier(null));

final currentMetaTraceManager =
StateNotifierProvider<CurrentMetaTraceNotifier, MetaTrace?>(
        (_) => CurrentMetaTraceNotifier(null));

final currentPreTraceManager =
StateNotifierProvider<CurrentPreTraceNotifier, PreTrace?>(
        (_) => CurrentPreTraceNotifier(null));

final currentGameTraceManager =
StateNotifierProvider<CurrentGameTraceNotifier, GameTrace?>((ref) {
  return CurrentGameTraceNotifier(null);
});

final currentResultTraceManager =
StateNotifierProvider<CurrentResultTraceNotifier, ResultTrace?>(
        (_) => CurrentResultTraceNotifier(null));

//CacheSetupManager
final currentCacheSetupManager =
StateNotifierProvider<CacheSetupManager, Map<String, dynamic>>(
        (_) => CacheSetupManager({}));

// Some Precaution
final currentSafeSetupManager = StateNotifierProvider<
    SafeActionAndCommandScoreNotifier,
    Map<String, double>>(
        (_) =>
        SafeActionAndCommandScoreNotifier({
          TimePoints.action.name: 0.0,
          TimePoints.command.name: 0.0,
          TimePoints.phoneDiff.name: 0.0,
          TimePoints.padDiff.name: 0.0,
        }));

final currentPlayTraceStateManager =
StateNotifierProvider<PlayTraceStateControlNotifier, PlayTraceStates>(
        (_) => PlayTraceStateControlNotifier(PlayTraceStates.idle));

// Ble Flow Tracker
final currentBleTrackerStateManager =
StateNotifierProvider<BleFlowTrackerNotifier, BleFlowTracker?>(
        (_) => BleFlowTrackerNotifier(null));

final currentConnectionByCustomerManager = StateNotifierProvider<
    ConnectionByCustomerControlNotifier,
    ConnectionByCustomer?>((_) => ConnectionByCustomerControlNotifier(null));
// - Trace-End -

// - Battery Start -

final currentChargingStatusManager = StateNotifierProvider<
    CurrentDeviceBatteryChargingStatusNotifier,
    Map<String, bool>>((_) => CurrentDeviceBatteryChargingStatusNotifier({}));

final currentBatteryOfPadsManager =
StateNotifierProvider<CurrentBatteryVoltageNotifier, Map<String, double>>(
        (_) => CurrentBatteryVoltageNotifier({}));

// - Battery End -

final currentFinishControlManager =
StateNotifierProvider<CustomFinishControlNotifier, bool>(
        (_) => CustomFinishControlNotifier(false));

// - Catchpad Event -

final catchPadEventManager =
StateNotifierProvider<CatchpadEventControllerNotifier, CatchpadEvent?>(
        (_) => CatchpadEventControllerNotifier(null));

final catchpadEventCompetitorManager =
StateNotifierProvider<EventCompetitorNotifier, EventCustomer?>(
        (_) => EventCompetitorNotifier(null));

//CurrentAllConnectionStatusControlNotifier
final currentAllConnectionStates =
StateNotifierProvider<CurrentAllConnectionStatusControlNotifier, bool>(
        (_) => CurrentAllConnectionStatusControlNotifier(false));

// - Catchpad Event End -

// - System Start -
final currentDeviceInformationManager =
StateNotifierProvider<PhoneInformationNotifier, PhoneInformationModel?>(
        (_) => PhoneInformationNotifier(null));

final currentEmbModeManager =
StateNotifierProvider<CurrentEmbModeControlNotifier, int>(
        (_) => CurrentEmbModeControlNotifier(0));

final currentOrientationBlockManager =
StateNotifierProvider<CurrentOrientationBlockControlNotifier, bool>(
        (_) => CurrentOrientationBlockControlNotifier(false));

// - System End -

// - Utilities Start -

final currentSafeInGameToggleState =
StateNotifierProvider<SafeInGameToggleControlNotifier, bool>(
        (_) => SafeInGameToggleControlNotifier(false));

final currentMainBaseDiscoveredState =
StateNotifierProvider<MainBasePadControlNotifier, DiscoveredDevice?>(
        (_) => MainBasePadControlNotifier(null));

// - Utilities End -

// - Give Rate -
final currentGiveRateManager =
StateNotifierProvider<GiveRateControlNotifier, bool>(
        (_) => GiveRateControlNotifier(false));

// - Give Rate End -

// New Version
final currentNewVersionState =
StateNotifierProvider<NewVersionManager, bool>(
        (_) => NewVersionManager(false));

// New Version End-