import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../managers/sticker_manager.dart';

class HarfleriGorWidget extends ConsumerWidget {
  final DeviceModel dev;
  const HarfleriGorWidget({
    required this.dev,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tex = StickerManager.idToStickerLetterTranslation(
        ref: ref, val: dev.deviceNumber!.toString(), isForGame: true)!;
    return Text(
      tex,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}

class SayilariGorWidget extends ConsumerWidget {
  final DeviceModel dev;
  const SayilariGorWidget({
    required this.dev,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      dev.deviceNumber!.toString(),
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
