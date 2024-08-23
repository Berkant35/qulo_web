import 'package:catchpad/models/emb/iga/games/iga_game_result.dart';
import 'package:catchpad/models/emb/iga/location/iga_location.dart';
import 'package:catchpad/models/emb/iga/user/iga_user.dart';
import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/prov/emb/iga/flags_prov.dart';
import 'package:catchpad/prov/emb/iga/iga_background_ble.dart';
import 'package:catchpad/prov/game/curr_game_prov.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/emb/iga/iga_consts.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad/utils/util_widgets/util_dialogs.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/async.dart';

import '../../../../models/emb/iga/games/iga_game_info.dart';
import '../../../game_result_prov.dart';

class CurrentIgaResultNotifier extends StateNotifier<IgaGameResult?> {
  CurrentIgaResultNotifier(IgaGameResult? state) : super(null);

  IgaGameResult? _secondPlayerGameResult;

  IgaGameResult? get secondPlayerGameResult => _secondPlayerGameResult;

  IgaLocation? _igaLocation;

  //This variable is used for first player register work done
  bool _firstPlayerRegisterWorkDone = false;
  bool _firstPlayerRegistered = false;
  bool _singlePlayerGame = false;

  IgaLocation? get currentLocation => _igaLocation;

  bool get firstPlayerRegisterWorkDone => _firstPlayerRegisterWorkDone;
  bool get singlePlayerGame => _singlePlayerGame;
  bool get firstPlayerRegistered => _firstPlayerRegistered;

  void setTrueFirstPlayerRegisterWorkStatus({bool forceValue = true}) =>
      _firstPlayerRegisterWorkDone = forceValue;

  void backFirstPlayerRegisterWorkStatus() => _firstPlayerRegisterWorkDone = false;

  void incrementCurrentLocation() {
    _igaLocation = currentLocation!.copyWith(
        igaLocationGameCount: currentLocation!.igaLocationGameCount! + 1);
  }

  void incrementChatBot() {
    _igaLocation = currentLocation!.copyWith(
        igaChatBotClickCounter:
        (currentLocation!.igaChatBotClickCounter ?? 0) + 1);
  }

  Future<void> igaSetCurrentLocation(WidgetRef ref) async {
    final snapshot = await FirebaseIgaCollectionEnumsWithField
        .iga_locations.reference
        .where("igaLocationPhoneId",
        isEqualTo: ref.read(igaBackGroundManager.notifier).igaTableDeviceId)
        .get();

    if (snapshot.docs.isNotEmpty) {
      _igaLocation = IgaLocation.fromJson(
          snapshot.docs.first.data() as Map<String, dynamic>);
    }
  }

  ///This function triggers when any game end.And then if user enter
  ///own info to inputs then we create IgaUser if hadn't create before
  Future<void> createResult(WidgetRef ref,
      {required double primaryScore,
        required double secondaryScore,
        bool isMultipleAndSecondPlayer = false,bool isSinglePlayerGame = false}) async {
    logger.i("Created Result");
    _singlePlayerGame = isSinglePlayerGame;
    final currentResultGameId = await nanoid(24);

    //No action so return
    if (primaryScore.toInt() == 0 || secondaryScore.toInt() == 0) {
      ref
          .read(currentIgaPageManager.notifier)
          .changState(IGAStates.onBoardingFour, ref: ref);
      logger.e("Return");
      return;
    }

    final game = ref.read(currentGameProv);

    if (((currentLocation?.igaLocationId != null || kDebugMode) && !isMultipleAndSecondPlayer)  || isSinglePlayerGame) {
      state = IgaGameResult(
        igaGameResultId: currentResultGameId,
        primaryScore: primaryScore,
        secondaryScore: secondaryScore,
        igaUserId: null,
        createdAt: DateTime.now().toUtc().toString().substring(0, 19),
        igaGameId: game?.id,
        igaLocationId: currentLocation?.igaLocationId ?? "Demo",
      );
    } else {
      _secondPlayerGameResult = IgaGameResult(
        igaGameResultId: currentResultGameId,
        primaryScore: primaryScore,
        secondaryScore: secondaryScore,
        igaUserId: null,
        createdAt: DateTime.now().toUtc().toString().substring(0, 19),
        igaGameId: game?.id,
        igaLocationId: currentLocation?.igaLocationId ?? "Demo",
      );
    }
    logger.w("Game End Result : $state ${_secondPlayerGameResult == null}");
  }

