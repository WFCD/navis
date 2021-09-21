import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../../../l10n/l10n.dart';
import '../../bloc/solsystem_bloc.dart';

class SteelPathCard extends StatelessWidget {
  const SteelPathCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: BlocBuilder<SolsystemBloc, SolsystemState>(
        buildWhen: (p, n) {
          if (p is SolState && n is SolState) {
            return p.worldstate.steelPath.expiry !=
                n.worldstate.steelPath.expiry;
          }
          return false;
        },
        builder: (context, state) {
          final steelPath = (state as SolState).worldstate.steelPath;

          return ListTile(
            title: Text(context.l10n.steelPathTitle),
            subtitle: Text(steelPath.currentReward.name),
            trailing: CountdownTimer(expiry: steelPath.expiry!),
          );
        },
      ),
    );
  }
}
