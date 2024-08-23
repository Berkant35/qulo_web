import 'package:catchpad/models/enums/traces/play_traces_enum.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/utils.dart';

extension on EnviromentType {
  String textNotation(BuildContext context) {
    final inst = L10n.inst(context);

    switch (this) {
      case EnviromentType.real:
        return inst.enviroment_type_real;
      case EnviromentType.simulated:
        return inst.enviroment_type_simulated;
    }
  }
}

class EnviromentScreen extends ConsumerStatefulWidget {
  const EnviromentScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EnviromentScreen> createState() => _EnviromentScreenState();
}

class _EnviromentScreenState extends ConsumerState<EnviromentScreen> {
  @override
  void initState() {
    // initially we'll call this screen when there
    // is no enviroment set, so `enviroment` will be null.
    // but later on, we may put an option to open this
    // screen to reset the enviroment, so `enviroment`
    // will be set already.
    initialEnviroment = ref.read(enviromentProv);

    super.initState();
  }

  late EnviromentModel? initialEnviroment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(defPaddingSize),
          child: Column(
            children: [
              Text(
                L10n.inst(context).select_enviroment,
                style: Theme.of(context).textTheme.headline6,
              ),
              ...EnviromentType.values.map(_EnviromentLI.new).toList(),
            ].joinWidgetList((index) => const SizedBox(height: defPaddingSize)),
          ),
        ),
      ),
    );
  }
}

class _EnviromentLI extends ConsumerWidget {
  final EnviromentType enviromentType;

  const _EnviromentLI(this.enviromentType, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentEnviroment = ref.read(enviromentProv);

    return RadioListTile(
      value: enviromentType,
      groupValue: currentEnviroment?.enviromentType,
      onChanged: (e) {
        // there is a listener to `enviromentProv` provider in the device
        // list screen. so all we have to do is to update the
        // state, and the pop will happen automatically.

        // when the user selected Real enviroment,
        // we wanna just go on
        if (enviromentType == EnviromentType.real) {
          ref.read(enviromentProv.notifier).setEnviromentType(enviromentType);
          return;
        }
        // else, we wanna ask the user for the host and port of
        // the simulator enviroment.
        // FAR_FUTURE: soon when we get the simulator online, we'll
        // remove this part.
        showDialog(
          context: context,
          builder: (context) {
            const defHost =
                '192.168.0.10'; //10.34.0.66 Most used one is 192.168.0.10 home :172.20.10.6 personal hot spot| 192.168.1.46 annemlerin ev | meltemlerin iş yeri 10.10.10.80 // 10.34.1.150 ??
            const defPort = '49520';

            final hostController =
                TextEditingController(text: currentEnviroment?.ip ?? defHost);
            final portController =
                TextEditingController(text: currentEnviroment?.port ?? defPort);
            final formKey = GlobalKey<FormState>();

            return SingleChildScrollView(
              child: AlertDialog(
                title: Text(L10n.inst(context).simulator_enviroment),
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: hostController,
                        decoration:
                            InputDecoration(labelText: L10n.inst(context).host),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return L10n.inst(context).invalid_host;
                          }

                          return null;
                        },
                      ),
                      TextFormField(
                        controller: portController,
                        decoration:
                            InputDecoration(labelText: L10n.inst(context).port),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return L10n.inst(context).invalid_port;
                          }

                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  MaterialButton(
                    child: Text(L10n.inst(context).cancel),
                    onPressed: () async {
                      logger.i("Triggered!!!!!!!!!!!!");
                      Navigator.pop(context);
                    },
                  ),
                  MaterialButton(
                    child: Text(L10n.inst(context).ok),
                    onPressed: () {
                      if (formKey.currentState?.validate() != true) {
                        return;
                      }

                      final host = hostController.text;
                      final port = portController.text;

                      ref.read(enviromentProv.notifier).setEnviroment(
                            EnviromentModel(
                              enviromentType: enviromentType,
                              ip: host,
                              port: port,
                            ),
                          );
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      title: Text(enviromentType.textNotation(context)),
    );
  }
}
