import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:navis/codex/bloc/search_event.dart';
import 'package:navis/codex/bloc/search_state.dart';
import 'package:navis/codex/utils/result_filters.dart';
import 'package:navis/utils/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

export 'search_event.dart';
export 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.repository) : super(CodexSearchEmpty()) {
    on<CodexTextChanged>(_searchCodex, transformer: _waitForUser());
    on<CodexResultsFiltered>(_filterResults);
  }

  final WarframestatRepository repository;

  List<MinimalItem> _originalResults = [];

  static final _logger = Logger('SearchBloc');

  Future<void> _searchCodex(CodexTextChanged event, Emitter<SearchState> emit) async {
    final text = event.text;

    if (text.isEmpty) {
      emit(CodexSearchEmpty());
    } else {
      emit(CodexSearchInProgress());

      try {
        final results = await ConnectionManager.call(() async => repository.searchItems(text));
        results.prioritizeResults();

        _originalResults = results;
        emit(CodexSearchSuccess(results));
      } on Exception catch (e, stack) {
        _logger.severe('Some extra weird shit is going on', e, stack);

        emit(CodexSearchFailure(error: e, stackTrace: stack));
      }
    }
  }

  Future<void> _filterResults(CodexResultsFiltered event, Emitter<SearchState> emit) async {
    emit(CodexSearchInProgress());

    final originalResults = List<MinimalItem>.from(_originalResults);
    if (event.category == WarframeItemCategory.all) {
      return emit(CodexSearchSuccess(originalResults));
    } else {
      final results = List<MinimalItem>.from(originalResults)
        ..retainWhere((e) => e.category.toLowerCase() == event.category.name);

      emit(CodexSearchSuccess(results));
    }
  }

  EventTransformer<CodexTextChanged> _waitForUser() {
    return (event, mapper) {
      return event.debounceTime(kThemeAnimationDuration).distinct().flatMap(mapper);
    };
  }
}
