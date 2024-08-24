import 'package:audiotodo/generated/l10n.dart';
import 'package:audiotodo/utilities/components/containers/custom_bar_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'parts/meets_parts/meet_list.dart';

class Plans extends ConsumerStatefulWidget {
  const Plans({
    super.key,
  });

  @override
  ConsumerState createState() => _PlansState();
}

class _PlansState extends ConsumerState<Plans> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
                textScaler: MediaQuery.of(context)
                    .textScaler
                    .clamp(minScaleFactor: 1, maxScaleFactor: 1.2)),
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Center(
                        child: CustomBarContainer(text: S.current.navbar_meets))),
                const Expanded(flex: 14, child: MeetList()),
              ],
            ),
          );
        },
      ),
    );
  }
}
