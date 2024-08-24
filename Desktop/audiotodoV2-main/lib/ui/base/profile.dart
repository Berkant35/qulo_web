import 'package:audiotodo/ui/base/parts/profile_parts/personal_info.dart';
import 'package:audiotodo/utilities/components/drawer/profil_drawer.dart';
import 'package:audiotodo/utilities/constants/enums/utilities/time_frames.dart';
import 'package:audiotodo/utilities/constants/extensions/icon_size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../generated/l10n.dart';
import '../../utilities/components/charts/daily_meets_chart.dart';
import '../../utilities/components/containers/custom_bar_container.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({
    super.key,
  });

  @override
  ConsumerState createState() => _ProfilState();
}

class _ProfilState extends ConsumerState<Profile> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const ProfileDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: profileHeader()),
          Expanded(
              flex: 14,
              child: SizedBox(
                width: 100.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 7, child: PersonalInfoHeader()),
                      Expanded(
                          flex: 8,
                          child: DailyMeetsChart(
                            timeFrame: TimeFrame.last7Days,
                          )),
                      // Expanded(flex: 8, child: Container(color: Colors.pink,)),
                      Spacer(
                        flex: 1,
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Center profileHeader() {
    return Center(
        child: GestureDetector(
      onTap: () => _key.currentState!.openDrawer(),
      onLongPress: () => _key.currentState!.openDrawer(),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 1.5.w,
          ),
          IconButton(
              onPressed: () => _key.currentState!.openDrawer(),
              icon: Icon(
                Icons.menu,
                size: IconSizeExtension.medium.sizeValue,
              )),
          Center(child: CustomBarContainer(text: S.current.profil)),
          SizedBox(
            width: 16.5.w,
          )
        ],
      ),
    ));
  }
}
