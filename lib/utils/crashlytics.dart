import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';

class ExceptionService {
  factory ExceptionService() {
    assert(isDebug = true);
    FlutterError.onError = (FlutterErrorDetails details) {
      if (isDebug) {
        // In development mode simply print to console.
        FlutterError.dumpErrorToConsole(details);
      } else {
        // In production mode report to the application zone to report to
        // Crashlytics.
        Zone.current.handleUncaughtError(details.exception, details.stack);
      }
    };

    FlutterCrashlytics().initialize();
    return ExceptionService._();
  }

  ExceptionService._();

  static bool isDebug = false;

  /// Reports [error] (either an [Exception] or an [Error]) to Crashlytics.
  Future<void> reportError(dynamic error) async {
    if (isDebug) {
      throw error;
    }

    await FlutterCrashlytics().log(error.toString());
    await FlutterCrashlytics().logException(error, error.stackTrace);
  }

  Future<void> reportErrorAndStackTrace(
      dynamic error, dynamic stackTrace) async {
    if (isDebug) throw error;

    return await FlutterCrashlytics()
        .reportCrash(error, stackTrace, forceCrash: true);
  }
}