  ///This function does create new user what ever enter data from user.
  Future<IgaUser?> createIgaUserAndMatchCurrentResult(WidgetRef ref,
      {required String email,
        required String userName,
        required String country,
        required String countryCode}) async {

    if(state!.primaryScore == null || state!.secondaryScore == null )
    {
      throw Exception("Primary or Secondary Score is null");
    }

    final isCreatedBeforeCheck =
    await checkBeforeCreateIgaUser(email, userName);

    if (isCreatedBeforeCheck) {
      CustomCatchpadDialogs.createdIgaUserBefore(ref.context, ref);
      return null;
    }
    //
    final igaUserId = await nanoid(28);

    ref
        .read(currentIgaTraceManager.notifier)
        .setIgaTraceUserId(ref: ref, igaUserId: igaUserId);


    final result = ref.watch(gameResultProv);


    final igaUser = IgaUser(
      igaUserId: igaUserId,
      igaGameResultId: state != null ? state!.igaGameId : result!.gameId,
      igaUserCountry: country.toLowerCase(),
      igaUserCountryCode: countryCode,
      igaUserCreatedAt: DateTime.now().toUtc().toString().substring(0, 19),
      igaUserEmail: email.toLowerCase(),
      igaUserName: userName.toLowerCase(),
      isDebugUser: kDebugMode,
      isEventUser: ref.read(eventIgaController),
      eventName: ref.read(eventIgaController) ? IgaConsts.igaEventName : null,
    );



    if(ref.read(eventIgaController)) {
      await FirebaseIgaCollectionEnumsWithField.iga_event.reference
          .doc(igaUserId)
          .set(igaUser.toJson());
    }


    // Add to iga users with result
    await FirebaseIgaCollectionEnumsWithField.iga_users.reference
        .doc(igaUserId)
        .set(igaUser.toJson());

    IgaGameResult? igaGameResult = state ?? IgaGameResult(
      igaGameId: result!.gameId,
    );

    state = igaGameResult;




    if (!firstPlayerRegisterWorkDone) {
      igaGameResult = state!.copyWith(
        igaUserId: igaUserId,
        igaGameId: state != null ? state!.igaGameId : result!.gameId,
        primaryScore: state!.primaryScore,
        secondaryScore: state!.secondaryScore,
        igaLocationId: currentLocation?.igaLocationId ?? "demo",
        igaUsername: userName.toLowerCase(),
        igaUserCountryCode: countryCode,
      );
      logger.i("First Player Result: $igaGameResult");

      _firstPlayerRegistered = true;
    } else {
      igaGameResult = _secondPlayerGameResult!.copyWith(
        igaUserId: igaUserId,
        igaGameId: state != null ? state!.igaGameId : result!.gameId,
        igaLocationId: currentLocation?.igaLocationId ?? "demo",
        secondaryScore: _secondPlayerGameResult!.secondaryScore,
        primaryScore: _secondPlayerGameResult!.primaryScore,
        igaUsername: userName.toLowerCase(),
        igaUserCountryCode: countryCode,
      );
      logger.i("Second Player Result: $igaGameResult");
      state = igaGameResult;
    }

    //TODO IF CURRENT GAME FORMULA YARISI THEN ADD TO SECOND PLAYER RESULT

    await FirebaseIgaCollectionEnumsWithField.iga_results.reference
        .doc(FirebaseIgaCollectionEnumsWithField.iga_result_games.name)
        .collection(igaGameResult.igaGameId!)
        .doc(!firstPlayerRegisterWorkDone
        ? igaGameResult.igaGameResultId
        : "${igaGameResult.igaGameResultId}-2")
        .set(igaGameResult.toJson());

    //TODO IF CURRENT GAME FORMULA YARISI DONt NEED TO THIS FUNCTION
    if (!firstPlayerRegisterWorkDone) {
      if(!kDebugMode){
        await FirebaseIgaCollectionEnumsWithField.iga_locations.reference
            .doc(currentLocation?.igaLocationId ?? "demo")
            .update(currentLocation!
            .copyWith(
            igaLastGameId: state!.igaGameResultId,
            allPadOk: true,
            igaLastGameInfoId: igaGameResult.igaGameId,
            updatedAt: DateTime.now().toString().substring(0, 19))
            .toJson());
      }

    } else if (firstPlayerRegisterWorkDone &&
        secondPlayerGameResult != null &&
        secondPlayerGameResult!.primaryScore! < state!.primaryScore!) {
      if(!kDebugMode){
        await FirebaseIgaCollectionEnumsWithField.iga_locations.reference
            .doc(currentLocation!.igaLocationId)
            .update(currentLocation!
            .copyWith(
            igaLastGameId: secondPlayerGameResult!.igaGameResultId,
            allPadOk: true,
            igaLastGameInfoId: igaGameResult.igaGameId,
            updatedAt: DateTime.now().toString().substring(0, 19))
            .toJson());
      }

    }

    final igaGameInfoSnapshot = await FirebaseIgaCollectionEnumsWithField
        .iga_games.reference
        .doc(state != null ? state!.igaGameId : result!.gameId)
        .get();

    final igaGameInfo = IgaGameInfo.fromJson(
        igaGameInfoSnapshot.data() as Map<String, dynamic>);

    final newPrimaryAverage =
        ((igaGameInfo.gameCount! * igaGameInfo.primaryAverage!.toDouble()) +
            igaGameResult.primaryScore!) /
            (igaGameInfo.gameCount! + 1);

    final newSecondaryAverage =
        ((igaGameInfo.gameCount! * igaGameInfo.secondaryAverage!.toDouble()) +
            igaGameResult.secondaryScore!) /
            (igaGameInfo.gameCount! + 1);

    await FirebaseIgaCollectionEnumsWithField.iga_games.reference
        .doc(state!.igaGameId)
        .set(igaGameInfo
        .copyWith(
        gameCount: igaGameInfo.gameCount! + 1,
        primaryAverage: newPrimaryAverage,
        igaLastGameId: igaGameResult.igaGameResultId,
        igaGameId: igaGameInfo.igaGameId,
        secondaryAverage: newSecondaryAverage)
        .toJson());

    return igaUser;
  }

