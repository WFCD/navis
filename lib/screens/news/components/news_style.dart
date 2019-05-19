import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/models/export.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({this.news});

  final OrbiterNews news;

  Future<void> _launchLink(String link, BuildContext context) async {
    try {
      await launch(link,
          option: CustomTabsOption(
              toolbarColor: Theme.of(context).primaryColor,
              enableDefaultShare: true,
              enableUrlBarHiding: true,
              showPageTitle: true,
              animation: CustomTabsAnimation.slideIn(),
              extraCustomTabs: <String>['org.mozilla.firefox']));
    } catch (err) {
      scaffold.currentState.showSnackBar(SnackBar(
          duration: const Duration(seconds: 5),
          content: link.isEmpty
              ? const Text('No valid link provided by API')
              : const Text('No Browser detected')));
    }
  }

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
        child: InkWell(
      onTap: () => _launchLink(news.link, context),
      child: Container(
          height: 200,
          child: Stack(children: <Widget>[
            CachedNetworkImage(
              imageUrl: news.imageLink,
              errorWidget: (context, url, error) =>
                  Image.asset('assets/general/404.webp'),
              imageBuilder: (context, provider) {
                return Container(
                  constraints: const BoxConstraints.expand(height: 200.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image:
                          DecorationImage(image: provider, fit: BoxFit.cover)),
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
                      '[${_timestamp(news.date)} ago] ${news.translations.en}',
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
