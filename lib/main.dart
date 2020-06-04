import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/app.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/services/storage/cache_storage.service.dart';
import 'package:navis/services/storage/persistent_storage.service.dart';
import 'package:package_info/package_info.dart';

void main() {
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runZonedGuarded(startApp, Crashlytics.instance.recordError);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

Future<void> startApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cache = CacheStorageService();
  final persistent = PersistentStorageService();

  await cache.startInstance();
  await persistent.startInstance();

  final repository =
      Repository(persistent, cache, await PackageInfo.fromPlatform());

  BlocSupervisor.delegate = await HydratedBlocDelegate.build();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(create: (_) => NavigationBloc()),
        BlocProvider<SearchBloc>(create: (_) => SearchBloc(repository)),
        BlocProvider<WorldstateBloc>(
          create: (context) {
            return WorldstateBloc(
              api: Repository.warframestat,
              persistent: persistent,
              cache: cache,
            );
          },
        ),
      ],
      child: Navis(repository),
    ),
  );
}
