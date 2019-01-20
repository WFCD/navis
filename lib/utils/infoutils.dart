import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

class Infoutils {
  final String deviceModel;
  final String androidVersion;
  final String appVersion;

  factory Infoutils() {
    final deviceInfo = DeviceInfoPlugin();
    String androidVersion, appVersion, deviceModel;

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appVersion = packageInfo.version;
    });

    deviceInfo.androidInfo.then((data) {
      deviceModel = data.model;
      androidVersion = data.version.release;
    });

    return Infoutils._(androidVersion, appVersion, deviceModel);
  }

  Infoutils._(this.androidVersion, this.appVersion, this.deviceModel);
}
