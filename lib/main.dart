import 'dart:async';
import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/services/worldstate.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:navis/utils/crashlytics.dart';

import 'app.dart';

final state = WorldstateBloc();
final stateService = WorldstateAPI();

Future<void> fetchState() async {
  state.update();
  BackgroundFetch.finish();
}

Future<void> main() async {
  WorldstateBloc.initworldstate = await stateService.updateState();

  final exception = ExceptionService();

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
