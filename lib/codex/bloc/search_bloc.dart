import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:navis/codex/bloc/search_event.dart';
import 'package:navis/codex/bloc/search_state.dart';
import 'package:navis/codex/utils/result_filters.dart';
import 'package:navis_codex/navis_codex.dart';
import 'package:rxdart/rxdart.dart';

export 'search_event.dart';
export 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.codex) : super(CodexSearchEmpty()) {
    on<CodexTextChanged>(_searchCodex, transformer: _waitForUser());
    on<CodexResultsFiltered>(_filterResults);
  }

  final CodexDatabase codex;

  List<CodexItem> _originalResults = [];

  Future<void> _searchCodex(CodexTextChanged event, Emitter<SearchState> emit) async {
    final text = event.text;

    if (text.isEmpty) {
      emit(CodexSearchEmpty());
    } else {
      emit(CodexSearchInProgress());

      try {
        final results = await codex.search(text);
        results.prioritizeResults();

        _originalResults = results;
        emit(CodexSearchSuccess(results));
      } on Exception catch (e, stack) {
        addError(e, stack);
        emit(const CodexSearchFailure());
      }
    }
  }

  Future<void> _filterResults(CodexResultsFiltered event, Emitter<SearchState> emit) async {
    emit(CodexSearchInProgress());

    final originalResults = List<CodexItem>.from(_originalResults);
    if (event.category == WarframeItemCategory.all) {
      return emit(CodexSearchSuccess(originalResults));
    } else {
      final results = List<CodexItem>.from(originalResults)
        ..retainWhere((e) => e.category.toLowerCase() == event.category.name);

      emit(CodexSearchSuccess(results));
    }
  }

  EventTransformer<CodexTextChanged> _waitForUser() {
    return (event, mapper) {
      return event.debounceTime(Durations.medium2).distinct().flatMap(mapper);
    };
  }
}
