import 'dart:async';

import 'package:codex/codex.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:navis/utils/utils.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

part 'item_state.dart';

class ItemCubit extends HydratedCubit<ItemState> {
  ItemCubit(this.name, this.codex, this.repo) : super(ItemInitial());

  /// Can be Item name or Item uniqueName
  final String name;
  final Codex codex;
  final WarframestatRepository repo;

  static final _logger = Logger('ItemCubit');

  Future<void> fetchItem() async {
    emit(ItemFetchInProgress());

    final item = await _handleItemFetch(() => repo.fetchItem(name)) as ItemCommon?;
    if (isClosed) return;
    if (item == null) return emit(ItemNotFound());

    emit(ItemFetchSuccess(item));
  }

  Future<void> fetchByName() async {
    emit(ItemFetchInProgress());

    final items = await codex.search(name);
    final cItem = items.where((item) => item.imageName != null).firstWhereOrNull((item) => item.name == name);
    if (cItem == null) return emit(ItemNotFound());

    final item = await _handleItemFetch(() => repo.fetchItem(cItem.uniqueName)) as ItemCommon?;
    if (isClosed) return;

    emit(ItemFetchSuccess(_toMisc(item!)));
  }

  Future<void> fetchIncarnonGenesis() async {
    emit(ItemFetchInProgress());

    final items = await codex.search('Incarnon');
    final item = items.where((item) => item.imageName != null).firstWhereOrNull((item) {
      return name.replaceAll(' ', '') == item.name.replaceAll(' ', '');
    });

    if (isClosed) return;
    if (item == null) return emit(ItemNotFound());

    final misc = Misc(
      uniqueName: item.uniqueName,
      name: item.name,
      description: item.description,
      type: item.type,
      category: item.category,
      productCategory: '',
      imageName: item.imageName,
      tradable: false,
      patchlogs: const [],
      releaseDate: '',
      excludeFromCodex: false,
      wikiaThumbnail: item.wikiaThumbnail,
      wikiaUrl: item.wikiaUrl,
    );

    emit(ItemFetchSuccess(misc));
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

  Misc _toMisc(ItemCommon item) {
    return Misc(
      uniqueName: item.uniqueName,
      name: item.name,
      description: item.description,
      type: item.type,
      category: item.category,
      productCategory: item.productCategory,
      imageName: item.imageName,
      tradable: item.tradable,
      patchlogs: item.patchlogs,
      releaseDate: item.releaseDate,
      excludeFromCodex: item.excludeFromCodex,
      wikiaThumbnail: item.wikiaThumbnail,
      wikiaUrl: item.wikiaUrl,
    );
  }
}
