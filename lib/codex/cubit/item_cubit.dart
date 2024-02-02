import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit(this.repo) : super(ItemInitial());

  final WorldstateRepository repo;

  Future<void> fetchItem(String uniqueName) async {
    try {
      final item = await repo.fetchItem(uniqueName);

      emit(ItemFetchSucess(item));
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      emit(const ItemFetchFailure('Failed to parse item'));
    }
  }
}
