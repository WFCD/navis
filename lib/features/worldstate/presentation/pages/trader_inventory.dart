import 'package:flutter/material.dart';
import 'package:worldstate_api_model/entities.dart';

// TODO: maybe add more functionality to Baro's Inventory
class BaroInventory extends StatefulWidget {
  const BaroInventory({Key key}) : super(key: key);

  static const route = '/baro_inventory';

  @override
  _BaroInventoryState createState() => _BaroInventoryState();
}

class _BaroInventoryState extends State<BaroInventory> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  InventoryDataSource _source;

  final List<DataColumn> columns = [
    DataColumn(label: const Text('Item'), onSort: (i, b) {}),
    DataColumn(label: const Text('Ducats'), onSort: (i, b) {}),
    DataColumn(label: const Text('Credits'), onSort: (i, b) {})
  ];

  @override
  void didChangeDependencies() {
    final inventory =
        ModalRoute.of(context).settings.arguments as List<InventoryItem>;

    _source = InventoryDataSource(inventory: inventory);

    super.didChangeDependencies();
  }

  void _onRowsPerPageChanged(int r) => setState(() => _rowsPerPage = r);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Baro\'s Inventory')),
      body: SingleChildScrollView(
          child: PaginatedDataTable(
        header: const Text('Inventory'),
        rowsPerPage: _rowsPerPage,
        onRowsPerPageChanged: _onRowsPerPageChanged,
        // onSelectAll: (selected) {},
        columns: columns,
        source: _source,
      )),
    );
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
          DataCell(Text(product.item)),
          DataCell(Text('${product.ducats}')),
          DataCell(Text('${product.credits}cr'))
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
