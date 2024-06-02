import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navis/utils/utils.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit(this.repo) : super(ItemInitial());

  final WarframestatRepository repo;

  Future<void> fetchItem(String uniqueName) async {
    try {
      Item item;
      if (await ConnectionManager.hasInternetConnection) {
        item = await repo.fetchItem(uniqueName);
      }

      item = await ConnectionManager.call(
        () async => repo.fetchItem(uniqueName),
      );

      emit(ItemFetchSucess(item));
    } catch (e, s) {
      await Sentry.captureException(
        e,
        stackTrace: s,
        hint: Hint.withMap({'uniqueName': uniqueName}),
      );

      emit(const ItemFetchFailure('Failed to parse item'));
    }
  }
}
