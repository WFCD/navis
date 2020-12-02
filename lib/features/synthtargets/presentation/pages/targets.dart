import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/core/utils/helper_methods.dart';
import 'package:navis/features/synthtargets/presentation/widgets/target.dart';
import 'package:navis/injection_container.dart';

import '../bloc/synthtargets_bloc.dart';

class SynthTargetsPage extends StatelessWidget {
  const SynthTargetsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final bloc = sl<SynthtargetsBloc>();

    return BlocProvider(
      create: (context) => bloc,
      child: RefreshIndicator(
        onRefresh: bloc.refresh,
        child: BlocBuilder<SynthtargetsBloc, SynthtargetsState>(
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
      ),
    );
  }
}
