import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:matomo/matomo.dart';

import '../bloc/solsystem_bloc.dart';
import '../widgets/common/refresh_indicator_bloc_screen.dart';
import '../widgets/orbiter_news/news_widget.dart';

class OrbiterNewsPage extends TraceableStatelessWidget {
  const OrbiterNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicatorBlocScreen(
      builder: (context, state) {
        if (state is SolState) {
          final news = state.worldstate.news;

          return ListView.builder(
            cacheExtent: 200,
            itemCount: news.length,
            itemBuilder: (context, index) =>
                OrbiterNewsWidget(news: news[index]),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
