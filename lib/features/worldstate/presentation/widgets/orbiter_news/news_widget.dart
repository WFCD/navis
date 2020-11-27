import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:warframestat_api_models/entities.dart';

import '../../../../../core/utils/helper_methods.dart';
import '../../../../../resources/resources.dart';

class OrbiterNewsWidget extends StatelessWidget {
  const OrbiterNewsWidget({Key key, @required this.news, this.height = 200})
      : assert(news != null),
        super(key: key);

  final OrbiterNews news;
  final double height;

  Widget _imageBuilder(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context).languageCode;
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => launchLink(context, news.link),
      child: Material(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: Container(
          height: height,
          margin: EdgeInsets.symmetric(
              horizontal: (size.width / 100) * 2,
              vertical: (size.height / 100) * .9),
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: news.proxyImage,
                placeholder: (context, url) =>
                    _imageBuilder(const AssetImage(NavisAssets.derelict)),
                imageBuilder: (context, imageProvider) =>
                    _imageBuilder(imageProvider),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: NewsInformation(
                  timestamp: news.timestamp,
                  message: news?.translations[currentLocale] ?? news.message,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewsInformation extends StatelessWidget {
  const NewsInformation({
    Key key,
    @required this.timestamp,
    @required this.message,
  })  : assert(timestamp != null),
        assert(message != null),
        super(key: key);

  final String timestamp, message;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.shortestSide,
      alignment: Alignment.center,
      color: Colors.black.withOpacity(.4),
      child: Text(
        '[$timestamp ago] $message',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
