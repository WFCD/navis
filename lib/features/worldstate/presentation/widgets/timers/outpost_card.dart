import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../bloc/solsystem_bloc.dart';
import '../common/faction_icons.dart';

class SentientOutpostCard extends StatelessWidget {
  const SentientOutpostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: BlocBuilder<SolsystemBloc, SolsystemState>(
        buildWhen: (p, n) {
          if (p is SolState && n is SolState) {
            return p.worldstate.sentientOutposts.expiry !=
                n.worldstate.sentientOutposts.expiry;
          }
          return false;
        },
        builder: (context, state) {
          final outpost = (state as SolState).worldstate.sentientOutposts;
          final mission = outpost.mission;

          return ListTile(
            leading: const Icon(FactionIcons.sentient, size: 50),
            title: Text(mission?.node ?? ''),
            subtitle: Text('${mission?.faction} | ${mission?.type}'),
            trailing: CountdownTimer(expiry: outpost.expiry!),
          );
        },
      ),
    );
  }
}
