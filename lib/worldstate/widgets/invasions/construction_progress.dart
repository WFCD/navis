import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis_ui/navis_ui.dart';

class ConstructionProgressCard extends StatelessWidget {
  const ConstructionProgressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      // TODO(SlayerOrnstein): add to loacle data.
      title: 'Construction Progress',
      child: BlocBuilder<SolsystemCubit, SolsystemState>(
        builder: (context, state) {
          const iconSize = 25.0;
          final textTheme = Theme.of(context).textTheme;

          final constructionProgress =
              (state as SolState).worldstate.constructionProgress;

          final razorbackProgress =
              double.parse(constructionProgress.razorbackProgress).toInt();
          final fomorianProgress =
              double.parse(constructionProgress.fomorianProgress).toInt();

          return Padding(
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      AppIcon(
                        FactionIcons.grineer,
                        size: iconSize,
                        color: Factions.grineer.primaryColor,
                      ),
                      SizedBoxSpacer.spacerWidth12,
                      Text(
                        '$razorbackProgress%',
                        style: textTheme.headline6,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        '$fomorianProgress%',
                        style: textTheme.headline6,
                      ),
                      SizedBoxSpacer.spacerWidth12,
                      AppIcon(
                        FactionIcons.corpus,
                        size: iconSize,
                        color: Factions.corpus.primaryColor,
                      ),
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
