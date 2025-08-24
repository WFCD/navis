import 'package:drift/drift.dart';

class InventoriaManifest extends Table {
  late final Column<int> id = integer()();
  late final Column<String> hash = text()();
  late final Column<DateTime> timestamp = dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
