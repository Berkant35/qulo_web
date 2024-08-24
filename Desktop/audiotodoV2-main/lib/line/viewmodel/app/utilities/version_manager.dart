import 'package:audiotodo/main.dart';
import 'package:audiotodo/models/app/version_model.dart';
import 'package:audiotodo/utilities/constants/enums/service/firebase_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';


class VersionManagerNotifier extends StateNotifier<String?> {
  VersionManagerNotifier(String? state) : super(null);

  Future<void> initializeGetApplicationVersion(WidgetRef ref) async {
    final packageInfo = await PackageInfo.fromPlatform();

    state = packageInfo.version;
    _checkDbForUpdateAndLaunch(ref);
  }

  Future<bool> _checkDbForUpdateAndLaunch(WidgetRef ref) async{
    final snapshotVersion =
    await FirebaseCollectionEnums.version.versionReference.get();

    final appUpdateInfo =
    AppUpdateInfo.fromJson(snapshotVersion.data() as Map<String, dynamic>);



    if(appUpdateInfo.currentVersion != state && appUpdateInfo.forceUpdate){
      //launch Url
      _launchUrl(appUpdateInfo.storeLink);
      // throw VersionCustomException("Please update your app to the latest version");
    }

    return false;
  }

  Future<void> _launchUrl(String baseUrl) async {
    if (!await launchUrl(Uri.parse(baseUrl))) {
      throw Exception('Could not launch $baseUrl');
    }
  }
}
