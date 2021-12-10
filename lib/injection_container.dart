import 'package:get_it/get_it.dart';
import 'package:market_repository/market_repository.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:user_settings/user_settings.dart';
import 'package:wfcd_client/wfcd_client.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  final appDir = await getApplicationDocumentsDirectory();

  // Core
  sl
    // ..registerSingletonAsync<EventInfoParser>(EventInfoParser.loadEventData)
    ..registerSingletonAsync<PackageInfo>(PackageInfo.fromPlatform)
    ..registerSingleton<NotificationRepository>(NotificationRepository())

    // Data sources
    ..registerSingletonAsync(() => UserSettings.initSettings(appDir.path))
    ..registerSingleton<WarframestatClient>(WarframestatClient())
    ..registerSingletonAsync<WarframestatCache>(
      () => WarframestatCache.initCache(appDir.path),
    )
    ..registerSingletonAsync(() => MarketCache.initCache(appDir.path));

  await sl.isReady<UserSettings>();
  await sl.isReady<WarframestatCache>();
  await sl.isReady<MarketCache>();

  // Repository
  sl
    ..registerSingleton<UserSettingsNotifier>(
      UserSettingsNotifier(sl<UserSettings>()),
    )
    ..registerSingleton<WorldstateRepository>(
      WorldstateRepository(
        settings: sl<UserSettings>(),
        cache: sl<WarframestatCache>(),
      ),
    )
    ..registerSingleton<MarketRepository>(
      MarketRepository(
        usersettings: sl<UserSettings>(),
        cache: sl<MarketCache>(),
      ),
    );
}
