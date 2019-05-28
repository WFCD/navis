import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_lumberdash/firebase_lumberdash.dart';
import 'package:flutter/material.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/services/services.dart';
import 'package:package_info/package_info.dart';

import 'app.dart';

Future<void> main() async {
  final package = await PackageInfo.fromPlatform();

  await setupLocator();
  putLumberdashToWork(
      withClient: FirebaseLumberdash(
    firebaseAnalyticsClient: FirebaseAnalytics(),
    loggerName: 'Navis_Lumberdash',
    environment: 'production',
    releaseVersion: package.version,
  ));

  runApp(BlocProviderTree(blocProviders: [
    BlocProvider<StorageBloc>(bloc: StorageBloc()),
    BlocProvider<WorldstateBloc>(bloc: WorldstateBloc()),
    BlocProvider<NavigationBloc>(bloc: NavigationBloc())
  ], child: const Navis()));
}
