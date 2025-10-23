import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';

class ConstructionProgressCard extends StatelessWidget {
  const ConstructionProgressCard({super.key});

  String _parseProgress(num? progress) {
    return min(progress ?? 0, 100).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      title: context.l10n.constructionProgressTitle,
      child: BlocBuilder<WorldstateBloc, WorldState>(
        builder: (context, state) {
          const iconSize = 25.0;
          final textTheme = Theme.of(context).textTheme;

          final constructionProgress = switch (state) {
            WorldstateSuccess() => state.seed.constructionProgress,
            _ => null,
          };

          final razorbackProgress = _parseProgress(constructionProgress?.razorbackProgress);
          final fomorianProgress = _parseProgress(constructionProgress?.fomorianProgress);

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      AppIcon(WarframeIcons.factionsGrineer, size: iconSize, color: Factions.grineer.primaryColor),
                      Gaps.gap12,
                      Text('$fomorianProgress%', style: textTheme.titleLarge),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text('$razorbackProgress%', style: textTheme.titleLarge),
                      Gaps.gap12,
                      AppIcon(WarframeIcons.factionsCorpus, size: iconSize, color: Factions.corpus.primaryColor),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
