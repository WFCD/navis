import 'package:codex/codex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/home/widgets/section.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis/profile/utils/mastery_utils.dart';
import 'package:navis/router/routes.dart';
import 'package:navis_ui/navis_ui.dart';

class MasteryInProgressSection extends StatelessWidget {
  const MasteryInProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileCubit, ProfileState, PlayerProfile?>(
      selector: (state) {
        return switch (state) {
          ProfileSuccessful(profile: final profile) => profile,
          _ => null,
        };
      },
      builder: (context, profile) {
        if (profile == null) return const SizedBox.shrink();

        final codex = RepositoryProvider.of<Codex>(context);

        return BlocProvider(
          create: (context) => MasteryProgressCubit(codex)..fetchInProgress(),
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

          return Column(
            children: [
              for (final i in state.items.inProgress.take(5))
                ArsenalItemTitle(
                  name: i.name,
                  imageName: i.imageName!,
                  rank: masteryRank(i, i.xpInfo.value!.xp),
                  maxRank: i.maxLevelCap!,
                ),
            ],
          );
        },
      ),
    );
  }
}
