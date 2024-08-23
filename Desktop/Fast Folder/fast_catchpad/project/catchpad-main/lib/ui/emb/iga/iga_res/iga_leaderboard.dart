import 'package:catchpad/data/api/telegram/telegram_manager.dart';
import 'package:catchpad/models/emb/iga/games/iga_game_result.dart';
import 'package:catchpad/prov/emb/emb_global_providers.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/ui/emb/iga/dialog/iga_dialogs.dart';
import 'package:catchpad/ui/emb/iga/iga_res/parts/iga_content_leaderboard.dart';
import 'package:catchpad/ui/emb/iga/iga_res/parts/iga_header_leaderboard.dart';
import 'package:catchpad/ui/emb/iga/iga_res/parts/iga_last_game_user.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:catchpad/utils/emb/iga/iga_enums.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:catchpad/utils/widgets/emb/iga/icons/iga_basic_back_icon.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../models/enums/traces/play_traces_enum.dart';
import '../../../../../prov/game/curr_game_prov.dart';

class IgaLeaderboardPage extends ConsumerStatefulWidget {
  const IgaLeaderboardPage({
    super.key,
  });

  @override
  ConsumerState createState() => _IgaLeaderboardPageState();
}

class _IgaLeaderboardPageState extends ConsumerState<IgaLeaderboardPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  var index = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    tabController = TabController(length: 6, vsync: this);
    if (ref.read(currentGiveRateManager)){
      Future((){
        IgaDialogs.giveRateDialog(context,ref);
      });
    }else{
      logger.i("Normal State");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Future(() {
      final currentGameId = ref.read(currentGameProv)?.id;
      final lastGameInfoId = ref.read(currentIgaResultManager.notifier).currentLocation?.igaLastGameInfoId;

      index = tabGameIds.indexOf(currentGameId ?? lastGameInfoId ?? 's16');
      if (index == -1) {
        index = 0; // Fallback to a default valid index
      }

      ref.read(currentIgaLeaderboardManager.notifier).changeState(
          ref,
          tabGameIds[index]
      );

      tabController.animateTo(index);

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final inst = L10n.inst(context);
    double width = 45.w;
    double height = 25.h;
    double firstHeight = 30.h;
    double firstdWidth = 15.w;
    int selected = 2;

    Future(() {
      if (ref.read(currentIgaTraceStateManager) == IgaPlayTraceStates.register) {
        ref.read(currentIgaTraceStateManager.notifier)
            .changState(IgaPlayTraceStates.leaderboard, ref: ref);
      }
    });
    logger.w("LeaderBoard!!!!!!!!!!");


    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: _igaLeaderboardAppBar(inst, context),
        backgroundColor: Colors.black54,
        body: leaderboard(
            width, height, context, firstdWidth, firstHeight, selected
        ),
      ),
    );
  }

  Column leaderboard(double width, double height, BuildContext context,
      double firstdWidth, double firstHeight, int selected) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 13,
              child: _leaderboard(
                  width, height, context, firstdWidth, firstHeight, selected),
            ),
            IgaLastGameUser(
                selectedGameId:
                ref.watch(currentIgaLeaderboardManager) ?? 's16'),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ],
    );
  }

  AppBar _igaLeaderboardAppBar(AppLocalizations inst, BuildContext context) {
    return AppBar(
      leadingWidth: 10.w,
      leading: GestureDetector(
        onTap: () {
          ref
              .read(currentIgaTraceStateManager.notifier)
              .changState(IgaPlayTraceStates.pre, ref: ref);
          ref
              .read(currentIgaPageManager.notifier)
              .changState(IGAStates.onBoardingOne, ref: ref);
        },
        child: IgaBasicBackIcon(
            onPressed: () => ref
                .read(currentIgaPageManager.notifier)
                .changState(IGAStates.onBoardingOne, ref: ref)),
      ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        inst.tool_tip_sorting_title,
        style: Theme.of(context)
            .textTheme
            .displayLarge!
            .copyWith(color: CpColors.cpPrimary, fontWeight: FontWeight.bold),
      ),
      bottom: TabBar(
          controller: tabController,
          labelStyle: Theme.of(context).textTheme.bodySmall,
          tabAlignment: TabAlignment.center,
          indicatorWeight: 2,
          onTap: (index) {
            ref
                .read(currentIgaLeaderboardManager.notifier)
                .changeState(ref, tabGameIds[index]);
            setState(() {});
          },
          dividerColor: Colors.transparent,
          labelColor: Colors.white,
          indicatorColor: CpColors.cpPrimary,
          tabs: tabs(inst)),
      toolbarHeight: 14.h,
    );
  }

  StreamBuilder _leaderboard(double width, double height, BuildContext context,
      double firstdWidth, double firstHeight, int selected) {
    return StreamBuilder<List<IgaGameResult>>(
        stream: ref
            .read(currentIgaLeaderboardManager.notifier)
            .igaGameResultsLeaderboard(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              width: 5.w,
              height: 5.w,
              child: const CircularProgressIndicator(
                color: CpColors.cpPrimary,
              ),
            );
          } else if (snapshot.hasError) {
            final stackTrace = StackTrace.current;

            TelegramManager.instance!.sendMobileReportMessage(
                "Sıralama yüklenirken bir hata ile karşılaşıldı\n${stackTrace.toString()}",
                ref);

            Future.delayed(
                const Duration(seconds: 5),
                    () => ref
                    .read(currentIgaPageManager.notifier)
                    .changState(IGAStates.home, ref: ref));

            return const Center(
              child: Text("Bir şeyler ters gitti"),
            );
          }

          final list = snapshot.data;

          int takeCount = list!.length >= 3 ? 3 : list.length;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(3.h),
              if (takeCount > 0)
                IgaHeaderLeaderboard(
                  igaGameResults: list.sublist(0, takeCount),
                ),
              Gap(3.h),
              if (list.isNotEmpty && list.length > 3)
                SizedBox(
                    height: 45.h,
                    width: 45.w,
                    child: IgaContentLeaderboard(
                      igaGameResults: list.sublist(3, list.length),
                    )),
            ],
          );
        });
  }

  static const tabGameIds = [
    's16',
    's1',
    's14',
    '84',
    's35',
    's4',
  ];

  List<Widget> tabs(AppLocalizations inst) {
    return [
      Tab(
        text: inst.game_title_16,
      ),
      Tab(
        text: inst.game_title_1,
      ),
      Tab(
        text: inst.game_title_14,
      ),
      Tab(
        text: inst.game_title_111,
      ),
      Tab(
        text: inst.game_title_35,
      ),
      Tab(
        text: inst.game_title_4,
      ),
    ];
  }
}