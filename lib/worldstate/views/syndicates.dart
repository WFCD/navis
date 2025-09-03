import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis/synthtargets/views/targets.dart';
import 'package:navis/worldstate/widgets/syndicates/hex_card.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:warframestat_client/warframestat_client.dart';

typedef SyndicateData = ({List<SyndicateMission> jobs, Nightwave? nightwave, Calendar calendar});

class SyndicatePage extends StatelessWidget {
  const SyndicatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WorldstateBloc, WorldState, SyndicateData?>(
      selector: (state) {
        if (state is! WorldstateSuccess) return null;

        final worldstate = state.seed;

        return (
          calendar: worldstate.calendar,
          nightwave: worldstate.nightwave,
          jobs: worldstate.syndicateMissions,
        );
      },
      builder: (context, state) {
        return TraceableWidget(
          actionName: 'SyndicatePage()',
          child: ViewLoading(
            isLoading: state == null,
            child: ResponsiveBuilder(
              builder: (context, info) {
                return _SyndicateView(
                  syndicates: state?.jobs ?? [],
                  nightwave: state?.nightwave,
                  calendar: state?.calendar,
                  isMobile: info.deviceScreenType == DeviceScreenType.mobile,
                );
              },
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
        CountdownBanner(message: 'Bounties expire in:', time: syndicates.firstOrNull?.expiry),
        ...syndicates.map<SyndicateCard>(
          (syn) => SyndicateCard(syndicate: Syndicates.syndicateStringToEnum(syn.syndicate), onTap: () => onTap(syn)),
        ),
      ],
    );
  }
}

class _SyndicateView extends StatefulWidget {
  const _SyndicateView({required this.syndicates, this.nightwave, required this.calendar, this.isMobile = true});

  final List<SyndicateMission> syndicates;
  final Nightwave? nightwave;
  final Calendar? calendar;
  final bool isMobile;

  @override
  _SyndicateViewState createState() => _SyndicateViewState();
}

class _SyndicateViewState extends State<_SyndicateView> {
  StreamController<Widget>? _controller;

  void _changePane(Widget widget) => _controller?.sink.add(widget);

  @override
  void initState() {
    super.initState();
    if (widget.isMobile) _controller = StreamController<Widget>();
  }

  @override
  Widget build(BuildContext context) {
    final nightwave = widget.nightwave;
    final calendar = widget.calendar;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(top: 4),
            children: <Widget>[
              if (nightwave != null)
                NightwaveCard(
                  nightwave: nightwave,
                  onTap: () {
                    widget.isMobile
                        ? NightwavePageRoute(nightwave).push<void>(context)
                        : _changePane(NightwaveChalleneges(nightwave: widget.nightwave!));
                  },
                ),
              if (calendar != null)
                HexCard(
                  calendar: calendar,
                  onTap: () {
                    widget.isMobile
                        ? Calendar1999PageRoute(calendar.season, calendar.days).push<void>(context)
                        : _changePane(CalendarView(days: calendar.days));
                  },
                ),
              _BuildSyndicates(
                syndicates: widget.syndicates,
                onTap: (s) {
                  widget.isMobile
                      ? SyndicatePageRoute(s).push<void>(context)
                      : _changePane(SyndicateBounties(syndicate: s));
                },
              ),
              const Divider(),
              SyndicateCard(
                syndicate: Syndicates.simaris,
                onTap: () {
                  widget.isMobile
                      ? const SynthTargetsPageRoute().push<void>(context)
                      : _changePane(const SynthTargetsView());
                },
              ),
            ],
          ),
        ),
        if (!widget.isMobile) ...{
          const VerticalDivider(indent: 16, endIndent: 16),
          Expanded(
            child: Center(
              child: StreamBuilder<Widget>(
                initialData: Text(context.l10n.syndicateDualScreenTitle),
                stream: _controller?.stream,
                builder: (_, snapshot) {
                  return AnimatedSwitcher(
                    duration: kThemeAnimationDuration,
                    switchInCurve: Curves.easeInCubic,
                    switchOutCurve: Curves.easeOutCubic,
                    child: snapshot.data,
                  );
                },
              ),
            ),
          ),
        },
      ],
    );
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }
}
