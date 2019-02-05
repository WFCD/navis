import 'package:flutter/material.dart';

import 'package:navis/blocs/bloc.dart';

import 'news_style.dart';

class Orbiter extends StatefulWidget {
  const Orbiter({Key key = const PageStorageKey<String>('orbiter')})
      : super(key: key);

  @override
  _Orbiter createState() => _Orbiter();
}

class _Orbiter extends State<Orbiter> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WorldstateBloc>(context);

    return RefreshIndicator(
        onRefresh: () => bloc.update(),
        child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is WorldstateUninitialized) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is WorldstateLoaded) {
                final news = state.worldState.news;

                return CustomScrollView(slivers: <Widget>[
                  SliverFixedExtentList(
                      itemExtent: 200,
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) =>
                              NewsCard(news: news[index]),
                          childCount: news.length))
                ]);
              }
            }));
  }
}
