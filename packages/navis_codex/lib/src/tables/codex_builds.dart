import 'package:drift/drift.dart';

class CodexBuilds extends Table {
  late final id = integer().autoIncrement()();
  late final buildLabel = text()();
  late final timestamp = dateTime()();
}
