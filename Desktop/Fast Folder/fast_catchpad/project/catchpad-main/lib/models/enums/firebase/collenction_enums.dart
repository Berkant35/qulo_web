import 'package:cloud_firestore/cloud_firestore.dart';

Map<String, int> _requestCounterMap = {};

enum FirebaseCollectionEnums {
  admins,
  // ignore: constant_identifier_names
  game_results,
  logs,
  // ignore: constant_identifier_names
  pad_config,
  // ignore: constant_identifier_names
  product_groups,
  products,
  // ignore: constant_identifier_names
  serial_config,
  // ignore: constant_identifier_names
  usernamepool,
  users,
  emb_points,
  usersData,
  version,
  periods,
  demo_products,
  game_feed_back,
  ble_flow_tracker,
  melodies,
  main_traces,
  traces,
  custom_errors,
  pad_connection_checks,
  need_ota_pads,
  phone_operating_systems,
  catchpad_events,
  event_users,
  catchpad_event_results,
  products_error_status;

  CollectionReference get reference {
    _requestCounterMap.update(
      name,
      (value) => value + 1,
      ifAbsent: () => 1,
    );

    return FirebaseFirestore.instance.collection(name);
  }
}

enum FirebaseIgaCollectionEnumsWithField {
  catchpad_points,
  iga_error,
  iga,
  iga_users,
  iga_event,
  iga_qr_chatbot_mails,
  iga_cached_emails,
  iga_results,
  iga_result_games,
  iga_locations,
  iga_games,
  iga_rates,
  iga_traces;

  CollectionReference get igaErrorReference => FirebaseFirestore.instance.collection(FirebaseIgaCollectionEnumsWithField.catchpad_points.name)
      .doc(FirebaseIgaCollectionEnumsWithField.iga.name)
      .collection("iga_error");

  CollectionReference get reference => FirebaseFirestore.instance
      .collection(FirebaseIgaCollectionEnumsWithField.catchpad_points.name)
      .doc(FirebaseIgaCollectionEnumsWithField.iga.name)
      .collection(name)
      .doc(name.replaceAll("iga_", ""))
      .collection("list");
}

enum FirebaseCollectionEnumsWithDocuments {
  play_traces,
  error_traces,
  admin_traces,
  session_traces;

  CollectionReference get reference => FirebaseFirestore.instance
      .collection(FirebaseCollectionEnums.main_traces.name)
      .doc(name)
      .collection(FirebaseCollectionEnums.traces.name);
}
