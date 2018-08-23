import 'package:flutter/material.dart';
import 'package:navis/util/preferences.dart';

import 'app.dart';
import 'model.dart';
import 'services/sentry.dart';
import 'services/state.dart';
//import 'package:android_job_scheduler/android_job_scheduler.dart';

void update() async {
  final model = NavisModel(state: SystemState());
  model.update();
}

void main() async {
  final exceptionService = ExceptionService();
  final pref = Preferences();
  await pref.firstRun();

  final model = NavisModel(state: SystemState());

  await model.update();
  runApp(Navis(model: model));

  /*runZoned(() => runApp(Navis(model: model)),
      onError: (error, stackTrace) =>
          exceptionService.reportErrorAndStackTrace(error, stackTrace));*/

  //await AndroidJobScheduler.scheduleEvery(Duration(minutes: 5), 100, update);
}
