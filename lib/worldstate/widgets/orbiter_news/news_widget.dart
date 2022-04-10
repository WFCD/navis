import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class OrbiterNewsWidget extends StatelessWidget {
  const OrbiterNewsWidget({Key? key, required this.news}) : super(key: key);

  final OrbiterNews news;

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context).languageCode;

    return InkWell(
      onTap: () => news.link.launchLink(context),
      child: SizedBox(
        height: 200,
        child: Card(
          child: BackgroundImage(
            imageUrl: news.proxyImage,
            child: ListTile(
              title: Text(
                news.translations[currentLocale] ?? news.message,
                overflow: TextOverflow.ellipsis,
                // style: textTheme.bodyText1?.copyWith(fontSize: 16.0),
              ),
              subtitle: Text(
                MaterialLocalizations.of(context)
                    .formatFullDate(news.date.toLocal()),
                // style: textTheme.caption,
              ),
            ),
          ),
        ),
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
