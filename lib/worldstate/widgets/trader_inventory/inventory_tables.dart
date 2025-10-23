import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/widgets/widgets.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:worldstate_models/worldstate_models.dart';

class InventoryDataTable extends StatelessWidget {
  const InventoryDataTable({super.key, required this.inventory, this.isVarzia = false});

  final List<TraderItem> inventory;
  final bool isVarzia;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => _MobileInventoryDataTable(inventory: inventory, isVarzia: isVarzia),
      tablet: (_) => _TabletInventoryDataTable(inventory: inventory),
    );
  }
}

class _MobileInventoryDataTable extends StatelessWidget {
  const _MobileInventoryDataTable({required this.inventory, this.isVarzia = false});

  final List<TraderItem> inventory;
  final bool isVarzia;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: inventory.length,
      itemBuilder: (context, index) {
        return TraderItemCard(item: inventory[index], isVarzia: isVarzia);
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