  Future<bool> checkBeforeCreateIgaUser(String email, String userName) async {
    // Firestore sorgusuyla e-posta adresine sahip kullanıcıların sayısını alıyoruz
    final resEmailCount = await FirebaseIgaCollectionEnumsWithField
        .iga_users.reference
        .where("igaUserEmail", isEqualTo: email.toLowerCase())
        .get()
        .then((querySnapshot) => querySnapshot.size);

    // Firestore sorgusuyla kullanıcı adına sahip kullanıcıların sayısını alıyoruz
    final resUserNameCount = await FirebaseIgaCollectionEnumsWithField
        .iga_users.reference
        .where("igaUserName", isEqualTo: userName.toLowerCase())
        .get()
        .then((querySnapshot) => querySnapshot.size);

    // Eğer e-posta veya kullanıcı adı daha önceden kullanılmışsa false döndür
    if (resEmailCount > 0 || resUserNameCount > 0) {
      return true;
    }

    // Varsayılan olarak false döndür
    return false;
  }

  Future<IgaLocation?> getCurrentLocation(WidgetRef ref) async {
    return null;
  }

  Future<bool> createCurrentLocation(WidgetRef ref,
      {required String locationId, required String locationName}) async {
    //
    // final phoneId = ref.read(currentDeviceInformationManager)!.deviceId!;
    //
    // final igaLocation = IgaLocation(
    //   igaLocationId: locationId,
    //   igaLocationName: locationName,
    //   igaLocationPhoneId: phoneId,
    //   igaLastGameId: "",
    //   igaLocationGameCount: 0,
    // );
    //
    // await FirebaseIgaCollectionEnumsWithField.iga_locations.reference.doc(igaLocation.igaLocationId).set(igaLocation.toJson());
    //
    return false;
  }

