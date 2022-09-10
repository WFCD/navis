import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:market_repository/market_repository.dart';
import 'package:navis/firebase_options.dart';
import 'package:navis/worldstate/cubits/darvodeal_cubit.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  final storage = await HydratedStorage.build(storageDirectory: appDir);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FlutterWebBrowser.warmup();

  final app = await _startProviders(await builder());
  HydratedBlocOverrides.runZoned(
    () => runApp(app),
    storage: storage,
    blocObserver: AppBlocObserver(),
  );
}

Future<Widget> _startProviders(Widget app) async {
  final appDir = await getApplicationDocumentsDirectory();
  final temp = await getTemporaryDirectory();

  final usersettings = await UserSettings.initSettings(appDir.path);
  final warframestateCache = await WarframestatCache.initCache(temp.path);
  final marketCache = await MarketCache.initCache(temp.path);

  final usprovider = UserSettingsNotifier(usersettings);
  final notificationRepo = NotificationRepository();
  final worldstateRepo = WorldstateRepository(
    settings: usersettings,
    cache: warframestateCache,
  );
  final marketRepo = MarketRepository(
    usersettings: usersettings,
    cache: marketCache,
  );

  return ChangeNotifierProvider.value(
    value: usprovider,
    child: MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: worldstateRepo),
        RepositoryProvider.value(value: marketRepo),
        RepositoryProvider.value(value: notificationRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => SolsystemCubit(worldstateRepo)..fetchWorldstate(),
          ),
          BlocProvider(create: (_) => DarvodealCubit(worldstateRepo))
        ],
        child: app,
      ),
    ),
  );
}
