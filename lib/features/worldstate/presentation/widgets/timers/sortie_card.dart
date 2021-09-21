import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/default_durations.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../bloc/solsystem_bloc.dart';
import '../common/faction_logo.dart';

class SortieCard extends StatelessWidget {
  const SortieCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final boss = textTheme.headline6;
    final nodeMission = textTheme.subtitle1?.copyWith(fontSize: 15);
    final modifier = textTheme.caption?.copyWith(fontSize: 13);

    return BlocBuilder<SolsystemBloc, SolsystemState>(
      buildWhen: (p, n) =>
          (p as SolState).worldstate.sortie.expiry !=
          (n as SolState).worldstate.sortie.expiry,
      builder: (context, state) {
        final sortie = (state as SolState).worldstate.sortie;

        return CustomCard(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                ListTile(
                  leading: FactionIcon(
                    faction: sortie.faction,
                    iconSize: 35,
                  ),
                  title: Text(sortie.boss, style: boss),
                  trailing: CountdownTimer(
                    expiry:
                        sortie.expiry ?? DateTime.now().subtract(kDelayLong),
                  ),
                ),
                for (final variant in sortie.variants)
                  ListTile(
                    title: Text('${variant.missionType} - ${variant.node}',
                        style: nodeMission),
                    subtitle: Text(variant.modifier, style: modifier),
                  )
              ]),
        );
      },
    );
  }
}
