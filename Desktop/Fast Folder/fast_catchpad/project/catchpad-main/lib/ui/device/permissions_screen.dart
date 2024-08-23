import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../prov/permission_provider.dart';
import '../../utils/utils.dart';
import '../widgets/buttons/cp_button_2.dart';

// TODO: work using bleStatusProv
class PermissionsScreen extends ConsumerStatefulWidget {
  const PermissionsScreen({super.key});

  @override
  ConsumerState<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends ConsumerState<PermissionsScreen>
    with WidgetsBindingObserver {
  @override
  // listen to changes in app state,
  // as we're going to redirect user to settings, so
  // we need to know when the app gets back in foreground,
  // so we can refresh the permissions
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      PermissionManager.recheckAllAreGranted(ref);
    }
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool inited = false;

  Future<void> init() async {
    if (inited) {
      return;
    }
    inited = true;

    final st = Stopwatch()..start();
    final perm = await PermissionManager.checkStatus(ref);
    SchedulerBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(permissionsProvider.notifier).updateList = perm;
      },
    );

    // this is a bit fast, but however,
    // the transition does not look smooth
    // so we wanna make the transition from
    // loading about 800ms
    if (st.elapsedMilliseconds < 800) {
      await Future.delayed(
          Duration(milliseconds: 800 - st.elapsedMilliseconds));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: (context, snp) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Builder(
              builder: (context) {
                if (snp.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final permP = ref.watch(permissionsProvider);
                Permission.bluetooth.request();
                Permission.bluetoothAdvertise.request();
                Permission.bluetoothConnect.request();

                Permission.bluetoothScan.request();
                Permission.bluetooth.status
                    .then((value) => logger.d(value.toString()));
                Permission.bluetoothAdvertise.status
                    .then((value) => logger.d(value.toString()));
                Permission.bluetoothConnect.status
                    .then((value) => logger.d(value.toString()));
                Permission.bluetoothScan.status
                    .then((value) => logger.d(value.toString()));

                return SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(defPaddingSize),
                    child: Column(
                      children: [
                        Text(
                          L10n.inst(context).permission_req_title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          L10n.inst(context).permission_req_desc,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        ...permP.map(_PerLI.new),
                      ].joinWidgetList(
                          (index) => const SizedBox(height: defPaddingSize)),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _PerLI extends ConsumerWidget {
  final PermissionModel model;

  const _PerLI(this.model, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          CpButton2(
            fullWidth: true,
            onPressed: model.isGranted
                ? null
                : () async {
                    // for the case permannetly denied,
                    // for some reason, when you request permission.status,
                    // it will return status.denied, however, request()
                    // will return status.permanentlyDenied

                    var newPer = model.copyWith(
                        permissions: <Permission, PermissionStatus>{});

                    for (var per in model.permissions.keys) {
                      final stat = await per.request();

                      newPer = newPer.copyWith(
                        permissions: Map<Permission, PermissionStatus>.from(
                            newPer.permissions)
                          ..[per] = stat,
                      );
                    }
                    // here is how this goes:
                    // denied: -> request -> deny -> nothing happens
                    // denied: -> request -> accept -> this screen disappears, as the caller
                    // will load its own content
                    // permanently denied: -> we open the settings, and observe app state change
                    // (the app coming to foreground again) and recheck the permissions, and rebuild
                    // accordingly.
                    if (newPer.anyPermanentlyDenied) {
                      // TODO: this doesnt open settings most of the time,
                      // test on release apk

                      if (model.type == PermissionType.bluetooth) {
                        final opened = await openAppSettings();

                        if (opened) {
                          logger.d('was able to open settings');
                        } else {
                          logger.d('was not able to open settings');
                        }
                      }
                    } else {
                      // there is a listener to this provider in the device
                      // list screen. so all we have to do is to update the
                      // state, and the pop will happen automatically.
                      ref.read(permissionsProvider.notifier).update(newPer);
                    }
                  },
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (model.icon != null) Icon(model.icon),
              Expanded(
                child: Text(model.type.permissionStr(context)),
              ),
            ]),
          ),
          if (model.anyPermanentlyDenied)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                L10n.inst(context).permanently_denied,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
        ],
      ),
    );
  }
}
