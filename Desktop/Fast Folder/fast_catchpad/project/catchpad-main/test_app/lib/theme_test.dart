import 'package:catchpad/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:catchpad/ui/widgets/default_bg.dart';
import 'package:catchpad/ui/widgets/buttons/cp_button_1.dart';
import 'package:catchpad/ui/widgets/buttons/cp_button_2.dart';
import 'package:catchpad/ui/widgets/cp_switch.dart';
import 'package:catchpad/ui/widgets/cp_chip.dart';
import 'package:catchpad/ui/widgets/inputs/pass_field.dart';

class ThemeTestScreen extends StatelessWidget {
  const ThemeTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultBg(
        child: Container(
          margin: const EdgeInsets.all(defPaddingSize),
          child: ListView(
            children: [
              _Section(
                title: 'Text Fields',
                children: [
                  TextFormField(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ad Soyad',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: defPaddingSize),
                        child: TextFormField(),
                      ),
                    ],
                  ),
                  TextFormField(autofocus: true),
                  Builder(
                    builder: (context) {
                      final k = GlobalKey<FormState>();
                      Future.microtask(
                        () {
                          k.currentState?.validate();
                        },
                      );
                      return Form(
                        key: k,
                        child: TextFormField(validator: (e) => 'Error'),
                      );
                    },
                  ),
                  PassField(
                    field: TextFormField(),
                  ),
                ],
              ),
              _Section(
                title: 'Switch',
                children: [
                  for (var e in [null, (_) {}])
                    for (var b in [false, true])
                      CpSwitch(value: b, onChanged: e),
                ],
              ),
              _Section(
                title: 'Buttons',
                children: [
                  CpButton1(
                    onPressed: () {},
                    child: const Text('Devam'),
                  ),
                  const CpButton1(
                    onPressed: null,
                    child: Text('Not Devam'),
                  ),
                  CpButton2(
                    onPressed: () {},
                    child: const Text('Devam'),
                  ),
                  const CpButton2(
                    onPressed: null,
                    child: Text('Not Devam'),
                  ),
                ],
              ),
              _Section(
                title: 'Chip',
                children: [
                  CpChip(
                    text: 'A selected one',
                    initialSelected: true,
                    onSelected: (_) {},
                  ),
                  CpChip(
                    text: 'An unselected one',
                    initialSelected: false,
                    onSelected: (_) {},
                  ),
                  const CpChip(
                    text: 'A selected but disabled one',
                    initialSelected: true,
                  ),
                  const CpChip(
                    text: 'An unselected but disabled one',
                    initialSelected: false,
                  ),
                ],
              ),
              _Section(
                title: 'Texts',
                children: [
                  Text(
                    'Harekete Geç',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    'Yeni nesil aktivite yöntemi Catchpad ile aktivitelerini iyileştir, kendini geliştir!',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ]/* .joinWidgetList(
              (e) => const SizedBox(
                height: defPaddingSize,
              ),
            ) */,
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _Section({
    required this.title,
    required this.children,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: defPaddingSize * 2),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
          const Divider(thickness: 2),
          ...children/* .joinWidgetList(
            (index) => const SizedBox(
              height: defPaddingSize,
            ),
          ), */
        ],
      ),
    );
  }
}
