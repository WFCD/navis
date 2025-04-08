import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';
import 'package:warframestat_client/warframestat_client.dart';

class SteelPathCard extends StatelessWidget {
  const SteelPathCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocSelector<WorldstateBloc, WorldState, SteelPath?>(
        selector:
            (s) => switch (s) {
              WorldstateSuccess() => s.seed.steelPath,
              _ => null,
            },
        builder: (context, steelPath) {
          final expiry = steelPath?.expiry ?? DateTime.timestamp();

          return ListTile(
            leading: const AppIcon(WarframeIcons.spLogo, size: 30),
            title: Text(context.l10n.steelPathTitle),
            subtitle: Text(steelPath?.currentReward.name ?? ''),
            trailing: CountdownTimer(tooltip: context.l10n.countdownTooltip(expiry), expiry: expiry),
          );
        },
      ),
    );
  }
}
