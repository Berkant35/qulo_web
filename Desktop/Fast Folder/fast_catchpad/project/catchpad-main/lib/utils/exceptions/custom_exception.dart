import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VersionCustomException implements Exception {
  final String description;

  VersionCustomException(this.description);

  @override
  String toString() {
    return '$this $description';
  }
}


