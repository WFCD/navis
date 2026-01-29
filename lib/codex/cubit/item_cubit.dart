import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/utils/bloc_mixin.dart';
import 'package:navis/utils/utils.dart';
import 'package:navis_codex/navis_codex.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

part 'item_state.dart';

class ItemCubit extends HydratedCubit<ItemState> with SafeBlocMixin {
  ItemCubit(this.name, this.codex, this.repo) : super(ItemInitial());

  /// Can be Item name or Item uniqueName
  final String name;
  final CodexDatabase codex;
  final WarframestatRepository repo;

  Future<void> fetchItem() async {
    await safeEmit(
      () async {
        final item = await _handleItemFetch(() => repo.fetchItem(name)) as ItemCommon?;
        if (item == null) return ItemNotFound();

        return ItemFetchSuccess(item);
      },
      onError: (error, stackTrace) => ItemFetchFailure(exception: error, stackTrace: stackTrace),
    );
  }

  Future<void> fetchByName() async {
    await safeEmit(
      () async {
        final items = await _handleItemFetch(() => codex.search(name));
        final item = items.where((item) => item.imageName != null).firstWhereOrNull((item) => item.name == name);
        if (item == null) return ItemNotFound();

        final externalItem = await repo.fetchItem(item.uniqueName);

        return ItemFetchSuccess(externalItem! as ItemCommon);
      },
      onError: (error, stackTrace) => ItemFetchFailure(exception: error, stackTrace: stackTrace),
    );
  }

  Future<void> fetchIncarnonGenesis() async {
    await safeEmit(
      () async {
        final items = await _handleItemFetch(() async => codex.search('Incarnon'));
        final item = items.where((item) => item.imageName != null).firstWhereOrNull((item) {
          return name.replaceAll(RegExp('and', caseSensitive: false), '&') == item.name;
        });

        if (item == null) return ItemNotFound();

        final externalItem = await repo.fetchItem(item.uniqueName);

        return ItemFetchSuccess(externalItem! as ItemCommon);
      },
      onError: (error, stackTrace) => ItemFetchFailure(exception: error, stackTrace: stackTrace),
    );
  }

  Future<T> _handleItemFetch<T>(FutureOr<T> Function() compute) {
    emit(ItemFetchInProgress());
    return ConnectionManager.call(compute);
  }

  @override
  String get id => name;

  @override
  ItemState? fromJson(Map<String, dynamic> json) {
    final item = Misc.fromJson(json);

    return ItemFetchSuccess(item as ItemCommon);
  }

  @override
  Map<String, dynamic>? toJson(ItemState state) {
    if (state is! ItemFetchSuccess) return null;

    return state.item.toJson();
  }
}
