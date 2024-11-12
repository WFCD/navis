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
    try {
      final item = await ConnectionManager.call(
        () async => repo.fetchItem(name),
      );

      emit(ItemFetchSucess(item));
    } catch (e, s) {
      await Sentry.captureException(
        e,
        stackTrace: s,
        hint: Hint.withMap({'uniqueName': name}),
      );

      emit(const ItemFetchFailure('Failed to parse item'));
    }
  }

  Future<void> fetchByName() async {
    try {
      final items = await ConnectionManager.call(
        () async => repo.searchItems(name),
      );

      final item = items
          .where((item) => item.imageName != null)
          .firstWhereOrNull((item) => name == item.name);

      if (item == null) return emit(const NoItemFound());

      emit(ItemFetchSucess(item));
    } catch (e, s) {
      await Sentry.captureException(
        e,
        stackTrace: s,
        hint: Hint.withMap({'name': name}),
      );

      emit(const ItemFetchFailure('Failed to parse item'));
    }
  }

  @override
  String get id => name;

  @override
  ItemState? fromJson(Map<String, dynamic> json) {
    final item = toItem(json);

    return ItemFetchSucess(item);
  }

  @override
  Map<String, dynamic>? toJson(ItemState state) {
    if (state is! ItemFetchSucess) return null;

    return state.item.toJson();
  }
}
