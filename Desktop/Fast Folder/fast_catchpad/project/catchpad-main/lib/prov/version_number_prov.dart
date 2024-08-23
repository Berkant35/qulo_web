import 'package:catchpad/models/enums/firebase/collenction_enums.dart';
import 'package:catchpad/models/version_model.dart';
import 'package:catchpad/utils/settings/version_manager.dart';
import 'package:catchpad_flutter_lib/catchpad_flutter_lib.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/enums/platform_enum.dart';

class VersionNumberNotifier extends StateNotifier<VersionManager> {
  VersionNumberNotifier(VersionManager state)
      : super(VersionManager(deviceValue: "", databaseValue: ""));

  // Uygulama sürümünü kontrol eder ve mağazaya yönlendirir veya güncelleme yapar.
  Future<void> checkAndGoToStoreOrApp(WidgetRef ref) async {

    // Veritabanındaki sürüm numarasını alır.
    final databaseValueFromFirebase = await getDatabaseDeviceNumber();

    // Veritabanında değer yoksa mağazaya yönlendirir.
    if (databaseValueFromFirebase == null ||
        databaseValueFromFirebase.version!.isEmpty) {
      final Uri _url = Uri.parse(PlatformEnum.storeLink);
      launchUrlX(_url);
    } else {
      state.databaseValue = databaseValueFromFirebase.version!;
    }

    // Cihazdaki sürüm numarasını alır.
    state.deviceValue = (await getDeviceVersionNumber())!;

    // Güncelleme kontrolü yapar ve güncelleme gerekiyorsa mağazaya yönlendirir.
    if (state.isNeedUpdate())
    {
      logger.i("Database Link:${databaseValueFromFirebase!.link}");

      final Uri _url = Uri.parse(databaseValueFromFirebase!.link!);
      launchUrlX(_url);
    }

    return;
  }

  // URL'yi başlatır.
  Future<void> launchUrlX(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  // Veritabanındaki sürüm numarasını alır.
  Future<VersionModel?> getDatabaseDeviceNumber() async {
    final response = await FirebaseCollectionEnums.version.reference
        .withConverter<VersionModel>(
        fromFirestore: (snapshot, options) =>
            VersionModel.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson())
        .doc(PlatformEnum.versionName)
        .get();

    return response.data()!;
  }

  // Cihazdaki sürüm numarasını alır.
  Future<String?> getDeviceVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    //logger.i("Device Version:${packageInfo.version}");
    return packageInfo.version;
  }
}
