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
              final nightwave = state.worldState.nightwave;

              final daily = nightwave.dailyChallenges
                  .map((c) => BountyType(challenge: c))
                  .toList();

              final weekly = nightwave.weeklyChallenges
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

  final Challenge challenge;

  Widget _type() => challenge.isDaily
      ? CountdownBox(expiry: challenge.expiry)
      : Container(height: 0, width: 0);

  Color _setColor(BuildContext context) {
    if (challenge?.isElite ?? false)
      return Colors.red;
    else if (challenge?.isDaily ?? false)
      return Theme.of(context).accentColor;
    else
      return Colors.orange[700];
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).textTheme.caption.color;

    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
            margin: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Text(challenge.title,
                          style: Theme.of(context).textTheme.subhead)),
                  const SizedBox(height: 4.0),
                  Container(
                      child: Text(challenge.desc,
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(fontSize: 14, color: color))),
                  const SizedBox(height: 8.0),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        StaticBox(
                            color: _setColor(context),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Icon(Standing.standing, size: 15),
                                Text('${challenge.reputation}')
                              ],
                            )),
                        _type()
                      ]),
                ])));
  }
}
