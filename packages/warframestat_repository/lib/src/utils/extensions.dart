import 'package:drift/drift.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/src/arsenal_database.dart';

extension InsertableItem on MinimalItem {
  Insertable<MinimalItem> toInsertable() {
    return ArsenalItemCompanion.insert(
      uniqueName: uniqueName,
      name: name,
      description: Value(description),
      imageName: Value(imageName),
      type: type,
      productCategory: Value(productCategory),
      category: category,
      tradable: tradable,
      excludeFromCodex: Value(excludeFromCodex),
      vaultDate: Value(vaultDate),
      vaulted: Value(vaulted),
      masterable: Value(masterable),
      wikiaUrl: Value(wikiaUrl),
    );
  }
}

extension InsertableXpItem on XpItem {
  Insertable<XpItem> toInsertable() {
    return ArsenalItemXpCompanion.insert(uniqueName: uniqueName, xp: xp);
  }
}

extension WorldstateNavisX on Worldstate {
  // bool get activeAcolytes => worldstate.enemyActive;

  bool get activeAlerts => alerts.isNotEmpty;

  bool get activeSales => flashSales.isNotEmpty;

  bool get arbitrationActive =>
      arbitration != null && !arbitration!.node.contains('000');

  bool get eventsActive => events.isNotEmpty;

  bool get outpostDetected => sentientOutposts != null;

  bool get deepArchimedeaActive => deepArchimedea != null;
}
