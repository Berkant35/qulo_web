

class AppUpdateInfo {
  String currentVersion;
  bool forceUpdate;
  String storeLink;

  AppUpdateInfo({
    required this.currentVersion,
    required this.forceUpdate,
    required this.storeLink,
  });

  factory AppUpdateInfo.fromJson(Map<String, dynamic> json) {
    return AppUpdateInfo(
      currentVersion: json['currentVersion'],
      forceUpdate: json['forceUpdate'],
      storeLink: json['storeLink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentVersion': currentVersion,
      'forceUpdate': forceUpdate,
      'storeLink': storeLink,
    };
  }
}
