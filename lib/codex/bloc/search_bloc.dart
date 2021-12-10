import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:navis/codex/bloc/search_event.dart';
import 'package:navis/codex/bloc/search_state.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:rxdart/rxdart.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

export 'search_event.dart';
export 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.repository) : super(CodexSearchEmpty()) {
    on<SearchCodex>(_searchCodex, transformer: _waitForUser());
  }

  final WorldstateRepository repository;

  Future<void> _searchCodex(
    SearchCodex event,
    Emitter<SearchState> emit,
  ) async {
    final text = event.text;

    if (text.isEmpty) {
      emit(CodexSearchEmpty());
    } else {
      emit(CodexSearching());

      try {
        final results = await repository.searchItems(text);
        emit(CodexSuccessfulSearch(results));
      } catch (e) {
        emit(const CodexSearchError('Unknown Error occuroed'));
      }
    }
  }

  EventTransformer<SearchCodex> _waitForUser() {
    return (event, mapper) {
      return event.debounceTime(kAnimationLong).distinct().flatMap(mapper);
    };
  }
}
