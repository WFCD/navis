import 'package:drift/drift.dart';

/// Represents an item
class InventoryItem extends Table {
  /// Unique name provided by DE
  late final uniqueName = text()();

  /// Item name
  late final name = text()();

  /// Item description if possible
  late final description = text().nullable()();

  /// Image name
  late final image = text().nullable()();

  /// Item category according to DE
  late final productCategory = text().nullable()();

  /// Item type
  late final type = text()();

  /// Affinity
  ///
  /// If null consider this item missing
  late final xp = integer().nullable()();

  @override
  Set<Column<Object>>? get primaryKey => {uniqueName};
}
