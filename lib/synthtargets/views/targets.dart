import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/synthtargets/cubit/synthtargets_cubit.dart';
import 'package:navis/synthtargets/widgets/target.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_repository/warframe_repository.dart';

class SynthTargetsView extends StatelessWidget {
  const SynthTargetsView({super.key});

  static const route = '/simaris';

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<WarframeRepository>(context);

    return TraceableWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (_) => SynthtargetsCubit(repo)..fetchSynthtargets(),
          child: const _SynthTargetsPage(),
        ),
      ),
    );
  }
}

class _SynthTargetsPage extends StatelessWidget {
  const _SynthTargetsPage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SynthtargetsCubit, SynthtargetsState>(
      builder: (context, state) {
        if (state is TargetsLocated) {
          final targets = state.targets;

          return ListView.builder(
            scrollCacheExtent: const ScrollCacheExtent.pixels(500),
            itemCount: targets.length,
            itemBuilder: (context, index) {
              return TargetInfo(target: targets[index]);
            },
          );
        }

        return const Center(child: WarframeSpinner());
      },
    );
  }
}
