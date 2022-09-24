import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo/matomo.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:nil/nil.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/objects.dart';

class SyndicatePage extends TraceableStatelessWidget {
  const SyndicatePage({super.key});

  bool _buildWhen(SolsystemState p, SolsystemState n) {
    final previous = (p as SolState).worldstate;
    final next = (n as SolState).worldstate;

    if (previous.nightwave != null || next.nightwave != null) {
      return previous.syndicateMissions.first.expiry !=
              next.syndicateMissions.first.expiry ||
          // Already being checked for null.
          // ignore: avoid-non-null-assertion
          previous.nightwave!.daily.equals(next.nightwave!.daily) ||
          // Already being checked for null.
          // ignore: avoid-non-null-assertion
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
                  mobile: (_) => _SyndicatePageMobile(
                    syndicates: syndicateMissions,
                    nightwave: nightwave,
                  ),
                  tablet: (_) => _SyndicatePageTablet(
                    syndicates: syndicateMissions,
                    nightwave: nightwave,
                  ),
                ),
        );
      },
    );
  }
}

class _BuildSyndicates extends StatelessWidget {
  const _BuildSyndicates({required this.syndicates, this.onTap});

  final List<Syndicate> syndicates;
  final void Function(Syndicate)? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CountdownBanner(
          message: 'Bounties expire in:',
          // Will default to DateTime.now() under the hood.
          // ignore: avoid-non-null-assertion
          time: syndicates.first.expiry!,
        ),
        ...syndicates.map<SyndicateCard>(
          (syn) => SyndicateCard(
            syndicate: syn,
            // Already being checked for null.
            // ignore: avoid-non-null-assertion
            onTap: onTap != null ? () => onTap!.call(syn) : null,
          ),
        ),
      ],
    );
  }
}

class _BuildNightwave extends StatelessWidget {
  const _BuildNightwave({required this.nightwave, this.onTap});

  final Nightwave nightwave;
  final void Function(Nightwave)? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CountdownBanner(
          message: 'Season ends in:',
          // Will default to DateTime.now() under the hood.
          // ignore: avoid-non-null-assertion
          time: nightwave.expiry!,
        ),
        SyndicateCard(
          name: 'Nightwave',
          caption: 'Season ${nightwave.season}',
          nightwave: nightwave,
          // Already being checked for null.
          // ignore: avoid-non-null-assertion
          onTap: onTap != null ? () => onTap!.call(nightwave) : null,
        ),
      ],
    );
  }
}

class _SyndicatePageMobile extends StatelessWidget {
  const _SyndicatePageMobile({required this.syndicates, this.nightwave});

  final List<Syndicate> syndicates;
  final Nightwave? nightwave;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _BuildSyndicates(syndicates: syndicates),
        SizedBoxSpacer.spacerHeight8,
        // Already being checked for null.
        // ignore: avoid-non-null-assertion
        if (nightwave != null) _BuildNightwave(nightwave: nightwave!),
      ],
    );
  }
}

class _SyndicatePageTablet extends StatefulWidget {
  const _SyndicatePageTablet({required this.syndicates, this.nightwave});

  final List<Syndicate> syndicates;
  final Nightwave? nightwave;

  @override
  _SyndicatePageTabletState createState() => _SyndicatePageTabletState();
}

class _SyndicatePageTabletState extends State<_SyndicatePageTablet> {
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
      // ignore: avoid-non-null-assertion
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
                _BuildSyndicates(syndicates: widget.syndicates, onTap: _onTap),
                SizedBoxSpacer.spacerHeight8,
                if (widget.nightwave != null)
                  // Already being checked for null.
                  // ignore: avoid-non-null-assertion
                  _BuildNightwave(nightwave: widget.nightwave!, onTap: _onTap),
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
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }
}
