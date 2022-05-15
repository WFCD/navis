import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis_ui/navis_ui.dart';

class SortieCard extends StatelessWidget {
  const SortieCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final boss = textTheme.headline6;
    final nodeMission = textTheme.subtitle1?.copyWith(fontSize: 15);
    final modifier = textTheme.caption?.copyWith(fontSize: 13);

    return BlocBuilder<SolsystemCubit, SolsystemState>(
      buildWhen: (p, n) =>
          (p as SolState).worldstate.sortie.expiry !=
          (n as SolState).worldstate.sortie.expiry,
      builder: (context, state) {
        final sortie = (state as SolState).worldstate.sortie;
        final expiry = sortie.expiry!;

        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              ListTile(
                leading: FactionIcon(
                  name: sortie.factionKey ?? sortie.faction,
                  iconSize: 35,
                ),
                title: Text(sortie.boss, style: boss),
                trailing: CountdownTimer(
                  tooltip: context.l10n.countdownTooltip(expiry),
                  expiry: expiry,
                ),
              ),
              for (final variant in sortie.variants)
                ListTile(
                  title: Text(
                    '${variant.missionType} - ${variant.node}',
                    style: nodeMission,
                  ),
                  subtitle: Text(variant.modifier, style: modifier),
                )
            ],
          ),
        );
      },
    );
  }
}
