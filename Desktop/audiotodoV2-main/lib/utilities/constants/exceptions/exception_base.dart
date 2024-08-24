



import 'package:audiotodo/utilities/constants/enums/service/firebase_collections.dart';
import 'package:flutter/foundation.dart';

abstract class ExceptionBase{
  static Future<void> sendExceptionToServer(String key,{String? title, String? description}) async {


    if(kDebugMode) return;

    final currentStackTrace = StackTrace.current.toString();

    FirebaseCollectionEnums.errors.reference.doc(key).collection("list").add(
      {
        "title": title,
        "description": description,
        "dateTime" : DateTime.now().toIso8601String(),
        "trace" : currentStackTrace
      }
    );
  }
}