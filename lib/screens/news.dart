import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:share/share.dart';

import '../json/news.dart';
import '../model.dart';
import '../util/keys.dart';

class Orbiter extends StatefulWidget {
  Orbiter({Key key}) : super(key: key);

  _Orbiter createState() => _Orbiter();
}

class _Orbiter extends State<Orbiter> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _buildTiles(List<OrbiterNews> data, int index, BuildContext context,
      NavisModel model) {
    bool hotfix = data[index].message.contains('Hotfix');
    CachedNetworkImageProvider image =
        CachedNetworkImageProvider(data[index].imageLink);

    return Padding(
        padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
        child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: InkWell(
              onLongPress: () => Share.share(data[index].link),
              onTap: () => _launchLink(data[index].link, context),
              child: Container(
                constraints: BoxConstraints.expand(height: 200.0),
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.8), BlendMode.dstATop),
                        image: hotfix ? AssetImage('assets/hotfix.jpg') : image,
                        fit: BoxFit.cover)),
                child: Text(
                  data[index].message,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NavisModel>(
      builder: (context, child, model) {
        return RefreshIndicator(
          onRefresh: () => model.update(),
          child: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            _buildTiles(model.news, index, context, model),
                        childCount: model.news.length))
              ]),
        );
      },
    );
  }
}

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
              animation: CustomTabsAnimation.slideIn()));
    } catch (err) {
      _noBrowser(context);
    }
  }
}

Future<Null> _noBrowser(BuildContext context) async {
  return showDialog<Null>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Hey you! Yeah you.'),
        content: Text(
            'What kind of person doesn\'t have a broswer installed on thier phone?'),
        actions: <Widget>[
          FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            color: Theme.of(context).accentColor,
            child: Text(
              'Okay',
              style:
                  TextStyle(color: Theme.of(context).textTheme.display1.color),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
