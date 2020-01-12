import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'search_event.dart';
import 'search_state.dart';

abstract class SearchBloc extends Bloc<SearchEvent, SearchState> {
  @override
  SearchState get initialState => SearchStateEmpty();

  @override
  Stream<SearchState> transformEvents(Stream<SearchEvent> events,
      Stream<SearchState> Function(SearchEvent event) next) {
    return super.transformEvents(
      events.distinct().debounceTime(const Duration(milliseconds: 500)),
      next,
    );
  }

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is TextChanged) {
      if (event.text.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();

        try {
          final results = await search(event.text);

          yield SearchStateSuccess(results);
        } catch (e) {
          yield SearchStateError();
        }
      }
    }
  }

  Future<List> search(String term);
}
