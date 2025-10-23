import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:navis/home/widgets/section.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_repository/warframestat_repository.dart';
import 'package:worldstate_models/worldstate_models.dart';

class ActivitiesSection extends StatelessWidget {
  const ActivitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final wsRepo = RepositoryProvider.of<WarframestatRepository>(context);

    return Section(
      title: Text(context.l10n.activitiesTitle),
      content: BlocProvider(create: (_) => WorldstateBloc(wsRepo), child: const _ActivitiesContent()),
      onTap: () => context.go(const ActivitesPageRouteData().location),
    );
  }
}

typedef _Activities = ({List<WorldEvent> events, List<Alert> alerts});

class _ActivitiesContent extends StatelessWidget {
  const _ActivitiesContent();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WorldstateBloc, WorldState, _Activities?>(
      selector: (state) {
        return switch (state) {
          WorldstateSuccess(seed: final seed) => (events: seed.events, alerts: seed.alerts),
          _ => null,
        };
      },
      builder: (context, activities) {
        return ViewLoading(
          isLoading: activities == null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const DailyReward(),
              if (activities?.events.isNotEmpty ?? false) const EventCard(),
              if (activities?.alerts.isNotEmpty ?? false) const AlertsCard(),
            ],
          ),
        );
      },
    );
  }
}
