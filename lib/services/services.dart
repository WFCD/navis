import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';

import 'crashlytics_service.dart';
import 'drop_data_service.dart';
import 'localstorage_service.dart';
import 'permission_service.dart';
import 'worldstate.dart';

GetIt locator = GetIt();

Future<void> setupLocator({http.Client client, bool isTest = false}) async {
  locator.registerSingleton<LocalStorageService>(
      await LocalStorageService.getInstance());

  if (!isTest) {
    locator.registerSingleton<DropTableService>(
        await DropTableService.initilizeTable());
  }

  locator.registerSingleton<FirebaseMessaging>(FirebaseMessaging());
  locator.registerSingleton<CrashlyticsService>(CrashlyticsService());
  locator.registerSingleton<WorldstateAPI>(WorldstateAPI(client: client));
  locator.registerSingleton<PermissionsService>(PermissionsService());

  if (!isTest) {
    locator.registerSingleton<PackageInfo>(await PackageInfo.fromPlatform());
  }
}
