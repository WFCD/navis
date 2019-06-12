import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:navis/services/crashlytics_service.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/worldstate.dart';
import 'package:package_info/package_info.dart';

GetIt locator = GetIt();

Future<void> setupLocator({http.Client client}) async {
  final messagingService = FirebaseMessaging();
  final localStorageService = await LocalStorageService.getInstance();
  final errorService = CrashlyticsService();
  final package = await PackageInfo.fromPlatform();

  locator.registerSingleton<FirebaseMessaging>(messagingService);
  locator.registerSingleton<LocalStorageService>(localStorageService);
  locator.registerSingleton<CrashlyticsService>(errorService);
  locator.registerSingleton(WorldstateAPI(client: client));
  locator.registerSingleton<PackageInfo>(package);
}
