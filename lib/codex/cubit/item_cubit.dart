import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/utils/utils.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

part 'item_state.dart';

class ItemCubit extends HydratedCubit<ItemState> {
  ItemCubit(this.name, this.repo) : super(ItemInitial());

  final String name;
  final WarframestatRepository repo;

  Future<void> fetchItem() async {
    final item = await _handleItemFetch(() async => repo.fetchItem(name));

    emit(ItemFetchSuccess(item));
  }

  Future<void> fetchByName() async {
    final items = await _handleItemFetch(() async => repo.searchItems(name));

    final item = items
        .where((item) => item.imageName != null)
        .firstWhereOrNull((item) => item.name == name);

    if (item == null) return emit(const NoItemFound());

    emit(ItemFetchSuccess(item));
  }

  Future<void> fetchIncarnonGenesis() async {
    final items = await _handleItemFetch(
      () async => repo.searchItems('Incarnon'),
    );

    final item = items.where((item) => item.imageName != null).firstWhereOrNull(
      (item) {
        return name.replaceAll(' ', '') == item.name.replaceAll(' ', '');
      },
    );

    if (item == null) return emit(const NoItemFound());

    emit(ItemFetchSuccess(item));
  }

  Future<T> _handleItemFetch<T>(FutureOr<T> Function() compute) async {
    try {
      return ConnectionManager.call(compute);
    } catch (e, s) {
      await Sentry.captureException(
        e,
        stackTrace: s,
        hint: Hint.withMap({'query': name}),
      );

      emit(const ItemFetchFailure('Failed to parse item'));

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
