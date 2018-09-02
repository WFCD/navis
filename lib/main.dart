import 'dart:async';

import 'package:flutter/material.dart';

import 'app.dart';
import 'model.dart';
import 'services/sentry.dart';
//import 'package:android_job_scheduler/android_job_scheduler.dart';

Future update() async {
  final model = NavisModel();
  model.update();
}

void main() async {
  final exceptionService = ExceptionService();
  final model = NavisModel();

  await model.update();

  runZoned(() => runApp(Navis(model: model)),
      onError: (error, stackTrace) =>
          exceptionService.reportErrorAndStackTrace(error, stackTrace));

  //await AndroidJobScheduler.scheduleEvery(Duration(minutes: 5), 100, update);
}
