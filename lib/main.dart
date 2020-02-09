import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/injection_container.dart';

import 'core/app.dart';
import 'core/bloc/navigation_bloc.dart';
import 'features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  await runZoned(() async {
    BlocSupervisor.delegate = await HydratedBlocDelegate.build();

    await di.init();
    runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<NavigationBloc>()),
        BlocProvider(create: (_) => sl<SolsystemBloc>())
      ],
      child: const NavisApp(),
    ));
  }, onError: Crashlytics.instance.recordError);
}
