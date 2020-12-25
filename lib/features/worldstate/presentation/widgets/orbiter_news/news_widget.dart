import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/helper_methods.dart';
import '../../../../../core/widgets/custom_card.dart';
import '../../../../../core/widgets/static_box.dart';
import '../common/background_image.dart';

class OrbiterNewsWidget extends StatelessWidget {
  const OrbiterNewsWidget({Key key, @required this.news})
      : assert(news != null),
        super(key: key);

  final OrbiterNews news;

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context).languageCode;
    final isOneDayOld =
        news.date.toLocal().difference(DateTime.now()).abs() < 2.days;

    return InkWell(
      onTap: () => launchLink(context, news.link),
      child: CustomCard(
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        child: BackgroundImage(
          imageUrl: news.proxyImage,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (isOneDayOld)
                        StaticBox.text(
                          text: 'New',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: Text(
                          news?.translations[currentLocale] ?? news.message,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    news.date.toLocal().format(context),
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
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
