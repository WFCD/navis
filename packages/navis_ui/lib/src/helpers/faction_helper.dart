import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

enum SyndicateFactions {
  ostron('Ostrons', WarframeSymbols.ostron, OstronColorScheme()),
  solaris(
      'Solaris United', WarframeSymbols.solaris, SolariesColorScheme(),),
  entrati('Entrati', WarframeSymbols.entrati, EntratiColorScheme()),
  nightwave(
      'Nightwave', WarframeSymbols.nightwave, NightwaveColorScheme(),),
  simaris(
      'Cephalon Simaris', WarframeSymbols.simaris, SimarisColorScheme(),);

  const SyndicateFactions(this.name, this.icon, this.colorScheme);

  final String name;
  final IconData icon;
  final SyndicateColorScheme colorScheme;

  static SyndicateFactions? fromString(String faction) {
    return SyndicateFactions.values.firstWhereOrNull(
      (e) => e.name.toLowerCase().contains(faction.toLowerCase()),
    );
  }
}

enum EnemyFactions {
  grineer('Grineer', WarframeSymbols.menu_Grineer, GrineerColorScheme()),
  corpus('Corpus', WarframeSymbols.menu_Corpus, CorpusColorScheme()),
  corrupted(
    'Corrupted',
    WarframeSymbols.factions_corrupted,
    CorruptedColorScheme(),
  ),
  infestation(
    'Infested',
    WarframeSymbols.menu_Infested,
    InfestedColorScheme(),
  ),
  infested(
    'Infested',
    WarframeSymbols.menu_Infested,
    InfestedColorScheme(),
  ),
  narmer('Narmer', WarframeSymbols.factions_narmer, NarmerColorScheme());

  const EnemyFactions(this.name, this.icon, this.colorScheme);

  final String name;
  final IconData icon;
  final FactionColorScheme colorScheme;

  static EnemyFactions? fromString(String faction) {
    return EnemyFactions.values.firstWhereOrNull(
      (e) => e.name.toLowerCase().contains(faction.toLowerCase()),
    );
  }
}
