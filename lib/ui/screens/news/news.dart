import 'package:flutter/material.dart';

import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import 'news_style.dart';

class Orbiter extends StatefulWidget {
  Orbiter({Key key = const PageStorageKey<String>('orbiter')})
      : super(key: key);

  _Orbiter createState() => _Orbiter();
}

class _Orbiter extends State<Orbiter> {
  @override
  Widget build(BuildContext context) {
    final news = BlocProvider.of<WorldstateBloc>(context);

    return RefreshIndicator(
        onRefresh: () => news.update(),
        child: StreamBuilder<WorldState>(
            stream: news.worldstate,
            builder:
                (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());

              return CustomScrollView(slivers: <Widget>[
                SliverFixedExtentList(
                    itemExtent: 200,
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) =>
                            NewsCard(news: snapshot.data.news[index]),
                        childCount: snapshot.data.news.length))
              ]);
            }));
  }
}
