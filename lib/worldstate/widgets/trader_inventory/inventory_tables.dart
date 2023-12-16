import 'package:flutter/material.dart';
import 'package:navis/worldstate/widgets/trader_inventory/inventory.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:warframestat_client/warframestat_client.dart';

List<DataColumn> _buildDataColumn(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;

  return <DataColumn>[
    DataColumn(
      label: Text(
        'Item',
        style: textTheme.bodyMedium,
      ),
    ),
    DataColumn(
      label: Text(
        'Ducats',
        style: textTheme.bodyMedium,
      ),
    ),
    DataColumn(
      label: Text(
        'Credits',
        style: textTheme.bodyMedium,
      ),
    ),
  ];
}

class InventoryDataTable extends StatelessWidget {
  const InventoryDataTable({super.key, required this.inventory});

  final List<TraderItem> inventory;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => _MobileInventoryDataTable(inventory: inventory),
      tablet: (_) => _TabletInventoryDataTable(inventory: inventory),
    );
  }
}

class _MobileInventoryDataTable extends StatelessWidget {
  const _MobileInventoryDataTable({required this.inventory});

  final List<TraderItem> inventory;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: inventory.length,
      itemBuilder: (context, index) {
        return TraderItemView(traderItem: inventory[index]);
      },
    );
  }
}

class _TabletInventoryDataTable extends StatelessWidget {
  const _TabletInventoryDataTable({required this.inventory});

  final List<TraderItem> inventory;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaginatedDataTable(
        header: const Text('Inventory'),
        onSelectAll: (selected) {},
        columns: _buildDataColumn(context),
        source: InventoryDataSource(inventory: inventory),
      ),
    );
  }
}
