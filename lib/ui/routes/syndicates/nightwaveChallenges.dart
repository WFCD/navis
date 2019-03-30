import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/models/export.dart';
import 'package:navis/ui/widgets/animations/countdown.dart';
import 'package:navis/ui/widgets/icons.dart';
import 'package:navis/ui/widgets/layout.dart';

class NightwaveChallenges extends StatelessWidget {
  const NightwaveChallenges();

  int _sort(BountyType a, BountyType b) {
    if (a.challenge.isElite ?? false)
      return 0;
    else
      return 1;
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.subtitle.copyWith(fontSize: 15);

    return Scaffold(
        appBar: AppBar(
            title: const Text('Nightwave'), backgroundColor: Colors.red[800]),
        body: BlocBuilder(
          bloc: BlocProvider.of<WorldstateBloc>(context),
          builder: (_, state) {
            if (state is WorldstateLoaded) {
              final List<Challenges> challenges =
                  state.worldState.nightwave.activeChallenges;

              final daily = challenges
                  .where((c) => c.isDaily == true)
                  .map((c) => BountyType(challenge: c))
                  .toList();

              final weekly = challenges
                  .where((c) => c?.isDaily == false)
                  .map((c) => BountyType(challenge: c))
                  .toList();

              //make sure the daily that ends sooner and the elites are on top
              daily.sort(
                  (a, b) => a.challenge.expiry.compareTo(b.challenge.expiry));
              weekly.sort(_sort);

              return ListView(children: List.unmodifiable(() sync* {
                yield Container(
                    margin: const EdgeInsets.only(top: 10.0, left: 8.0),
                    alignment: Alignment.centerLeft,
                    child: Text('Daily', style: style));
                yield* daily;

                yield Container(
                    margin: const EdgeInsets.only(top: 10.0, left: 8.0),
                    alignment: Alignment.centerLeft,
                    child: Text('Weekly', style: style));
                yield* weekly;
              }()));
            }
          },
        ));
  }
}

class BountyType extends StatelessWidget {
  const BountyType({Key key, this.challenge}) : super(key: key);

  final Challenges challenge;

  Widget _type() {
    final timer = CountdownBox(expiry: challenge.expiry);
    const elite = StaticBox(child: Text('Elite Mission'), color: Colors.red);

    if (challenge.isDaily)
      return timer;
    else if (challenge.isElite)
      return elite;
    else
      return Container(height: 0, width: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Tiles(
        child: ListTile(
      title: Text(challenge.title),
      subtitle: Text(challenge.desc),
      trailing: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            StaticBox(
                color: Theme.of(context).accentColor,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(Standing.standing, size: 13),
                    Text('${challenge.reputation}')
                  ],
                )),
            _type()
          ]),
    ));
  }
}
