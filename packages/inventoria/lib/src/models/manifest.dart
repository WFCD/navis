import 'package:drift/drift.dart';

class InventoriaManifest extends Table {
  late final id = integer()();
  late final hash = text()();
  late final timestamp = dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
