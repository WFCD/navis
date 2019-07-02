import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/styles.dart';
import 'package:navis/models/export.dart';

import 'components/nightwave_style.dart';
import 'components/syndicate_style.dart';

class SyndicatesList extends StatelessWidget {
  final _currentTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final WorldstateBloc bloc = BlocProvider.of<WorldstateBloc>(context);

    return RefreshIndicator(
        onRefresh: () => bloc.update(),
        child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is WorldstateLoaded) {
                final List<Syndicate> syndicates = state.syndicates;

                if (syndicates.first.activation.isAfter(_currentTime) &&
                    syndicates.first.expiry.isBefore(_currentTime))
                  return const Center(
                      child: Text('Retrieving new bounties...'));

                return ListView(children: <Widget>[
                  TimerBox(
                      title: 'Bounties expire in:',
                      time: syndicates.first.expiry),
                  Column(
                      children: syndicates
                          .map(
                              (Syndicate syn) => SyndicateStyle(syndicate: syn))
                          .toList()),
                  const SizedBox(height: 20),
                  if (state.nightwave != null) ...{
                    TimerBox(
                        title: 'Season ends in:', time: state.nightwave.expiry),
                    NightWaveStyle()
                  },
                ]);
              }

              return const Center(child: CircularProgressIndicator());
            }));
  }
}
