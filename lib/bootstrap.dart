import 'dart:async';

import 'package:feedback_sentry/feedback_sentry.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:market_repository/market_repository.dart';
import 'package:navis/app/app_observer.dart';
import 'package:navis/firebase_options.dart';
import 'package:navis/worldstate/cubits/darvodeal_cubit.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:user_settings/user_settings.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FlutterWebBrowser.warmup();
  await Hive.initFlutter();

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

  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: appDir);
  runApp(
    ChangeNotifierProvider.value(
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
            BlocProvider(create: (_) => DarvodealCubit(worldstateRepo)),
          ],
          child: BetterFeedback(child: await builder()),
        ),
      ),
    ),
  );
}
