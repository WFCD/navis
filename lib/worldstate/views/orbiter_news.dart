import 'package:black_hole_flutter/black_hole_flutter.dart';
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
    final state = context.watch<SolsystemCubit>().state;
    final orbitNews = state is SolState ? state.worldstate.news : <News>[];

    return TraceableWidget(
      child: ViewLoading(
        isLoading: state is! SolState,
        child: RefreshIndicator(
          onRefresh: () => BlocProvider.of<SolsystemCubit>(context)
              .fetchWorldstate(context.locale, forceUpdate: true),
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
      ),
    );
  }
}
