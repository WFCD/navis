import 'package:flutter/material.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/worldstate/widgets/syndicates/nightwave_challenges.dart';
import 'package:warframestat_client/warframestat_client.dart';

class NightwavesPage extends StatelessWidget {
  const NightwavesPage({super.key});

  static const route = '/nightwave';

  @override
  Widget build(BuildContext context) {
    final nightwave = ModalRoute.of(context)?.settings.arguments as Nightwave?;

    return TraceableWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nightwave'),
          backgroundColor: const Color(0xFF6C1822),
        ),
        body: nightwave != null
            ? NightwaveChalleneges(nightwave: nightwave)
            : const Center(child: Text('No active Nightwave')),
      ),
    );
  }
}
