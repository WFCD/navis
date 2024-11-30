import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/worldstate/worldstate_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class DuviriCircuit extends StatelessWidget {
  const DuviriCircuit({super.key});

  bool _buildWhen(SolsystemState previous, SolsystemState current) {
    if (previous is! WorldstateSuccess || current is! WorldstateSuccess) {
      return false;
    }

    final previousCycle = previous.worldstate.duviriCycle;
    final nextCycle = current.worldstate.duviriCycle;

    return previousCycle.id != nextCycle.id;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldstateCubit, SolsystemState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final cycle = switch (state) {
          WorldstateSuccess() => state.worldstate.duviriCycle,
          _ => null
        };

        final choices = cycle?.choices.map((c) => CircuitChoiceTile(choice: c));

        return AppCard(
          child: CircuitResetTimer(
            expiry: cycle?.expiry ?? DateTime.now(),
            onTap: () {
              showBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: choices?.toList() ?? [],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

class CircuitResetTimer extends StatelessWidget {
  const CircuitResetTimer({
    super.key,
    required this.expiry,
    required this.onTap,
  });

  final DateTime expiry;
  final void Function() onTap;

  DateTime _getNextMonday() {
    final now = DateTime.timestamp();

    var daysUntilNextMonday = (DateTime.monday - now.weekday + 7) % 7;
    daysUntilNextMonday = daysUntilNextMonday == 0 ? 7 : daysUntilNextMonday;

    final nextMondayMidnight = DateTime.utc(
      now.year,
      now.month,
      now.day + daysUntilNextMonday,
    );

    return nextMondayMidnight;
  }

  @override
  Widget build(BuildContext context) {
    final date = MaterialLocalizations.of(context).formatFullDate(expiry);

    return ListTile(
      title: Text(context.l10n.circuitResetTitle),
      trailing: CountdownTimer(tooltip: date, expiry: _getNextMonday()),
      onTap: onTap,
    );
  }
}

class CircuitChoiceTile extends StatelessWidget {
  const CircuitChoiceTile({super.key, required this.choice});

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<WarframestatRepository>(context);
    final isSteelPatch = choice.category == 'hard';

    var category = toBeginningOfSentenceCase(choice.category);
    if (isSteelPatch) category = context.l10n.steelPathTitle;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              category,
              style: context.textTheme.titleMedium
                  ?.copyWith(color: context.theme.colorScheme.secondary),
            ),
          ),
          ...choice.choices.map((c) {
            final name = isSteelPatch ? '$c Incarnon Genesis' : c;

            return BlocProvider(
              create: (_) {
                final cubit = ItemCubit(name, repo);

                isSteelPatch
                    ? cubit.fetchIncarnonGenesis()
                    : cubit.fetchByName();

                return cubit;
              },
              child: _CircuitPathTile(name: name),
            );
          }),
        ],
      ),
    );
  }
}

class _CircuitPathTile extends StatelessWidget {
  const _CircuitPathTile({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemCubit, ItemState>(
      builder: (context, state) {
        final item = switch (state) {
          ItemFetchSuccess() => state.item as MinimalItem,
          _ => null,
        };

        final icon = item != null
            ? CircleAvatar(
                foregroundImage: CachedNetworkImageProvider(item.imageUrl),
                radius: 20,
              )
            : null;

        final tile = ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          leading: icon,
          title: Text(item?.name ?? name),
          subtitle: Text(
            item?.description ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          isThreeLine: true,
          dense: true,
        );

        if (item == null) return tile;

        return EntryViewOpenContainer(
          item: item,
          builder: (_, __) => tile,
        );
      },
    );
  }
}
