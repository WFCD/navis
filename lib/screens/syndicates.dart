import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/widgets/syndicates/syndicates.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:warframestat_api_models/entities.dart';

class SyndicatesList extends StatelessWidget {
  Widget _buildSyndicates(List<Syndicate> syndicates) {
    return Column(
      children: <Widget>[
        TimerBox(
          title: 'Bounties expire in:',
          time: syndicates.first.expiry,
        ),
        ...syndicates
            .map<SyndicateWidget>((syn) => SyndicateWidget(syndicate: syn)),
      ],
    );
  }

  Widget _buildNightwave(Nightwave nightwave) {
    return Column(
      children: <Widget>[
        TimerBox(
          title: 'Season ends in:',
          time: nightwave.expiry,
        ),
        SyndicateWidget(
          name: 'Nightwave',
          caption: 'Season ${nightwave.season}',
        )
      ],
    );
  }

  Widget _buildOthers(BuildContext context) {
    return Column(
      children: <Widget>[
        SettingTitle(
          title: 'Others',
          alignment: Alignment.centerRight,
          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 16),
        ),
        const SyndicateWidget(name: 'Simaris')
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => BlocProvider.of<WorldstateBloc>(context).update(),
        child: BlocBuilder<WorldstateBloc, WorldStates>(
            builder: (BuildContext context, WorldStates state) {
          if (state is WorldstateLoaded) {
            final List<Syndicate> syndicates =
                state.worldstate?.syndicateMissions ?? [];

            final Nightwave nightwave = state.worldstate?.nightwave;

            return ListView(
              children: <Widget>[
                if (syndicates.isNotEmpty) _buildSyndicates(syndicates),
                const SizedBox(height: 20),
                if (nightwave != null) _buildNightwave(nightwave),
                const SizedBox(height: 16),
                _buildOthers(context)
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        }));
  }
}