  Future<bool> createIgaGame(WidgetRef ref) async {
    // final phoneId = ref.read(currentDeviceInformationManager)!.deviceId!;
    // // case 's16':
    // // return _igaFormulaDikkatDikkatDinleYakala(results);
    // // case 's14':
    // // case '84':
    // // case '80':
    // // return _igaFormulaDikkatDikkatDinleYakala(results, needCounter: true);
    // // case 's1':
    // // return _formulaYarisi(results);
    // // case 's35':
    // // return bulBakalim(results, needCounter: true);
    // // case 's4':
    // // return _teamWork(results);
    // final s16 = IgaGameInfo(
    //   igaGameId: 's16',
    //   primaryAverage: 0.0,
    //   secondaryAverage: 0.0,
    //   gameCount: 0
    // );
    //     await FirebaseIgaCollectionEnumsWithField.iga_games.reference.doc(s16.igaGameId).set(s16.toJson());
    // final s14 = IgaGameInfo(
    //     igaGameId: 's14',
    //     primaryAverage: 0.0,
    //     secondaryAverage: 0.0,
    //     gameCount: 0
    // );
    //     await FirebaseIgaCollectionEnumsWithField.iga_games.reference.doc(s14.igaGameId).set(s14.toJson());
    // final seksendort = IgaGameInfo(
    //     igaGameId: '84',
    //     primaryAverage: 0.0,
    //     secondaryAverage: 0.0,
    //     gameCount: 0
    // );
    //     await FirebaseIgaCollectionEnumsWithField.iga_games.reference.doc(seksendort.igaGameId).set(seksendort.toJson());
    // final sesen = IgaGameInfo(
    //     igaGameId: '80',
    //     primaryAverage: 0.0,
    //     secondaryAverage: 0.0,
    //     gameCount: 0
    // );
    //     await FirebaseIgaCollectionEnumsWithField.iga_games.reference.doc(sesen.igaGameId).set(sesen.toJson());
    // final s1 = IgaGameInfo(
    //     igaGameId: 's1',
    //     primaryAverage: 0.0,
    //     secondaryAverage: 0.0,
    //     gameCount: 0
    // );
    //     await FirebaseIgaCollectionEnumsWithField.iga_games.reference.doc(s1.igaGameId).set(s1.toJson());
    // final s35 = IgaGameInfo(
    //     igaGameId: 's35',
    //     primaryAverage: 0.0,
    //     secondaryAverage: 0.0,
    //     gameCount: 0
    // );
    //     await FirebaseIgaCollectionEnumsWithField.iga_games.reference.doc(s35.igaGameId).set(s35.toJson());
    // final s4 = IgaGameInfo(
    //     igaGameId: 's4',
    //     primaryAverage: 0.0,
    //     secondaryAverage: 0.0,
    //     gameCount: 0
    // );
    //     await FirebaseIgaCollectionEnumsWithField.iga_games.reference.doc(s4.igaGameId).set(s4.toJson());
    //
    return false;
  }

  void clearCurrentResultGame() => state = null;
}

// Telegram banned from IGA so we can't use it anymore

// final stringBuffer = StringBuffer();
//
// stringBuffer.write("Yeni Kullanıcı Kaydı Gerçekleştirildi!\n");
// stringBuffer.write("Kullanıcı Adı: $userName\n");
// stringBuffer.write("Kullanıcı E-mail: $email\n");
//
// TelegramManager.instance!
//     .sendIGAMobilePeriodicallyReport(stringBuffer.toString(), ref);
// stringBuffer.clear();