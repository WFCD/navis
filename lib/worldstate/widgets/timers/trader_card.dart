import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/gen/assets.gen.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class TraderCard extends StatelessWidget {
  const TraderCard({super.key});

  @override
  Widget build(BuildContext context) {
    const baroPurple = Color(0xFF82598b);
    final l10n = context.l10n;

    return Card(
      clipBehavior: Clip.antiAlias,
      color: baroPurple,
      child: BlocSelector<WorldstateCubit, SolsystemState, List<Trader>?>(
        selector:
            (s) => switch (s) {
              WorldstateSuccess() => s.worldstate.voidTraders,
              _ => null,
            },
        builder: (context, traders) {
          final now = DateTime.timestamp();
          final trader = traders?.first;
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
      ),
    );
  }
}
