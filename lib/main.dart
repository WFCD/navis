import 'dart:async';
import 'package:flutter/material.dart';
import 'package:navis/utils/crashlytics.dart';
import 'package:navis/services/database.dart';

import 'app.dart';

void main() {
  final exception = ExceptionService();

  DBProvider.db.database;

  runZoned<Future<void>>(() async => runApp(Navis()),
      onError: (error, stackTrace) async =>
          await exception.reportErrorAndStackTrace(error, stackTrace));
}
