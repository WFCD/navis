import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navis/models/export.dart';
import 'package:rxdart/rxdart.dart';

import 'package:navis/ui/widgets/countdown.dart';
import 'package:navis/ui/widgets/row_item.dart';

class NightwaveChallenges extends StatefulWidget {
  const NightwaveChallenges({this.challenges});

  final List<Challenges> challenges;

  @override
  _NightwaveChallengesState createState() => _NightwaveChallengesState();
}

class _NightwaveChallengesState extends State<NightwaveChallenges> {
  StreamController<bool> daily;
  StreamController<bool> weekly;

  @override
  void initState() {
    super.initState();

    weekly = BehaviorSubject<bool>();
    daily = BehaviorSubject<bool>();
  }

  @override
  void dispose() {
    weekly?.close();
    daily?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            titleSpacing: 0.0,
            title: const Text('Nightwave'),
            backgroundColor: Theme.of(context).primaryColor),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: const ColorFilter.mode(
                        Color.fromRGBO(34, 34, 34, .5), BlendMode.darken),
                    image: const AssetImage('assets/general/background.webp'),
                    fit: BoxFit.fitHeight)),
            child: ListView(children: <Widget>[
              BountyType(
                  category: 'Weekly',
                  child: _BuildChallengeBox(
                      challenges: widget.challenges, isElite: true)),
              BountyType(
                  category: 'Daily',
                  child: _BuildChallengeBox(challenges: widget.challenges)),
            ])));
  }
}

class BountyType extends StatefulWidget {
  const BountyType({Key key, this.category, this.child}) : super(key: key);

  final String category;
  final Widget child;

  @override
  _BountyTypeState createState() => _BountyTypeState();
}

class _BountyTypeState extends State<BountyType>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  AnimationController _controller;
  Animation<double> _iconTurns;

  bool _show = false;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _show = !_show;
      if (_show) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Widget _buildTitle(String title) => Align(
      alignment: Alignment.centerLeft,
      child: Text(title,
          style: Theme.of(context).textTheme.title.copyWith(fontSize: 20)));

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Card(
            color: const Color(0xFF811914),
            child: InkWell(
                splashColor: Colors.redAccent[700],
                onTap: () => _handleTap(),
                child: Container(
                    height: 50,
                    margin: const EdgeInsets.all(4.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(child: _buildTitle(widget.category)),
                          Container(
                              child: RotationTransition(
                                  turns: _iconTurns,
                                  child: const Icon(Icons.expand_more)))
                        ])))),
        AnimatedCrossFade(
          firstChild: Container(),
          secondChild: widget.child,
          duration: _controller.duration,
          crossFadeState:
              _show ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        )
      ]),
    );
  }
}

class _BuildChallengeBox extends StatelessWidget {
  const _BuildChallengeBox({this.challenges, this.isElite = false});

  final List<Challenges> challenges;
  final bool isElite;

  Widget _buildChallenge(Challenges challenge) {
    return Container(
        height: 60,
        margin: const EdgeInsets.all(2.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RowItem(
                  text: challenge.title,
                  child: CountdownBox(expiry: challenge.expiry)),
              Expanded(child: Text(challenge.desc))
            ]));
  }

  void _buildtype(bool d, List<Widget> children, TextStyle style) {
    final elite = Text('Elite Bounties', style: style);
    final normal = Text('Normal Bounties', style: style);

    if (d == true) {
      children.add(elite);
      children.addAll(
          challenges.where((e) => e.isElite == true).map(_buildChallenge));

      children.add(const SizedBox(height: 8));
      children.add(normal);
      children.addAll(challenges
          .where((e) => e.isElite == false && e.isDaily == false)
          .map(_buildChallenge));
    } else {
      children.addAll(challenges
          .where((e) => e.isDaily == true && e.isElite == false)
          .map(_buildChallenge));
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[const SizedBox(height: 8)];
    final style = Theme.of(context).textTheme.subhead;

    _buildtype(isElite, children, style);
    return Container(color: Colors.black54, child: Column(children: children));
  }
}
