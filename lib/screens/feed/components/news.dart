import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/utils/utils.dart';
import 'package:worldstate_model/models/news.dart';

class NewsStyle extends StatelessWidget {
  const NewsStyle({@required this.news});

  final OrbiterNews news;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchLink(context, news.link, isStream: news.stream),
      child: Container(
          child: Stack(children: <Widget>[
        CachedNetworkImage(
          imageUrl: news.imageLink,
          placeholder: (BuildContext context, String url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (BuildContext context, String url, Object error) {
            return Center(
              child: Column(
                children: <Widget>[Icon(Icons.error), Text(error.toString())],
              ),
            );
          },
          imageBuilder: (context, provider) {
            return Container(
              constraints: BoxConstraints.expand(height: 250.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                    image: provider,
                    fit: BoxFit.cover,
                  )),
            );
          },
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration:
                    const BoxDecoration(color: Color.fromRGBO(34, 34, 34, .4)),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 6.0),
                    Text(
                      '[${timestamp(news.date)} ago] ${news.translations['en']}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ))),
      ])),
    );
  }
}
