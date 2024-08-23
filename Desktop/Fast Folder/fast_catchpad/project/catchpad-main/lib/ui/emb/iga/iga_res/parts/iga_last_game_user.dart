import 'package:catchpad/data/api/telegram/telegram_manager.dart';
import 'package:catchpad/models/emb/iga/games/iga_game_info.dart';
import 'package:catchpad/models/emb/iga/games/iga_game_result.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/ui/emb/iga/iga_res/parts/rank_plate.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/emb/iga/iga_consts.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/util_widgets/util_information_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'iga_rank_detail.dart';

class IgaLastGameUser extends ConsumerStatefulWidget {
  final String selectedGameId;

  const IgaLastGameUser({
    required this.selectedGameId,
    super.key,
  });

  @override
  ConsumerState createState() => _IgaLastGameUserState();
}

class _IgaLastGameUserState extends ConsumerState<IgaLastGameUser> {
  @override
  Widget build(BuildContext context) => _body(context);

  Expanded _body(BuildContext context) {
    final inst = L10n.inst(context);

    return Expanded(
      flex: 10,
      child: Column(
        children: [
          liveLastGameOnCurrentLocation(ref),
          const Gap(8),
          _reactionInfo(
              context: context,
              reactionTime: 125,
              totalPersons: 12,
              gameId: widget.selectedGameId),
        ],
      ),
    );
  }

  StreamBuilder<IgaGameResult?> liveLastGameOnCurrentLocation(WidgetRef ref) {
    return StreamBuilder<IgaGameResult?>(
        stream: ref
            .read(currentIgaLeaderboardManager.notifier)
            .listenCurrentLocationLastGame(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(color: CpColors.cpPrimary);
          }

          if (!snapshot.hasData) {
            return const SizedBox();
          }

          if (snapshot.hasError) {
            return TextButton(
                onPressed: () => TelegramManager.instance!.sendMobileReportMessage(
                    "Oynanan Son Sonuç Gösteriminde Hata Gerçekleşti Bu bildirim kullanıcı tarafından butona basılmıştır!",
                    ref),
                child: Text(
                  "Sorun Bildir",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: CpColors.red),
                ));
          }

          final gameResult = snapshot.data;

          return Column(
            children: [
              FutureBuilder<int?>(
                future: ref
                    .watch(currentIgaLeaderboardManager.notifier)
                    .getUserRank(gameResult!.igaUserId!, gameResult.igaGameId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                        color: CpColors.cpPrimary);
                  }

                  if (snapshot.hasError) {
                    return TextButton(
                        onPressed: () => TelegramManager.instance!
                            .sendMobileReportMessage(
                                "Oynanan Son Sonuç Gösteriminde Hata Gerçekleşti Bu bildirim kullanıcı tarafından butona basılmıştır!",
                                ref),
                        child: Text(
                          "Sorun Bildir",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: CpColors.red),
                        ));
                  }

                  final rank = snapshot.data;

                  return RankPlate(rank: rank ?? 1, size: 130);
                },
              ),
              FutureBuilder<Map<String, dynamic>>(
                  future: ref
                      .read(currentIgaLeaderboardManager.notifier)
                      .compareWithAverage(
                          gameResult.primaryScore?.toDouble() ?? 0.0,locationGameId: gameResult.igaGameId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator.adaptive();
                    }

                    if (snapshot.hasError) {
                      return TextButton(
                          onPressed: () => TelegramManager.instance!
                              .sendMobileReportMessage(
                                  "Oynanan Son Sonuç Gösteriminde Hata Gerçekleşti Bu bildirim kullanıcı tarafından butona basılmıştır!",
                                  ref),
                          child: Text(
                            "Sorun Bildir",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(color: CpColors.red),
                          ));
                    }


                    return RankDetail(
                        name: gameResult.igaUsername ?? "**",
                        isPercentageAbove: snapshot.data!["isUnder"],
                        percentage: snapshot.data!["percentage"] != null &&
                                !(snapshot.data!["percentage"] as double)
                                    .isNaN &&
                                !(snapshot.data!["percentage"] as double)
                                    .isInfinite
                            ? (snapshot.data!["percentage"] as double)
                                .abs()
                                .toInt()
                            : 0,
                        reactionTime: gameResult.primaryScore?.toInt() ?? 0,
                        countryCode: gameResult.igaUserCountryCode ?? "TR",
                      gameId: gameResult.igaGameId ?? 's16',);
                  }),
            ],
          );
        });
  }

  FutureBuilder<IgaGameInfo?> _reactionInfo(
      {required BuildContext context,
      required int totalPersons,
      required int reactionTime,
      required String gameId}) {
    return FutureBuilder<IgaGameInfo?>(
        future: ref
            .read(currentIgaLeaderboardManager.notifier)
            .getGameInfo(forceGameId: gameId,ref: ref),
        builder: (context, snapshotData) {

          if (snapshotData.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(color: CpColors.cpPrimary);
          }

          final gameInfo = snapshotData.data;

          return Container(
            width: double.infinity,
            height: 15.h,
            decoration: BoxDecoration(
                color: CpColors.cpChineseBlack,
                border: Border.all(
                  width: 0.2,
                  color: CpColors.cpDavysGrey,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(18))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10.w,
                  child: Center(
                    child: Text(
                      L10n.inst(context).number_of_participate,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),
                ),
                CustomCpInformationCards.buildBasicBox(
                    boxText: gameInfo?.gameCount.toString() ?? "-",
                    backgroundColor: CpColors.cpDavysGrey,
                    isColored: false,
                    fontSize: 12.sp,
                    insidePadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    isNewVersion: true,
                    context: context),
                Text(
                  L10n.inst(context).activity_default_scores_average_duration,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white, fontSize: 12.sp),
                ),
                CustomCpInformationCards.buildBasicBox(
                    fontSize: 12.sp,
                    boxText: '${gameInfo?.primaryAverage?.toInt() ?? "-"}',
                    backgroundColor: CpColors.cpDavysGrey,
                    isColored: false,
                    isNewVersion: true,
                    boxType: BoxType.ms,
                    context: context),
              ],
            ),
          );
        });
  }
}
