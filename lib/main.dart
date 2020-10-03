import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:navis/injection_container.dart';
import 'package:wfcd_client/wfcd_client.dart';
import 'package:provider/provider.dart';

import 'core/app.dart';
import 'core/bloc/navigation_bloc.dart';
import 'core/local/user_settings.dart';
import 'core/services/notifications.dart';
import 'features/codex/presentation/bloc/search_bloc.dart';
import 'features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  await runZoned(() async {
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
  }, onError: FirebaseCrashlytics.instance.recordError);
}
