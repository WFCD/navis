import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class OrbiterNewsPage extends StatelessWidget {
  const OrbiterNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wsRepo = RepositoryProvider.of<WarframestatRepository>(context);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.warframeNewsTitle)),
      body: BlocProvider(create: (_) => WorldstateBloc(wsRepo), child: const _OrbiterNewsView()),
    );
  }
}

class _OrbiterNewsView extends StatelessWidget {
  const _OrbiterNewsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldstateBloc, WorldState>(
      builder: (context, state) {
        final news = state is WorldstateSuccess ? state.seed.news : <News>[];

        return ViewLoading(
          isLoading: state is! WorldstateSuccess,
          child: ListView.builder(
            itemExtent: 200,
            itemCount: news.length,
            itemBuilder: (context, index) {
              return OrbiterNewsCard(news: news[index]);
            },
          ),
        );
      },
    );
  }
}
