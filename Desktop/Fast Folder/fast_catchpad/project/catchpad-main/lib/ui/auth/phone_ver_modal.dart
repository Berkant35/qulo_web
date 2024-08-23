import '../../managers/auth_manager_new.dart';
import '../../prov/auth/current_user_prov.dart';
import '../../utils/route_table.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading/loading.dart';

import '../../models/auth/phone_ver_model.dart';
import '../../models/enums/auth/auth_error.dart';
import '../../utils/utils.dart';
import '../widgets/buttons/cp_button_1.dart';

class PhoneVerModal extends ConsumerStatefulWidget {
  const PhoneVerModal({Key? key}) : super(key: key);

  @override
  ConsumerState<PhoneVerModal> createState() => _PhoneVerModalState();
}

class _PhoneVerModalState extends ConsumerState<PhoneVerModal> {
  String code = '';

  final _formKey = GlobalKey<FormState>();

  Future<void> verify() async {
    final formState = _formKey.currentState;
    if (formState == null || formState.validate() != true) {
      return;
    }

    formState.save();

    final auth = FirebaseAuth.instance;

    EasyLoading.show();

    try {
      final verifier = ref.read(phoneVerProv);

      assert(verifier.verificationId != null);

      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifier.verificationId!,
        smsCode: code,
      );
      final result = await auth.signInWithCredential(credential);
      ref.read(currentUserCredential.notifier).state = result;
      context.go(RouteTable.rHomeScreen);
    } catch (e) {
      EasyLoading.dismiss();
      logger.e('Error in verify: $e');
      if (e is FirebaseAuthException) {
        final err = FireAuth.handleFirebaseAuthException(e);
        if (err == AuthError.invalidVerificationCode) {
          FireAuth.handleAuthError(context, err);

          code = '';
          _formKey.currentState?.reset();
          return;
        }
      }
    }

    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Loading(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            L10n.inst(context).form_phone_verification,
          ),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.all(defPaddingSize),
            child: Column(
              children: [
                Text(
                  L10n.inst(context).form_pls_enter_the_code_sent_to_your_phone,
                  style: Theme.of(context).textTheme.headline6,
                ),
                TextFormField(
                  maxLength: 6,
                  onChanged: (value) {
                    setState(() {
                      code = value;
                    });
                  },
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return L10n.inst(context).form_the_code_is_required;
                    }

                    final par = int.tryParse(value);

                    if (par == null || value.length != 6) {
                      return L10n.inst(context).form_the_code_is_not_valid;
                    }

                    return null;
                  },
                ),
                CpButton1(
                  onPressed: verify,
                  fullWidth: true,
                  child: Text(L10n.inst(context).form_verify),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
