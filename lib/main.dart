import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/app.dart';
import 'package:path_provider/path_provider.dart';

import 'repository/repositories.dart';
import 'resources/storage/storage_resources.dart';

Future<void> main() async {
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  WidgetsFlutterBinding.ensureInitialized();

  final appDir = await getApplicationDocumentsDirectory();
  final cacheDir = await getTemporaryDirectory();

  Hive.init(appDir.path);
  Hive.init(cacheDir.path);

  final persistent =
      PersistentResource(await Hive.openBox<dynamic>('persistent'));
  final cache = CacheResource(await Hive.openBox<dynamic>('cache'));

  const dropTableApi = DropTableRepository();

  BlocSupervisor.delegate = await HydratedBlocDelegate.build();

  runZoned<void>(() async {
    runApp(
      MultiRepositoryProvider(
        providers: <RepositoryProvider>[
          RepositoryProvider<PersistentResource>.value(value: persistent),
          RepositoryProvider<CacheResource>.value(value: cache),
          RepositoryProvider<WorldstateRepository>(
            create: (_) => const WorldstateRepository(),
          ),
          RepositoryProvider<DropTableRepository>.value(value: dropTableApi)
        ],
        child: const NavisApp(),
      ),
    );

    // Run after the app us loaded this way it doesn't get in the way
    // if it doesn't load.
    await dropTableApi.initDrops();
  }, onError: Crashlytics.instance.recordError);
}
