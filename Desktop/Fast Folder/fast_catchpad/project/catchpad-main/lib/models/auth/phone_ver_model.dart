import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../ui/auth/phone_ver_modal.dart';

final phoneVerProv = StateProvider<PhoneVerModel>((ref) => PhoneVerModel());

class PhoneVerModel {
  String? verificationId;
  int? forceResendingToken;

  PhoneVerModel({
    this.verificationId,
    this.forceResendingToken,
  });

  Future<T?> showCodeVerifyDialog<T>(BuildContext context) async {
    return await showMaterialModalBottomSheet<T>(
      context: context,
      builder: (context) => const PhoneVerModal(),
    );
  }
}
