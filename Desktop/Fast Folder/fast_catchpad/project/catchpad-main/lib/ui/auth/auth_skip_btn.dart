import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../widgets/buttons/cp_button_2.dart';
import 'auth_top_part_widget.dart';

class AuthSkipButton extends StatelessWidget {
  final AuthPageType type;
  const AuthSkipButton(this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CpButton2(
      onPressed: () async {
        final auth = FirebaseAuth.instance;

        await auth.signInAnonymously();
        // GoRouter.of(context).go(RouteTable.initialLocation);
      },
      child: Text(
        type.isLogin
            ? L10n.inst(context).form_continue_without_login
            : L10n.inst(context).form_continue_without_register,
      ),
      fullWidth: true,
    );
  }
}
