import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';
import 'package:wfcd_client/wfcd_client.dart';

import 'core/app.dart';
import 'core/bloc/navigation_bloc.dart';
import 'core/local/user_settings.dart';
import 'core/services/notifications.dart';
import 'features/codex/presentation/bloc/search_bloc.dart';
import 'features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'injection_container.dart';
import 'injection_container.dart' as di;

Future<void> startApp() async {
  HydratedBloc.storage = await HydratedStorage.build();

  await di.init();
  if (sl<Usersettings>().platform == null) {
    sl<Usersettings>().platform = GamePlatforms.pc;
    await sl<NotificationService>().subscribeToPlatform(GamePlatforms.pc);
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<NavigationBloc>()),
        BlocProvider(create: (_) => sl<SolsystemBloc>()),
        BlocProvider(create: (_) => sl<SearchBloc>()),
      ],
      child: ChangeNotifierProvider.value(
        value: sl<Usersettings>(),
        child: const NavisApp(),
      ),
    ),
  );
}

Future<void> main() async {
  var isDebug = false;
  const systemOverlay =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);

  SystemChrome.setSystemUIOverlayStyle(systemOverlay);
  await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();
  await FlutterWebBrowser.warmup();

  assert(isDebug = true);
  if (!isDebug) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  await runZonedGuarded(startApp, FirebaseCrashlytics.instance.recordError);
}
