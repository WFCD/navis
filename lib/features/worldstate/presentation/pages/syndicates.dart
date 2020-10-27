import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navis/core/widgets/countdown_banner.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:navis/features/worldstate/presentation/widgets/common/refresh_indicator_bloc_screen.dart';
import 'package:navis/features/worldstate/presentation/widgets/syndicates/nightwave_challenges.dart';
import 'package:navis/features/worldstate/presentation/widgets/syndicates/syndicate_bounties.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:warframestat_api_models/warframestat_api_models.dart';

import '../widgets/syndicates/syndicate_card.dart';

class SyndicatePage extends StatelessWidget {
  const SyndicatePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicatorBlocScreen(
      builder: (BuildContext context, SolsystemState state) {
        if (state is SolState) {
          return ScreenTypeLayout.builder(
            mobile: (_) => SyndicatePageMobile(state: state),
            tablet: (_) => SyndicatePageTablet(state: state),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
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
    return CustomScrollView(
      key: const PageStorageKey<String>('mobile_syndicate'),
      slivers: <Widget>[
        SliverOverlapInjector(
          // This is the flip side of the SliverOverlapAbsorber above.
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            _buildSyndicates(_worldstate.syndicateMissions),
            const SizedBox(height: 8.0),
            if (state.isNightwaveActive)
              _buildNightwave(state.worldstate.nightwave)
          ]),
        )
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

    _controller = StreamController<Widget>.broadcast();
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildSyndicates(
                _worldstate.syndicateMissions,
                onTap: (syn) => _onTap(syn),
              ),
              const SizedBox(height: 8.0),
              if (widget.state.isNightwaveActive)
                _buildNightwave(
                  widget.state.worldstate.nightwave,
                  onTap: (night) => _onTap(night),
                )
            ],
          ),
        ),
        const VerticalDivider(),
        Expanded(
          child: Center(
            child: StreamBuilder<Widget>(
                initialData: const Text('Select Syndicate'),
                stream: _controller.stream,
                builder:
                    (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
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
