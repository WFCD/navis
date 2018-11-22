import 'dart:async';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:package_info/package_info.dart';
import 'package:background_fetch/background_fetch.dart';

import 'app.dart';
import 'network/sentry.dart';

final state = WorldstateBloc();

void fetchState() async {
  state.update();
  BackgroundFetch.finish();
}

void main() async {
  final deviceInfo = DeviceInfoPlugin();

  final platformInfo = await PackageInfo.fromPlatform();
  final androidInfo = await deviceInfo.androidInfo;

  ExceptionService.appVersion = platformInfo.version;
  ExceptionService.androidVersion = androidInfo.version.release;
  ExceptionService.model = androidInfo.model;

  final exceptionService = ExceptionService();

  runZoned<Future<Null>>(
      () async =>
          runApp(BlocProvider<WorldstateBloc>(bloc: state, child: Navis())),
      onError: (error, stackTrace) async =>
          await exceptionService.reportErrorAndStackTrace(error, stackTrace));

  //runApp(BlocProvider<WorldstateBloc>(bloc: state, child: Navis()));
  BackgroundFetch.configure(
      BackgroundFetchConfig(
          startOnBoot: true, stopOnTerminate: false, enableHeadless: true),
      fetchState);
  //BackgroundFetch.registerHeadlessTask(fetchState);
}
