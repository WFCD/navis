import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/themes/themes.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/helper_methods.dart';

class OrbiterNewsWidget extends StatelessWidget {
  const OrbiterNewsWidget({Key? key, required this.news}) : super(key: key);

  final OrbiterNews news;

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context).languageCode;

    return Theme(
      data: NavisTheming.dark,
      child: InkWell(
        onTap: () => news.link.launchLink(context),
        child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(news.proxyImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: const <double>[
                        0.3,
                        1
                      ],
                      colors: <Color>[
                        Colors.black.withOpacity(0.7),
                        Colors.transparent
                      ]),
                ),
                child: ListTile(
                  title: Text(
                    news.translations[currentLocale] ?? news.message,
                    overflow: TextOverflow.ellipsis,
                    // style: textTheme.bodyText1?.copyWith(fontSize: 16.0),
                  ),
                  subtitle: Text(
                    news.date.toLocal().format(context),
                    // style: textTheme.caption,
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

class NewsInformation extends StatelessWidget {
  const NewsInformation({
    Key? key,
    required this.timestamp,
    required this.message,
  }) : super(key: key);

  final String timestamp, message;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.shortestSide,
      alignment: Alignment.center,
      color: Colors.black.withOpacity(.4),
      child: Text(
        '[$timestamp ago] $message',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
