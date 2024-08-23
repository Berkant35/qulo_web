import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading/loading.dart';

import '../../utils/cp_colors.dart';
import '../../utils/utils.dart';
import '../widgets/default_bg.dart';
import 'auth_top_part_widget.dart';
import 'login_form_body.dart';
import 'register_form_body.dart';
/* 
 */

class AuthPageWrapper extends ConsumerStatefulWidget {
  const AuthPageWrapper({Key? key, required this.type}) : super(key: key);
  final AuthPageType type;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthPageWrapperState();
}

class _AuthPageWrapperState extends ConsumerState<AuthPageWrapper> {
  AuthPageType get type => widget.type;
  @override
  Widget build(BuildContext context) {
    final body =
        type.isLogin ? const LoginFormBody() : const RegisterFormBody();

    return WillPopScope(
      onWillPop: () async {
        // TODO: for some reason the go_router
        // redirection has a behaviour of pushing
        // and not replacing this route. we need
        // to look into that later.

        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          child: Container(),
          preferredSize: Size.zero,
        ),
        body: Loading(
          child: DefaultBg(
            child: SafeArea(
              child: CustomScrollView(
                slivers: <Widget>[
                  // if keyboard is open, then we dont wanna show
                  // this widget
                  KeyboardVisibilityBuilder(
                    builder: (context, isKeyboardVisible) {
                      if (isKeyboardVisible) {
                        return const SliverPadding(padding: EdgeInsets.zero);
                      }
                      return SliverAppBar(
                        expandedHeight: 220,
                        // it is displaying a back button,
                        // which we do not want to show
                        leading: const SizedBox(),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            decoration: const BoxDecoration(
                              color: CpColors.button2Color,
                            ),
                            child: const AuthTopPartWidget(),
                          ),
                        ),
                      );
                    },
                  ),
                  SliverFillRemaining(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.all(defPaddingSize),
                        child: body,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/* class AuthPageWrapper extends ConsumerWidget {
  
  @override
  
}
 */