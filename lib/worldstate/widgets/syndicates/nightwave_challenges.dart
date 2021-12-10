import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis/worldstate/widgets/syndicates/nightwave_challenge.dart';
import 'package:navis_ui/navis_ui.dart';

class NightwaveChalleneges extends StatelessWidget {
  const NightwaveChalleneges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 15);

    return BlocBuilder<SolsystemCubit, SolsystemState>(
      builder: (_, state) {
        if (state is SolState) {
          const padding = SizedBox(height: 8);

          final daily = state.nightwaveDailies
              .map<NightwaveChallenge>((c) => NightwaveChallenge(challenge: c));

          final weekly = state.nightwaveWeeklies
              .map<NightwaveChallenge>((c) => NightwaveChallenge(challenge: c));

          return ListView(
            children: <Widget>[
              padding,
              CategoryTitle(
                title: context.l10n.dailyNightwaveTitle,
                style: style,
              ),
              ...daily,
              padding,
              CategoryTitle(
                title: context.l10n.weeklyNightwaveTitle,
                style: style,
              ),
              ...weekly
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
