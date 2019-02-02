import 'dart:async';
import 'package:flutter/material.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/theming.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/utils/crashlytics.dart';
import 'package:navis/utils/themes.dart';

import 'app.dart';

final state = WorldstateBloc();

Future<void> fetchState() async {
  state.update();
  BackgroundFetch.finish();
}

Future<void> main() async {
  final exception = ExceptionService();
  final AppThemes theme = AppThemes();

  ThemeBloc.initialTheme = await theme.savedTheme();

  runZoned<Future<void>>(
      () async =>
          runApp(BlocProvider<WorldstateBloc>(bloc: state, child: Navis())),
      onError: (error, stackTrace) async =>
          await exception.reportErrorAndStackTrace(error, stackTrace));

  BackgroundFetch.configure(
      BackgroundFetchConfig(
          startOnBoot: true, stopOnTerminate: false, enableHeadless: true),
      fetchState);
}
