import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navis/global_keys.dart';
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
    } catch (error, stack) {
      scaffold.currentState.showSnackBar(
        SnackBar(
          content: const Text('Failed to download drop table,'
              ' searching drop table will yield zero results until one is downloaded'),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () => _initializeTables(),
          ),
        ),
      );

      Crashlytics.instance.recordError(error, stack);
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
              ? api.search(searchText)
              : compute(searchDropTable,
                  SearchDropTable(searchText, _dropTable ?? []));

          yield SearchStateSuccess(await results);
        } catch (e) {
          yield SearchStateError(e.toString());
        }
      }
    }

    if (event is SwitchSearchType) {
      searchType = event.searchType;
    }

    if (event is SortSearch) {
      if (searchType == SearchTypes.drops) {
        final sorted =
            await compute(sortDrops, SortedDrops(event.sortBy, event.results));

        yield SearchStateSuccess(sorted);
      }
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    Crashlytics.instance.recordError(error, stacktrace);
  }
}
