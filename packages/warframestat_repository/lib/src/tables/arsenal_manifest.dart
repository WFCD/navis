import 'package:drift/drift.dart';

class ArsenalManifest extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get lastUpdate => dateTime()();
}
