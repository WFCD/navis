import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/utils/size_config.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

import 'news_widget.dart';

class NewsPanel extends StatelessWidget {
  const NewsPanel({Key key, this.news}) : super(key: key);

  final List<OrbiterNews> news;

  @override
  Widget build(BuildContext context) {
    final height = SizeConfig.heightMultiplier * 30;

    return Container(
      height: height,
      child: PageStorage(
        key: newsKey,
        bucket: newsBucket,
        child: Carousel(
          dotCount: news.length,
          children: news.map((n) => NewsWidget(news: n)).toList(),
        ),
      ),
    );
  }
}
