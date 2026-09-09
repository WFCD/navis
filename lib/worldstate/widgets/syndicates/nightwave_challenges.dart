import 'package:material_ui/material_ui.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:warframe_common/warframe_common.dart' as model;

class NightwaveChalleneges extends StatelessWidget {
  const new({super.key, required this.nightwave});

  final model.Nightwave nightwave;

  @override
  Widget build(BuildContext context) {
    final challenges = nightwave.challenges
      ..sort(
        (a, b) {
          if (a.isDaily && b.isDaily) return 0;
          return a.isDaily ? -1 : 1;
        },
      );

    return ListView(
      children: challenges.map((c) => NightwaveChallenge(challenge: c)).toList(),
    );
  }
}
