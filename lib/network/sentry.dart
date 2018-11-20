import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sentry/sentry.dart';

import '../resources/keys.dart';

class ExceptionService {
  final SentryClient sentry;

  static String appVersion;
  static String androidVersion;

  static bool isDebug = false;

  factory ExceptionService() {
    final sentry = SentryClient(
        dsn: dsn,
        environmentAttributes: Event(
            release: appVersion, extra: {'Android Version': androidVersion}));

    assert(isDebug = true);
    FlutterError.onError = (FlutterErrorDetails details) async {
      if (isDebug) {
        FlutterError.dumpErrorToConsole(details);
      } else {
        Zone.current.handleUncaughtError(details.exception, details.stack);
      }
    };

    return ExceptionService._(sentry);
  }

  ExceptionService._(this.sentry);

  /// Reports [error] (either an [Exception] or an [Error]) to Sentry.io.

  Future<Null> reportError(dynamic error) async {
    if (isDebug) throw error;

    debugPrint('Caught error: $error');
    debugPrint('Reporting to Sentry.io...');

    SentryResponse response;

    if (error is Error) {
      response = await sentry.captureException(
        exception: error,
        stackTrace: error.stackTrace,
      );
    } else {
      response = await sentry.captureException(exception: error);
    }

    if (response.isSuccessful) {
      debugPrint('Success! Event ID: ${response.eventId}');
    } else {
      debugPrint('Failed to report to Sentry.io: ${response.error}');
    }
  }

  Future<Null> reportErrorAndStackTrace(
      dynamic error, dynamic stackTrace) async {
    if (isDebug) throw error;

    debugPrint('Caught error: $error');
    debugPrint('Reporting to Sentry.io...');

    final SentryResponse response = await sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );

    if (response.isSuccessful) {
      debugPrint('Success! Event ID: ${response.eventId}');
    } else {
      debugPrint('Failed to report to Sentry.io: ${response.error}');
    }
  }
}
