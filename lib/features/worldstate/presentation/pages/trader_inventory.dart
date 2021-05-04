import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:matomo/matomo.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';

import '../widgets/trader_inventory/inventory_tables.dart';

// TODO(Ornstein): maybe add more functionality to Baro's Inventory
class BaroInventory extends TraceableStatelessWidget {
  const BaroInventory({Key? key}) : super(key: key);

  static const route = '/baro_inventory';

  @override
  Widget build(BuildContext context) {
    final inventory =
        ModalRoute.of(context)?.settings.arguments as List<InventoryItem>;

    return Scaffold(
      appBar: AppBar(title: const Text('Baro\'s Inventory')),
      body: ScreenTypeLayout.builder(
        mobile: (_) => MobileInventoryDataTable(inventory: inventory),
        tablet: (_) => TabletInventoryDataTable(inventory: inventory),
      ),
    );
  }
}
