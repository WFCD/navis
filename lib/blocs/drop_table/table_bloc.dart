import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:navis/models/drop_tables/slim.dart';
import 'package:navis/services/drop_data_service.dart';
import 'package:navis/services/services.dart';
import 'package:rxdart/rxdart.dart';

import 'table_event.dart';
import 'table_state.dart';

class TableSearchBloc extends Bloc<SearchEvent, SearchState> {
  final droptable = locator<DropTableService>();

  @override
  Stream<SearchState> transform(
    Stream<SearchEvent> events,
    Stream<SearchState> Function(SearchEvent event) next,
  ) {
    return super.transform(
      Observable<SearchEvent>(events).debounceTime(
        const Duration(milliseconds: 500),
      ),
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
              await compute(search, SearchTable(searchTerm, droptable.table));
          yield SearchStateSuccess(results);
        } catch (error) {
          yield SearchStateError('something went wrong');
        }
      }
    }
  }
}

List<Reward> search(SearchTable table) {
  final regex = RegExp(table.term);

  return table.rewards.where((r) => r.item.contains(regex)).toList();
}

class SearchTable {
  SearchTable(this.term, this.rewards);

  final String term;
  final List<Reward> rewards;
}
