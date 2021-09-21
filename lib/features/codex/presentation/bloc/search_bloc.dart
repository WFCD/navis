import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../constants/default_durations.dart';
import '../../../../core/error/exceptions.dart';
import '../../domian/usercases/search_items.dart';
import 'search_event.dart';
import 'search_state.dart';

export 'search_event.dart';
export 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.searchItems) : super(CodexSearchEmpty()) {
    on<SearchCodex>(_searchCodex, transformer: _waitForUser());
    on<SearchFilter>(_filterSearchResults);
  }

  final SearchItems searchItems;

  late List<Item> _originalResults;

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
        final results = await searchItems(text);

        emit(
          results.match(
            (r) {
              _originalResults = r;
              return CodexSuccessfulSearch(r.cast<Item>());
            },
            matchFailure,
          ),
        );
      } catch (e) {
        emit(const CodexSearchError('Unknown Error occuroed'));
      }
    }
  }

  Future<void> _filterSearchResults(
    SearchFilter event,
    Emitter<SearchState> emit,
  ) async {
    emit(CodexSearching());

    final category = event.category;
    if (FilterCategories.categories.contains(category)) {
      if (category == FilterCategories.all) {
        return emit(CodexSuccessfulSearch(_originalResults));
      } else {
        final results = List<Item>.from(_originalResults)
          ..retainWhere((e) => e.category == category);

        emit(CodexSuccessfulSearch(results));
      }
    }
  }

  EventTransformer<SearchEvent> _waitForUser() {
    return (event, mapper) {
      return event.debounceTime(kAnimationLong).distinct().switchMap(mapper);
    };
  }
}

class FilterCategories {
  static const categories = <String>[
    all,
    arcanes,
    archwing,
    archgun,
    archmelee,
    enemy,
    fish,
    gear,
    glyphs,
    melee,
    misc,
    mods,
    node,
    pets,
    primary,
    quests,
    relics,
    resources,
    secondary,
    sentinels,
    sigils,
    skins,
    warframes
  ];

  static const all = 'All';
  static const arcanes = 'Arcanes';
  static const archwing = 'Archwing';
  static const archgun = 'Arch-Gun';
  static const archmelee = 'Arch-Melee';
  static const enemy = 'Enemy';
  static const fish = 'Fish';
  static const gear = 'Gear';
  static const glyphs = 'Glyphs';
  static const melee = 'Melee';
  static const misc = 'Misc';
  static const mods = 'Mods';
  static const node = 'Node';
  static const pets = 'Pets';
  static const primary = 'Primary';
  static const quests = 'Quests';
  static const relics = 'Relics';
  static const resources = 'Resources';
  static const secondary = 'Secondary';
  static const sentinels = 'Sentinels';
  static const sigils = 'Sigils';
  static const skins = 'Skins';
  static const warframes = 'Warframes';
}
