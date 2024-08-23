import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:catchpad/prov/global_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

// TODO Animasyonu Belirle

// TODO Sesi Belirle Audio Manager zaten bulunmakta.

typedef AnimationPaths = Map<String, String>;
typedef AnimationSounds = Map<String, String>;

class AnimationKeyManagerNotifier extends StateNotifier<String?> {
  AnimationKeyManagerNotifier(String? state) : super(null);

  AnimationPaths animationPaths = {};
  AnimationSounds animationSounds = {};

  void setKey(String key, String animationPath, String animationSoundPath) {
    state = key;
    animationPaths.addAll({key: animationPath});
    animationSounds.addAll({key: animationSoundPath});
  }
}



class ShowAnimationNotifier extends StateNotifier<bool> {
  ShowAnimationNotifier(bool state) : super(false);

  Future<void> showSuccessDialog(BuildContext context) async {
    final alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      content: Lottie.asset(
        'assets/animation/lottie/good.json',
        repeat: false,
        filterQuality: FilterQuality.high,

      ),
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    );
    await Future.delayed(const Duration(milliseconds: 50));
    showDialog(
      context: context,
      barrierColor: Colors.transparent,

      builder: (BuildContext context) {
        return alertDialog;
      },
    ).then((value) {
      // This code will run after the dialog is closed
      debugPrint('Dialog closed');
    });
    await Future.delayed(const Duration(milliseconds: 1200));
    Navigator.of(context).pop();
  }
}
