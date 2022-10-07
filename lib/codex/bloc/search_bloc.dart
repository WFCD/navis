import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:navis/codex/bloc/search_event.dart';
import 'package:navis/codex/bloc/search_state.dart';
import 'package:navis/codex/utils/result_filters.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wfcd_client/entities.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

export 'search_event.dart';
export 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.repository) : super(CodexSearchEmpty()) {
    on<SearchCodex>(_searchCodex, transformer: _waitForUser());
    on<FilterResults>(_filterResults);
  }

  final WorldstateRepository repository;

  List<Item> _results = [];

  Future<void> _searchCodex(
    SearchCodex event,
    Emitter<SearchState> emit,
  ) async {
    final text = event.text;

    if (text.isEmpty) {
      emit(CodexSearchEmpty());
    } else {
      emit(CodexSearching());

      try {
        _results = await repository.searchItems(text);
        emit(CodexSuccessfulSearch(_results));
      } catch (e) {
        emit(const CodexSearchError('Unknown Error occuroed'));
        rethrow;
      }
    }
  }

  Future<void> _filterResults(
    FilterResults event,
    Emitter<SearchState> emit,
  ) async {
    emit(CodexSearching());

    final originalResults = List<Item>.from(_results);
    if (FilterCategories.categories.contains(event.category)) {
      if (event.category == FilterCategories.all) {
        return emit(CodexSuccessfulSearch(originalResults));
      } else {
        final results = List<Item>.from(originalResults)
          ..retainWhere((e) => e.category == event.category.category);

        emit(CodexSuccessfulSearch(results));
      }
    }
  }

  EventTransformer<SearchCodex> _waitForUser() {
    return (event, mapper) {
      return event.debounceTime(kAnimationLong).distinct().flatMap(mapper);
    };
  }
}
