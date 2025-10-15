import 'dart:async';

import 'package:codex/codex.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:http_client/http_client.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:navis/app/app_observer.dart';
import 'package:navis/app/widgets/bloc_bootstrap.dart';
import 'package:navis/app/widgets/repo_bootstrap.dart';
import 'package:navis/firebase_options.dart';
import 'package:navis/router/app_router.dart';
import 'package:navis/settings/settings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

typedef BootstrapBuilder = FutureOr<Widget> Function(AppRouter);

Future<void> bootstrap(BootstrapBuilder builder) async {
  final logger = Logger('Bootstrap')..info('Starting up services');
  final appDir = await getApplicationDocumentsDirectory();
  final temp = await getTemporaryDirectory();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter(temp.path);

  final settings = await UserSettings.initSettings(appDir.path);

  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: HydratedStorageDirectory(temp.path));

  final observer = RouteObserver<ModalRoute<void>>();
  final router = AppRouter(navigatorKey: GlobalKey<NavigatorState>(), observer: observer);
  final client = SentryHttpClient(
    client: await buildNativeClient(),
    // Get Default but also get what I think is cloudflare bot protection as a rough way of getting possibly affected installs
    failedRequestStatusCodes: [const SentryStatusCode.defaultRange(), SentryStatusCode(403)],
  );

  final database = await NavisDatabase.open(directory: appDir.path);
  final codex = Codex(database, client);

  logger.info('Booting up Navis');
  runApp(
    RepositoryBootstrap(
      routeObserver: observer,
      settings: settings,
      codex: codex,
      client: client,
      child: BlocBootstrap(child: await builder(router)),
    ),
  );

  await codex.initializeCodex();
}
