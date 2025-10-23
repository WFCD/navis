import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/gen/assets.gen.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:worldstate_models/worldstate_models.dart';

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
          final trader = traders?.firstWhere((t) => !t.node.contains('TennoCon'));

          return _TraderWidget(
            trader: trader!,
            status: (isActive) => isActive ? context.l10n.baroLeavesOn : context.l10n.baroArrivesOn,
            background: Assets.baroBanner.provider(),
            color: baroPurple,
          );
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
            status: (_) => context.l10n.primeVaultResetText,
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
  const _TraderWidget({
    required this.trader,
    required this.status,
    required this.background,
    this.color,
    this.isVarzia = false,
  });

  final Trader trader;
  // ignore: avoid_positional_boolean_parameters doesn't work as a named prop (I think)
  final String Function(bool isActive) status;
  final ImageProvider<Object> background;
  final Color? color;
  final bool isVarzia;

  @override
  Widget build(BuildContext context) {
    final isActive = trader.isActive;
    final date = isActive ? trader.expiry : trader.activation;
    final dateFormatted = MaterialLocalizations.of(context).formatFullDate(date);
    final title = '${trader.character} ${isActive ? '| ${trader.node}' : ''}';

    return ImageContainer(
      height: 100,
      imageProvider: background,
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: isActive
            ? () => TraderPageRoute(trader.character, trader.inventory, isVarzia: isVarzia).push<void>(context)
            : null,
        child: ListTile(
          title: Text(title),
          subtitle: Text('${status(isActive)} $dateFormatted'),
          textColor: Colors.white,
          trailing: CountdownTimer(
            tooltip: context.l10n.countdownTooltip(date),
            color: color,
            expiry: (isActive ? trader.expiry : trader.activation),
          ),
        ),
      ),
    );
  }
}
