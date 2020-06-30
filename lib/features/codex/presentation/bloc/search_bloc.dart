import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:navis/core/error/exceptions.dart';
import 'package:navis/features/codex/domian/usercases/search_items.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supercharged/supercharged.dart';
import 'package:wfcd_client/wfcd_client.dart';

import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends HydratedBloc<SearchEvent, SearchState> {
  SearchBloc(this.searchItems);

  final SearchItems searchItems;

  @override
  SearchState get initialState => CodexSearchEmpty();

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    Stream<SearchEvent> events,
    TransitionFunction<SearchEvent, SearchState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(500.milliseconds).distinct(),
      transitionFn,
    );
  }

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchCodex) {
      final text = event.text;

      if (text.isEmpty) {
        yield CodexSearchEmpty();
      } else {
        yield CodexSearching();

        try {
          final results = await searchItems(text);

          yield results.fold(
            (l) => matchFailure<SearchState>(l),
            (r) => CodexSuccessfulSearch(r),
          );
        } catch (e) {
          yield const CodexSearchError('Unknown Error occuroed');
        }
      }
    }
  }

  @override
  SearchState fromJson(Map<String, dynamic> json) {
    final results = toBaseItems(json['results'] as List<dynamic>);

    return CodexSuccessfulSearch(results);
  }

  @override
  Map<String, dynamic> toJson(SearchState state) {
    // if (state is CodexSuccessfulSearch) {
    //   final results = state.results.map((e) => fromBaseItem(e)).toList();

    //   return <String, dynamic>{'results': results};
    // }

    return null;
  }
}
