import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:navis/utils/utils.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

part 'item_state.dart';

class ItemCubit extends HydratedCubit<ItemState> {
  ItemCubit(this.name, this.repo) : super(ItemInitial());

  final String name;
  final WarframestatRepository repo;

  static final _logger = Logger('ItemCubit');

  Future<void> fetchItem() async {
    final item = await _handleItemFetch(() => repo.fetchItem(name));
    if (!isClosed) return;
    if (item == null) return emit(const ItemNotFound());

    emit(ItemFetchSuccess(item));
  }

  Future<void> fetchByName() async {
    final items = await _handleItemFetch(() => repo.searchItems(name));

    final item = items.where((item) => item.imageName != null).firstWhereOrNull((item) => item.name == name);

    if (!isClosed) return;
    if (item == null) return emit(const ItemNotFound());

    emit(ItemFetchSuccess(item));
  }

  Future<void> fetchIncarnonGenesis() async {
    final items = await _handleItemFetch(() async => repo.searchItems('Incarnon'));

    final item = items.where((item) => item.imageName != null).firstWhereOrNull((item) {
      return name.replaceAll(' ', '') == item.name.replaceAll(' ', '');
    });

    if (!isClosed) return;
    if (item == null) return emit(const ItemNotFound());

    emit(ItemFetchSuccess(item));
  }

  Future<T> _handleItemFetch<T>(FutureOr<T> Function() compute) async {
    try {
      return ConnectionManager.call(compute);
    } catch (e, stack) {
      _logger.shout('Failed to parse $name', e, stack);
      emit(const ItemFetchFailure());

      rethrow;
    }
  }

  @override
  String get id => name;

  @override
  ItemState? fromJson(Map<String, dynamic> json) {
    final item = MinimalItem.fromJson(json);

    return ItemFetchSuccess(item);
  }

  @override
  Map<String, dynamic>? toJson(ItemState state) {
    if (state is! ItemFetchSuccess) return null;

    return state.item.toJson();
  }
}
