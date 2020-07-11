import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/utils/search_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:warframestat_api_models/warframestat_api_models.dart';

import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.repository) : super(SearchStateEmpty());

  final Repository repository;

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    events,
    transitionFn,
  ) {
    return super.transformEvents(
      events.distinct().debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    final type = repository.persistent?.searchType ?? CodexDatabase.drops;

    if (event is TextChanged) {
      final searchText = event.text;

      if (searchText.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();

        try {
          if (type == CodexDatabase.drops) {
            final results = await repository.searchDrops(searchText);

            yield SearchStateSuccess<SlimDrop>(results);
          } else {
            final results = await repository.searchItems(searchText);

            yield SearchStateSuccess<BaseItem>(results);
          }
        } catch (exception, stack) {
          Crashlytics.instance.recordError(exception, stack);
          yield SearchStateError(exception.toString());
        }
      }
    }

    if (event is SortSearch) {
      if (type == CodexDatabase.drops) {
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
