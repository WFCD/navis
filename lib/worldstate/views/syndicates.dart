import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo/matomo.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis/worldstate/widgets/syndicate_widgets.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:nil/nil.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/objects.dart';

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
    return BlocBuilder<SolsystemCubit, SolsystemState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final syndicateMissions = state is SolState
            ? state.worldstate.syndicateMissions
            : <Syndicate>[];
        final nightwave = state is SolState
            ? state.worldstate.nightwave
            : Nightwave(
                id: 'id',
                activation: DateTime.now(),
                expiry: DateTime.now().add(kThemeAnimationDuration),
                startString: 'startString',
                tag: 'tag',
                active: false,
                season: 0,
                phase: 0,
                possibleChallenges: const <Challenge>[],
                activeChallenges: const <Challenge>[],
                rewardTypes: const <String>[],
              );

        return ViewLoading(
          isLoading: state is! SolState,
          child: state is! SolState
              ? nil
              : ScreenTypeLayout.builder(
                  mobile: (_) => SyndicatePageMobile(
                    syndicates: syndicateMissions,
                    nightwave: nightwave,
                  ),
                  tablet: (_) => SyndicatePageTablet(
                    syndicates: syndicateMissions,
                    nightwave: nightwave,
                  ),
                ),
        );
      },
    );
  }
}

Widget _buildSyndicates(
  List<Syndicate> syndicates, {
  void Function(Syndicate)? onTap,
}) {
  return Column(
    children: <Widget>[
      CountdownBanner(
        message: 'Bounties expire in:',
        time: syndicates.first.expiry!,
      ),
      ...syndicates.map<SyndicateCard>(
        (syn) => SyndicateCard(
          syndicate: syn,
          onTap: onTap == null ? null : () => onTap(syn),
        ),
      ),
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
        nightwave: nightwave,
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
      // Since the widget itself isn't visible when nightwave are inactive it
      // seems alright to force this.
      _controller?.sink.add(NightwaveChalleneges(nightwave: widget.nightwave!));
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
              },
            ),
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
