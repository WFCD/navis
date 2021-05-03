import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supercharged/supercharged.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/error/exceptions.dart';
import '../../domian/usercases/search_items.dart';
import 'search_event.dart';
import 'search_state.dart';

export 'search_event.dart';
export 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.searchItems) : super(CodexSearchEmpty());

  final SearchItems searchItems;

  late List<Item> _originalResults;

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

          yield results.match(
            (r) {
              _originalResults = r;
              return CodexSuccessfulSearch(r.cast<Item>());
            },
            matchFailure,
          );
        } catch (e) {
          yield const CodexSearchError('Unknown Error occuroed');
        }
      }
    }

    if (event is SearchFilter) {
      yield CodexSearching();
      final filteredResults = _filterResults(event.category);

      yield CodexSuccessfulSearch(filteredResults ?? _originalResults);
    }
  }

  List<Item>? _filterResults(String category) {
    if (FilterCategories.categories.contains(category)) {
      if (category == FilterCategories.all) {
        return _originalResults;
      } else {
        return List<Item>.from(_originalResults)
          ..retainWhere((e) => e.category == category);
      }
    }

    return null;
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
