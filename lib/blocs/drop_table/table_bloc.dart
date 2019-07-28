import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:navis/models/slim_drop_table.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:rxdart/rxdart.dart';

import 'table_event.dart';
import 'table_state.dart';

class TableSearchBloc extends Bloc<SearchEvent, SearchState> {
  TableSearchBloc(this.repository) {
    _initializeTable();
  }

  final Repository repository;

  Future<void> _initializeTable() async {
    List<Drop> table;

    final File file = await repository.updateDropTable();
    table = await compute(jsonToRewards, await file.readAsString());

    _table = table;
  }

  static List<Drop> _table;

  @override
  Stream<SearchState> transform(
    Stream<SearchEvent> events,
    Stream<SearchState> Function(SearchEvent event) next,
  ) {
    return super.transform(
      Observable<SearchEvent>(events)
          .distinct()
          .debounceTime(const Duration(milliseconds: 500)),
      next,
    );
  }

  @override
  SearchState get initialState => SearchStateEmpty();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is TextChanged) {
      final String searchTerm = event.text;
      if (searchTerm.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();
        try {
          final results =
              await compute(_search, SearchTable(searchTerm, _table));

          yield SearchStateSuccess(results);
        } catch (error, stackTrace) {
          Crashlytics.instance.recordError(error, stackTrace);
          yield SearchStateError('something went wrong');
        }
      }
    }

    if (event is SearchSort) {
      const sorted = null;

      yield SearchStateSuccess(sorted);
    }
  }
}

List<Drop> _search(SearchTable drops) {
  return drops.rewards
      .where((r) => r.item.toLowerCase().contains(drops.term.toLowerCase()))
      .toList()
        ..sort((a, b) => a.chance.compareTo(b.chance));
}

class SearchTable {
  SearchTable(this.term, this.rewards);

  final String term;
  final List<Drop> rewards;
}
