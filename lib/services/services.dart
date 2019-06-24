import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:navis/services/crashlytics_service.dart';
import 'package:navis/services/drop_data_service.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/worldstate.dart';
import 'package:package_info/package_info.dart';

GetIt locator = GetIt();

Future<void> setupLocator({http.Client client, bool isTest = false}) async {
  locator.registerSingleton<LocalStorageService>(
      await LocalStorageService.getInstance());

  locator.registerSingleton<DropTableService>(
      await DropTableService.initilizeTable());

  locator.registerSingleton<FirebaseMessaging>(FirebaseMessaging());
  locator.registerSingleton<CrashlyticsService>(CrashlyticsService());
  locator.registerSingleton<WorldstateAPI>(WorldstateAPI(client: client));

  if (!isTest) {
    locator.registerSingleton<PackageInfo>(await PackageInfo.fromPlatform());
  }
}
