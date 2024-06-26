import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class OrbiterNewsPage extends StatelessWidget {
  const OrbiterNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const cacheExtent = 200.0;
    final state = context.watch<WorldstateCubit>().state;
    final orbitNews =
        state is WorldstateSuccess ? state.worldstate.news : <News>[];

    return TraceableWidget(
      child: ViewLoading(
        isLoading: state is! WorldstateSuccess,
        child: RefreshIndicator(
          onRefresh: () =>
              BlocProvider.of<WorldstateCubit>(context).fetchWorldstate(),
          child: state is! WorldstateSuccess
              ? const SizedBox.shrink()
              : ListView.builder(
                  cacheExtent: cacheExtent,
                  itemCount: orbitNews.length,
                  itemBuilder: (context, index) {
                    return OrbiterNewsWidget(news: orbitNews[index]);
                  },
                ),
        ),
      ),
    );
  }
}
