import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:market_repository/market_repository.dart';
import 'package:navis/app/app.dart';
import 'package:navis/firebase_options.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:user_settings/user_settings.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}), ${change.runtimeType}');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}), $error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  await Hive.initFlutter();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  if (!kIsWeb) await FlutterWebBrowser.warmup();

  final appDir = kIsWeb
      ? HydratedStorage.webStorageDirectory
      : await getApplicationDocumentsDirectory();

  final storage = await HydratedStorage.build(storageDirectory: appDir);

  final usersettings = await UserSettings.initSettings(appDir.path);
  final warframestateCache = await WarframestatCache.initCache(appDir.path);
  final marketCache = await MarketCache.initCache(appDir.path);
  final notificationRepo = NotificationRepository();

  final worldstateRepo = WorldstateRepository(
    settings: usersettings,
    cache: warframestateCache,
  );
  final marketRepo = MarketRepository(
    usersettings: usersettings,
    cache: marketCache,
  );

  await HydratedBlocOverrides.runZoned(
    () async {
      runApp(
        UserSettingsWidget(
          settings: usersettings,
          child: DependenciesProvider(
            notifications: notificationRepo,
            worldstateRepository: worldstateRepo,
            marketRepository: marketRepo,
            child: BlocProviders(
              solsystemCubit: SolsystemCubit(worldstateRepo),
              darvodealCubit: DarvodealCubit(worldstateRepo),
              child: await builder(),
            ),
          ),
        ),
      );
    },
    storage: storage,
    blocObserver: AppBlocObserver(),
  );
}
