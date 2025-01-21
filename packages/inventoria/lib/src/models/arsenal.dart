import 'package:drift/drift.dart';

/// Items to be hidden from the user
const hidden = ['Excalibur Prime', 'Skana Prime', 'Lato Prime', 'Helminth'];

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
  late final xp = integer().withDefault(const Constant(0))();

  /// If the item is missing based on stored xp
  late final isMissing = boolean().generatedAs(xp.equals(0))();

  /// If the item can be hidden from the user
  late final isHidden = boolean().generatedAs(isMissing & name.isIn(hidden))();

  @override
  Set<Column<Object>>? get primaryKey => {uniqueName};
}
