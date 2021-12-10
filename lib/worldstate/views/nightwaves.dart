import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo/matomo.dart';
import 'package:navis/injection_container.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis/worldstate/widgets/syndicates/nightwave_challenges.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

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
      body: BlocProvider(
        create: (_) => SolsystemCubit(sl<WorldstateRepository>()),
        child: const NightwaveChalleneges(),
      ),
    );
  }
}
