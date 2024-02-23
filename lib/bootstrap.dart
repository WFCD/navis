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
import 'package:navis/settings/settings.dart';
import 'package:navis/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();

  final appDir = await getApplicationDocumentsDirectory();
  final settings = await UserSettings.initSettings(appDir.path);
  final warframestateCache = await WarframestatCache.initCache(appDir.path);

  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await SentryHydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  runApp(
    RepositoryBootstrap(
      settings: settings,
      warframestatCache: warframestateCache,
      child: BlocBootstrap(child: await builder()),
    ),
  );
}
