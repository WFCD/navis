import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:navis/services/worldstate_service.dart';
import 'package:navis/utils/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

import 'search_event.dart';
import 'search_state.dart';
import 'search_utils.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.api, this.storage) {
    _initializeTables();
  }

  final WorldstateService api;
  final Box storage;

  List<SlimDrop> _dropTable;

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

  Future<List<Equatable>> _search(SearchTypes type, String searchText) async {
    final results = type != SearchTypes.drops
        ? await api.search(searchText)
        : await compute(
            searchDropTable, SearchDropTable(searchText, _dropTable ?? []));

    return results;
  }

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    final searchType = stringToSearchType(storage.get('searchType'));

    if (event is TextChanged) {
      final searchText = event.text;

      if (searchText.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();

        try {
          final results = await _search(searchType, searchText);

          yield SearchStateSuccess(results);
        } catch (e) {
          yield SearchStateError(e.toString());
        }
      }
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
