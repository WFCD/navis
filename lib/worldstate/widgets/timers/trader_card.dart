import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/gen/assets.gen.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';

class TraderCard extends StatelessWidget {
  const TraderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<WorldstateCubit, SolsystemState>(
      builder: (context, state) {
        final now = DateTime.now();
        final trader = switch (state) {
          WorldstateSuccess() => state.worldstate.voidTraders.first,
          _ => null,
        };

        final isActive = trader?.active ?? false;
        final date = MaterialLocalizations.of(context).formatFullDate(
          isActive ? trader?.expiry ?? now : trader?.activation ?? now,
        );

        final status = isActive ? l10n.baroLeavesOn : l10n.baroArrivesOn;
        final title = '${l10n.baroTitle} '
            '${isActive ? '| ${trader?.location ?? ''}' : ''}';

        return Card(
          clipBehavior: Clip.antiAlias,
          color: const Color(0xFF82598b),
          child: InkWell(
            onTap: isActive
                ? () => Navigator.of(context).pushNamed(
                      BaroInventory.route,
                      arguments: trader?.inventory,
                    )
                : null,
            child: SizedBox(
              height: 150,
              child: ImageContainer(
                imageProvider: Assets.baroBanner.provider(),
                padding: EdgeInsets.zero,
                child: ListTile(
                  title: Text(title),
                  subtitle: Text('$status $date'),
                  textColor: Colors.white,
                  trailing: CountdownTimer(
                    tooltip: l10n.countdownTooltip(date),
                    color: const Color(0xFF82598b),
                    expiry:
                        (isActive ? trader?.expiry : trader?.activation) ?? now,
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
