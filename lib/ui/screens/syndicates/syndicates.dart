import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/models/export.dart';

import '../../widgets/timer_style.dart';
import 'nightwave_style.dart';
import 'syndicate_style.dart';

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
              if (state is WorldstateUninitialized)
                return const Center(child: CircularProgressIndicator());

              if (state is WorldstateLoaded) {
                final List<Syndicate> syndicates = state.worldState.syndicates;

                if (syndicates[0].activation.isAfter(_currentTime) &&
                    syndicates[0].expiry.isBefore(_currentTime))
                  return const Center(
                      child: Text('Retrieving new bounties...'));

                return ListView(children: <Widget>[
                  TimerBox(
                      title: 'Bounties expire in:', time: syndicates[0].expiry),
                  Column(
                      children: syndicates
                          .map(
                              (Syndicate syn) => SyndicateStyle(syndicate: syn))
                          .toList()),
                  const SizedBox(height: 20),
                  TimerBox(
                      title: 'Season ends in:',
                      time: state.worldState.nightwave.expiry),
                  NightWaveStyle()
                ]);
              }
            }));
  }
}
