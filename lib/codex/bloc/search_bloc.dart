import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:navis/codex/bloc/search_event.dart';
import 'package:navis/codex/bloc/search_state.dart';
import 'package:navis/codex/utils/result_filters.dart';
import 'package:navis/utils/utils.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

export 'search_event.dart';
export 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.repository) : super(CodexSearchEmpty()) {
    on<SearchCodex>(_searchCodex, transformer: _waitForUser());
    on<FilterResults>(_filterResults);
  }

  final WorldstateRepository repository;

  List<MinimalItem> _results = [];

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
        CodexSuccessfulSearch state;
        if (await hasInternetConnection) {
          state = await _emitResults(text);
          emit(state);
        }

        state = await onReconnect(() async => _emitResults(text));
        emit(state);
      } catch (error, stackTrace) {
        await Sentry.captureException(
          error,
          stackTrace: stackTrace,
          hint: Hint.withMap({'query': event.text}),
        );

        emit(const CodexSearchError('Unknown Error occuroed'));
      }
    }
  }

  Future<CodexSuccessfulSearch> _emitResults(String query) async {
    _results = await repository.searchItems(query);

    return CodexSuccessfulSearch(_results);
  }

  Future<void> _filterResults(
    FilterResults event,
    Emitter<SearchState> emit,
  ) async {
    emit(CodexSearching());

    final originalResults = List<MinimalItem>.from(_results);
    if (event.category == WarframeItemCategory.all) {
      return emit(CodexSuccessfulSearch(originalResults));
    } else {
      final results = List<MinimalItem>.from(originalResults)
        ..retainWhere((e) => e.category.toLowerCase() == event.category.name);

      emit(CodexSuccessfulSearch(results));
    }
  }

  EventTransformer<SearchCodex> _waitForUser() {
    return (event, mapper) {
      return event.debounceTime(kAnimationLong).distinct().flatMap(mapper);
    };
  }
}
