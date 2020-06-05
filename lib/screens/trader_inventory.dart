import 'package:flutter/material.dart';
import 'package:warframestat_api_models/entities.dart';

class VoidTraderInventory extends StatefulWidget {
  const VoidTraderInventory({Key key}) : super(key: key);

  static const route = 'inventory';

  @override
  VoidTraderInventoryState createState() => VoidTraderInventoryState();
}

class VoidTraderInventoryState extends State<VoidTraderInventory> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  InventoryDataSource _source;

  final List<DataColumn> columns = [
    DataColumn(label: const Text('Item'), onSort: (i, b) {}),
    DataColumn(label: const Text('Ducats'), onSort: (i, b) {}),
    DataColumn(label: const Text('Credits'), onSort: (i, b) {})
  ];

  @override
  void didChangeDependencies() {
    final inventory = ModalRoute.of(context).settings.arguments;

    _source = InventoryDataSource(inventory: inventory);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Baro\'s Inventory')),
        body: ListView(
          children: <Widget>[
            PaginatedDataTable(
              header: const Text('Inventory'),
              rowsPerPage: _rowsPerPage,
              onRowsPerPageChanged: (r) => setState(() => _rowsPerPage = r),
              onSelectAll: (selected) {},
              columns: columns,
              source: _source,
            )
          ],
        ));
  }
}

class InventoryDataSource extends DataTableSource {
  InventoryDataSource({this.inventory});

  final List<InventoryItem> inventory;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= inventory.length) return null;

    final product = inventory[index];

    return DataRow.byIndex(
        index: index,
        cells: <DataCell>[
          DataCell(Text(product.item), onTap: () {}),
          DataCell(Text('${product.ducats}'), onTap: () {}),
          DataCell(Text('${product.credits}cr'), onTap: () {})
        ],
        onSelectChanged: null);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => inventory.length;

  @override
  int get selectedRowCount => 0;
}
