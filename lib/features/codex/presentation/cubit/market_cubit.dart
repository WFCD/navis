import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:market_client/market_client.dart';

import '../../../../core/error/failures.dart';
import '../../domian/usercases/get_orders.dart';

part 'market_state.dart';

class MarketCubit extends Cubit<MarketState> {
  MarketCubit(this.getOrders) : super(MarketInitial());

  final GetOrders getOrders;

  Future<void> findOrders(String item) async {
    emit(const FindingOrders());
    final _orders = await getOrders('chroma_prime_set');

    _orders.match(
      (orders) {
        if (orders.isNotEmpty) {
          emit(OrdersFound(orders));
        } else {
          emit(const NoOrdersFound());
        }
      },
      (f) {
        if (f is ServerFailure) {
          emit(const MarketError('Warframe Market returned and error'));
        }
      },
    );
  }
}
