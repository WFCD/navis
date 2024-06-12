import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

sealed class FactionColorScheme {
  const FactionColorScheme();

  IconData get icon;
  Color get iconColor;
  Color get backgroundColor => Color(0xFFFFFFFF);
}

final class DefaultColorScheme implements FactionColorScheme {
  const DefaultColorScheme({
    required Color iconColor,
    required Color backgroundColor,
  })  : _iconColor = iconColor,
        _backgroundColor = backgroundColor;

  final Color _iconColor;
  final Color _backgroundColor;

  @override
  Color get backgroundColor => _backgroundColor;

  @override
  IconData get icon => WarframeSymbols.menu_LotusEmblem;

  @override
  Color get iconColor => _iconColor;
}

final class CorpusColorScheme extends FactionColorScheme {
  const CorpusColorScheme();

  @override
  Color get backgroundColor => Colors.blue[700]!;

  @override
  Color get iconColor => const Color(0xFF8bdefe);

  @override
  IconData get icon => WarframeSymbols.menu_Corpus;
}

final class GrineerColorScheme extends FactionColorScheme {
  const GrineerColorScheme();

  @override
  Color get backgroundColor => Colors.red[800]!;

  @override
  Color get iconColor => const Color(0xFFb23232);

  @override
  IconData get icon => WarframeSymbols.menu_Grineer;
}

final class InfestedColorScheme extends FactionColorScheme {
  const InfestedColorScheme();

  @override
  Color get backgroundColor => Color(0xFF228B22);

  @override
  Color get iconColor => const Color(0xFF2a3c2e);

  @override
  IconData get icon => WarframeSymbols.menu_Infested;
}

final class CorruptedColorScheme extends FactionColorScheme {
  const CorruptedColorScheme();

  @override
  Color get backgroundColor => Colors.yellow[300]!;

  @override
  Color get iconColor => const Color(0xFFe9a835);

  @override
  IconData get icon => WarframeSymbols.factions_corrupted;
}

final class NarmerColorScheme extends FactionColorScheme {
  const NarmerColorScheme();

  @override
  Color get iconColor => const Color(0xFF997927);

  @override
  IconData get icon => WarframeSymbols.factions_narmer;
}

sealed class SyndicateColorScheme implements FactionColorScheme {
  const SyndicateColorScheme();

  List<IconData> get titleIcons;

  IconData titleIcon(int rank) {
    return switch (rank) {
      <= 5 && >= 1 => titleIcons[rank - 1],
      0 => WarframeSymbols.sigils_Neutral,
      -1 => WarframeSymbols.sigils_NegativeRank1,
      -2 => WarframeSymbols.sigils_NegativeRank2,
      _ => WarframeSymbols.nightmare,
    };
  }
}

final class OstronColorScheme extends SyndicateColorScheme {
  const OstronColorScheme();

  @override
  IconData get icon => WarframeSymbols.ostron;

  @override
  Color get backgroundColor => const Color(0xFF92381D);

  @override
  Color get iconColor => const Color(0xFFE8DDAF);

  @override
  List<IconData> get titleIcons {
    return [
      WarframeSymbols.sigils_Ostron_OstronLevel1,
      WarframeSymbols.sigils_Ostron_OstronLevel2,
      WarframeSymbols.sigils_Ostron_OstronLevel3,
      WarframeSymbols.sigils_Ostron_OstronLevel4,
      WarframeSymbols.sigils_Ostron_OstronLevel5
    ];
  }
}

final class SolariesColorScheme extends SyndicateColorScheme {
  const SolariesColorScheme();

  @override
  Color get backgroundColor => const Color(0xFF523A29);

  @override
  IconData get icon => WarframeSymbols.solaris;

  @override
  Color get iconColor => const Color(0xFFD7C38F);

  @override
  List<IconData> get titleIcons {
    return [
      WarframeSymbols.sigils_Solaris_United_SolarisLevel1,
      WarframeSymbols.sigils_Solaris_United_SolarisLevel2,
      WarframeSymbols.sigils_Solaris_United_SolarisLevel3,
      WarframeSymbols.sigils_Solaris_United_SolarisLevel4,
      WarframeSymbols.sigils_Solaris_United_SolarisLevel5
    ];
  }
}

final class EntratiColorScheme extends SyndicateColorScheme {
  const EntratiColorScheme();

  @override
  Color get backgroundColor => const Color(0xFF3D4245);

  @override
  IconData get icon => WarframeSymbols.entrati;

  @override
  Color get iconColor => const Color(0xFFBC9028);

  @override
  List<IconData> get titleIcons {
    return [
      WarframeSymbols.sigils_Entrati_EntratiLevel1,
      WarframeSymbols.sigils_Entrati_EntratiLevel2,
      WarframeSymbols.sigils_Entrati_EntratiLevel3,
      WarframeSymbols.sigils_Entrati_EntratiLevel4,
      WarframeSymbols.sigils_Entrati_EntratiLevel5,
    ];
  }
}

final class SimarisColorScheme extends SyndicateColorScheme {
  const SimarisColorScheme();

  @override
  Color get backgroundColor => const Color(0xFF4C300A);

  @override
  IconData get icon => WarframeSymbols.menu_Simaris;

  @override
  Color get iconColor => const Color(0xFFEBD28E);

  @override
  List<IconData> get titleIcons => throw UnimplementedError();
}

final class NightwaveColorScheme extends SyndicateColorScheme {
  const NightwaveColorScheme();

  @override
  Color get backgroundColor => const Color(0xFF611E26);

  @override
  IconData get icon => WarframeSymbols.nightwave;

  @override
  Color get iconColor => const Color(0xFFFEADAA);

  @override
  List<IconData> get titleIcons => throw UnimplementedError();
}
