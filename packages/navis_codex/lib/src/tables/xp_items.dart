import 'package:drift/drift.dart';

class XpItems extends Table {
  late final uniqueName = text()();
  late final xp = integer()();

  @override
  Set<Column<Object>>? get primaryKey => {uniqueName};
}
