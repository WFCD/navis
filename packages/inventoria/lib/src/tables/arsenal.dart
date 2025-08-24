import 'package:drift/drift.dart';

/// Items to be hidden from the user
const hidden = ['Excalibur Prime', 'Skana Prime', 'Lato Prime', 'Helminth'];

/// Represents an item
class InventoryItem extends Table {
  /// Unique name provided by DE
  late final Column<String> uniqueName = text()();

  /// Item name
  late final Column<String> name = text()();

  /// Item description if possible
  late final Column<String> description = text().nullable()();

  /// Image name
  late final Column<String> image = text().nullable()();

  /// Item category according to DE
  late final Column<String> productCategory = text().nullable()();

  /// Item type
  late final Column<String> type = text()();

  /// Affinity
  late final Column<int> xp = integer().withDefault(const Constant(0))();

  /// If the item is missing based on stored xp
  late final Column<bool> isMissing = boolean().generatedAs(xp.equals(0))();

  /// If the item can be hidden from the user
  late final Column<bool> isHidden = boolean().generatedAs(isMissing & name.isIn(hidden))();

  @override
  Set<Column<Object>>? get primaryKey => {uniqueName};
}
