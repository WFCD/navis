import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/services/notification_service.dart';
import 'package:navis/services/worldstate.dart';

import 'app.dart';

void main() {
  bool isDebug = false;

  assert(isDebug = true);
  FlutterError.onError = (FlutterErrorDetails details) {
    if (isDebug) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Crashlytics.
      Crashlytics.instance.onError(details);
    }
  };

  runApp(BlocProvider(bloc: NavigationBloc(), child: const Navis()));

  BackgroundFetch.registerHeadlessTask(callNotification);
}

Future<void> callNotification() async {
  final worldstate = WorldstateAPI();

  callNotifications(await worldstate.updateState());
  BackgroundFetch.finish();
}
