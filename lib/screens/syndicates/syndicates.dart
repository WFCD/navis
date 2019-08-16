import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/styles.dart';
import 'package:worldstate_model/worldstate_models.dart';

import 'components/nightwave_style.dart';
import 'components/syndicate_style.dart';

class SyndicatesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WorldstateBloc bloc = BlocProvider.of<WorldstateBloc>(context);

    return RefreshIndicator(
        onRefresh: () => bloc.update(),
        child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
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
                  Column(children: <Widget>[
                    ...syndicates
                        .map((Syndicate syn) => SyndicateStyle(syndicate: syn))
                  ]),
                  const SizedBox(height: 20),
                  if (nightwave != null) ...{
                    TimerBox(
                      title: 'Season ends in:',
                      time: nightwave?.expiry ?? DateTime.now(),
                    ),
                    NightWaveStyle(season: nightwave.season)
                  },
                ]);
              }

              return const Center(child: CircularProgressIndicator());
            }));
  }
}
