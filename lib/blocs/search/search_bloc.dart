import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:navis/services/worldstate_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

import 'search_event.dart';
import 'search_state.dart';
import 'search_utils.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.api) {
    _initializeTables();
  }

  final WorldstateService api;

  List<SlimDrop> _dropTable;

  SearchTypes searchType = SearchTypes.drops;

  Future<void> _initializeTables() async {
    try {
      final File table = await api.initializeDropTable();

      _dropTable = await compute(convertToDrop, table?.readAsStringSync());
    } catch (e) {
      dispatch(SearchError(
          'Downloading drop table failed, searching the drop table will not be possible'));
    }
  }

  @override
  SearchState get initialState => SearchStateEmpty();

  @override
  Stream<SearchState> transformEvents(Stream<SearchEvent> events,
      Stream<SearchState> Function(SearchEvent event) next) {
    return super.transformEvents(
        (events as Observable<SearchEvent>)
            .distinct()
            .debounceTime(const Duration(milliseconds: 500)),
        next);
  }

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is TextChanged) {
      final searchText = event.text;

      if (searchText.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();

        try {
          final results = searchType != SearchTypes.drops
              ? await api.search(searchText)
              : await compute(searchDropTable,
                  SearchDropTable(searchText, _dropTable ?? []));

          yield SearchStateSuccess(results);
        } catch (e) {
          yield SearchStateError(e.toString());
        }
      }
    }

    if (event is SwitchSearchType) {
      searchType = event.searchType;

      yield SearchStateEmpty();
    }

    if (event is SortSearch) {
      if (searchType == SearchTypes.drops) {
        final sorted =
            await compute(sortDrops, SortedDrops(event.sortBy, event.results));

        yield SearchStateSuccess(sorted, sortBy: event.sortBy);
      }
    }

    if (event is SearchError) {
      yield SearchListenerError(event.error);
    }
  }
}
