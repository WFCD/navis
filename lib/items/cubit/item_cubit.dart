import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:item_repository/items_repository.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:navis/utils/utils.dart';
import 'package:warframe_common/warframe_common.dart';

part 'item_state.dart';

class ItemCubit extends HydratedCubit<ItemState> with SafeBlocMixin {
  ItemCubit(this.repo) : super(ItemInitial());

  final ItemsRepository repo;

  Future<void> fetchItem(String uniqueName) async {
    emit(ItemFetchInProgress());
    await safeEmit(
      () async {
        final item = await repo.fetchItemFStore(uniqueName);
        if (item == null) return ItemNotFound(uniqueName);
        return ItemStoreFetchSuccess(item);
      },
      onError: (error, stackTrace) => ItemFetchFailure(exception: error, stackTrace: stackTrace),
    );
  }

  Future<void> fetchByName(String name) async {
    emit(ItemFetchInProgress());
    await safeEmit(
      () async {
        final item = await repo.fetchFStorByName(name);
        if (item == null) return ItemNotFound(name);
        return ItemStoreFetchSuccess(item);
      },
      onError: (error, stackTrace) => ItemFetchFailure(exception: error, stackTrace: stackTrace),
    );
  }

  Future<void> fetchIncarnon(String name) async {
    emit(ItemFetchInProgress());
    await safeEmit(
      () async {
        final item = await repo.searchIncarnon(name);
        if (item == null) return ItemNotFound(name);
        return ItemStoreFetchSuccess(item);
      },
      onError: (error, stackTrace) => ItemFetchFailure(exception: error, stackTrace: stackTrace),
    );
  }

  Future<void> fetchItemApi(String uniqueName) async {
    emit(ItemFetchInProgress());
    await safeEmit(
      () async {
        final item = await ConnectionManager.call(() => repo.fetchItemFApi(uniqueName));
        if (item == null) return ItemNotFound(uniqueName);
        return ItemApiFetchSuccess(item as ItemCommon);
      },
      onError: (error, stackTrace) => ItemFetchFailure(exception: error, stackTrace: stackTrace),
    );
  }

  @override
  ItemState? fromJson(Map<String, dynamic> json) {
    final item = Misc.fromJson(json);
    return ItemApiFetchSuccess(item as ItemCommon);
  }

  @override
  Map<String, dynamic>? toJson(ItemState state) {
    // Only persist API calls everything else is local and just as fast
    if (state case ItemApiFetchSuccess(:final item)) return item.toJson();
    return null;
  }

  @override
  String toString() => 'ItemCubit()';
}
