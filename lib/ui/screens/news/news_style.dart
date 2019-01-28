import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:navis/globalkeys.dart';
import 'package:navis/models/export.dart';
import 'package:navis/utils/keys.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({this.news});

  final OrbiterNews news;

  Future<void> _launchLink(String link, BuildContext context) async {
    if (link.contains(RegExp('youtube'))) {
      FlutterYoutube.playYoutubeVideoByUrl(
          apiKey: youtubeKey, videoUrl: link, autoPlay: true);
    } else {
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
            duration: Duration(seconds: 30),
            content: const Text('No Browser detected')));
      }
    }
  }

  String _timestamp(DateTime timestamp) {
    final Duration duration =
        timestamp.difference(DateTime.now().toUtc()).abs();

    final Duration hour = Duration(hours: 1);
    final Duration day = Duration(hours: 24);

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
        constraints: const BoxConstraints.expand(height: 200.0),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            image: DecorationImage(
                image: CachedNetworkImageProvider(news.imageLink),
                fit: BoxFit.cover)),
        child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration:
                const BoxDecoration(color: Color.fromRGBO(34, 34, 34, .4)),
            child: Text(
              '[${_timestamp(news.date)} ago] ${news.translations.en}',
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .copyWith(color: Colors.white),
            )),
      ),
    ));
  }
}
