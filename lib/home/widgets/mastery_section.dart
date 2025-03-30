import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoria/inventoria.dart';
import 'package:navis/home/widgets/section.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis/router/routes.dart';
import 'package:navis_ui/navis_ui.dart';

class MasteryInProgressSection extends StatelessWidget {
  const MasteryInProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileCubit, ProfileState, String?>(
      selector: (state) {
        return switch (state) {
          ProfileSuccessful(profile: final p) => p.id,
          _ => null,
        };
      },
      builder: (context, id) {
        if (id == null) return const SizedBox.shrink();

        final inventoria = RepositoryProvider.of<Inventoria>(context);

        return BlocProvider(
          create: (context) => MasteryProgressCubit(inventoria)..fetchInProgress(),
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
            children: [for (final i in state.items.where((i) => !i.isMissing).take(5)) ArsenalItemTitle(item: i)],
          );
        },
      ),
    );
  }
}
