import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class OrbiterNewsPage extends StatelessWidget {
  const OrbiterNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const itemExtent = 200.0;
    final state = context.watch<WorldstateCubit>().state;
    final orbitNews =
        state is WorldstateSuccess ? state.worldstate.news : <News>[];

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.warframeNewsTitle)),
      body: TraceableWidget(
        child: ViewLoading(
          isLoading: state is! WorldstateSuccess,
          child: BlocBuilder<WorldstateCubit, SolsystemState>(
            builder: (context, state) {
              if (state is! WorldstateSuccess) {
                return const Center(child: WarframeSpinner());
              }

              return ListView.builder(
                itemExtent: itemExtent,
                itemCount: orbitNews.length,
                itemBuilder: (context, index) {
                  return OrbiterNewsWidget(news: orbitNews[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
