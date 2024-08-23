import 'dart:async';
import 'dart:ui' as ui;

import 'package:battery_plus/battery_plus.dart';
import 'package:catchpad/models/emb/iga/games/iga_game_info.dart';
import 'package:catchpad/models/emb/iga/games/iga_game_result.dart';
import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_log_handler/flutter_native_logs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:memory_info/memory_info.dart';
import 'package:restart_app/restart_app.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../models/emb/iga/location/iga_location.dart';
import '../../../../utils/emb/iga/iga_enums.dart';

class IgaLeaderboardNotifier extends StateNotifier<String?> {
  IgaLeaderboardNotifier(String? state) : super(null);

  IgaGameResult? _lastGame;

  IgaGameResult? get lastGame => _lastGame;

  late ScreenshotController _screenshotController;

  void changeState(WidgetRef ref, String val) => state = val;

  Future<void> initalizePeriodicallyRestartApp(WidgetRef ref) async {
    await FirebaseIgaCollectionEnumsWithField.iga_locations.reference
        .doc(kDebugMode
            ? "3"
            : ref
                .read(currentIgaResultManager.notifier)
                .currentLocation
                ?.igaLocationId)
        .update({
      "restartTime": DateTime.now().toString().substring(0, 19),
    });

    Timer.periodic(const Duration(hours: 2), (timer) {
      if (ref.read(currentIgaPageManager) == IGAStates.home) {
        Restart.restartApp();
      } else {
        ref.read(needForceRestartManager.notifier).changState(true);
      }
    });
  }

  Future<void> getMemoryInfo(WidgetRef ref) async {
    Memory? memory;
    DiskSpace? diskSpace;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      memory = await MemoryInfoPlugin().memoryInfo;
      diskSpace = await MemoryInfoPlugin().diskSpace;
    } on PlatformException catch (e) {
      logger.e('error $e');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    await FirebaseIgaCollectionEnumsWithField.iga_locations.reference
        .doc(kDebugMode
            ? "3"
            : ref
                .read(currentIgaResultManager.notifier)
                .currentLocation
                ?.igaLocationId)
        .get()
        .then((value) async {
      if (value.data() == null) return;
      final doc = value.data() as Map<String, dynamic>;
      if (doc['whiteScreen']) Restart.restartApp();
      await FirebaseIgaCollectionEnumsWithField.iga_locations.reference
          .doc(kDebugMode
              ? "3"
              : ref
                  .read(currentIgaResultManager.notifier)
                  .currentLocation
                  ?.igaLocationId)
          .update({
        "mFreeSpace": memory?.freeMem,
        "mAppMem": memory?.appMem,
        "mTotalMem": memory?.totalMem,
        "mLowMemory": memory?.lowMemory,
        "dFreeSpace": diskSpace?.freeSpace,
        "whiteScreen": true,
        "dTotalSpace": diskSpace?.totalSpace
      });
    });

    final percentage =
        ((memory?.freeMem ?? double.infinity) / (memory?.totalMem ?? 1));

    if ((memory?.lowMemory ?? false) || percentage < 0.1) {
      if (ref.read(currentIgaPageManager) == IGAStates.home)
        Restart.restartApp();
      if (ref.context.mounted)
        ref.read(needForceRestartManager.notifier).changState(true);
    }
  }

  Future<bool> _isWhiteImage(ui.Image image) async {
    ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    if (byteData == null) return false;

    int width = image.width;
    int height = image.height;
    int whitePixelCount = 0;
    int totalPixelCount = width * height;

    for (int i = 0; i < totalPixelCount; i++) {
      int pixelIndex = i * 4;
      int r = byteData.getUint8(pixelIndex);
      int g = byteData.getUint8(pixelIndex + 1);
      int b = byteData.getUint8(pixelIndex + 2);
      int a = byteData.getUint8(pixelIndex + 3);

      if (r == 255 && g == 255 && b == 255 && a == 255) {
        whitePixelCount++;
      }
    }

    double whitePercentage = (whitePixelCount / totalPixelCount) * 100;
    final res = whitePercentage > 95.0;

    return res; // Eğer ekranın %95'inden fazlası beyazsa true döner
  }

