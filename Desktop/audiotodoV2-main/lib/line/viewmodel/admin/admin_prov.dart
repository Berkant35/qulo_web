import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:audiotodo/utilities/constants/enums/service/firebase_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminControlNotifier extends StateNotifier<bool> {
  AdminControlNotifier(bool state) : super(false);

  void changState(bool val) => state = val;

  Future<void> initializeAdminControl(WidgetRef ref) async {
    final currentAuth = ref.read(authManager);
    if (currentAuth == null) return changState(false);
    final currentEmail = currentAuth.email;
    final adminIdListFromFirebase =
        await FirebaseCollectionEnums.admin_emails.reference.get();

    final adminEmailList =
        adminIdListFromFirebase.docs.map((e) => e['email']).toList();

    final isAdmin = adminEmailList.contains(currentEmail);

    changState(isAdmin);
  }
}
