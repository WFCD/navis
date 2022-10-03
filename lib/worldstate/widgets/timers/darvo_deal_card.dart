import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/darvodeal_cubit.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class DarvoDealCard extends StatelessWidget {
  const DarvoDealCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolsystemCubit, SolsystemState>(
      buildWhen: (p, n) => (p as SolState)
          .worldstate
          .dailyDeals
          .equals((n as SolState).worldstate.dailyDeals),
      builder: (context, state) {
        final dailyDeals = (state as SolState).worldstate.dailyDeals;

        return AppCard(
          title: context.l10n.darvoNotificationTitle,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: _DealWidget(deal: dailyDeals.first),
        );
      },
    );
  }
}

class _DealWidget extends StatefulWidget {
  const _DealWidget({required this.deal});

  final DarvoDeal deal;

  @override
  _DealWidgetState createState() => _DealWidgetState();
}

class _DealWidgetState extends State<_DealWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DarvodealCubit>(context)
        .fetchDeal(widget.deal.id ?? '', widget.deal.item);
  }

  @override
  Widget build(BuildContext context) {
    // Will default to DateTime.now() under the hood.
    // ignore: avoid-non-null-assertion
    final expiry = widget.deal.expiry!;
    final item = widget.deal.item;
    final total = widget.deal.total;
    final saleInfo = Theme.of(context)
        .textTheme
        .subtitle2
        ?.copyWith(fontWeight: FontWeight.w500);

    return BlocBuilder<DarvodealCubit, DarvodealState>(
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
                      // It's what worked for the style.
                      // ignore: no-magic-number
                      width: 50,
                      errorWidget: (context, url, dynamic object) {
                        return Icon(
                          Icons.error_outline,
                          color: Theme.of(context).errorColor,
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
                    // It's what worked for the style.
                    // ignore: no-magic-number
                    spacing: 10,
                    // It's what worked for the style.
                    // ignore: no-magic-number
                    runSpacing: 5,
                    children: <Widget>[
                      if (state is! DarvoDealLoaded)
                        ColoredContainer.text(text: item),
                      ColoredContainer.text(
                        text: '${widget.deal.salePrice}p',
                        style: saleInfo,
                      ),
                      ColoredContainer.text(
                        text: '${total - widget.deal.sold} / $total',
                        style: saleInfo,
                      ),
                      ColoredContainer.text(
                        text: '${widget.deal.discount}% OFF',
                        style: saleInfo,
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
                              Theme.of(context).textTheme.button?.color,
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
