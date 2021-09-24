import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo/matomo.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/objects.dart';

import '../../../../constants/default_durations.dart';
import '../../../../constants/sizedbox_spacer.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/l10n.dart';
import '../bloc/solsystem_bloc.dart';
import '../widgets/syndicates/nightwave_challenges.dart';
import '../widgets/syndicates/syndicate_bounties.dart';
import '../widgets/syndicates/syndicate_card.dart';

class SyndicatePage extends TraceableStatelessWidget {
  const SyndicatePage({Key? key}) : super(key: key);

  bool _buildWhen(SolsystemState p, SolsystemState n) {
    final previous = (p as SolState).worldstate;
    final next = (n as SolState).worldstate;

    if (previous.nightwave != null || next.nightwave != null) {
      return previous.syndicateMissions.first.expiry !=
              next.syndicateMissions.first.expiry ||
          previous.nightwave!.daily.equals(next.nightwave!.daily) ||
          previous.nightwave!.weekly.equals(next.nightwave!.weekly);
    }

    return previous.syndicateMissions.first.expiry !=
        next.syndicateMissions.first.expiry;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolsystemBloc, SolsystemState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final worldstate = (state as SolState).worldstate;

        return ScreenTypeLayout.builder(
          mobile: (_) => SyndicatePageMobile(
            syndicates: worldstate.syndicateMissions,
            nightwave: worldstate.nightwave,
          ),
          tablet: (_) => SyndicatePageTablet(
            syndicates: worldstate.syndicateMissions,
            nightwave: worldstate.nightwave,
          ),
        );
      },
    );
  }
}

Widget _buildSyndicates(List<Syndicate> syndicates,
    {void Function(Syndicate)? onTap}) {
  return Column(
    children: <Widget>[
      CountdownBanner(
        message: 'Bounties expire in:',
        time: syndicates.first.expiry!,
      ),
      ...syndicates.map<SyndicateCard>((syn) => SyndicateCard(
            syndicate: syn,
            onTap: onTap == null ? null : () => onTap(syn),
          )),
    ],
  );
}

Widget _buildNightwave(Nightwave nightwave, {void Function(Nightwave)? onTap}) {
  return Column(
    children: <Widget>[
      CountdownBanner(
        message: 'Season ends in:',
        time: nightwave.expiry!,
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
  const SyndicatePageMobile({
    Key? key,
    required this.syndicates,
    this.nightwave,
  }) : super(key: key);

  final List<Syndicate> syndicates;
  final Nightwave? nightwave;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildSyndicates(syndicates),
        SizedBoxSpacer.spacerHeight8,
        if (nightwave != null) _buildNightwave(nightwave!)
      ],
    );
  }
}

class SyndicatePageTablet extends StatefulWidget {
  const SyndicatePageTablet({
    Key? key,
    required this.syndicates,
    this.nightwave,
  }) : super(key: key);

  final List<Syndicate> syndicates;
  final Nightwave? nightwave;

  @override
  _SyndicatePageTabletState createState() => _SyndicatePageTabletState();
}

class _SyndicatePageTabletState extends State<SyndicatePageTablet> {
  StreamController<Widget>? _controller;

  @override
  void initState() {
    super.initState();
    _controller = StreamController<Widget>();
  }

  void _onTap(WorldstateObject object) {
    if (object is Syndicate) {
      _controller?.sink.add(SyndicateBounties(syndicate: object));
    } else {
      _controller?.sink.add(const NightwaveChalleneges());
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
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildSyndicates(widget.syndicates, onTap: _onTap),
                SizedBoxSpacer.spacerHeight8,
                if (widget.nightwave != null)
                  _buildNightwave(widget.nightwave!, onTap: _onTap)
              ],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: StreamBuilder<Widget>(
                initialData: Text(context.l10n.syndicateDualScreenTitle),
                stream: _controller?.stream,
                builder: (_, snapshot) {
                  return AnimatedSwitcher(
                    duration: kAnimationShort,
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
