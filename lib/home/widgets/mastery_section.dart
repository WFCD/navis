import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:navis/home/widgets/section.dart';
import 'package:navis/mastery/mastery.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis/router/routes.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:warframe_common/warframe_common.dart';

class MasteryInProgressSection extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileCubit, ProfileState, Profile?>(
      selector: (state) => switch (state) {
        ProfileSuccessful(:final profile) => profile,
        _ => null,
      },
      builder: (context, state) {
        if (state == null) return const SizedBox.shrink();
        return const MasteryInProgressContent();
      },
    );
  }
}

class MasteryInProgressContent extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      onTap: () => const MasteryPageRoute().push<void>(context),
      title: const Text('Mastery in progress'),
      content: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          const padding = EdgeInsets.symmetric(vertical: 16);

          return switch (state) {
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
  const new();

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
              Text('No Items in progress', style: TextTheme.of(context).titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class _MasteryInProgressQuickView extends StatelessWidget {
  const new(this.items);

  final List<MasterableItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.inProgress.take(5).map((i) => MasteryItemTile(masterableItem: i, enableCard: false)).toList(),
    );
  }
}
