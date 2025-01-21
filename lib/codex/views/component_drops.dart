import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart' hide ItemNotFound;
import 'package:warframestat_repository/warframestat_repository.dart';

class ComponentDrops extends StatelessWidget {
  const ComponentDrops({super.key, required this.drops});

  final List<Drop> drops;

  void _loadRelic(BuildContext context, String itemName) {
    final teirReg = RegExp(r'\(([^)]*)\)');
    final repo = RepositoryProvider.of<WarframestatRepository>(context);

    final tier = teirReg.firstMatch(itemName)?.group(1);
    final relic = '${itemName.replaceAll(teirReg, '').trim()} ${tier ?? 'Intact'}';

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return BlocProvider(
            create: (context) => ItemCubit(itemName, repo)..fetchItem(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  return BlocBuilder<ItemCubit, ItemState>(
                    builder: (context, state) {
                      final l10n = context.l10n;

                      if (state is! ItemFetchSuccess) {
                        return const Center(child: WarframeSpinner());
                      }

                      if (state is ItemNotFound) {
                        return Center(child: Text(l10n.codexNoResults));
                      }

                      return EntryView(item: state.item);
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const cacheExtent = 150.0;
    const densityThreshold = 10;

    final drops = List<Drop>.from(this.drops)..sort((a, b) {
      return ((b.chance ?? 0) * 100).compareTo((a.chance ?? 0) * 100);
    });

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        cacheExtent: cacheExtent,
        itemCount: drops.length,
        itemBuilder: (context, index) {
          final drop = drops[index];
          final percentage = ((drop.chance ?? 0) * 100).toStringAsFixed(2);

          return ListTile(
            title: Text(drop.location),
            subtitle: Text('$percentage% drop chance'),
            onTap: drop.uniqueName != null ? () => _loadRelic(context, drop.uniqueName!) : null,
            dense: drops.length > densityThreshold,
          );
        },
      ),
    );
  }
}
