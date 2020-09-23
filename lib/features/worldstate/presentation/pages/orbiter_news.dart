import 'package:flutter/material.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/features/worldstate/presentation/widgets/common/refresh_indicator_bloc_screen.dart';
import 'package:navis/features/worldstate/presentation/widgets/orbiter_news/news_widget.dart';

import '../bloc/solsystem_bloc.dart';

class OrbiterNewsPage extends StatelessWidget {
  const OrbiterNewsPage({Key key}) : super(key: key);

  Widget _category(String text, TextStyle style) {
    return CategoryTitle(title: text, style: style);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final height = (MediaQuery.of(context).size.height / 100) * 20;

    return RefreshIndicatorBlocScreen(
      builder: (context, state) {
        if (state is SolState) {
          final news = state.worldstate?.news ?? [];
          final recent = news.skip(1).map((n) {
            return OrbiterNewsWidget(news: n, height: height);
          });

          return ListView(
            cacheExtent: 500,
            children: <Widget>[
              _category('New', textTheme.headline6),
              Divider(color: theme.accentColor),
              OrbiterNewsWidget(news: news.first, height: height),
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
