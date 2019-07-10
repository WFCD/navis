import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:catcher/core/catcher.dart';
import 'package:flutter/foundation.dart';
import 'package:navis/models/drop_tables/slim.dart';
import 'package:navis/services/services.dart';
import 'package:navis/services/wfcd_repository.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:rxdart/rxdart.dart';

import 'table_event.dart';
import 'table_state.dart';

class TableSearchBloc extends Bloc<SearchEvent, SearchState> {
  TableSearchBloc();

  static Future<void> initializeTable() async {
    List<Drop> table;

    final File file = await wfcd.updateDropTable();
    table = await compute(jsonToRewards, await file.readAsString());

    _table = table;
  }

  static List<Drop> _table;

  static final wfcd = locator<WfcdRepository>();

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
          Catcher.reportCheckedError(error, stackTrace);
          yield SearchStateError('something went wrong');
        }
      }
    }
  }
}

List<Drop> _search(SearchTable drops) {
  return drops.rewards
      .where((r) => r.item.toLowerCase().contains(drops.term.toLowerCase()))
      .toList();
}

class SearchTable {
  SearchTable(this.term, this.rewards);

  final String term;
  final List<Drop> rewards;
}
