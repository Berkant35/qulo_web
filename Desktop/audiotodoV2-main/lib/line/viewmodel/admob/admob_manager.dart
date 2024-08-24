import 'package:audiotodo/line/viewmodel/global_providers.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobManager extends StateNotifier<bool> {
  AdmobManager() : super(false);

  late InterstitialAd _interstitialAd;
  bool _isAdLoaded = false;

  Future<void> initializeAds(WidgetRef ref) async {
    // AdMob ID'lerini belirleyin
    String adUnitId = kDebugMode
        ? dotenv.env['IOS_ADMOB_TEST']! // Test AdMob ID
        : dotenv.env['IOS_ADMOB_RELEASE']!; // Gerçek AdMob ID

    // Admin kontrolü ekleyin (admin kontrolü sağlanmış olmalı)
    bool isAdmin = ref.read(currentAdminControlState); // Admin kontrolü için bir mekanizma ekleyin

    if (isAdmin) {
      adUnitId = dotenv.env['IOS_ADMOB_TEST']!; // Test AdMob ID
    }

    await InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isAdLoaded = true;
          state = true;
        },
        onAdFailedToLoad: (error) {
          print('Ad failed to load: ${error.message}');
          _isAdLoaded = false;
          state = false;
        },
      ),
    );
  }

  void show(WidgetRef ref) {
    if (_isAdLoaded) {
      _interstitialAd.show();
      _interstitialAd.dispose();
      _isAdLoaded = false;
      initializeAds(ref); // Yeni bir reklam yüklemek için tekrar başlatıyoruz
    } else {
      print('Ad is not loaded yet.');
    }
  }
}
