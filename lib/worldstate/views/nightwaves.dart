import 'package:flutter/material.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/worldstate/widgets/syndicates/nightwave_challenges.dart';
import 'package:warframestat_client/warframestat_client.dart';

class NightwavesPage extends StatelessWidget {
  const NightwavesPage({required this.nightwave, super.key});

  final Nightwave? nightwave;

  @override
  Widget build(BuildContext context) {
    return TraceableWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nightwave'),
          titleSpacing: 0,
          titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
          iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
          backgroundColor: const Color(0xFF6C1822),
        ),
        body:
            nightwave != null
                ? NightwaveChalleneges(nightwave: nightwave!)
                : const Center(child: Text('No active Nightwave')),
      ),
    );
  }
}