  Future<void> initalizePeriodicallyOkeyLoop(WidgetRef ref) async {
    _screenshotController = ScreenshotController();

    StreamSubscription<NativeLogMessage> subscription =
        FlutterNativeLogs().logStream.listen(
              (NativeLogMessage message) =>
                  logger.i("NativeLogMessage: $message"),
            );

    subscription.onData((data) async {
      if (data.message.toLowerCase().contains("fatal") ||
          data.message
              .toLowerCase()
              .replaceAll(" ", "")
              .contains("outofmemory")) {
        await FirebaseIgaCollectionEnumsWithField.iga_locations.reference
            .doc(kDebugMode
                ? "3"
                : ref
                    .read(currentIgaResultManager.notifier)
                    .currentLocation
                    ?.igaLocationId)
            .update({
          "outOfMemory": true,
        });
        Restart.restartApp();
      }
    });

    ref
        .read(currentShareController.notifier)
        .initialize(ref, _screenshotController);

    Timer.periodic(const Duration(minutes: 5), (timer) async {
      final phoneBattery = Battery();
      final batteryLevel = await phoneBattery.batteryLevel;

      try {
        Uint8List? screenshot =
            await _screenshotController.capture(delay: Duration.zero);

        if (screenshot != null) {
          ui.decodeImageFromList(screenshot, (result) async {
            final isWhite = await _isWhiteImage(result);

            if (isWhite) {
              logger.w("Restarting...");
              Restart.restartApp();
            }
          });
        } else {
          logger.i("Screenshot Null");
        }
      } catch (e) {
        logger.e(e.toString());
      }

      getMemoryInfo(ref);

      // Update All Pad Ok Status Current Location
      //ref.read(currentIgaResultManager.notifier).currentLocation?.igaLocationId ?? "3"
      FirebaseIgaCollectionEnumsWithField.iga_locations.reference
          .doc(kDebugMode
              ? "3"
              : ref
                  .read(currentIgaResultManager.notifier)
                  .currentLocation
                  ?.igaLocationId)
          .update({
        "allPadOk": ref
                .read(bleConPr)
                .values
                .where((element) =>
                    element.connectionState == DeviceConnectionState.connected)
                .length ==
            12,
        "periodFiveBatteryInfo": batteryLevel,
        "updatedAt": DateTime.now().toString().substring(0, 19),
      });
    });
  }

  Future<void> initalizePeriodicReportLoop(WidgetRef ref) async {
    Timer.periodic(const Duration(minutes: 2), (timer) async {
      final currentLoc =
          ref.read(currentIgaResultManager.notifier).currentLocation;
      FirebaseIgaCollectionEnumsWithField.iga_locations.reference
          .doc(kDebugMode ? "3" : currentLoc?.igaLocationId)
          .update({"whiteScreen": false});

       // // - Telegram - //
       // final currentLoc =
       //     ref.read(currentIgaResultManager.notifier).currentLocation;
       // final connectedDevice = ref
       //     .read(bleConPr)
       //     .values
       //     .where((element) =>
       //         element.connectionState == DeviceConnectionState.connected)
       //     .length;
       // final stringBuffer = StringBuffer();
       // stringBuffer.write("Location Name: ${currentLoc?.igaLocationName}\n");
       // stringBuffer.write("Location ID: ${currentLoc?.igaLocationId}\n");
       // stringBuffer.write(
       //     "Location On Game Count: ${currentLoc?.igaLocationGameCount}\n");
       // stringBuffer.write("Last Game Date: ${currentLoc?.updatedAt}\n");
       // stringBuffer
       //     .write("Location Iga Phone ID: ${currentLoc?.igaLocationPhoneId}\n");
       // stringBuffer.write(
       //     "Current BLE Connected Device ID: ${currentLoc?.igaLocationPhoneId}\n");
       // stringBuffer.write("Connected Device Count: $connectedDevice\n");
       // await TelegramManager.instance!
       //     .sendIGAMobilePeriodicallyReport(stringBuffer.toString(), ref);
       // stringBuffer.clear();
    });
  }

  Stream<List<IgaGameResult>> igaGameResultsLeaderboard(WidgetRef ref) {
    return FirebaseIgaCollectionEnumsWithField.iga_results.reference
        .doc(FirebaseIgaCollectionEnumsWithField.iga_result_games.name)
        .collection(state != null
            ? state!
            : ref
                    .read(currentIgaResultManager.notifier)
                    .currentLocation
                    ?.igaLastGameInfoId ??
                "s16")
        .orderBy("primaryScore", descending: false)
        .limit(50)
        .snapshots(includeMetadataChanges: true)
        .map((perIgaGameResult) {
      final List<IgaGameResult> igaGameResultList = [];

      for (var perResult in perIgaGameResult.docs) {
        final igaGameResult = IgaGameResult.fromJson(perResult.data());
        igaGameResultList.add(igaGameResult);
      }

      return igaGameResultList;
    });
  }

