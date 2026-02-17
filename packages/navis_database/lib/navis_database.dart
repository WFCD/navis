import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:sentry_drift/sentry_drift.dart';

class NavisDatabase {
  static QueryExecutor? _executor;

  static const _databaseName = 'navis_database';

  static QueryExecutor get queryExecutor => _executor ??= _createExceutor();

  static QueryExecutor _createExceutor() {
    return driftDatabase(name: _databaseName).interceptWith(SentryQueryInterceptor(databaseName: _databaseName));
  }
}
