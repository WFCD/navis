import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import 'syndicate_style.dart';
import 'syndicate_timer.dart';

class SyndicatesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WorldstateBloc bloc = BlocProvider.of<WorldstateBloc>(context);

    return RefreshIndicator(
        onRefresh: () => bloc.update(),
        child: StreamBuilder<WorldState>(
            stream: bloc.worldstate,
            builder:
                (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
              if (!snapshot.hasData)
                return const Center(child: CircularProgressIndicator());

              final List<Syndicates> syndicates = snapshot.data.syndicates;

              if (syndicates.isEmpty)
                return const Center(child: Text('Retrieving new bounties...'));

              return ListView(children: <Widget>[
                SyndicateTimer(time: syndicates[0].expiry),
                Column(
                    children: syndicates
                        .where((Syndicates syn) => syn.active == true)
                        .map((Syndicates syn) => Syndicate(syndicate: syn))
                        .toList())
              ]);
            }));
  }
}
