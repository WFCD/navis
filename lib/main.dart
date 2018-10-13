import 'dart:async';

import 'package:android_job_scheduler/android_job_scheduler.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';

import 'app.dart';
import 'network/sentry.dart';

Future updateState() async {
  final state = WorldstateBloc();
  await state.update();
}

void main() async {
  final state = WorldstateBloc();
  final exceptionService = ExceptionService();

  runZoned(
          () =>
          runApp(BlocProvider<WorldstateBloc>(bloc: state, child: Navis())),
      onError: (error, stackTrace) async =>
      await exceptionService.reportErrorAndStackTrace(error, stackTrace));

  await AndroidJobScheduler.scheduleEvery(
      Duration(minutes: 10), 100, updateState);
}
