import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class ComponentDrops extends StatelessWidget {
  const ComponentDrops({super.key, required this.drops});

  final List<Drop> drops;

  void _loadRelic(BuildContext context, String itemName) {
    final teirReg = RegExp(r'\(([^)]*)\)');

    final tier = teirReg.firstMatch(itemName)?.group(1);
    final relic = '${itemName.replaceAll(teirReg, '').trim()} ${tier ?? 'Intact'}';

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return BlocProvider(
            create: (context) => SearchBloc(RepositoryProvider.of<WarframestatRepository>(context)),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  final l10n = context.l10n;

                  context.watch<SearchBloc>().add(SearchCodex(relic));
                  final state = context.watch<SearchBloc>().state;

                  if (state is! CodexSuccessfulSearch) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final item = state.results.firstWhereOrNull((e) => e.name.contains(relic));

                  if (item == null) {
                    return Center(child: Text(l10n.codexNoResults));
                  }

                  return EntryView(item: item);
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
          final dropName = drops[index].location;
          final percentage = ((drops[index].chance ?? 0) * 100).toStringAsFixed(2);

          return ListTile(
            title: Text(dropName),
            subtitle: Text('$percentage% drop chance'),
            onTap:
                !dropName.contains('Relic')
                    ? null
                    : () => _loadRelic(context, dropName.replaceFirst('Relic', '').trim()),
            dense: drops.length > densityThreshold,
          );
        },
      ),
    );
  }
}
