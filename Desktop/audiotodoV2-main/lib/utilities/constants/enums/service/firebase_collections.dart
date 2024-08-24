import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollectionEnums {
  users,
  version,
  close_accounts,
  contact_us,
  admin_emails,
  errors,
  meets;

  CollectionReference get reference =>
      FirebaseFirestore.instance.collection(name);

  DocumentReference get versionReference => FirebaseFirestore.instance
      .collection(name)
      .doc("version_info");
}
