import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/home/widgets/section.dart';
import 'package:navis/mastery/mastery.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis/router/routes.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:settings_repository/settings_repository.dart';

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
        final profile = context.read<ProfileRepository>();
        final settings = context.read<SettingsRepository>();

        return BlocProvider(
          create: (_) => ProfileCubit(profile, settings)..refreshProfile(),
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
      content: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          const padding = EdgeInsets.symmetric(vertical: 16);

          return switch (state) {
            ProfileInitial() => const SizedBox.shrink(),
            ProfileUpdating() => const Padding(padding: padding, child: WarframeSpinner(size: 100)),
            ProfileSuccessful(:final xpInfo) when xpInfo.list.isEmpty => const _MasteryInProgressEmpty(),
            ProfileSuccessful(:final xpInfo) when xpInfo.list.isNotEmpty => _MasteryInProgressQuickView(xpInfo.list),
            ProfileFailure() || _ => const Padding(padding: padding, child: Text('Error updating XP info')),
          };
        },
      ),
    );
  }
}

class _MasteryInProgressEmpty extends StatelessWidget {
  const _MasteryInProgressEmpty();

  @override
  Widget build(BuildContext context) {
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
}

class _MasteryInProgressQuickView extends StatelessWidget {
  const _MasteryInProgressQuickView(this.items);

  final List<MasterableItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final i in items.inProgress.take(5)) MasteryItemTile(masterableItem: i, enableCard: false),
      ],
    );
  }
}
