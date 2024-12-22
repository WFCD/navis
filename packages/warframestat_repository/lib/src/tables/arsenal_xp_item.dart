import 'package:drift/drift.dart';
import 'package:warframestat_client/warframestat_client.dart';

@UseRowClass(XpItem)
class ArsenalItemXp extends Table {
  TextColumn get uniqueName => text()();
  IntColumn get xp => integer()();

  @override
  Set<Column<Object>>? get primaryKey => {uniqueName};
}
