import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/cp_colors.dart';
import '../../utils/utils.dart';
import '../widgets/cp_logo.dart';

enum AuthPageType { register, login }

extension CpAuthPageType on AuthPageType {
  bool get isLogin => this == AuthPageType.login;
}

final currentAuthPageType =
    StateProvider.autoDispose<AuthPageType>((ref) => AuthPageType.login);

class AuthTopPartWidget extends StatelessWidget {
  const AuthTopPartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(defPaddingSize * 2),
      child: Column(
        children: const [
          CpLogo(),
          _TopPartTitle(),
          // _AuthSwitcher(),
        ]
            .joinWidgetList(
              (e) => const SizedBox(height: defPaddingSize),
            )
            .toList(),
      ),
    );
  }
}

class _TopPartTitle extends ConsumerStatefulWidget {
  const _TopPartTitle({super.key});

  @override
  ConsumerState<_TopPartTitle> createState() => _TopPartTitleState();
}

class _TopPartTitleState extends ConsumerState<_TopPartTitle> {
  String get title {
    final type = ref.read(currentAuthPageType);

    final st = type.isLogin
        ? L10n.inst(context).form_welcome_back
        : L10n.inst(context).form_welcome_to_catchpad;

    return st;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline5,
    );
  }
}

const _radDegree = 15.0;

class OptionSwitchModel<T> {
  final String title;
  final T selectedValue;
  final T value;
  final void Function(T) onTap;

  bool get isSelected => selectedValue == value;

  const OptionSwitchModel({
    required this.title,
    required this.selectedValue,
    required this.value,
    required this.onTap,
  });
}

class OptionsSwitch<T> extends StatelessWidget {
  final Iterable<OptionSwitchModel<T>> models;
  final bool isSubtitle;
  const OptionsSwitch(this.models, {this.isSubtitle = false, super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final wid = isSubtitle ? width * 3 / 4 : width;
    return Container(
      width: wid - formsPaddingSize * 3,
      height: defPaddingSize * 4,
      decoration: BoxDecoration(
        color: CpColors.defBgColor,
        borderRadius: BorderRadius.circular(_radDegree),
      ),
      child: Container(
        margin: const EdgeInsets.all(4),
        child: _OptionsSwitchSwitch(models),
      ),
    );
  }
}

class _OptionsSwitchSwitch<T> extends StatelessWidget {
  final Iterable<OptionSwitchModel<T>> models;
  const _OptionsSwitchSwitch(this.models, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: models.map(
        (model) {
          return Expanded(
            child: GestureDetector(
              onTap: () => model.onTap(model.value),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: model.isSelected ? CpColors.authTopPartColor1 : null,
                  borderRadius: BorderRadius.circular(_radDegree),
                ),
                child: Text(
                  model.title,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}

// class _AuthSwitcher extends ConsumerWidget {
//   const _AuthSwitcher({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, ref) {
//     final map = {
//       AuthPageType.login: L10n.inst(context).form_login,
//       AuthPageType.register: L10n.inst(context).form_register,
//     };

//     final currentType = ref.watch(currentAuthPageType);

//     final models = map.entries.map(
//       (e) => OptionSwitchModel<AuthPageType>(
//         title: e.value,
//         selectedValue: currentType,
//         value: e.key,
//         onTap: (val) {
//           ref.read(currentAuthPageType.notifier).state = val;
//         },
//       ),
//     );

//     return OptionsSwitch(models);
//   }
// }
