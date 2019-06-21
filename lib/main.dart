import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_lumberdash/firebase_lumberdash.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/services/services.dart';
import 'package:package_info/package_info.dart';

import 'app.dart';

Future<void> main() async {
  BlocSupervisor.delegate = await HydratedBlocDelegate.build();
  await setupLocator();

  runApp(BlocProviderTree(blocProviders: [
    BlocProvider<StorageBloc>(bloc: StorageBloc()),
    BlocProvider<WorldstateBloc>(bloc: WorldstateBloc()),
    BlocProvider<NavigationBloc>(bloc: NavigationBloc())
  ], child: const Navis()));

  putLumberdashToWork(
      withClient: FirebaseLumberdash(
    firebaseAnalyticsClient: FirebaseAnalytics(),
    loggerName: 'Navis_Lumberdash',
    environment: 'production',
    releaseVersion: locator<PackageInfo>().version,
  ));
}
