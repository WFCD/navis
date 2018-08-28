import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:navis/util/preferences.dart';

import 'app.dart';
import 'model.dart';
import 'services/sentry.dart';
import 'services/state.dart';
//import 'package:android_job_scheduler/android_job_scheduler.dart';

Future update() async {
  final model = NavisModel(state: SystemState());
  model.update();
}

void main() async {
  final exceptionService = ExceptionService();
  final fcm = FirebaseMessaging();
  final pref = Preferences();
  await pref.firstRun();

  final model = NavisModel(state: SystemState());

  await model.update();

  fcm.configure(onResume: (Map<String, dynamic> payload) => update());

  runZoned(() => runApp(Navis(model: model)),
      onError: (error, stackTrace) =>
          exceptionService.reportErrorAndStackTrace(error, stackTrace));

  //await AndroidJobScheduler.scheduleEvery(Duration(minutes: 5), 100, update);
}
