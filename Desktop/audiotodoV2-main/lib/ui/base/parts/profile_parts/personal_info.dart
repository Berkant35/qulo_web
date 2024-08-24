import 'package:audiotodo/core/theme/custom_colors.dart';
import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/main.dart';
import 'package:audiotodo/utilities/components/containers/info_containers.dart';
import 'package:audiotodo/utilities/components/sheets/sheets.dart';
import 'package:audiotodo/utilities/constants/extensions/context_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

part 'personal_info_mixin.dart';

class PersonalInfoHeader extends ConsumerStatefulWidget {
  const PersonalInfoHeader({
    super.key,
  });

  @override
  ConsumerState createState() => _PersonalInfoHeaderState();
}

class _PersonalInfoHeaderState extends ConsumerState<PersonalInfoHeader>
    with PersonalInfoMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: headerOne()),
        //Total meeting count and meeting total durations cards
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder<Map<String, int>>(
                future: countOfMeetings(),
                builder: (context, snapshot) {
                  //error
                  if (snapshot.hasError) {
                    return const Icon(Icons.error);
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator.adaptive());
                  }
                  // logger.i(snapshot.data.toString());
                  // totalMeetCount
                  // totalLast7Days

                  if (snapshot.hasData && snapshot.data != null) {
                    return InfoContainer(
                      title: S.current.meeting_count,
                      subTitle: snapshot.data!["totalMeetCount"].toString(),
                      titleSecond: S.current.last_7_days,
                      subTitleSecond:
                          snapshot.data!["totalLast7Days"].toString(),
                      iconData: Icons.meeting_room_sharp,
                    );
                  }

                  return const Icon(Icons.error);
                }),
            FutureBuilder<int>(
                future: totalDurationTime(),
                builder: (context, snapshot) {
                  //error
                  if (snapshot.hasError) {
                    return const Icon(Icons.error);
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: const CircularProgressIndicator.adaptive());
                  }

                  if (snapshot.hasData && snapshot.data != null) {
                    final duration = Duration(milliseconds: snapshot.data ?? 0);

                    return InfoContainer(
                      title: S.current.meeting_sum_record_time,
                      subTitle: "${duration.inHours} ${S.current.hours}\n${
                          //remain minute
                          duration.inMinutes - (duration.inHours * 60)} ${S.current.minute} \n${
                          //remain second
                          duration.inSeconds - (duration.inMinutes * 60)} ${S.current.second}",
                      iconData: Icons.punch_clock,
                    );
                  }

                  return const Icon(Icons.error);
                })
          ],
        ))
        // Expanded(child: headerTwo()),
      ],
    );
  }

  Widget headerOne() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        headerInfoCol(
            ref,
            "${ref.read(authManager)?.userName} ${ref.read(authManager)?.surName}",
            ref.read(authManager)?.email ?? "-"),
        InkWell(
            onTap: () =>
                Sheets.getImageFromGalleryOrCameraAndSetCurrentImage(ref),
            child: photoSection())
      ],
    );
  }

  Widget photoSection() {
    final currentUser = ref.watch(authManager);
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(1.w),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.w),
              border: Border.all(color: CustomColors.primaryColor, width: 0.5.w),
            ),
            child: currentUser != null
                ? CircleAvatar(
                    radius: 8.w,
                    backgroundColor: CustomColors.grey2Color.withOpacity(0.3),
                    child: currentUser.photoUrl == null ||
                            currentUser.photoUrl!.isEmpty
                        ? Center(
                            child: Text(
                            currentUser.userName!.substring(0, 1),
                          ))
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8.w),
                            child: CachedNetworkImage(
                              imageUrl: currentUser.photoUrl!,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ))
                : const SizedBox(),
          ),
        ),
        add()
      ],
    );
  }

  Positioned add() {
    return Positioned(
        bottom: MediaQuery.of(context).size.height > 800 ? -0.75.w : -2.9.w,
        right: MediaQuery.of(context).size.height > 800 ? -0.75.w : -2.9.w,
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add_circle_outlined,
              size: 6.w,
              color: CustomColors.accentColor,
            )),
      );
  }

  Row headerTwo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        headerInfoCol(ref, "Catchpad Anonim Şirketi", "Istanbul Turkey"),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit_outlined,
              size: 4.h,
              color: CustomColors.primaryColor,
            ))
      ],
    );
  }

  Widget headerInfoCol(WidgetRef ref, String infoOne, String infoTwo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          infoOne,
          style: ThemeValueExtension.headline6.copyWith(
              color: CustomColors.fillBlackElevationColor,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 0.5.h,
        ),
        Text(
          infoTwo,
          style: ThemeValueExtension.highBody.copyWith(
            color: CustomColors.profileGreyColor,
          ),
        ),
      ],
    );
  }
}
