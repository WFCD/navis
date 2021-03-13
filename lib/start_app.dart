import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:matomo/matomo.dart';
import 'package:provider/provider.dart';
import 'package:wfcd_client/wfcd_client.dart';
import 'package:path_provider/path_provider.dart';

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

  final temp = await getTemporaryDirectory();
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: temp);

  await di.init();
  if (sl<Usersettings>().platform == null) {
    sl<Usersettings>().platform = GamePlatforms.pc;
    await sl<NotificationService>().subscribeToPlatform(GamePlatforms.pc);
  }

  if (sl<Usersettings>().language == null) {
    sl<Usersettings>().language =
        PlatformDispatcher.instance.locale.languageCode;

    await sl<NotificationService>()
        .subscribeToNotification(sl<Usersettings>().language);
  }

  await MatomoTracker()
      .initialize(siteId: 2, url: const String.fromEnvironment('MATOMO_URL'));

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
