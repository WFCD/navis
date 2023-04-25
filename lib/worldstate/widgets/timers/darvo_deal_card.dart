import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/item_extensions.dart';
import 'package:navis/worldstate/cubits/darvodeal_cubit.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class DarvoDealCard extends StatelessWidget {
  const DarvoDealCard({super.key});

  bool _buildWhen(SolsystemState previous, SolsystemState current) {
    if (previous is! SolState || current is! SolState) return true;

    return previous.worldstate.dailyDeals.equals(current.worldstate.dailyDeals);
  }

  void _listener(BuildContext context, SolsystemState state) {
    if (state is! SolState) return;

    final deal = state.worldstate.dailyDeals.first;

    BlocProvider.of<DarvodealCubit>(context)
        .fetchDeal(deal.id ?? '', deal.item);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SolsystemCubit, SolsystemState>(
      listener: _listener,
      child: BlocBuilder<SolsystemCubit, SolsystemState>(
        buildWhen: _buildWhen,
        builder: (context, state) {
          final dailyDeals = (state as SolState).worldstate.dailyDeals;

          return AppCard(
            title: context.l10n.darvoNotificationTitle,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: _DealWidget(deal: dailyDeals.first),
          );
        },
      ),
    );
  }
}

class _DealWidget extends StatelessWidget {
  const _DealWidget({required this.deal});

  final DailyDeal deal;

  bool _buildWhen(DarvodealState previous, DarvodealState current) {
    if (previous is! DarvoDealLoaded || current is! DarvoDealLoaded) {
      // Return true so the UI can adapt to not having info.
      return true;
    }

    return previous.item.uniqueName == current.item.uniqueName;
  }

  @override
  Widget build(BuildContext context) {
    final expiry = deal.expiry!;
    final item = deal.item;
    final total = deal.total;
    final saleInfo = Theme.of(context)
        .textTheme
        .titleSmall
        ?.copyWith(fontWeight: FontWeight.w500);

    final theme = context.theme;
    final color = theme.isLight
        ? theme.colorScheme.primary
        : theme.colorScheme.primaryContainer;

    return BlocBuilder<DarvodealCubit, DarvodealState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (state is DarvoDealLoaded)
                  ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: state.item.imageUrl,
                      fit: BoxFit.contain,
                      width: 50,
                      errorWidget: (context, url, dynamic object) {
                        return Icon(
                          Icons.error_outline,
                          color: Theme.of(context).colorScheme.error,
                        );
                      },
                      placeholder: (context, url) => const SizedBox(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    title: Text(item),
                    subtitle: Text(
                      state.item.description?.parseHtmlString() ?? '',
                    ),
                  ),
                SizedBoxSpacer.spacerHeight16,
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    runSpacing: 5,
                    children: <Widget>[
                      if (state is! DarvoDealLoaded)
                        ColoredContainer.text(text: item),
                      ColoredContainer.text(
                        text: '${deal.salePrice}p',
                        style: saleInfo,
                        color: color,
                      ),
                      ColoredContainer.text(
                        text: '${total - deal.sold} / $total',
                        style: saleInfo,
                        color: color,
                      ),
                      ColoredContainer.text(
                        text: '${deal.discount}% OFF',
                        style: saleInfo,
                        color: color,
                      ),
                      CountdownTimer(
                        tooltip: context.l10n.countdownTooltip(expiry),
                        expiry: expiry,
                        style: saleInfo,
                      ),
                    ],
                  ),
                ),
                if (state is DarvoDealLoaded)
                  ButtonBar(
                    children: <Widget>[
                      if (state.item.wikiaUrl != null)
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(
                              Theme.of(context).textTheme.labelLarge?.color,
                            ),
                          ),
                          onPressed: () =>
                              state.item.wikiaUrl?.launchLink(context),
                          child: Text(context.l10n.seeWikia),
                        ),
                    ],
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
