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
    final aPriority = _mapPriority[a.type] ?? 100;
    final bPriority = _mapPriority[b.type] ?? 100;

    if (aPriority != bPriority) return aPriority.compareTo(bPriority);

    return a.name.compareTo(b.name);
  }

  final Map<ItemType, int> _mapPriority = {

    // Warframes, weapons and companions
    ItemType.warframes: 0,
    ItemType.melee: 0,
    ItemType.shotgun: 0,
    ItemType.rifle: 0,
    ItemType.pistol: 0,
    ItemType.dualPistols: 0,
    ItemType.amp: 0,
    ItemType.archMelee: 0,
    ItemType.archGun: 0,
    ItemType.throwing: 0,
    ItemType.pets: 0,
    ItemType.sentinels: 0,
    ItemType.archwing: 0,
    ItemType.companionWeapon: 0,

    // Mods and arcanes
    ItemType.necramechMod: 1,
    ItemType.primaryMod: 1,
    ItemType.secondaryMod: 1,
    ItemType.warframeMod: 1,
    ItemType.shotGunMod: 1,
    ItemType.companionMod: 1,
    ItemType.archwingMod: 1,
    ItemType.archMeleeMod: 1,
    ItemType.archGunMod: 1,
    ItemType.stanceMod: 1,
    ItemType.parazonMod: 1,
    ItemType.kDriveMod: 1,
    ItemType.meleeMod: 1,
    ItemType.peculiarMod: 1,
    ItemType.arcanes: 1,

    // Riven mods
    ItemType.companionWeaponRiven: 1,
    ItemType.archGunRiven: 1,
    ItemType.rifleRiven: 1,
    ItemType.pistolRiven: 1,
    ItemType.shotgunRiven: 1,
    ItemType.meleeRiven: 1,
    ItemType.kitgunRiven: 1,
    ItemType.zawRiven: 1,
    ItemType.rivenMod: 1,

    // Gear quests and nodes
    ItemType.gear: 2,
    ItemType.node: 2,
    ItemType.quests: 2,

    // Relics
    ItemType.relics: 3,

    // Resources and components
    ItemType.resources: 4,
    ItemType.fish: 4,
    ItemType.petResource: 4,
    ItemType.kDriveComponent: 4,
    ItemType.zawComponent: 4,
    ItemType.kitGunComponent: 4,

    // Skins, sigils and glyphs
    ItemType.skin: 5,
    ItemType.sigils: 5,
    ItemType.misc: 5,
    ItemType.glyphs: 6,
};
}
