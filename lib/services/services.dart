import 'package:get_it/get_it.dart';
import 'package:navis/services/notification.dart';
import 'package:package_info/package_info.dart';

import 'crashlytics_service.dart';
import 'localstorage_service.dart';
import 'permission_service.dart';
import 'wfcd_api.dart';

GetIt locator = GetIt();

Future<void> setupLocator({bool isTest = false}) async {
  locator
      .registerSingleton<NotificationService>(NotificationService.initialize());

  locator.registerSingleton<LocalStorageService>(
      await LocalStorageService.getInstance());

  locator.registerSingleton<CrashlyticsService>(CrashlyticsService());
  locator.registerSingleton<WFCD>(WFCD());
  locator.registerSingleton<PermissionsService>(PermissionsService());

  if (!isTest) {
    locator.registerSingleton<PackageInfo>(await PackageInfo.fromPlatform());
  }
}
