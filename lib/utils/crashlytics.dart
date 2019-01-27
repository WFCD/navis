import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';

class ExceptionService {
  static bool isDebug = false;

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

  /// Reports [error] (either an [Exception] or an [Error]) to Sentry.io.
  Future<Null> reportError(dynamic error) async {
    if (isDebug) throw error;

    debugPrint('Caught error: $error');
    debugPrint('Reporting to Error Crashlytics...');

    await FlutterCrashlytics().logException(error, error.stackTrace);
  }

  Future<Null> reportErrorAndStackTrace(
      dynamic error, dynamic stackTrace) async {
    if (isDebug) throw error;

    debugPrint('Caught error: $error');
    debugPrint('Reporting to Error and StackTrace Crashlytics...');

    return await FlutterCrashlytics()
        .reportCrash(error, stackTrace, forceCrash: true);
  }
}
