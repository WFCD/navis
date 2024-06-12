import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

enum SyndicateFactions {
  ostron('Ostrons', WarframeSymbols.ostron, const OstronColorScheme()),
  solaris(
      'Solaris United', WarframeSymbols.solaris, const SolariesColorScheme()),
  entrati('Entrati', WarframeSymbols.entrati, const EntratiColorScheme()),
  nightwave(
      'Nightwave', WarframeSymbols.nightwave, const NightwaveColorScheme()),
  simaris(
      'Cephalon Simaris', WarframeSymbols.simaris, const SimarisColorScheme());

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
  grineer('Grineer', WarframeSymbols.menu_Grineer, const GrineerColorScheme()),
  corpus('Corpus', WarframeSymbols.menu_Corpus, const CorpusColorScheme()),
  corrupted(
    'Corrupted',
    WarframeSymbols.factions_corrupted,
    const CorruptedColorScheme(),
  ),
  infestation(
    'Infested',
    WarframeSymbols.menu_Infested,
    const InfestedColorScheme(),
  ),
  infested(
    'Infested',
    WarframeSymbols.menu_Infested,
    const InfestedColorScheme(),
  ),
  narmer('Narmer', WarframeSymbols.factions_narmer, const NarmerColorScheme());

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
