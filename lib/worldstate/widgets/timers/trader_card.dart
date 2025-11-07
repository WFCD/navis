import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/gen/assets.gen.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis/utils/utils.dart';
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
          if (traders == null) return const SizedBox.shrink();
          final trader = traders.firstWhere((t) => !t.node.contains('TennoCon'));
          final isActive = trader.isActive;
          final date = isActive ? trader.expiry : trader.activation;
          final dateFormatted = MaterialLocalizations.of(context).formatFullDate(date);
          final title = '${trader.character} ${isActive ? '| ${trader.node}' : ''}';

          return _TraderWidget(
            title: Text(title),
            subtitle: Text('${isActive ? context.l10n.baroLeavesOn : context.l10n.baroArrivesOn} $dateFormatted'),
            onTap: () => TraderPageRoute(trader.character, trader.inventory).push<void>(context),
            background: Assets.baroBanner.provider(),
            color: baroPurple,
            isActive: trader.isActive,
            activation: trader.activation,
            expiry: trader.expiry,
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
          if (trader == null) return const SizedBox.shrink();
          final schedule = trader.schedule;
          final current = schedule?[schedule.length - 2];
          final background = primeResurganceBackgrounds[current?.key?.split('/').last ?? ''];
          final hasBackground = background != null;

          return _TraderWidget(
            title: Text(trader.character),
            subtitle: Text(current?.resurgence?.replaceAll('Dual Pack', '').trim() ?? ''),
            background: hasBackground ? CachedNetworkImageProvider(background) : Assets.varziaBanner.provider(),
            color: Colors.blue[800],
            onTap: () => TraderPageRoute(trader.character, trader.inventory, isVarzia: true).push<void>(context),
            isActive: trader.isActive,
            activation: trader.activation,
            expiry: trader.expiry,
          );
        },
      ),
    );
  }
}

class _TraderWidget extends StatelessWidget {
  const _TraderWidget({
    required this.title,
    required this.subtitle,
    required this.background,
    required this.onTap,
    required this.activation,
    required this.expiry,
    this.isActive = false,
    this.color,
  });

  final Widget title;
  final Widget subtitle;
  final ImageProvider<Object> background;
  final Color? color;
  final bool isActive;
  final void Function() onTap;
  final DateTime activation;
  final DateTime expiry;

  @override
  Widget build(BuildContext context) {
    const containerHeight = 100.0;
    final date = isActive ? expiry : activation;

    return ImageContainer(
      height: containerHeight,
      imageProvider: background,
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: isActive ? onTap : null,
        child: ListTile(
          title: title,
          subtitle: subtitle,
          textColor: Colors.white,
          trailing: CountdownTimer(
            tooltip: context.l10n.countdownTooltip(date),
            color: color,
            expiry: (isActive ? expiry : activation),
          ),
        ),
      ),
    );
  }
}
