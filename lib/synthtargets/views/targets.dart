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
      child: const SynthTargetsPage(),
    );
  }
}

class SynthTargetsPage extends StatelessWidget {
  const SynthTargetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: BlocProvider.of<SynthtargetsCubit>(context).fetchSynthtargets,
      child: BlocBuilder<SynthtargetsCubit, SynthtargetsState>(
        builder: (BuildContext context, SynthtargetsState state) {
          if (state is TargetsLocated) {
            final targets = state.targets;

            return ListView.builder(
              cacheExtent: 500,
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
