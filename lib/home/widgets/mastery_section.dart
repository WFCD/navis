import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/home/widgets/section.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis/profile/utils/mastery_utils.dart';
import 'package:navis/router/routes.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';
import 'package:warframe_repository/warframe_repository.dart';

class MasteryInProgressSection extends StatelessWidget {
  const MasteryInProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileCubit, ProfileState, ProfileSuccessful?>(
      selector: (state) {
        if (state is ProfileSuccessful) return state;
        return null;
      },
      builder: (context, state) {
        if (state == null) return const SizedBox.shrink();
        final repository = RepositoryProvider.of<WarframeRepository>(context);

        return BlocProvider(
          create: (context) => MasteryProgressCubit(repository)..fetchInProgress(state.profile.loadout.xpInfo),
          child: const MasteryInProgressContent(),
        );
      },
    );
  }
}

class MasteryInProgressContent extends StatelessWidget {
  const MasteryInProgressContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      onTap: () => const MasteryPageRoute().push<void>(context),
      title: const Text('Mastery in progress'),
      content: BlocBuilder<MasteryProgressCubit, MasteryProgressState>(
        builder: (context, state) {
          const padding = EdgeInsets.symmetric(vertical: 16);

          if (state is MasteryProgressFailure) {
            return const Padding(padding: padding, child: Text('Error updating XP info'));
          }

          if (state is! MasteryProgressSuccess) {
            return const Padding(padding: padding, child: WarframeSpinner(size: 100));
          }

          if (state.items.inProgress.isEmpty) {
            return Card(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Column(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(WarframeIcons.menuWoundedInfestedCritter, size: 80),
                      Text('No Items in progress', style: context.textTheme.titleMedium),
                    ],
                  ),
                ),
              ),
            );
          }

          return Column(
            children: [
              for (final i in state.items.inProgress.take(5))
                ArsenalItemTitle(
                  name: i.item.name,
                  imageName: i.item.imageName!,
                  rank: masteryRank(i),
                  maxRank: i.item.maxLevel ?? 30,
                ),
            ],
          );
        },
      ),
    );
  }
}
