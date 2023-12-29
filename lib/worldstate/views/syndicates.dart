import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:warframestat_client/warframestat_client.dart';

class SyndicatePage extends StatelessWidget {
  const SyndicatePage({super.key});

  bool _buildWhen(SolsystemState p, SolsystemState n) {
    final previous = switch (p) {
      SolState() => p.worldstate,
      _ => null,
    };

    final next = switch (n) {
      SolState() => n.worldstate,
      _ => null,
    };

    if (previous == null || next == null) return true;

    if (previous.nightwave != null || next.nightwave != null) {
      return previous.syndicateMissions.first.expiry !=
              next.syndicateMissions.first.expiry ||
          previous.nightwave!.activeChallenges
              .equals(next.nightwave!.activeChallenges);
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
            : <SyndicateMission>[];
        final nightwave = state is SolState ? state.worldstate.nightwave : null;

        return TraceableWidget(
          child: ViewLoading(
            isLoading: state is! SolState,
            child: ScreenTypeLayout.builder(
              mobile: (_) => _SyndicatePageMobile(
                syndicates: syndicateMissions,
                nightwave: nightwave,
              ),
              tablet: (_) => _SyndicatePageTablet(
                syndicates: syndicateMissions,
                nightwave: nightwave,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BuildSyndicates extends StatelessWidget {
  const _BuildSyndicates({required this.syndicates, required this.onTap});

  final List<SyndicateMission> syndicates;
  final void Function(SyndicateMission) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CountdownBanner(
          message: 'Bounties expire in:',
          time: syndicates.first.expiry,
        ),
        ...syndicates.map<SyndicateCard>(
          (syn) => SyndicateCard(
            syndicate: syn,
            onTap: () => onTap(syn),
          ),
        ),
      ],
    );
  }
}

class _BuildNightwave extends StatelessWidget {
  const _BuildNightwave({required this.nightwave, required this.onTap});

  final Nightwave nightwave;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CountdownBanner(
          message: 'Season ends in:',
          // Will default to DateTime.now() under the hood.
          // ignore: avoid-non-null-assertion
          time: nightwave.expiry,
        ),
        SyndicateCard(
          name: 'Nightwave',
          caption: 'Season ${nightwave.season}',
          nightwave: nightwave,
          onTap: onTap,
        ),
      ],
    );
  }
}

class _SyndicatePageMobile extends StatelessWidget {
  const _SyndicatePageMobile({required this.syndicates, this.nightwave});

  final List<SyndicateMission> syndicates;
  final Nightwave? nightwave;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _BuildSyndicates(
          syndicates: syndicates,
          onTap: (s) {
            Navigator.of(context).pushNamed(BountiesPage.route, arguments: s);
          },
        ),
        SizedBoxSpacer.spacerHeight8,
        if (nightwave != null)
          _BuildNightwave(
            nightwave: nightwave!,
            onTap: () {
              Navigator.of(context)
                  .pushNamed(NightwavesPage.route, arguments: nightwave);
            },
          ),
      ],
    );
  }
}

class _SyndicatePageTablet extends StatefulWidget {
  const _SyndicatePageTablet({required this.syndicates, this.nightwave});

  final List<SyndicateMission> syndicates;
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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ListView(
              children: <Widget>[
                _BuildSyndicates(
                  syndicates: widget.syndicates,
                  onTap: (s) {
                    _controller?.sink.add(SyndicateBounties(syndicate: s));
                  },
                ),
                SizedBoxSpacer.spacerHeight8,
                if (widget.nightwave != null)
                  // Already being checked for null.
                  _BuildNightwave(
                    nightwave: widget.nightwave!,
                    onTap: () {
                      _controller?.sink.add(
                        NightwaveChalleneges(nightwave: widget.nightwave!),
                      );
                    },
                  ),
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
