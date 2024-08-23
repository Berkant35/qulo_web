import 'dart:async';

import 'package:catchpad/models/enums/product/variants_type.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';

import '../models/game/attachment/attachment.dart';
import '../prov/game/curr_game_prov.dart';
import '../utils/audio_files.dart';
import '../utils/utils.dart';

final cpAudioPlayerProv = Provider<_CpAudioPlayer>(
  (ref) => _CpAudioPlayer(ref),
);

class _CpAudioPlayer {
  final Ref ref;
  late FlutterSoundPlayer _player;

  _CpAudioPlayer(this.ref) {
    _player = FlutterSoundPlayer();
  }


  FlutterSoundPlayer get player => _player;
  bool _inited = false;

  bool get isGameAudioEnabled {
    final controls = ref.read(currentGameSetupProv)?.controlsSetup;
    final audioSetup = controls?.gameAudioControls;
    final isE = audioSetup?.gameAudioSetup?.isEnabled;

    return isE ?? false;
  }

  bool get isMusicEnabled {
    final controls = ref.read(currentGameSetupProv)?.controlsSetup;
    final audioSetup = controls?.gameAudioControls;
    final isE = audioSetup?.musicSetup?.isEnabled;

    return isE ?? false;
  }

  bool get isSoundEffectsEnabled {
    final controls = ref.read(currentGameSetupProv)?.controlsSetup;
    final audioSetup = controls?.gameAudioControls;
    final isE = audioSetup?.soundEffectsSetup?.isEnabled;

    return isE ?? false;
  }

  bool isEnabled(Attachment attachment) {
    switch (attachment.audioType) {
      case GameAudioType.music:
        return isMusicEnabled;
      case GameAudioType.soundEffect:
        return isSoundEffectsEnabled;
      case GameAudioType.gameAudio:
        return isGameAudioEnabled;
      case GameAudioType.force:
        return isGameAudioEnabled;
      default:
        return false;
    }
  }

  Future<bool> init(Attachment att, {bool isForce = false}) async {
    if (!isEnabled(att) && !isForce) {
      return true;
    }

    if (!_inited) {
      try {
        if (_player.isOpen()) {
          await _player.closePlayer();
        } else {
          await _player.openPlayer();
        }

        _inited = true;
      } catch (e) {
        logger.e(e.toString());
      }
    }

    return _inited;
  }

  Future<bool> _open(Attachment att, {bool isForce = false}) async {
    if (!isEnabled(att) && !isForce) {
      return true;
    }

    try {
      final p = await _player.openPlayer();
      if (p == null) {
        return false;
      }
      _player = p;
      return true;
    } catch (e) {
      logger.e(e.toString());
      return false;
    }
  }

  Future<bool> resume(Attachment att) async {
    if (!isEnabled(att)) {
      return true;
    }

    final _init = await init(att);
    if (_init) {
      final isOpen = _player.isOpen();
      final isPaused = _player.isPaused;

      if (isOpen && isPaused) {
        try {
          await _player.resumePlayer();
          return true;
        } catch (e) {
          logger.e(e.toString());
          return false;
        }
      } else {
        try {
          final pl = await play(att);
          return pl;
        } catch (e) {
          logger.e(e.toString());
          return false;
        }
      }
    }

    return false;
  }

  Future<bool> customPlay(Attachment att) async {
    try {
      final resultInit = await init(att, isForce: true);
      final resultOpen = await _open(att, isForce: true);
      if (resultInit && resultOpen) {
        final buffer = await rootBundle.load(att.filePath);

        try {
          final dur = await _player.startPlayer(
            fromDataBuffer: buffer.buffer.asUint8List(),
            codec: audiosCodec,
          );


          if (dur != null) {

            await Future.delayed(dur);
          }
          return true;
        } catch (e) {
          logger.e(e.toString());
          return false;
        }
      }
    } catch (e) {
      logger.e(e.toString());
      return false;
    }

    return false;
  }

  Future<bool> play(Attachment att, {bool forceEnable = false,Codec? customCodec}) async {
    if (!isEnabled(att) && !forceEnable) {
      return true;
    }

    try {
      if (await init(att,isForce: forceEnable) && await _open(att,isForce: forceEnable)) {
        final buffer = await rootBundle.load(att.filePath);

        try {
          final dur = await _player.startPlayer(
            fromDataBuffer: buffer.buffer.asUint8List(),
            codec: customCodec ?? audiosCodec,
          );

          if (dur != null) {
            await Future.delayed(dur);
          }
          return true;
        } catch (e) {
          logger.e(e.toString());
          return false;
        }
      }
    } catch (e) {
      logger.e(e.toString());
      return false;
    }

    return false;
  }

  Future<bool> playBuzz() => play(AudioFiles.wrongBuzzAttachment);

  Future<bool> raceStart() => play(AudioFiles.raceStartSoundAttachment);

  Future<bool> triggerStart(BuildContext context) {
    logger.w(
        "Play trigger ${L10n.inst(context).localeName}  ${AudioFiles.triggerCounterAttachmentTR.audioType.toString()}");

    return play(L10n.inst(context).localeName == 'tr'
        ? AudioFiles.triggerCounterAttachmentTR
        : AudioFiles.triggerCounterAttachmentEN,forceEnable: true);
  }

  Future<bool> playSuccess() => play(AudioFiles.successAttachment);

  Future<bool> playPerfect() => customPlay(AudioFiles.perfect);

  Future<bool> playAmazing() => customPlay(AudioFiles.goodjob);

  Future<bool> playBad() => customPlay(AudioFiles.notbad);

  Future<bool> playExcellent() => customPlay(AudioFiles.excellent);

  Future<bool> playRocky() => customPlay(AudioFiles.rocky);

  Future<bool> playDemo() => customPlay(AudioFiles.demo);
  Future<bool> playPsy() => customPlay(AudioFiles.psy);

  Future<bool> playCountDown() => customPlay(AudioFiles.igaCountDown);

  Future<bool> playDong() => customPlay(AudioFiles.dong);


  Future<bool> pause() async {
    try {
      VariantsType.PRO.getModeNumber();
      await _player.pausePlayer();
      return true;
    } catch (e) {
      logger.e(e.toString());
      return false;
    }
  }

  Future<bool> dispose() async {
    try {
      await _player.stopPlayer();
      await _player.closePlayer();
      return true;
    } catch (e) {
      logger.e(e.toString());
      return false;
    }
  }

  Future<void> get done async {
    await Future.doWhile(
      () async {
        await Future.delayed(Duration.zero);

        return _player.isPlaying;
      },
    );
  }
}
