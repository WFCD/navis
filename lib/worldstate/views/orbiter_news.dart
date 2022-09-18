import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo/matomo.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis/worldstate/widgets/orbiter_news_widgets.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class OrbiterNewsPage extends TraceableStatelessWidget {
  const OrbiterNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const cacheExtent = 200.0;
    final state = context.watch<SolsystemCubit>().state;
    final orbitNews =
        state is SolState ? state.worldstate.news : <OrbiterNews>[];

    return ViewLoading(
      isLoading: state is! SolState,
      child: RefreshIndicator(
        onRefresh: BlocProvider.of<SolsystemCubit>(context).fetchWorldstate,
        child: state is! SolState
            ? const SizedBox.shrink()
            : ListView.builder(
                cacheExtent: cacheExtent,
                itemCount: orbitNews.length,
                itemBuilder: (context, index) {
                  return OrbiterNewsWidget(news: orbitNews[index]);
                },
              ),
      ),
    );
  }
}
