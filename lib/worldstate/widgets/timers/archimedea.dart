import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:worldstate_models/worldstate_models.dart';

class ArchimedeaCard extends StatelessWidget {
  const ArchimedeaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocSelector<WorldstateBloc, WorldState, List<Archimedea>?>(
        selector: (state) => switch (state) {
          WorldstateSuccess() => state.seed.archimedeas,
          _ => null,
        },
        builder: (context, archimedea) {
          return Column(
            children: [
              ...?archimedea?.map(
                (a) => ListTile(
                  hoverColor: Colors.transparent,
                  title: Text('${a.type} Archimedea'),
                  subtitle: Text(context.l10n.tapForMoreDetails),
                  onTap: () => ArchimedeaPageRoute(a).push<void>(context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
