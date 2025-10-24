import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:navis/utils/utils.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

part 'item_state.dart';

class ItemCubit extends HydratedCubit<ItemState> {
  ItemCubit(this.name, this.repo) : super(ItemInitial());

  final String name;
  final WarframestatRepository repo;

  static final _logger = Logger('ItemCubit');

  Future<void> fetchItem() async {
    emit(ItemFetchInProgress());

    try {
      final item = await _handleItemFetch(() => repo.fetchItem(name)) as ItemCommon?;
      if (isClosed) return;
      if (item == null) return emit(ItemNotFound());

      emit(ItemFetchSuccess(item));
    } on FormatException {
      return emit(ItemNotFound());
    } on Exception catch (e, stack) {
      emit(ItemNotFound());
      await Sentry.captureException(e, stackTrace: stack);
    }
  }

  Future<void> fetchByName() async {
    emit(ItemFetchInProgress());

    try {
      final items = await _handleItemFetch(() => repo.searchItems(name));
      final item = items.where((item) => item.imageName != null).firstWhereOrNull((item) => item.name == name);

      if (isClosed) return;
      if (item == null) return emit(ItemNotFound());

      emit(ItemFetchSuccess(item.toMisc()));
    } on FormatException {
      return emit(ItemNotFound());
    } on Exception catch (e, stack) {
      emit(ItemNotFound());
      await Sentry.captureException(e, stackTrace: stack);
    }
  }

  Future<void> fetchIncarnonGenesis() async {
    emit(ItemFetchInProgress());

    try {
      final items = await _handleItemFetch(() async => repo.searchItems('Incarnon'));
      final item = items.where((item) => item.imageName != null).firstWhereOrNull((item) {
        return name.replaceAll(RegExp('and', caseSensitive: false), '&') == item.name;
      });

      if (isClosed) return;
      if (item == null) return emit(ItemNotFound());

      emit(ItemFetchSuccess(item.toMisc()));
    } on FormatException {
      return emit(ItemNotFound());
    } on Exception catch (e, stack) {
      emit(ItemNotFound());
      await Sentry.captureException(e, stackTrace: stack);
    }
  }

  Future<T> _handleItemFetch<T>(FutureOr<T> Function() compute) async {
    emit(ItemFetchInProgress());

    try {
      return ConnectionManager.call(compute);
    } on Exception catch (e, stack) {
      _logger.shout('Failed to parse $name', e, stack);
      emit(ItemFetchFailure(exception: e, stackTrace: stack));

      rethrow;
    }
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
