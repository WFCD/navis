import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:warframestat_api_models/entities.dart';

import '../widgets/trader_inventory/inventory_tables.dart';

// TODO: maybe add more functionality to Baro's Inventory
class BaroInventory extends StatelessWidget {
  const BaroInventory({Key key}) : super(key: key);

  static const route = '/baro_inventory';

  @override
  Widget build(BuildContext context) {
    final inventory =
        ModalRoute.of(context).settings.arguments as List<InventoryItem>;

    return Scaffold(
      appBar: AppBar(title: const Text('Baro\'s Inventory')),
      body: ScreenTypeLayout.builder(
        mobile: (_) => MobileInventoryDataTable(inventory: inventory),
        tablet: (_) => TabletInventoryDataTable(inventory: inventory),
      ),
    );
  }
}
