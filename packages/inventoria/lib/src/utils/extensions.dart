import 'package:drift/drift.dart';
import 'package:inventoria/inventoria.dart';
import 'package:inventoria/src/models/arsenal_item.dart';

/// Extensions to make my life easy
extension ItemX on ArsenalItem {
  /// Convert items to insertables
  InventoryItemCompanion toInsert() {
    return InventoryItemCompanion.insert(
      uniqueName: uniqueName,
      name: name,
      description: Value.absentIfNull(description),
      image: Value.absentIfNull(imageName),
      productCategory: Value.absentIfNull(productCategory),
      type: type.name,
    );
  }
}
