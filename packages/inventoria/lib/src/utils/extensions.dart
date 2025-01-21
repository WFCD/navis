import 'package:drift/drift.dart';
import 'package:inventoria/inventoria.dart';
import 'package:warframestat_client/warframestat_client.dart';

/// Extensions to make my life easy
extension ItemX on Item {
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
