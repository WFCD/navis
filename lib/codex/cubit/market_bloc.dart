import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:market_client/market_client.dart';
import 'package:market_repository/market_repository.dart';
import 'package:navis/codex/cubit/market_state.dart';

export 'market_state.dart';

class MarketCubit extends HydratedCubit<MarketState> {
  MarketCubit(this.repository) : super(MarketInitial());

  final MarketRepository repository;

  Future<void> findOrder(String itemName) async {
    emit(const FindingOrders());

    try {
      final orders = await repository.retriveOrders(itemName);

      if (orders.isNotEmpty) {
        emit(OrdersFound(orders..sort((a, b) => a.compareTo(b))));
      } else {
        emit(const NoOrdersFound());
      }
    } on MarketServerException {
      emit(const MarketError('Warframe Market returned and error'));
    } catch (e) {
      emit(const MarketError('Unknown error occured'));
    }
  }

  @override
  MarketState? fromJson(Map<String, dynamic> json) {
    final orders = json['orders'] as List<dynamic>;

    return OrdersFound(
      orders
          .map((dynamic e) => OrderRow.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Map<String, dynamic>? toJson(MarketState state) {
    if (state is OrdersFound && state.orders.isNotEmpty) {
      final orders = state.orders.map((e) => e.toJson());

      return <String, dynamic>{'orders': orders.toList()};
    }

    return null;
  }
}
