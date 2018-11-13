import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import '../widgets/cards.dart';
import '../widgets/timer.dart';
import 'syndicate_missions.dart';

class SyndicatesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final syndicate = BlocProvider.of<WorldstateBloc>(context);

    final bountyTime = DateTime.parse(syndicate.lastState.syndicates
        .firstWhere((s) => s.syndicate == 'Ostrons')
        .expiry)
        .difference(DateTime.now());

    return StreamBuilder(
        stream: syndicate.worldstate,
        builder: (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return RefreshIndicator(
            onRefresh: () => syndicate.update(),
            child: ListView(children: <Widget>[
              SizedBox(
                height: 50.0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Bounties expire in',
                            style: TextStyle(
                                fontSize: 20.0,
                                color:
                                Theme
                                    .of(context)
                                    .textTheme
                                    .body1
                                    .color)),
                        Timer(
                            duration: bountyTime,
                            size: 17.0,
                            callback: syndicate.update(),
                            isMore1H: true)
                      ]),
                ),
              ),
              Column(
                  children: snapshot.data.syndicates
                      .map((s) =>
                      _buildSyndicate(context, s, snapshot.data.events))
                      .toList())
            ]),
          );
        });
  }
}

Widget _buildSyndicate(
    BuildContext context, Syndicates syndicate, List<Events> events) {
  final ostronsColor = Color.fromRGBO(183, 70, 36, 1.0);
  final solarisColor = Color.fromRGBO(206, 162, 54, 1.0);

  return Tiles(
    color: syndicate.syndicate == 'Ostrons' ? ostronsColor : solarisColor,
    child: ListTile(
      leading: _checkSigil(syndicate.syndicate),
      title: Text(syndicate.syndicate, style: TextStyle(color: Colors.white)),
      trailing: ButtonTheme.bar(
        child: FlatButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SyndicateJobs(
                      syndicate: syndicate,
                      events: events,
                      color: syndicate.syndicate == 'Ostrons'
                          ? ostronsColor
                          : solarisColor,
                    ))),
            child: Text(
              'See Bounties',
              style: TextStyle(color: Colors.white),
            )),
      ),
    ),
  );
}

_checkSigil(String syndicateName) {
  final height = 50.0;
  final width = 50.0;

  switch (syndicateName) {
    case 'Ostrons':
      return SvgPicture.asset('assets/sigils/OstronSigil.svg',
          height: height,
          width: width,
          color: Color.fromRGBO(232, 221, 175, 1.0));
    default:
      return SvgPicture.asset('assets/sigils/SolarisUnited.svg',
          height: height,
          width: width,
          color: Color.fromRGBO(152, 92, 67, 1.0));
  }
}
