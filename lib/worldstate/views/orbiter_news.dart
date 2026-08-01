import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class OrbiterNewsPage extends StatelessWidget {
  const OrbiterNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.languageCode;
    final repository = RepositoryProvider.of<WorldstateRepository>(context);

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.warframeNewsTitle)),
      body: BlocProvider(create: (_) => WorldstateBloc(locale, repository), child: const _OrbiterNewsView()),
    );
  }
}

class _OrbiterNewsView extends StatelessWidget {
  const _OrbiterNewsView();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WorldstateBloc>().state;
    final news = switch (state) {
      WorldstateSuccess(:final seed) => seed.news,
      _ => <News>[],
    };

    return ViewLoading(
      isLoading: state is! WorldstateSuccess,
      child: ListView.builder(
        itemExtent: MediaQuery.sizeOf(context).height * .30,
        itemCount: news.length,
        itemBuilder: (context, index) => OrbiterNewsCard(news: news[index]),
      ),
    );
  }
}
