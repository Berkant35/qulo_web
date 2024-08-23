import 'dart:ui';

import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IgaParameters extends ConsumerStatefulWidget {
  const IgaParameters({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IgaParametersState();
}

class _IgaParametersState extends ConsumerState<IgaParameters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () async {
          final registeredMail = await FirebaseIgaCollectionEnumsWithField
              .iga_users.reference
              .get()
              .then((value) {
            return value.docs.map((e) => e.data()).toList().length;
          });

          final cachedMail = await FirebaseIgaCollectionEnumsWithField
              .iga_cached_emails.reference
              .get()
              .then((value) {
            return value.docs.map((e) => e.data()).toList().length;
          });

          final chatbotMail = await FirebaseIgaCollectionEnumsWithField
              .iga_qr_chatbot_mails.reference
              .get()
              .then((value) {
            return value.docs.map((e) => e.data()).toList().length;
          });

          final gameCount = await FirebaseIgaCollectionEnumsWithField
              .iga_locations.reference
              .get()
              .then((value) async {
            print('---Game Counts---');
            int sum = 0;
            for (var element in value.docs) {
              if (element['igaLocationId'] == '0' ||
                  element['igaLocationId'] == '1' ||
                  element['igaLocationId'] == '2') {
                print(
                    '${element['igaLocationName']}: ${element['igaLocationGameCount']}');
                sum += element['igaLocationGameCount'] as int;
              }
            }
            print('Total: $sum');
            print('-----------------');
          });
          print('Kayıtlı mail: $registeredMail');
          print('Cached mail: $cachedMail');
          print('Chatbot mail: $chatbotMail');
        },
        child: const Text(
          'Fetch Data',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ));
  }
}
