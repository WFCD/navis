import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo/matomo.dart';
import 'package:navis/synthtargets/cubit/synthtargets_cubit.dart';
import 'package:navis/synthtargets/widgets/target.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class SynthTargetsView extends TraceableStatelessWidget {
  const SynthTargetsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SynthtargetsCubit(
        RepositoryProvider.of<WorldstateRepository>(context),
      )..fetchSynthtargets(),
      child: const _SynthTargetsPage(),
    );
  }
}

class _SynthTargetsPage extends StatelessWidget {
  const _SynthTargetsPage();

  @override
  Widget build(BuildContext context) {
    const cacheExtent = 500.0;

    return RefreshIndicator(
      onRefresh: BlocProvider.of<SynthtargetsCubit>(context).fetchSynthtargets,
      child: BlocBuilder<SynthtargetsCubit, SynthtargetsState>(
        builder: (BuildContext context, SynthtargetsState state) {
          if (state is TargetsLocated) {
            final targets = state.targets;

            return ListView.builder(
              cacheExtent: cacheExtent,
              itemCount: targets.length,
              itemBuilder: (BuildContext context, int index) {
                return TargetInfo(target: targets[index]);
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
