import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/utils/size_config.dart';
import 'package:navis/widgets/widgets.dart';

import 'news_widget.dart';

class NewsBuilder extends StatelessWidget {
  const NewsBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = SizeConfig.heightMultiplier * 30;

    return Container(
        height: height,
        child: Material(
          color: Theme.of(context).cardColor,
          elevation: 6,
          child: PageStorage(
            key: newsKey,
            bucket: newsBucket,
            child: BlocBuilder<WorldstateBloc, WorldStates>(
                builder: (BuildContext context, WorldStates state) {
              final news = state.worldstate?.news ?? [];

              return Carousel(
                dotCount: news.length,
                children: news.map((n) => NewsWidget(news: n)).toList(),
              );
            }),
          ),
        ));
  }
}
