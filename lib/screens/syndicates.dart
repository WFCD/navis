import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/widgets/syndicates/syndicates.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_model/worldstate_models.dart';

class SyndicatesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => BlocProvider.of<WorldstateBloc>(context).update(),
        child:
            BlocBuilder<WorldstateBloc, WorldStates>(builder: (context, state) {
          if (state is WorldstateLoaded) {
            final List<Syndicate> syndicates =
                state.worldstate?.syndicateMissions ?? [];

            final Nightwave nightwave = state.worldstate?.nightwave;

            return ListView(children: <Widget>[
              if (syndicates.isNotEmpty)
                TimerBox(
                  title: 'Bounties expire in:',
                  time: syndicates.first.expiry,
                ),
              ...syndicates
                  .map((Syndicate syn) => SyndicateWidget(syndicate: syn)),
              const SizedBox(height: 20),
              if (nightwave != null) ...{
                TimerBox(
                  title: 'Season ends in:',
                  time: nightwave?.expiry ?? DateTime.now(),
                ),
                NightWaveWidget(season: nightwave.season)
              },
            ]);
          }

          return const Center(child: CircularProgressIndicator());
        }));
  }
}
