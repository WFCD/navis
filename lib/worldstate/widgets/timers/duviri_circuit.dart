import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:item_repository/items_repository.dart';
import 'package:navis/items/items.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/string_extensions.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class DuviriCircuit extends StatelessWidget {
  const DuviriCircuit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WorldstateBloc, WorldState, DuviriCycle?>(
      selector: (state) => switch (state) {
        WorldstateSuccess(:final seed) => seed.duviriCycle,
        _ => null,
      },
      builder: (context, cycle) {
        final choices = cycle?.choices.map((c) => CircuitChoiceTile(choice: c));

        return AppCard(
          child: CircuitResetTimer(
            expiry: cycle?.expiry ?? DateTime.now(),
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return Column(mainAxisSize: MainAxisSize.min, children: choices?.toList() ?? []);
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
  const CircuitResetTimer({super.key, required this.expiry, required this.onTap});

  final DateTime expiry;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final date = MaterialLocalizations.of(context).formatFullDate(expiry);

    return ListTile(
      hoverColor: Colors.transparent,
      title: Text(context.l10n.circuitResetTitle),
      subtitle: Text(context.l10n.circuitResetSubtitle),
      trailing: CountdownTimer(tooltip: date, expiry: weeklyReset()),
      onTap: onTap,
    );
  }
}

class CircuitChoiceTile extends StatelessWidget {
  const CircuitChoiceTile({super.key, required this.choice});

  final CircuitChoice choice;

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<ItemsRepository>(context);
    final isSteelPatch = choice.key == 'EXC_HARD';

    var category = toBeginningOfSentenceCase(choice.mode);
    if (isSteelPatch) category = context.l10n.steelPathTitle;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              category,
              style: context.textTheme.titleMedium?.copyWith(color: context.theme.colorScheme.secondary),
            ),
          ),
          ...choice.choices.map((c) {
            return BlocProvider(
              create: (_) {
                final cubit = ItemCubit(repo);
                isSteelPatch ? cubit.fetchIncarnon(c) : cubit.fetchByName(c);

                return cubit;
              },
              child: _CircuitPathTile(name: c),
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
          ItemStoreFetchSuccess() => state.item,
          _ => null,
        };

        final icon = item != null
            ? CircleAvatar(
                foregroundImage: CachedNetworkImageProvider(
                  item.imageName.warframeItemsCdn().optimize(pixelRatio: MediaQuery.devicePixelRatioOf(context)),
                ),
                radius: 20,
              )
            : null;

        final tile = ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          leading: icon,
          title: Text(item?.name ?? name),
          subtitle: Text(item?.description ?? '', maxLines: 1, overflow: TextOverflow.ellipsis),
          isThreeLine: true,
          dense: true,
        );

        if (item == null || item.name.contains('Incarnon')) return tile;

        return OpenItemContainer(item: item, closedBuilder: (_, _) => tile);
      },
    );
  }
}
