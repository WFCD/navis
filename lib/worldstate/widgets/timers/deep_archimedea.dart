import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class DeepArchimedeaCard extends StatelessWidget {
  const DeepArchimedeaCard({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime placeholder() => DateTime.timestamp().add(const Duration(days: 7));

    return AppCard(
      child: BlocSelector<WorldstateBloc, WorldState, Archimedea?>(
        selector:
            (state) => switch (state) {
              WorldstateSuccess() => state.seed.deepArchimedea,
              _ => null,
            },
        builder: (context, archimedea) {
          return ListTile(
            hoverColor: Colors.transparent,
            title: Text(context.l10n.archimedeaTitle),
            subtitle: Text(context.l10n.tapForMoreDetails),
            trailing: CountdownTimer(
              tooltip: MaterialLocalizations.of(context).formatFullDate(archimedea?.expiry ?? placeholder()),
              expiry: archimedea?.expiry ?? placeholder(),
            ),
            onTap: () => ArchimedeaPageRoute(archimedea!).push<void>(context),
          );
        },
      ),
    );
  }
}
