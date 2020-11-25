import 'package:flutter/material.dart';
import 'package:warframestat_api_models/entities.dart';

import 'inventory_data_source.dart';

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
    )
  ];
}

class MobileInventoryDataTable extends StatelessWidget {
  const MobileInventoryDataTable({Key key, this.inventory}) : super(key: key);

  final List<InventoryItem> inventory;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: _buildDataColumn(context),
        columnSpacing: 32,
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
                DataCell(Text('${product.credits}cr'))
              ],
            ),
        ],
      ),
    );
  }
}

class TabletInventoryDataTable extends StatelessWidget {
  const TabletInventoryDataTable({Key key, this.inventory}) : super(key: key);

  final List<InventoryItem> inventory;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaginatedDataTable(
        header: const Text('Inventory'),
        rowsPerPage: PaginatedDataTable.defaultRowsPerPage,
        onSelectAll: (selected) {},
        columns: _buildDataColumn(context),
        source: InventoryDataSource(inventory: inventory),
      ),
    );
  }
}
