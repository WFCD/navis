import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/widgets/trader_inventory/trader_item_card.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:warframestat_client/warframestat_client.dart';

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
        return TraderItemCard(item: inventory[index]);
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
        header: Text(context.l10n.baroInventory),
        onSelectAll: (selected) {},
        columns: <DataColumn>[
          DataColumn(label: Text(context.l10n.traderItemHeaderTitle, style: context.textTheme.bodyMedium)),
          DataColumn(label: Text(context.l10n.traderDucatsHeaderTitle, style: context.textTheme.bodyMedium)),
          DataColumn(label: Text(context.l10n.traderCreditsHeaderTitle, style: context.textTheme.bodyMedium)),
        ],
        source: InventoryDataSource(inventory: inventory),
      ),
    );
  }
}
