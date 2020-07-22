import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:navis/core/error/exceptions.dart';
import 'package:navis/features/codex/domian/usercases/search_items.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supercharged/supercharged.dart';

import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.searchItems) : super(CodexSearchEmpty());

  final SearchItems searchItems;

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
}
