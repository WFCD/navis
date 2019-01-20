import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:background_fetch/background_fetch.dart';

import 'app.dart';
import 'APIs/sentry.dart';

final state = WorldstateBloc();

void main() {
  final exceptionService = ExceptionService();

  runZoned<Future<Null>>(
      () async =>
          runApp(BlocProvider<WorldstateBloc>(bloc: state, child: Navis())),
      onError: (error, stackTrace) async =>
          await exceptionService.reportErrorAndStackTrace(error, stackTrace));

  BackgroundFetch.configure(
      BackgroundFetchConfig(
          startOnBoot: true, stopOnTerminate: false, enableHeadless: true),
      fetchState);
}

void fetchState() async {
  state.update();
  BackgroundFetch.finish();
}
