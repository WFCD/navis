import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';
import 'package:wfcd_client/wfcd_client.dart';
import 'package:path_provider/path_provider.dart';

import 'core/app.dart';
import 'core/cubits/navigation_cubit.dart';
import 'core/notifiers/user_settings_notifier.dart';
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
  if (sl<UserSettingsNotifier>().isFirstTime) {
    await sl<NotificationService>().subscribeToPlatform(GamePlatforms.pc);
    sl<UserSettingsNotifier>().setFirstTime(false);
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<NavigationCubit>()),
        BlocProvider(create: (_) => sl<SolsystemBloc>()),
        BlocProvider(create: (_) => sl<SearchBloc>()),
      ],
      child: ChangeNotifierProvider.value(
        value: sl<UserSettingsNotifier>(),
        child: const NavisApp(),
      ),
    ),
  );
}
