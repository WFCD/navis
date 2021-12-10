import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_repository/market_repository.dart';
import 'package:navis/codex/cubit/market_bloc.dart';
import 'package:navis/codex/widgets/market/market_order.dart';
import 'package:navis/injection_container.dart';

class MarketItemView extends StatelessWidget {
  const MarketItemView({Key? key, required this.itemName}) : super(key: key);

  final String itemName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MarketCubit(sl<MarketRepository>())..findOrder(itemName),
      child: const Market(),
    );
  }
}

class Market extends StatelessWidget {
  const Market({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketCubit, MarketState>(
      builder: (context, state) {
        if (state is OrdersFound) {
          final orders = state.orders;

          return ListView.builder(
            key: const PageStorageKey('market'),
            padding: EdgeInsets.zero,
            itemCount: orders.length,
            itemBuilder: (_, index) => MarketSellWidget(order: orders[index]),
          );
        }

        if (state is NoOrdersFound) {
          return const Center(
            child: Text('No seller orders found for this item'),
          );
        }

        if (state is MarketError) {
          return Center(
            child: Text(state.message),
          );
        }

        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}
