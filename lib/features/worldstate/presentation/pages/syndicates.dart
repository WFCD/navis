import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/core/widgets/countdown_banner.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:worldstate_api_model/entities.dart';
import '../widgets/syndicates/syndicate_card.dart';

class SyndicatePage extends StatelessWidget {
  const SyndicatePage({Key key}) : super(key: key);

  Widget _buildSyndicates(List<Syndicate> syndicates) {
    return Column(
      children: <Widget>[
        CountdownBanner(
          message: 'Bounties expire in:',
          time: syndicates.first.expiry,
        ),
        ...syndicates
            .map<SyndicateCard>((syn) => SyndicateCard(syndicate: syn)),
      ],
    );
  }

  Widget _buildNightwave(Nightwave nightwave) {
    return Column(
      children: <Widget>[
        CountdownBanner(
          message: 'Season ends in:',
          time: nightwave.expiry,
        ),
        SyndicateCard(
          name: 'Nightwave',
          caption: 'Season ${nightwave.season}',
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: context.bloc<SolsystemBloc>().update,
      child: BlocBuilder<SolsystemBloc, SolsystemState>(
        builder: (BuildContext context, SolsystemState state) {
          if (state is SolState) {
            return ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
              children: <Widget>[
                _buildSyndicates(state.worldstate.syndicateMissions),
                const SizedBox(height: 8.0),
                if (state.isNightwaveActive)
                  _buildNightwave(state.worldstate.nightwave)
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
