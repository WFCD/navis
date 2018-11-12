import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';

import 'app.dart';
import 'network/sentry.dart';

void main() {
  final state = WorldstateBloc();
  final exceptionService = ExceptionService();

  runZoned(
      () => runApp(BlocProvider<WorldstateBloc>(bloc: state, child: Navis())),
      onError: (error, stackTrace) async =>
          await exceptionService.reportErrorAndStackTrace(error, stackTrace));

  //runApp(BlocProvider<WorldstateBloc>(bloc: state, child: Navis()));
}
