import 'package:flutter/material.dart';
import 'package:matomo/matomo.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/widgets/trader_widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';

class BaroInventory extends TraceableStatelessWidget {
  const BaroInventory({Key? key}) : super(key: key);

  static const route = '/baro_inventory';

  @override
  Widget build(BuildContext context) {
    final inventory =
        // ignore: cast_nullable_to_non_nullable
        ModalRoute.of(context)?.settings.arguments! as List<InventoryItem>;

    return Scaffold(
      appBar:
          AppBar(title: Text(NavisLocalizations.of(context)!.baroInventory)),
      body: ScreenTypeLayout.builder(
        mobile: (_) => MobileInventoryDataTable(inventory: inventory),
        tablet: (_) => TabletInventoryDataTable(inventory: inventory),
      ),
    );
  }
}
