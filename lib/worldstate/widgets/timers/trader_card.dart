import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/gen/assets.gen.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class BaroKiTeerCard extends StatelessWidget {
  const BaroKiTeerCard({super.key});

  @override
  Widget build(BuildContext context) {
    const baroPurple = Color(0xFF82598b);

    return AppCard(
      clipBehavior: Clip.antiAlias,
      color: baroPurple,
      padding: EdgeInsets.zero,
      child: BlocSelector<WorldstateBloc, WorldState, List<Trader>?>(
        selector: (s) => switch (s) {
          WorldstateSuccess() => s.seed.voidTraders,
          _ => null,
        },
        builder: (context, traders) {
          final trader = traders?.firstWhere((t) => !t.location.contains('TennoCon'));

          return _TraderWidget(trader: trader!, background: Assets.baroBanner.provider(), color: baroPurple);
        },
      ),
    );
  }
}

class VarziaTraderCard extends StatelessWidget {
  const VarziaTraderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      clipBehavior: Clip.antiAlias,
      color: Colors.blue[800],
      padding: EdgeInsets.zero,
      child: BlocSelector<WorldstateBloc, WorldState, Trader?>(
        selector: (s) => switch (s) {
          WorldstateSuccess() => s.seed.vaultTrader,
          _ => null,
        },
        builder: (context, trader) {
          return _TraderWidget(
            trader: trader!,
            background: Assets.varziaBanner.provider(),
            color: Colors.blue[800],
            isVarzia: true,
          );
        },
      ),
    );
  }
}

class _TraderWidget extends StatelessWidget {
  const _TraderWidget({required this.trader, required this.background, this.color, this.isVarzia = false});

  final Trader trader;
  final ImageProvider<Object> background;
  final Color? color;
  final bool isVarzia;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isActive = trader.active;
    final date = isActive ? trader.expiry : trader.activation;
    final dateFormatted = MaterialLocalizations.of(context).formatFullDate(date);
    final status = isActive ? l10n.baroLeavesOn : l10n.baroArrivesOn;
    final character = trader.character.isNotEmpty ? trader.character : 'Varzia';
    final title = '$character ${isActive ? '| ${trader.location}' : ''}';

    return ImageContainer(
      height: 100,
      imageProvider: background,
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: isActive
            ? () => TraderPageRoute(character, trader.inventory, isVarzia: isVarzia).push<void>(context)
            : null,
        child: ListTile(
          title: Text(title),
          subtitle: Text('$status $dateFormatted'),
          textColor: Colors.white,
          trailing: CountdownTimer(
            tooltip: l10n.countdownTooltip(date),
            color: color,
            expiry: (isActive ? trader.expiry : trader.activation),
          ),
        ),
      ),
    );
  }
}
