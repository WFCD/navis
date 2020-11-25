import 'package:flutter/material.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../bloc/solsystem_bloc.dart';
import '../widgets/common/refresh_indicator_bloc_screen.dart';
import '../widgets/orbiter_news/news_widget.dart';

class OrbiterNewsPage extends StatelessWidget {
  const OrbiterNewsPage({Key key}) : super(key: key);

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
              CategoryTitle(
                title: context.locale.recentNewsCategoryTitle,
                style: textTheme.headline6,
              ),
              Divider(color: theme.accentColor),
              OrbiterNewsWidget(news: news.first, height: height),
              const SizedBox(height: 16.0),
              CategoryTitle(
                title: context.locale.pastNewsCategoryTitle,
                style: textTheme.headline6,
              ),
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
