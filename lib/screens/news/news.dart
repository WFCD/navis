import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

import 'components/news_style.dart';

class Orbiter extends StatelessWidget {
  const Orbiter({Key key = const PageStorageKey<String>('orbiter')})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WorldstateBloc>(context);

    return RefreshIndicator(
        onRefresh: bloc.update,
        child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is WorldstateLoaded) {
                return ListView.builder(
                    itemCount: state.worldstate.news.length,
                    itemBuilder: (context, index) =>
                        NewsCard(news: state.worldstate.news[index]));
              }

              return const Center(child: CircularProgressIndicator());
            }));
  }
}
