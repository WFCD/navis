import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

// Fuck is the plural of archimedea
typedef Archimedies = ({Archimedea? deep, Archimedea? temporal});

class ArchimedeaCard extends StatelessWidget {
  const ArchimedeaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocSelector<WorldstateBloc, WorldState, Archimedies?>(
        selector:
            (state) => switch (state) {
              WorldstateSuccess() => (deep: state.seed.deepArchimedea, temporal: state.seed.temporalArchimedea),
              _ => null,
            },
        builder: (context, archimedea) {
          final deep = archimedea?.deep;
          final temporal = archimedea?.temporal;

          return Column(
            children: [
              if (deep != null)
                ListTile(
                  hoverColor: Colors.transparent,
                  title: Text(context.l10n.deepArchimedeaTitle),
                  subtitle: Text(context.l10n.tapForMoreDetails),
                  onTap: () => ArchimedeaPageRoute(archimedea!.deep!).push<void>(context),
                ),
              if (temporal != null)
                ListTile(
                  hoverColor: Colors.transparent,
                  title: Text(context.l10n.temporalArchimedeaTitle),
                  subtitle: Text(context.l10n.tapForMoreDetails),
                  onTap: () => ArchimedeaPageRoute(archimedea!.temporal!).push<void>(context),
                ),
            ],
          );
        },
      ),
    );
  }
}
