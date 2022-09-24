import 'package:flutter/material.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';

List<DataColumn> _buildDataColumn(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;

  return <DataColumn>[
    DataColumn(
      label: Text(
        'Item',
        style: textTheme.bodyText2,
      ),
    ),
    DataColumn(
      label: Text(
        'Ducats',
        style: textTheme.bodyText2,
      ),
    ),
    DataColumn(
      label: Text(
        'Credits',
        style: textTheme.bodyText2,
      ),
    ),
  ];
}

class InventoryDataTable extends StatelessWidget {
  const InventoryDataTable({super.key, required this.inventory});

  final List<InventoryItem> inventory;

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

  final List<InventoryItem> inventory;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: _buildDataColumn(context),
        // It's what worked for the style.
        // ignore: no-magic-number
        columnSpacing: 32,
        // It's what worked for the style.
        // ignore: no-magic-number
        dataRowHeight: 52,
        rows: <DataRow>[
          for (final product in inventory)
            DataRow(
              cells: <DataCell>[
                DataCell(
                  Text(
                    product.item,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                DataCell(Text('${product.ducats}')),
                DataCell(Text('${product.credits}cr')),
              ],
            ),
        ],
      ),
    );
  }
}

class _TabletInventoryDataTable extends StatelessWidget {
  const _TabletInventoryDataTable({required this.inventory});

  final List<InventoryItem> inventory;

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
