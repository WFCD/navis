import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/app/app_observer.dart';
import 'package:navis/app/widgets/bloc_bootstrap.dart';
import 'package:navis/app/widgets/repo_bootstrap.dart';
import 'package:navis/firebase_options.dart';
import 'package:navis/router/app_router.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_hive/sentry_hive.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

typedef BootstrapBuilder = FutureOr<Widget> Function(AppRouter);

Future<void> bootstrap(BootstrapBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();

  final appDir = await getApplicationDocumentsDirectory();
  final temp = await getTemporaryDirectory();

  final settings = await UserSettings.initSettings(appDir.path);
  final cache = await SentryHive.openBox<CachedItem>('cache');

  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await SentryHydratedStorage.build(storageDirectory: temp);

  final observer = RouteObserver<ModalRoute<void>>();
  final router = AppRouter(navigatorKey: GlobalKey<NavigatorState>(), observer: observer);

  final observer = RouteObserver<ModalRoute<void>>();
  final router = AppRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    observer: observer,
  );

  runApp(
    RepositoryBootstrap(
      settings: settings,
      cache: cache,
      routeObserver: observer,
      child: BlocBootstrap(child: await builder(router)),
    ),
  );
}
