import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../resources/keys.dart';

class Orbiter extends StatefulWidget {
  Orbiter({Key key}) : super(key: key);

  _Orbiter createState() => _Orbiter();
}

class _Orbiter extends State<Orbiter> {
  _buildTiles(OrbiterNews news, BuildContext context, WorldstateBloc bloc) {
    bool hotfix = news.message.contains('Hotfix');
    CachedNetworkImageProvider image =
    CachedNetworkImageProvider(news.imageLink);

    return Padding(
        padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
        child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: InkWell(
              onTap: () => _launchLink(news.link, context),
              child: Container(
                constraints: BoxConstraints.expand(height: 200.0),
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                        image: hotfix ? AssetImage('assets/hotfix.jpg') : image,
                        fit: BoxFit.cover)),
                child: Text(
                  '[${timeago.format(DateTime.parse(news.date))}] ${news
                      .message}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: hotfix ? Colors.red[700] : Colors.white),
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    final news = BlocProvider.of<WorldstateBloc>(context);

    return StreamBuilder(
        initialData: news.lastState,
        stream: news.worldstate,
        builder: (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return RefreshIndicator(
            onRefresh: () => news.update(),
            child: OrientationBuilder(
                builder: (BuildContext context, Orientation orientation) {
                  if (orientation == Orientation.landscape)
                    return GridView.builder(
                        itemCount: snapshot.data.news.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) =>
                            _buildTiles(
                                snapshot.data.news[index], context, news));

                  return ListView.builder(
                      itemCount: snapshot.data.news.length,
                      itemBuilder: (BuildContext context, int index) =>
                          _buildTiles(
                              snapshot.data.news[index], context, news));
                }),
          );
        });
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
              animation: CustomTabsAnimation.slideIn(),
              extraCustomTabs: <String>['org.mozilla.firefox']));
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
