import 'dart:async';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:package_info/package_info.dart';

import 'app.dart';
import 'network/sentry.dart';

void main() async {
  final deviceInfo = DeviceInfoPlugin();
  final state = WorldstateBloc();

  final plaformInfo = await PackageInfo.fromPlatform();
  final androidInfo = await deviceInfo.androidInfo;

  ExceptionService.appVersion = plaformInfo.version;
  ExceptionService.androidVersion = androidInfo.version.release;

  final exceptionService = ExceptionService();

  runZoned<Future<Null>>(
          () async =>
          runApp(BlocProvider<WorldstateBloc>(bloc: state, child: Navis())),
      onError: (error, stackTrace) async =>
          await exceptionService.reportErrorAndStackTrace(error, stackTrace));

  //runApp(BlocProvider<WorldstateBloc>(bloc: state, child: Navis()));
}
