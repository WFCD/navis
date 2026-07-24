import 'dart:async';

import 'package:arbi_api/arbi_api.dart';
import 'package:cache/cache.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:http_client/http_client.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart' hide Storage;
import 'package:item_repository/items_repository.dart';
import 'package:navis/app/app.dart';
import 'package:navis/firebase_options.dart';
import 'package:navis/router/app_router.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:settings_repository/settings_repository.dart';
import 'package:storage/storage.dart';
import 'package:warframe_api/warframe_api.dart';
import 'package:warframe_common/warframe_common.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

typedef BootstrapBuilder = FutureOr<Widget> Function(AppRouter);

Future<void> bootstrap(BootstrapBuilder builder) async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final appDir = await getApplicationSupportDirectory();
  final cacheDir = await getApplicationCacheDirectory();

  Hive
    ..init(appDir.path)
    ..init(cacheDir.path);

  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: HydratedStorageDirectory(cacheDir.path));

  final routeObserver = RouteObserver<ModalRoute<void>>();
  final router = AppRouter(navigatorKey: GlobalKey<NavigatorState>(), observer: routeObserver);
  final client = SentryHttpClient(client: await buildNativeClient(), captureFailedRequests: true);

  final warframeApi = WarframeApi(client);
  final arbitrationApi = ArbiApi(client);
  final itemsClient = WarframeItemsClient(client: client);

  final settings = await Storage.open<dynamic>('settings', appDir.path);
  final itemStore = await Storage.open<Map<dynamic, dynamic>>('items', appDir.path);
  final cacheStore = await Storage.open<Map<dynamic, dynamic>>('cache', cacheDir.path);

  final cacheManager = CacheManager(cacheStore);

  final settingsRepository = SettingsRepository(settings);
  final itemsRepository = ItemsRepository(itemsClient, cacheManager, itemStore);
  final worldstateRepository = WorldstateRepository(cacheManager, warframeApi, arbitrationApi);
  final profileRepository = ProfileRepository(warframeApi, cacheManager, itemStore);

  await profileRepository.buildXpInfo();

  runApp(
    AppBootstrap(
      routeObserver: routeObserver,
      settingsRepository: settingsRepository,
      notificationRepository: NotificationRepository(),
      itemsRepository: itemsRepository,
      worldstateRepository: worldstateRepository,
      profileRepository: profileRepository,
      child: await builder(router),
    ),
  );
}
