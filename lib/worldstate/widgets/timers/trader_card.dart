import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          WorldstateSuccess() => state.worldstate.voidTrader,
          _ => null,
        };

        final isActive = trader?.active ?? false;
        final date = MaterialLocalizations.of(context).formatFullDate(
          isActive ? trader?.expiry ?? now : trader?.activation ?? now,
        );

        final status = isActive ? l10n.baroLeavesOn : l10n.baroArrivesOn;
        final title = '${l10n.baroTitle} '
            '${isActive ? '| ${trader?.location ?? ''}' : ''}';

        return Theme(
          data: NavisThemes.dark,
          child: Card(
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
                  imageProvider: const AssetImage(
                    'assets/baro_banner.webp',
                    package: 'navis_ui',
                  ),
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    title: Text(title),
                    subtitle: Text(
                      '$status $date',
                    ),
                    trailing: CountdownTimer(
                      tooltip: l10n.countdownTooltip(date),
                      color: const Color(0xFF82598b),
                      // Will default to DateTime.now() under the hood.
                      // ignore: avoid-non-null-assertion
                      expiry:
                          (isActive ? trader?.expiry : trader?.activation) ??
                              now,
                    ),
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
