import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/widgets/screen_widgets/nightwave/nightwave.dart';
import 'package:navis/widgets/widgets.dart';

class Nightwaves extends StatelessWidget {
  const Nightwaves();

  static const route = '/nightwave';

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.subtitle.copyWith(fontSize: 15);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Nightwave'),
            backgroundColor: Colors.red[800],
          ),
          body: BlocBuilder<WorldstateBloc, WorldStates>(
            condition: (previous, current) {
              return (previous.worldstate?.nightwave !=
                      current.worldstate?.nightwave) ??
                  false;
            },
            builder: (_, state) {
              if (state is WorldstateLoaded) {
                const padding = SizedBox(height: 8.0);
                final nightwave = state.worldstate.nightwave;

                final daily = nightwave
                    .dailyChallenges()
                    .map((c) => NightwaveChallenge(challenge: c));

                final weekly = nightwave
                    .weeklyChallenges()
                    .map((c) => NightwaveChallenge(challenge: c));

                return ListView(children: <Widget>[
                  padding,
                  SettingTitle(title: 'Daily', style: style),
                  ...daily,
                  padding,
                  SettingTitle(title: 'Weekly', style: style),
                  ...weekly
                ]);
              }

              return Container();
            },
          )),
    );
  }
}
