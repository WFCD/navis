import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:navis/codex/bloc/search_event.dart';
import 'package:navis/codex/bloc/search_state.dart';
import 'package:navis/codex/utils/result_filters.dart';
import 'package:navis/utils/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

export 'search_event.dart';
export 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.repository) : super(CodexSearchEmpty()) {
    on<SearchCodex>(_searchCodex, transformer: _waitForUser());
    on<FilterResults>(_filterResults);
  }

  final WarframestatRepository repository;

  List<MinimalItem> _originalResults = [];

  Future<void> _searchCodex(SearchCodex event, Emitter<SearchState> emit) async {
    final text = event.text;

    if (text.isEmpty) {
      emit(CodexSearchEmpty());
    } else {
      emit(CodexSearching());

      try {
        final results = await ConnectionManager.call(() async => repository.searchItems(text));
        results.sort(_itemComparator);

        _originalResults = results;
        emit(CodexSuccessfulSearch(results));
      } on SocketException {
        emit(const CodexSearchError('A network error has occurred'));
      } on FormatException {
        emit(const CodexSearchError('Failed to parse server response'));
      } on Exception catch (error, stackTrace) {
        await Sentry.captureException(error, stackTrace: stackTrace, hint: Hint.withMap({'query': event.text}));

        emit(const CodexSearchError('Unknown Error occurred'));
      }
    }
  }

  Future<void> _filterResults(FilterResults event, Emitter<SearchState> emit) async {
    emit(CodexSearching());

    final originalResults = List<MinimalItem>.from(_originalResults);
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
      return event.debounceTime(kThemeAnimationDuration).distinct().flatMap(mapper);
    };
  }

  int _itemComparator(MinimalItem a, MinimalItem b) {
    final hasPriority =
        a.type.isWeapon ||
        b.type.isWeapon ||
        a.type == ItemType.warframes ||
        b.type == ItemType.warframes ||
        a.type == ItemType.sentinels ||
        b.type == ItemType.sentinels ||
        a.type == ItemType.pets ||
        b.type == ItemType.pets ||
        a.type == ItemType.petResource ||
        b.type == ItemType.petResource;

    if (hasPriority) return -1;

    return a.name.compareTo(b.name);
  }
}
