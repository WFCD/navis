import 'package:flutter/material.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:warframestat_client/warframestat_client.dart';

class BaroInventory extends StatelessWidget {
  const BaroInventory({super.key, required this.character, required this.inventory, this.isVarzia = false});

  final String character;
  final List<TraderItem>? inventory;
  final bool isVarzia;

  @override
  Widget build(BuildContext context) {
    return TraceableWidget(
      child: Scaffold(
        appBar: AppBar(title: Text(context.l10n.characterInventory(character))),
        body: InventoryDataTable(inventory: inventory ?? [], isVarzia: isVarzia),
      ),
    );
  }
}
