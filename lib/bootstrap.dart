import 'dart:async';

import 'package:arbi_api/arbi_api.dart';
import 'package:cache/cache.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:http_client/http_client.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart' hide Storage;
import 'package:item_repository/items_repository.dart';
import 'package:logging/logging.dart';
import 'package:navis/app/app_observer.dart';
import 'package:navis/app/widgets/bloc_bootstrap.dart';
import 'package:navis/app/widgets/repo_bootstrap.dart';
import 'package:navis/firebase_options.dart';
import 'package:navis/router/app_router.dart';
import 'package:navis/settings/settings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:storage/storage.dart';
import 'package:warframe_api/warframe_api.dart';
import 'package:warframe_common/warframe_common.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

typedef BootstrapBuilder = FutureOr<Widget> Function(AppRouter);

Future<void> bootstrap(BootstrapBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final appDir = await getApplicationSupportDirectory();
  final cacheDir = await getApplicationCacheDirectory();

  Hive
    ..init(appDir.path)
    ..init(cacheDir.path);

  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: HydratedStorageDirectory(cacheDir.path));

  final observer = RouteObserver<ModalRoute<void>>();
  final router = AppRouter(navigatorKey: GlobalKey<NavigatorState>(), observer: observer);
  final client = SentryHttpClient(client: await buildNativeClient(), captureFailedRequests: true);

  final settings = await UserSettings.initSettings();
  final cacheManager = CacheManager(storage: await Storage.open('cache', cacheDir.path));

  final itemsRepository = ItemsRepository(
    WarframeItemsClient(client: client),
    cacheManager,
    await Storage.open('items', appDir.path),
  );

  final worldstateRepository = WorldstateRepository(cacheManager, WarframeApi(client), ArbiApi(client));

  logger.info('Booting up Navis');
  runApp(
    RepositoryBootstrap(
      routeObserver: observer,
      settings: settings,
      codex: codex,
      repository: repository,
      child: BlocBootstrap(child: await builder(router)),
    ),
  );

  // All calls for items will fallback to the API so its alright to deffer this and let the app warm up
  Timer(const Duration(seconds: 3), repository.autoUpdateCodex);
}
