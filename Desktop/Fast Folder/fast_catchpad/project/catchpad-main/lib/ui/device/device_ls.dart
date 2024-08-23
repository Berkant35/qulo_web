import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../prov/permission_provider.dart';
import '../../utils/utils.dart';
import '../widgets/default_bg.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import 'device_list.dart';
import 'enviroment_screen.dart';
import 'permissions_screen.dart';

class DeviceLS extends ConsumerWidget {
  const DeviceLS({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultBg(
      child: FutureBuilder<bool>(
        future: PermissionManager.recheckAllAreGranted(ref),
        builder: (context, snp) {
          // we dont wanna use a loading widget here because this will
          // take a fraction of a second to load, so the loading widget
          // will disturb the ui
          if (!snp.hasData) return const SizedBox();

          // listen to the provider, so we can remove
          // permissions screen when they're all are granted
          ref.watch(permissionsProvider);

          final allGranted =
              snp.data == true || PermissionManager.allAreGranted(ref);

          if (!allGranted) {
            return const PermissionsScreen();
          }

          // now we're gonna do an enviroment check. if we're in prod,
          // we don't need to do anything. if we're in dev, we'll
          // check if we have an enviroment set. if it is not, we'll
          // show the enviroment screen.
          if (ref.watch(appSettingsToggleProvider).enableEnvironmentSelection) {
            // listen to the enviroment, so we can remove
            // enviroment screen when they're all are granted
            final enviroment = ref.watch(enviromentProv);

            if (enviroment == null) {
              return const EnviromentScreen();
            }
            return const DeviceList();
          }

          final bleStat = ref.watch(bleStatusProv);
          return bleStat.when(
            loading: LoadingWidget.new,
            error: ErrWidget.new,
            data: (stat) {
              if (stat != BleStatus.ready) {
                return const LoadingWidget();
              }

              return const DeviceList();
            },
          );
        },
      ),
    );
  }
}
