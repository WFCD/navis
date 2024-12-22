import 'package:drift/drift.dart';
import 'package:warframestat_client/warframestat_client.dart' show MinimalItem;
import 'package:warframestat_repository/src/converters/converters.dart';

@UseRowClass(MinimalItem)
class ArsenalItem extends Table {
  TextColumn get uniqueName => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get imageName => text().nullable()();
  TextColumn get type => text().map(const ItemTypeConverter())();
  TextColumn get productCategory => text().nullable()();
  TextColumn get category => text()();
  BoolColumn get tradable => boolean()();
  BoolColumn get excludeFromCodex => boolean().nullable()();
  TextColumn get vaultDate => text().nullable()();
  BoolColumn get vaulted => boolean().nullable()();
  TextColumn get wikiaUrl => text().nullable()();
  BoolColumn get masterable => boolean().nullable()();

  @override
  Set<Column<Object>>? get primaryKey => {uniqueName};
}
