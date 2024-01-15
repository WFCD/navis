import 'dart:async';

import 'package:feedback_sentry/feedback_sentry.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/app/app_observer.dart';
import 'package:navis/firebase_options.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  // );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();

  final appDir = await getApplicationDocumentsDirectory();
  final temp = await getTemporaryDirectory();

  final usersettings = await UserSettings.initSettings(appDir.path);
  final warframestateCache = await WarframestatCache.initCache(temp.path);

  final notificationRepo = NotificationRepository();
  final worldstateRepo = WorldstateRepository(cache: warframestateCache);

  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: appDir);

  runApp(
    BetterFeedback(
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: worldstateRepo),
          RepositoryProvider.value(value: notificationRepo),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => WorldstateCubit(worldstateRepo),
            ),
            BlocProvider(
              create: (_) => DarvodealCubit(worldstateRepo),
            ),
            BlocProvider(
              create: (_) => UserSettingsCubit(settings: usersettings),
            ),
          ],
          child: await builder(),
        ),
      ),
    ),
  );
}
