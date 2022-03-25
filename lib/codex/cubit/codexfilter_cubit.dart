import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navis/codex/bloc/search_state.dart';
import 'package:navis/codex/cubit/codexfilter_state.dart';
import 'package:wfcd_client/entities.dart';

export 'codexfilter_state.dart';

class CodexfilterCubit extends Cubit<SearchState> {
  CodexfilterCubit() : super(CodexfilterInitial());

  void filterResults(FilterCategory category, List<Item?> originalResults) {
    emit(CodexSearching());

    if (FilterCategories.categories.contains(category)) {
      if (category == FilterCategories.all) {
        return emit(CodexSuccessfulSearch(originalResults));
      } else {
        final results = List<Item>.from(originalResults)
          ..retainWhere((e) => e.category == category.category);

        emit(CodexSuccessfulSearch(results));
      }
    }
  }
}

class FilterCategory extends Equatable {
  const FilterCategory(this.category);

  final String category;

  @override
  List<Object?> get props => [category];
}

class FilterCategories {
  static const categories = <FilterCategory>[
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

  static const all = FilterCategory('All');
  static const arcanes = FilterCategory('Arcanes');
  static const archwing = FilterCategory('Archwing');
  static const archgun = FilterCategory('Arch-Gun');
  static const archmelee = FilterCategory('Arch-Melee');
  static const enemy = FilterCategory('Enemy');
  static const fish = FilterCategory('Fish');
  static const gear = FilterCategory('Gear');
  static const glyphs = FilterCategory('Glyphs');
  static const melee = FilterCategory('Melee');
  static const misc = FilterCategory('Misc');
  static const mods = FilterCategory('Mods');
  static const node = FilterCategory('Node');
  static const pets = FilterCategory('Pets');
  static const primary = FilterCategory('Primary');
  static const quests = FilterCategory('Quests');
  static const relics = FilterCategory('Relics');
  static const resources = FilterCategory('Resources');
  static const secondary = FilterCategory('Secondary');
  static const sentinels = FilterCategory('Sentinels');
  static const sigils = FilterCategory('Sigils');
  static const skins = FilterCategory('Skins');
  static const warframes = FilterCategory('Warframes');
}
