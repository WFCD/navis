import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsService {
  bool isDebug = false;

  void initiateErrorService() {
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
  }
}
