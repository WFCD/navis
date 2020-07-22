import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/features/worldstate/presentation/widgets/orbiter_news/news_widget.dart';
import 'package:warframestat_api_models/entities.dart';

import '../bloc/solsystem_bloc.dart';

class OrbiterNewsPage extends StatelessWidget {
  const OrbiterNewsPage({Key key}) : super(key: key);

  Widget _buildOlderNews(OrbiterNews news) {
    return OrbiterNewsWidget(
      news: news,
      height: 150,
    );
  }

  Widget _category(String text, TextStyle style) {
    return CategoryTitle(title: text, style: style);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return BlocBuilder<SolsystemBloc, SolsystemState>(
      builder: (context, state) {
        if (state is SolState) {
          final news = state.worldstate?.news ?? [];
          final recent = news.skip(1).map(_buildOlderNews);

          return ListView(
            cacheExtent: 500,
            children: <Widget>[
              _category('New', textTheme.headline6),
              Divider(color: theme.accentColor),
              OrbiterNewsWidget(news: news.first),
              const SizedBox(height: 16.0),
              _category('Recent', textTheme.headline6),
              Divider(color: theme.accentColor),
              ...recent
            ],
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