  Stream<IgaGameResult?> listenCurrentLocationLastGame(WidgetRef ref) async* {
    final snapshot = await FirebaseIgaCollectionEnumsWithField
        .iga_locations.reference
        .doc(ref
                .read(currentIgaResultManager.notifier)
                .currentLocation
                ?.igaLocationId ??
            "3")
        .snapshots()
        .first;

    final currentIgaLocation =
        IgaLocation.fromJson(snapshot.data() as Map<String, dynamic>);

    final lastGame = currentIgaLocation.igaLastGameId;
    if (lastGame == null) {
      logger.e("Last Game Null");
      yield null;
    } else {
      final querySnapshot = await FirebaseIgaCollectionEnumsWithField
          .iga_results.reference
          .doc(FirebaseIgaCollectionEnumsWithField.iga_result_games.name)
          .collection(currentIgaLocation.igaLastGameInfoId ?? 's16')
          .where("igaGameResultId", isEqualTo: lastGame)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final igaGameResult =
            IgaGameResult.fromJson(querySnapshot.docs.first.data());
        _lastGame = igaGameResult;
        yield igaGameResult;
      } else {
        logger.e("Last Game Empty");
        yield null;
      }
    }
  }

  Future<int?> getUserRank(String userId, String? gameId) async {
    final querySnapshot = await FirebaseIgaCollectionEnumsWithField
        .iga_results.reference
        .doc(FirebaseIgaCollectionEnumsWithField.iga_result_games.name)
        .collection(gameId ?? (state ?? "s16"))
        .orderBy("primaryScore", descending: false)
        .get();

    final docs = querySnapshot.docs;

    // Kullanıcının skorunu bulalım
    var userScore;
    for (int i = 0; i < docs.length; i++) {
      final data = docs[i].data();

      print("UserId: ${data["igaUserId"]}");
      if (data["igaUserId"] == userId) {
        userScore = data["primaryScore"];
        break;
      }
    }

    // Kullanıcının skorunu bulamazsak null döndürelim
    if (userScore == null) {
      logger.e("User Socre Null");
    }

    // Kullanıcının sırasını bulalım
    int rank = 1;
    for (int i = 0; i < docs.length; i++) {
      final data = docs[i].data();
      final score = data["primaryScore"];
      if (score < userScore) {
        rank++;
      } else if (score == userScore && data["igaUserId"] != userId) {
        rank++;
      } else {
        break;
      }
    }
    logger.i("Triggered!!");

    return rank;
  }

  final defMap = {"percentage": 0, "isUnder": false};

  Future<Map<String, dynamic>> compareWithAverage(double valueToCompare,
      {String? locationGameId}) async {
    final igaGameInfoData = await FirebaseIgaCollectionEnumsWithField
        .iga_games.reference
        .doc(locationGameId ?? (state ?? "s16"))
        .get();

    final defaultMap = {"percentage": 0, "isUnder": false};

    if (igaGameInfoData.data() == null) return defaultMap;

    final igaGameInfo =
        IgaGameInfo.fromJson(igaGameInfoData.data() as Map<String, dynamic>);

    final currentAverageOnGlobalGame = igaGameInfo.primaryAverage ?? 0.0;

    final double difference = valueToCompare - currentAverageOnGlobalGame;
    final double percentage = (difference / currentAverageOnGlobalGame) * 100;
    final bool isUnder = difference < 0;

    return {"percentage": percentage, "isUnder": isUnder};
  }

  Future<IgaGameInfo?> getGameInfo(
      {String? forceGameId, required WidgetRef ref}) async {
    final igaGameInfoData = await FirebaseIgaCollectionEnumsWithField
        .iga_games.reference
        .doc(state ?? (forceGameId ?? "s16"))
        .get();
    final igaGameInfo =
        IgaGameInfo.fromJson(igaGameInfoData.data() as Map<String, dynamic>);

    return igaGameInfo;
  }
}
