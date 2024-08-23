import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

class GiveRateControlNotifier extends StateNotifier<bool> {
  GiveRateControlNotifier(bool state) : super(false);

  String _gameId = "";

  String get gameId => _gameId;

  void changState(bool val) => state = val;

  void changeGameId(String gameId) => _gameId = gameId;

}
