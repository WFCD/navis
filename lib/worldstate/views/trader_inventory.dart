import 'package:flutter/material.dart';
import 'package:matomo/matomo.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:wfcd_client/entities.dart';

class BaroInventory extends TraceableStatelessWidget {
  const BaroInventory({super.key});

  static const route = '/baro_inventory';

  @override
  Widget build(BuildContext context) {
    final inventory =
        // There are checks in place that prevent this from being anything else.
        // ignore: cast_nullable_to_non_nullable
        ModalRoute.of(context)?.settings.arguments as List<InventoryItem>;

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.baroInventory)),
      body: InventoryDataTable(inventory: inventory),
    );
  }
}
