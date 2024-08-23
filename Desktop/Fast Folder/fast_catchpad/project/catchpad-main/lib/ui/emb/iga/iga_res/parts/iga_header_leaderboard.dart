import 'package:catchpad/models/emb/iga/games/iga_game_result.dart';
import 'package:catchpad/ui/emb/iga/first_player.dart';
import 'package:catchpad/utils/cp_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../utils/util_widgets/util_localizations.dart';

class IgaHeaderLeaderboard extends ConsumerStatefulWidget {
  final List<IgaGameResult> igaGameResults;

  const IgaHeaderLeaderboard({super.key, required this.igaGameResults});

  @override
  ConsumerState createState() => _IgaHeaderLeaderboardState();
}

class _IgaHeaderLeaderboardState extends ConsumerState<IgaHeaderLeaderboard> {
  @override
  Widget build(BuildContext context) {
    double width = 45.w;
    double height = 25.h;
    double firstHeight = 30.h;
    double firstdWidth = 15.w;
    return SizedBox(
      width: width,
      height: 26.h,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: height / 2,
              width: width,
              decoration: BoxDecoration(
                color: CpColors.cpLead, // Container rengi
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                    color: CpColors.cpDavysGrey, // Çerçeve rengi
                    width: 1.0 // Çerçeve genişliği
                    ), // Kenar yuvarlatma
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        const Spacer(
                          flex: 3,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.igaGameResults.length > 1
                                  ? widget.igaGameResults[1].igaUsername
                                      .toString()
                                  : "-",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.white, fontSize: 12),
                            ),
                          ],

                        ),
                        Text(
                          widget.igaGameResults.length > 1
                              ? "${widget.igaGameResults[1].primaryScore!.toInt()} ms"
                              : "-",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: CpColors.cpPrimary,
                                  fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 6,
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      children: [

                        const Spacer(flex: 3,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.igaGameResults.length > 2
                                  ? widget.igaGameResults[2].igaUsername
                                      .toString()
                                  : "-",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.white, fontSize: 12),
                            ),
                          ],

                        ),
                        Text(
                          widget.igaGameResults.length > 2
                              ? "${widget.igaGameResults[2].primaryScore!.toInt()} ms"
                              : "-",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: CpColors.cpPrimary,
                                  fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: (width - firstdWidth) / 1.9,
            child: Container(
              width: firstdWidth,
              height: firstHeight * 0.6,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 45, 44, 44), // Container rengi
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                border: Border.all(
                  color: CpColors.cpDavysGrey, // Çerçeve rengi
                  width: 1.0, // Çerçeve genişliği
                ), // Kenar yuvarlatma
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Gap(6.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.igaGameResults.isNotEmpty
                            ? widget.igaGameResults.first.igaUsername.toString()
                            : "-",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white, fontSize: 12),
                      ),
                    ],

                  ),
                  Text(
                    widget.igaGameResults.isNotEmpty
                        ? "${widget.igaGameResults.first.primaryScore?.toInt()} ms"
                        : "-",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: CpColors.cpPrimary,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  )
                ],
              ),
            ),
          ),
          // Positioned(
          //   left: 5.25.w,
          //   bottom: 10.h,
          //   child: const CpCircleAvatar(
          //       size: 70, imagePath: 'https://picsum.photos/200', rank: "2"),
          // ),
          Positioned(
            left: 4.75.w,
            bottom: 10.h,

            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: Container(
                    padding: EdgeInsets.all(1.5.px),
                    decoration: BoxDecoration(
                        color: CpColors.cpPrimary,
                        borderRadius: BorderRadius.all(Radius.circular(60.px))),
                    child: UtilLocalizations.getCountryFlag(
                        widget.igaGameResults.length > 1
                            ? widget.igaGameResults[1].igaUserCountryCode
                            : "TR"),
                  ),
                ),
                Container(
                  width: 2.w,
                  height: 2.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CpColors.cpPrimary,
                    border: Border.all(
                      color: CpColors.cpPrimary, // Çerçeve rengi
                      width: 1.0, // Çerçeve genişliği
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(50.0), // Kenar yuvarlatma
                    child: Center(
                      child: Text(
                        '2',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: CpColors.cpChineseBlack,
                        ),
                      ),
                    ),
                  ),
                ),
              ],

            ),
          ),
          Positioned(
            bottom: 10.h,

            left: 18.55.w,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                FirstPlayer(
                  countryCode: widget.igaGameResults.isNotEmpty
                      ? widget.igaGameResults.first.igaUserCountryCode
                          .toString()
                      : "TR",
                ),
                Positioned(
                  bottom: 1.5.h,
                  child: Container(
                    width: 2.w,
                    height: 2.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CpColors.cpPrimary,
                      border: Border.all(
                        color: CpColors.cpPrimary, // Çerçeve rengi
                        width: 1.0, // Çerçeve genişliği
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(50.0), // Kenar yuvarlatma
                      child: Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: CpColors.cpChineseBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          Positioned(
            bottom: 10.h,

            left: 34.55.w,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  child: Container(
                    padding: EdgeInsets.all(1.5.px),
                    decoration: BoxDecoration(
                        color: CpColors.cpPrimary,
                        borderRadius: BorderRadius.all(Radius.circular(60.px))),
                    child:  UtilLocalizations.getCountryFlag(
                        widget.igaGameResults.length > 2
                            ? widget.igaGameResults[2].igaUserCountryCode!
                            : "TR"),
                  ),
                ),

                Container(
                  width: 2.w,
                  height: 2.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CpColors.cpPrimary,
                    border: Border.all(
                      color: CpColors.cpPrimary, // Çerçeve rengi
                      width: 1.0, // Çerçeve genişliği
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(50.0), // Kenar yuvarlatma
                    child: Center(
                      child: Text(
                        '3',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: CpColors.cpChineseBlack,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
