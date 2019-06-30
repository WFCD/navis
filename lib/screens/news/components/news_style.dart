import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/models/export.dart';
import 'package:navis/utils/link_handler.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({this.news});

  final OrbiterNews news;

  String _timestamp(DateTime timestamp) {
    final Duration duration =
        timestamp.difference(DateTime.now().toUtc()).abs();

    const Duration hour = Duration(hours: 1);
    const Duration day = Duration(hours: 24);

    if (duration < hour) {
      return '${duration.inMinutes.floor()}m';
    } else if (duration >= hour && duration < day) {
      return '${duration.inHours.floor()}h ${(duration.inMinutes % 60).floor()}m';
    } else
      return '${duration.inDays.floor()}d';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 2.0),
        child: InkWell(
          onTap: () => launchLink(context, news.link, isStream: news.stream),
          child: Container(
              height: 200,
              child: Stack(children: <Widget>[
                CachedNetworkImage(
                  imageUrl: news.imageLink,
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/general/404.webp'),
                  imageBuilder: (context, provider) {
                    return Container(
                      constraints: BoxConstraints.expand(
                          height: 200.0,
                          width: MediaQuery.of(context).size.width),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                              image: provider, fit: BoxFit.cover)),
                    );
                  },
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(34, 34, 34, .4)),
                        child: Text(
                          '[${_timestamp(news.date)} ago] ${news.translations['en']}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: Colors.white, fontSize: 15),
                        ))),
              ])),
        ));
  }
}
