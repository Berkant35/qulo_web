///This provider help us about any user connected to any pad anytime.

import 'package:catchpad/models/auth/register_user.dart';
import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/models/feedback/traces/connections/connection_by_customer.dart';
import 'package:catchpad/models/feedback/traces/connections/connection_log.dart';
import 'package:catchpad/prov/auth/current_user_prov.dart';
import 'package:device_information/device_information.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Yarım kalmış devam ettirilebilir.
class ConnectionByCustomerControlNotifier
    extends StateNotifier<ConnectionByCustomer?> {
  ConnectionByCustomerControlNotifier(ConnectionByCustomer? state)
      : super(null);

  void changState(ConnectionByCustomer? val) => state = val;

  Future<void> addConnectionLog(ConnectionLog log, WidgetRef ref) async {

    final currentUser = ref.read(currentUserProv) ?? RegisterUser(userName: "Faıled!");

    final currentConnectionByCustomerJson = await FirebaseCollectionEnums
        .pad_connection_checks.reference
        .doc(currentUser.uid)
        .get();

    final connectionByCustomer = currentConnectionByCustomerJson.data() != null
        ? ConnectionByCustomer.fromJson(
        currentConnectionByCustomerJson.data() as Map<String,dynamic>)
        :  ConnectionByCustomer(
        customerEmail: currentUser.email,
        connectionLogs: {},
        customerId: currentUser.uid,
        anyConnectionBefore: true
    );

    state = connectionByCustomer;

    final deviceModel = await DeviceInformation.deviceModel;

    log = log.copyWith(
      deviceModel: deviceModel
    );

    final connectionLogs = ConnectionMapLog.from(state?.connectionLogs ?? {});
    final isThereKey = connectionLogs.containsKey(log.macId);

    if (isThereKey) {
      connectionLogs.update(log.macId!, (value) => log);
    } else {
      connectionLogs.addAll({log.macId!: log});
    }


    state = connectionByCustomer;

    state = state!.copyWith(connectionLogs: connectionLogs);



  }
}
