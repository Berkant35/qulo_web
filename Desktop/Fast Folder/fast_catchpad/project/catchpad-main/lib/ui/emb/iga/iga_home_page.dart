import 'package:catchpad/prov/global_providers.dart';
import 'package:catchpad/utils/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screenshot/screenshot.dart';

import 'buttons/wake_up_button.dart';

class IgaHomePage extends ConsumerStatefulWidget {
  const IgaHomePage({
    super.key,
  });

  @override
  ConsumerState createState() => _IgaHomePageState();
}

class _IgaHomePageState extends ConsumerState<IgaHomePage> {
  @override
  Widget build(BuildContext context) {
    return const WakeUpButton();
  }
}
