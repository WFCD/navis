import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';

import 'package:background_fetch/background_fetch.dart';
import 'package:navis/utils/crashlytics.dart';

import 'app.dart';

final state = WorldstateBloc();

void main() {
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

Future<void> fetchState() async {
  state.update();
  BackgroundFetch.finish();
}
