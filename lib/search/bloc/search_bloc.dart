import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:item_repository/items_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:warframe_common/warframe_common.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.codex) : super(SearchEmpty()) {
    on<ItemsSearchTextChanged>(_searchItems, transformer: _waitForUser());
    on<MasteryItemSearchTextChanged>(_searchMastery, transformer: _waitForUser());
    on<ItemResultsFiltered>(_filterResults);
  }

  final ItemsRepository codex;

  List<WarframeItem> _originalResults = [];

  Future<void> _searchItems(SearchTextChanged event, Emitter<SearchState> emit) async {
    final text = event.text;

    if (text.isEmpty) {
      emit(SearchEmpty());
    } else {
      emit(SearchInProgress());

      try {
        _originalResults = await codex.search(text);
        emit(SearchSuccessful(_originalResults));
      } on Exception catch (e, stack) {
        addError(e, stack);
        emit(SearchFailure(text));
      }
    }
  }

  Future<void> _searchMastery(SearchTextChanged event, Emitter<SearchState> emit) async {
    final text = event.text;

    if (text.isEmpty) {
      emit(SearchEmpty());
    } else {
      emit(SearchInProgress());

      try {
        final results = await codex.searchMasterable(text);
        emit(SearchSuccessful(results));
      } on Exception catch (e, stack) {
        addError(e, stack);
        emit(SearchFailure(text));
      }
    }
  }

  Future<void> _filterResults(ItemResultsFiltered event, Emitter<SearchState> emit) async {
    emit(SearchInProgress());

    final type = event.type;
    if (type == null) return emit(SearchSuccessful(_originalResults));

    final results = _originalResults.filterByCategory(type).toList();
    emit(SearchSuccessful(results));
  }

  EventTransformer<T> _waitForUser<T extends SearchTextChanged>() {
    return (event, mapper) {
      return event.debounceTime(const Duration(milliseconds: 500)).distinct().flatMap(mapper);
    };
  }
}
