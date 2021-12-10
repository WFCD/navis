import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo/matomo.dart';
import 'package:navis/injection_container.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis/worldstate/widgets/orbiter_news_widgets.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class OrbiterNewsPage extends StatelessWidget {
  const OrbiterNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SolsystemCubit(sl<WorldstateRepository>())..fetchWorldstate(),
      child: const OrbiterNewsView(),
    );
  }
}

class OrbiterNewsView extends TraceableStatelessWidget {
  const OrbiterNewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SolsystemCubit>().state;
    final orbitNews =
        state is SolState ? state.worldstate.news : <OrbiterNews>[];

    return ViewLoading(
      isLoading: state is! SolState,
      child: RefreshIndicator(
        onRefresh: BlocProvider.of<SolsystemCubit>(context).fetchWorldstate,
        child: state is! SolState
            ? const SizedBox(height: 0, width: 0)
            : ListView.builder(
                cacheExtent: 200,
                itemCount: orbitNews.length,
                itemBuilder: (context, index) {
                  return OrbiterNewsWidget(news: orbitNews[index]);
                },
              ),
      ),
    );
  }
}
