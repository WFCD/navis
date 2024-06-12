import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

// "required" is a reserved word
typedef MasteryInfo = ({int current, int next, int needed});

class PlayerCard extends StatelessWidget {
  const PlayerCard({
    super.key,
    required this.username,
    required this.masteryRank,
  });

  final String username;
  final int masteryRank;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.theme.textTheme;

    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          // TODO(Orn): Replace with rank icon
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(WarframeSymbols.menu_LotusEmblem, size: 80),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$username | $masteryRank', style: textTheme.titleMedium),
                // const PlayerProgress()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
