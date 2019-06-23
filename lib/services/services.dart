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
  final localStorageService = await LocalStorageService.getInstance();
  final messagingService = FirebaseMessaging();
  final errorService = CrashlyticsService();

  locator.registerSingleton<FirebaseMessaging>(messagingService);
  locator.registerSingleton<LocalStorageService>(localStorageService);
  locator.registerSingleton<CrashlyticsService>(errorService);
  locator.registerSingleton<WorldstateAPI>(WorldstateAPI(client: client));

  final droptableService = await DropTableService.initilizeTable();
  locator.registerSingleton<DropTableService>(droptableService);

  if (!isTest) {
    final package = await PackageInfo.fromPlatform();
    locator.registerSingleton<PackageInfo>(package);
  }
}
