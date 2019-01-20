import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:navis/globalkeys.dart';
import 'package:navis/models/export.dart';
import 'package:navis/utils/keys.dart';

class NewsCard extends StatelessWidget {
  final OrbiterNews news;

  NewsCard({this.news});

  void _launchLink(String link, BuildContext context) async {
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
            content: Text('No Browser detected')));
      }
    }
  }

  String _timestamp(String timestamp) {
    final duration =
        DateTime.parse(timestamp).difference(DateTime.now().toLocal()).abs();

    final hour = Duration(hours: 1);
    final day = Duration(hours: 24);

    if (duration < hour) {
      return '${duration.inMinutes.abs()}m';
    } else if (duration >= hour && duration < day) {
      return '${duration.inHours.abs()}h ${(duration.inMinutes % 60).abs()}m';
    } else
      return '${duration.inDays.abs()}d';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      onTap: () => _launchLink(news.link, context),
      child: Container(
        constraints: BoxConstraints.expand(height: 200.0),
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            image: DecorationImage(
                image: CachedNetworkImageProvider(news.imageLink),
                fit: BoxFit.cover)),
        child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Color.fromRGBO(34, 34, 34, .5)),
            child: Text(
              '[${_timestamp(news.date)} ago] ${news.message}',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
      ),
    ));
  }
}
