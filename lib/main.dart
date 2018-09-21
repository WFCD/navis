import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'app.dart';
import 'app_model.dart';
import 'network/sentry.dart';
//import 'package:android_job_scheduler/android_job_scheduler.dart';

Future update() async {
  final model = NavisModel();
  model.update();
}

void main() async {
  final package = await PackageInfo.fromPlatform();
  ExceptionService.release = package.version;

  final exceptionService = ExceptionService();
  final model = NavisModel();

  await model.update();

  /* runZoned(() => runApp(Navis(model: model)),
      onError: (error, stackTrace) =>
          exceptionService.reportErrorAndStackTrace(error, stackTrace));*/

  runApp(Navis(model: model));
  //await AndroidJobScheduler.scheduleEvery(Duration(minutes: 5), 100, update);
}
