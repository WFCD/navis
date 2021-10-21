import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:wfcd_client/wfcd_client.dart';

import 'core/app.dart';
import 'core/app_bloc_observer.dart';
import 'core/cubits/navigation_cubit.dart';
import 'core/notifiers/user_settings_notifier.dart';
import 'core/services/notifications.dart';
import 'features/codex/presentation/bloc/market_bloc.dart';
import 'features/codex/presentation/bloc/search_bloc.dart';
import 'features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'injection_container.dart';
import 'injection_container.dart' as di;

Future<void> startApp() async {
  Bloc.observer = AppBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await Firebase.initializeApp();
  await FlutterWebBrowser.warmup();

  final temp = await getTemporaryDirectory();
  final appDir = await getApplicationDocumentsDirectory();

  Hive.init(appDir.path);
  // HydratedBloc already runs Hive.init on the provided storageDirectoy, so
  // it's not needed for temp storage.
  try {
    HydratedBloc.storage = await HydratedStorage.build(storageDirectory: temp);
    // ignore: avoid_catching_errors
  } on HiveError {
    // I don't know what's causing the HiveError and at this point I would
    // rather just recreate the entire folder and subfolders at this point
    if (!temp.existsSync()) {
      temp.createSync(recursive: true);
    } else {
      temp
        ..deleteSync(recursive: true)
        ..createSync(recursive: true);
    }

    HydratedBloc.storage = await HydratedStorage.build(storageDirectory: temp);
  }

  await di.init();
  if (sl<UserSettingsNotifier>().isFirstTime) {
    await sl<NotificationService>().subscribeToPlatform(GamePlatforms.pc);
    sl<UserSettingsNotifier>().setFirstTime(value: false);
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<NavigationCubit>()),
        BlocProvider(create: (_) => sl<SolsystemBloc>()),
        BlocProvider(create: (_) => sl<SearchBloc>()),
        BlocProvider(create: (_) => sl<MarketBloc>())
      ],
      child: ChangeNotifierProvider.value(
        value: sl<UserSettingsNotifier>(),
        child: const NavisApp(),
      ),
    ),
  );
}
