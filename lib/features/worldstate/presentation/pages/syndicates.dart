import 'dart:async';

import 'package:flutter/material.dart';
import 'package:matomo/matomo.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/objects.dart';

import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/l10n.dart';
import '../bloc/solsystem_bloc.dart';
import '../widgets/syndicates/nightwave_challenges.dart';
import '../widgets/syndicates/syndicate_bounties.dart';
import '../widgets/syndicates/syndicate_card.dart';

class SyndicatePage extends TraceableStatelessWidget {
  const SyndicatePage({Key key, @required this.state})
      : assert(state != null),
        super(key: key);

  final SolState state;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (_) => SyndicatePageMobile(state: state),
      tablet: (_) => SyndicatePageTablet(state: state),
    );
  }
}

Widget _buildSyndicates(List<Syndicate> syndicates,
    {void Function(Syndicate) onTap}) {
  return Column(
    children: <Widget>[
      CountdownBanner(
        message: 'Bounties expire in:',
        time: syndicates.first.expiry,
      ),
      ...syndicates.map<SyndicateCard>((syn) => SyndicateCard(
            syndicate: syn,
            onTap: onTap == null ? null : () => onTap(syn),
          )),
    ],
  );
}

Widget _buildNightwave(Nightwave nightwave, {void Function(Nightwave) onTap}) {
  return Column(
    children: <Widget>[
      CountdownBanner(
        message: 'Season ends in:',
        time: nightwave.expiry,
      ),
      SyndicateCard(
        name: 'Nightwave',
        caption: 'Season ${nightwave.season}',
        onTap: onTap == null ? null : () => onTap(nightwave),
      )
    ],
  );
}

class SyndicatePageMobile extends StatelessWidget {
  const SyndicatePageMobile({Key key, this.state}) : super(key: key);

  final SolState state;

  Worldstate get _worldstate => state.worldstate;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildSyndicates(_worldstate.syndicateMissions),
        const SizedBox(height: 8.0),
        if (state.isNightwaveActive) _buildNightwave(state.worldstate.nightwave)
      ],
    );
  }
}

class SyndicatePageTablet extends StatefulWidget {
  const SyndicatePageTablet({Key key, this.state}) : super(key: key);

  final SolState state;

  @override
  _SyndicatePageTabletState createState() => _SyndicatePageTabletState();
}

class _SyndicatePageTabletState extends State<SyndicatePageTablet> {
  StreamController<Widget> _controller;

  Worldstate get _worldstate => widget.state.worldstate;

  @override
  void initState() {
    super.initState();
    _controller = StreamController<Widget>();
  }

  void _onTap(WorldstateObject object) {
    if (object is Syndicate) {
      _controller.sink.add(SyndicateBounties(syndicate: object));
    } else {
      _controller.sink.add(const NightwaveChalleneges());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildSyndicates(
                  _worldstate.syndicateMissions,
                  onTap: _onTap,
                ),
                const SizedBox(height: 8.0),
                if (widget.state.isNightwaveActive)
                  _buildNightwave(
                    widget.state.worldstate.nightwave,
                    onTap: _onTap,
                  )
              ],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: StreamBuilder<Widget>(
                initialData: Text(context.l10n.syndicateDualScreenTitle),
                stream: _controller.stream,
                builder: (_, snapshot) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    switchInCurve: Curves.easeInCubic,
                    switchOutCurve: Curves.easeOutCubic,
                    child: snapshot.data,
                  );
                }),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }
}
