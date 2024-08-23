import 'package:catchpad/prov/global_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../utils/utils.dart';
import 'widgets/buttons/cp_button_1.dart';
import 'widgets/cp_logo.dart';
import 'widgets/default_bg.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inst = L10n.inst(context);
    return Scaffold(
      body: DefaultBg(
        child: Container(
          margin: const EdgeInsets.all(defPaddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(child: CpLogo()),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  L10n.inst(context).welcome_screen_tag,
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                child: Row(
                  children: [
                    CpButton1(
                      onPressed: () {
                        context.push('/register');
                      },
                      fullWidth: true,
                      child: Text(
                        L10n.inst(context).form_register,
                      ),
                    ),

                    // CpButton1(
                    //   onPressed: () {
                    //     GoRouter.of(context).goNamed(RouteTable.rLogin);
                    //     ref.read(firstEnteringProv.notifier).state = false;
                    //     AppSettings.setFirstEntering(false);
                    //   },
                    //   fullWidth: true,
                    //   child: Text(
                    //     L10n.inst(context).form_login,
                    //   ),
                    // ),
                  ]
                      .map(
                        (e) => Expanded(child: e),
                      )
                      .joinWidgetList(
                        (e) => const SizedBox(width: defPaddingSize),
                      ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: defPaddingSize),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          inst.form_already_have,
                          style: const TextStyle(color: Colors.white24),
                        ),
                        TextButton(
                            onPressed: () {
                              context.push('/login');
                            },
                            child: Text(inst.form_login))
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: InkWell(
                  onTap: () {
                    //start url for privacy policy+
                    ref
                        .read(currentVersionManager.notifier)
                        .launchUrlX(Uri.parse(L10n.inst(context).privacy_url));
                  },
                  child: Text(
                    L10n.inst(context).privacy_policy_title,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ].joinWidgetList(
              (index) => const SizedBox(height: defPaddingSize * 5),
            ),
          ),
        ),
      ),
    );
  }
}
