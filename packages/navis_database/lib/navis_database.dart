import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:sentry_drift/sentry_drift.dart';

class NavisDatabase {
  static QueryExecutor createExceutor(String name) {
    return driftDatabase(name: name).interceptWith(SentryQueryInterceptor(databaseName: name));
  }
}
