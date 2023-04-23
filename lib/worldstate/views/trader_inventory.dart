import 'package:flutter/material.dart';
import 'package:matomo/matomo.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:warframestat_client/warframestat_client.dart';

class BaroInventory extends TraceableStatelessWidget {
  const BaroInventory({super.key});

  static const route = '/baro_inventory';

  @override
  Widget build(BuildContext context) {
    final inventory =
        ModalRoute.of(context)?.settings.arguments as List<TraderItem>?;

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.baroInventory)),
      body: InventoryDataTable(inventory: inventory ?? []),
    );
  }
}
