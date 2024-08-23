// import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:catchpad/models/enums/traces/play_traces_enum.dart';
import 'package:catchpad/prov/emb/iga/chooses/iga_choose_level_prov.dart';
import 'package:catchpad/prov/emb/iga/device/iga_check_disconnecting_flag_prov.dart';
import 'package:catchpad/prov/emb/iga/iga_videos_prov.dart';
import 'package:catchpad/prov/emb/iga/result/iga_leaderboard_prov.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/emb/iga/games/iga_game_result.dart';
import '../../models/emb/iga/traces/iga_trace_model.dart';
import '../../utils/emb/iga/iga_enums.dart';
import 'iga/chooses/iga_choose_player_prov.dart';
import 'iga/device/iga_all_connection_once_time_prov.dart';
import 'iga/flags_prov.dart';
import 'iga/iga_is_there_any_customer_prov.dart';
import 'iga/iga_page_prov.dart';
import 'iga/result/iga_result_prov.dart';
import 'iga/traces/iga_current_trace_prov.dart';
import 'iga/traces/iga_trace_prov.dart';
import 'iga_show_text_bul_bakalim.dart';

// - IGA Start -
final currentIgaPageManager =
    StateNotifierProvider<IgaPageControlNotifier, IGAStates>(
        (_) => IgaPageControlNotifier(IGAStates.home));

final currentIgaPlayerModeManager =
    StateNotifierProvider<IgaChoosePlayerControlNotifier, IGAPlayerModes>(
        (_) => IgaChoosePlayerControlNotifier(IGAPlayerModes.singlePlayer));

final currentIgaChooseLevelManager =
    StateNotifierProvider<IgaChooseLevelControlNotifier, IGALevelModes>(
        (_) => IgaChooseLevelControlNotifier(IGALevelModes.hard));

final currentIgaIsThereAnyCustomerManager =
    StateNotifierProvider<IgaIsThereAnyCustomerControlNotifier, bool>(
        (_) => IgaIsThereAnyCustomerControlNotifier(false));

final currentIgaAllPadConnectionOnceTimeManager =
    StateNotifierProvider<IGAAllConnectionOnceTimeControlNotifier, bool>(
        (_) => IGAAllConnectionOnceTimeControlNotifier(false));

final checkDisconnectingFlagManager =
    StateNotifierProvider<IGACheckDisconnectingFlagControlNotifier, bool>(
        (_) => IGACheckDisconnectingFlagControlNotifier(false));
final currentBulBakalim =
    StateNotifierProvider<BulBakalimControlNotifier, bool>(
        (_) => BulBakalimControlNotifier(false));
final currentRemainBulBakalim =
    StateNotifierProvider<RemainTimeBulBakalimControlNotifier, bool>(
        (_) => RemainTimeBulBakalimControlNotifier(false));

//CurrentIgaResultNotifier
final currentIgaResultManager =
    StateNotifierProvider<CurrentIgaResultNotifier, IgaGameResult?>(
        (_) => CurrentIgaResultNotifier(null));

final currentIgaLeaderboardManager =
    StateNotifierProvider<IgaLeaderboardNotifier, String?>(
        (_) => IgaLeaderboardNotifier(null));

// IGA - TRACE - MANAGERS - START
final currentIgaTraceStateManager = StateNotifierProvider<
        CurrentIgaPlayTraceStateControlNotifier, IgaPlayTraceStates>(
    (_) => CurrentIgaPlayTraceStateControlNotifier(IgaPlayTraceStates.idle));

final currentIgaTraceManager =
    StateNotifierProvider<IgaTraceManagerNotifier, IgaTraceModel?>(
        (_) => IgaTraceManagerNotifier(null));
// IGA - TRACE - MANAGERS - END

// Flags - Start

final needForceRestartManager =
    StateNotifierProvider<NeedRestartAppControlNotifier, bool>(
        (_) => NeedRestartAppControlNotifier(false));

// Flags - End

// final currentIgaVideoController = StateNotifierProvider<
//         VideoControllerIGAControlNotifier, CustomVideoPlayerController?>(
//     (ref) => VideoControllerIGAControlNotifier(null));

// - IGA End -
