import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_repository/warframestat_repository.dart';
import 'package:worldstate_models/worldstate_models.dart';

class FlashSalesPage extends StatelessWidget {
  const FlashSalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<WarframestatRepository>(context);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.flashSaleAppbarTitle)),
      body: BlocProvider(create: (_) => WorldstateBloc(repo), child: const FlashSalesView()),
    );
  }
}

class FlashSalesView extends StatelessWidget {
  const FlashSalesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WorldstateBloc, WorldState, List<FlashSale>?>(
      selector: (state) {
        return switch (state) {
          WorldstateSuccess(seed: final seed) => seed.flashSales,
          _ => null,
        };
      },
      builder: (context, sales) {
        final shownInMarket = sales ?? [];

        return ViewLoading(
          isLoading: sales == null,
          child: ListView.builder(
            itemCount: shownInMarket.length,
            itemBuilder: (context, index) {
              final sale = shownInMarket[index];
              final saleDuration = sale.expiry.difference(DateTime.timestamp());

              return ListTile(
                title: Text(sale.item),
                subtitle: Text(context.l10n.flashSaleSubtitleText(sale.premiumOverride, sale.discount.ceil())),
                trailing: saleDuration < const Duration(days: 30)
                    ? CountdownTimer(tooltip: context.l10n.countdownTooltip(sale.expiry), expiry: sale.expiry)
                    : null,
              );
            },
          ),
        );
      },
    );
  }
}
