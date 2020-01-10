import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/app.dart';
import 'package:path_provider/path_provider.dart';

import 'resources/storage/cache.dart';
import 'resources/storage/persistent.dart';
import 'widgets/wrappers/bloc_wrapper.dart';
import 'widgets/wrappers/repository_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  final appDir = await getApplicationDocumentsDirectory();
  final cacheDir = await getTemporaryDirectory();

  Hive.init(appDir.path);
  Hive.init(cacheDir.path);

  final persistent =
      PersistentResource(await Hive.openBox<dynamic>('persistent'));
  final cache = CacheResource(await Hive.openBox<dynamic>('cache'));

  BlocSupervisor.delegate = await HydratedBlocDelegate.build();

  runZoned<void>(() {
    runApp(
      RepositoryWrapper(
        persistentResource: persistent,
        cacheResource: cache,
        child: const BlocWrapper(child: Navis()),
      ),
    );
  }, onError: Crashlytics.instance.recordError);
}
