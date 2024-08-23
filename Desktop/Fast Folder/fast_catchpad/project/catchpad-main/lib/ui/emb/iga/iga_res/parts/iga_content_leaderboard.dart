import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/emb/iga/iga_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../models/emb/iga/games/iga_game_result.dart';
import '../../../../../utils/util_widgets/util_localizations.dart';

class IgaContentLeaderboard extends ConsumerStatefulWidget {
  final List<IgaGameResult> igaGameResults;

  const IgaContentLeaderboard({super.key, required this.igaGameResults});

  @override
  ConsumerState createState() => _IgaContentLeaderboardState();
}

class _IgaContentLeaderboardState extends ConsumerState<IgaContentLeaderboard> {
  int selected = 1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.igaGameResults.length,
      itemBuilder: (BuildContext context, int index) {
        final perGameResult = widget.igaGameResults[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Container(
            width: 300,
            height: 55,
            decoration: BoxDecoration(
              color: perGameResult.igaGameResultId ==
                      ref
                          .watch(currentIgaLeaderboardManager.notifier)
                          .lastGame
                          ?.igaGameResultId
                  ? CpColors.cpPrimary
                  : CpColors.cpLead, //,
              border: Border.all(
                width: 1,
                color: CpColors.cpDavysGrey,
              ),
              borderRadius: BorderRadius.circular(20.0), // Kenar yuvarlatma
            ),
            child: ListTile(
              onTap: () {},
              title: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 2.5.w, bottom: 3),
                    child: Text(perGameResult.igaUsername ?? "-",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: perGameResult.igaGameResultId ==
                                    ref
                                        .watch(currentIgaLeaderboardManager
                                            .notifier)
                                        .lastGame
                                        ?.igaGameResultId
                                ? Colors.black
                                : Colors.white)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: Text(
                      '${perGameResult.primaryScore!.toInt()}ms',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: CpColors.cpTaupeGrey, fontSize: 11),
                    ),
                  ),
                ],
              ),
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 4),
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: UtilLocalizations.getCountryFlag(
                        perGameResult.igaUserCountryCode ?? "TR")),
              ),
              trailing: Container(
                width: 2.w,
                height: 2.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: CpColors.cpTaupeGrey, // Çerçeve rengi
                    width: 1.0, // Çerçeve genişliği
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0), // Kenar yuvarlatma
                  child: Center(
                    child: Text(
                      (index + 4).toString(),
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: CpColors.cpTaupeGrey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
