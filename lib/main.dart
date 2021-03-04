import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:matomo/matomo.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
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
  await Firebase.initializeApp();
  await FlutterWebBrowser.warmup();

  HydratedBloc.storage = await HydratedStorage.build();

  await di.init();
  if (sl<Usersettings>().platform == null) {
    sl<Usersettings>().platform = GamePlatforms.pc;
    await sl<NotificationService>().subscribeToPlatform(GamePlatforms.pc);
  }

  await MatomoTracker()
      .initialize(siteId: 1, url: const String.fromEnvironment('MATOMO_URL'));

  if (sl<Usersettings>().getToggle('firstVist') != true) {
    MatomoTracker.trackEvent('firstVisit', MatomoTracker.kFirstVisit);
    sl<Usersettings>().setToggle('firstVist', true);
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
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await SentryFlutter.init(
    (option) => option.dsn = const String.fromEnvironment('SENTRY_DSN'),
    appRunner: startApp,
  );
}
