import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import 'syndicate_style.dart';
import 'syndicate_timer.dart';

class SyndicatesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WorldstateBloc>(context);

    return StreamBuilder(
        stream: bloc.worldstate,
        builder: (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          List<Syndicates> syndicates = snapshot.data.syndicates;

          return RefreshIndicator(
            onRefresh: () => bloc.update(),
            child: ListView(children: <Widget>[
              SyndicateTimer(time: bloc.stateUtils.bountyTime),
              syndicates.isEmpty
                  ? Center(child: Text('Retrieving new bounties...'))
                  : Column(
                      children: syndicates
                          .where((syn) => syn.active == true)
                          .map((syn) => Syndicate(
                              syndicate: syn, events: snapshot.data.events))
                          .toList())
            ]),
          );
        });
  }
}
