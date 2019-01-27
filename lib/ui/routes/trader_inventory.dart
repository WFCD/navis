import 'package:flutter/material.dart';
import 'package:navis/models/export.dart';

class VoidTraderInventory extends StatefulWidget {
  final List<Inventory> inventory;

  VoidTraderInventory({this.inventory});

  @override
  VoidTraderInventoryState createState() => VoidTraderInventoryState();
}

class VoidTraderInventoryState extends State<VoidTraderInventory> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  InventoryDataSource _source;

  final List<DataColumn> columns = [
    DataColumn(label: Text('Item'), onSort: (i, b) {}),
    DataColumn(label: Text('Ducats'), onSort: (i, b) {}),
    DataColumn(label: Text('Credits'), onSort: (i, b) {})
  ];

  @override
  void initState() {
    super.initState();
    _source = InventoryDataSource(inventory: widget.inventory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Baro\'s Inventory')),
        body: ListView(
          children: <Widget>[
            PaginatedDataTable(
              header: Text('Inventory'),
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
  final List<Inventory> inventory;

  InventoryDataSource({this.inventory});

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
