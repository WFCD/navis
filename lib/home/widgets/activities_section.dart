import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:navis/home/widgets/section.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';

class ActivitiesSection extends StatelessWidget {
  const ActivitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      title: Text(context.l10n.activitiesTitle),
      content: const _ActivitiesContent(),
      onTap: () => context.go(const ActivitesPageRouteData().location),
    );
  }
}

class _ActivitiesContent extends StatelessWidget {
  const _ActivitiesContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldstateCubit, SolsystemState>(
      builder: (context, state) {
        final worldstate = switch (state) {
          WorldstateSuccess() => state,
          _ => null,
        };

        return ViewLoading(
          isLoading: state is! WorldstateSuccess,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const DailyReward(),
              if (worldstate?.eventsActive ?? false) const EventCard(),
              if (worldstate?.activeAlerts ?? false) const AlertsCard(),
            ],
          ),
        );
      },
    );
  }
}
