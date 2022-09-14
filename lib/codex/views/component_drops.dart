import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:wfcd_client/entities.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class ComponentDrops extends StatelessWidget {
  const ComponentDrops({super.key, required this.drops});

  final List<Drop> drops;

  void _loadRelic(BuildContext context, String itemName) {
    final teirReg = RegExp(r'\(([^)]*)\)');

    final tier = teirReg.firstMatch(itemName)?.group(1);
    final relic =
        '${itemName.replaceAll(teirReg, '').trim()} ${tier ?? 'Intact'}';

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return BlocProvider(
            create: (context) {
              return SearchBloc(
                RepositoryProvider.of<WorldstateRepository>(context),
              );
            },
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  final l10n = NavisLocalizations.of(context)!;

                  context.watch<SearchBloc>().add(SearchCodex(relic));
                  final state = context.watch<SearchBloc>().state;

                  if (state is! CodexSuccessfulSearch) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final item = state.results.firstWhereOrNull(
                    (e) => e?.name.contains(relic) ?? false,
                  );

                  if (item == null) {
                    return Center(child: Text(l10n.codexNoResults));
                  }

                  return CodexEntry(item: item);
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
    final _drops = List<Drop>.from(drops)
      ..sort((a, b) {
        return ((b.chance ?? 0) * 100).compareTo((a.chance ?? 0) * 100);
      });

    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        cacheExtent: 150,
        itemCount: _drops.length,
        itemBuilder: (context, index) {
          final dropName = _drops[index].location;
          final percentage =
              ((_drops[index].chance ?? 0) * 100).toStringAsFixed(2);

          return ListTile(
            title: Text(dropName),
            subtitle: Text('$percentage% drop chance'),
            onTap: !dropName.contains('Relic')
                ? null
                : () => _loadRelic(
                      context,
                      dropName.replaceFirst('Relic', '').trim(),
                    ),
            dense: _drops.length > 10,
          );
        },
      ),
    );
  }
}
