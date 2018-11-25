import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import '../../resources/keys.dart';

class Orbiter extends StatefulWidget {
  Orbiter({Key key}) : super(key: key);

  _Orbiter createState() => _Orbiter();
}

class _Orbiter extends State<Orbiter> {
  @override
  Widget build(BuildContext context) {
    final news = BlocProvider.of<WorldstateBloc>(context);

    return RefreshIndicator(
      onRefresh: () => news.update(),
      child: StreamBuilder<WorldState>(
          initialData: news.lastState,
          stream: news.worldstate,
          builder: (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());

            return OrientationBuilder(
                builder: (BuildContext context, Orientation orientation) {
              if (orientation == Orientation.landscape)
                return GridView.builder(
                    itemCount: snapshot.data.news.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) =>
                        _buildTiles(snapshot.data.news[index], context));

              return CustomScrollView(slivers: <Widget>[
                SliverFixedExtentList(
                    itemExtent: 200,
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) =>
                            _buildTiles(snapshot.data.news[index], context),
                        childCount: snapshot.data.news.length))
              ]);
            });
          }),
    );
  }
}

Widget _buildTiles(OrbiterNews news, BuildContext context) {
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
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          )),
    ),
  ));
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
