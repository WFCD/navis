import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:matomo/matomo.dart';

import '../widgets/syndicates/nightwave_challenges.dart';

class NightwavesPage extends TraceableStatelessWidget {
  const NightwavesPage({Key? key}) : super(key: key);

  static const route = '/nightwave';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nightwave'),
        backgroundColor: const Color(0xFF6C1822),
      ),
      body: const NightwaveChalleneges(),
    );
  }
}
