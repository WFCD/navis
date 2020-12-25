import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../bloc/solsystem_bloc.dart';
import 'nightwave_challenge.dart';

class NightwaveChalleneges extends StatelessWidget {
  const NightwaveChalleneges();

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 15);

    return BlocBuilder<SolsystemBloc, SolsystemState>(
      builder: (_, state) {
        if (state is SolState) {
          const padding = SizedBox(height: 8.0);

          final daily = state.nightwaveDailies
              .map<NightwaveChallenge>((c) => NightwaveChallenge(challenge: c));

          final weekly = state.nightwaveWeeklies
              .map<NightwaveChallenge>((c) => NightwaveChallenge(challenge: c));

          return ListView(children: <Widget>[
            padding,
            CategoryTitle(
              title: context.locale.dailyNightwaveTitle,
              style: style,
            ),
            ...daily,
            padding,
            CategoryTitle(
              title: context.locale.weeklyNightwaveTitle,
              style: style,
            ),
            ...weekly
          ]);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
