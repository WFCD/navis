import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/gen/assets.gen.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';

class TraderCard extends StatelessWidget {
  const TraderCard({super.key});

  bool _buildWhen(SolsystemState previous, SolsystemState current) {
    if (previous is! WorldstateSuccess || current is! WorldstateSuccess) {
      return false;
    }

    final previousTrader = previous.worldstate.voidTraders.first;
    final currentTrader = current.worldstate.voidTraders.first;

    return previousTrader.id != currentTrader.id;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<WorldstateCubit, SolsystemState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final now = DateTime.now();
        final trader = switch (state) {
          WorldstateSuccess() => state.worldstate.voidTraders.first,
          _ => null,
        };

        final isActive = trader?.active ?? false;
        final date = isActive ? trader?.expiry ?? now : trader?.activation ?? now;
        final dateFormatted = MaterialLocalizations.of(context).formatFullDate(date);
        final status = isActive ? l10n.baroLeavesOn : l10n.baroArrivesOn;
        final title = '${l10n.baroTitle} ${isActive ? '| ${trader?.location ?? ''}' : ''}';

        return Card(
          clipBehavior: Clip.antiAlias,
          color: const Color(0xFF82598b),
          child: InkWell(
            onTap: isActive ? () => TraderPageRoute(trader?.inventory).push<void>(context) : null,
            child: SizedBox(
              height: 150,
              child: ImageContainer(
                imageProvider: Assets.baroBanner.provider(),
                padding: EdgeInsets.zero,
                child: ListTile(
                  title: Text(title),
                  subtitle: Text('$status $dateFormatted'),
                  textColor: Colors.white,
                  trailing: CountdownTimer(
                    tooltip: l10n.countdownTooltip(date),
                    color: const Color(0xFF82598b),
                    expiry: (isActive ? trader?.expiry : trader?.activation) ?? now,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
