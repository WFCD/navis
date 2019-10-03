import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/utils/utils.dart';
import 'package:worldstate_model/worldstate_models.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({@required this.news});

  final OrbiterNews news;

  Widget _imageBuilder(BuildContext context, ImageProvider imageProvider) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        )
      ],
    );
  }

  Widget _placeholder(BuildContext context, String url) =>
      const Center(child: CircularProgressIndicator());

  Widget _errorWidget(BuildContext context, String url, Object error) {
    return Center(
      child: Column(
        children: <Widget>[
          Icon(Icons.error),
          const Text('Unable to load image')
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchLink(context, news.link, isStream: news.stream),
      child: Container(
          child: Stack(children: <Widget>[
        CachedNetworkImage(
          imageUrl: news.imageLink,
          fit: BoxFit.cover,
          imageBuilder: _imageBuilder,
          placeholder: _placeholder,
          errorWidget: _errorWidget,
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
