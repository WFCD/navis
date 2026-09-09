import 'package:material_ui/material_ui.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/widgets/widgets.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:warframe_common/warframe_common.dart';

class InventoryDataTable extends StatelessWidget {
  const new({super.key, required this.inventory, this.isVarzia = false});

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
  const new({required this.inventory, this.isVarzia = false});

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
  const new({required this.inventory});

  final List<TraderItem> inventory;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return SingleChildScrollView(
      child: PaginatedDataTable(
        onSelectAll: (selected) {},
        columns: <DataColumn>[
          DataColumn(label: Text(context.l10n.traderItemHeaderTitle, style: textTheme.bodyMedium)),
          DataColumn(label: Text(context.l10n.traderDucatsHeaderTitle, style: textTheme.bodyMedium)),
          DataColumn(label: Text(context.l10n.traderCreditsHeaderTitle, style: textTheme.bodyMedium)),
        ],
        source: InventoryDataSource(inventory: inventory),
      ),
    );
  }
}
