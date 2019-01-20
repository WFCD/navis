import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:navis/ui/widgets/scaffold.dart';

import 'feed/feed.dart';
import 'fissures/fissures.dart';
import 'news/news.dart';
import 'syndicates/syndicates.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  double size = 20;
  TextStyle _titleStyle = TextStyle(fontSize: 12);
  List<Widget> pages = [Orbiter(), Feed(), Fissure(), SyndicatesList()];
  List<BottomNavigationBarItem> _items;

  @override
  initState() {
    super.initState();

    _items = [
      BottomNavigationBarItem(
          icon: Icon(Icons.update, color: Colors.white),
          title: Text('News', style: _titleStyle)),
      BottomNavigationBarItem(
          icon: Icon(Icons.view_headline, color: Colors.white),
          title: Text('Feed', style: _titleStyle)),
      BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/general/VoidTearIcon.svg',
              height: size, width: size, color: Colors.white),
          title: Text('Fissures', style: _titleStyle)),
      BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/general/standing.svg',
              height: size, width: size, color: Colors.white),
          title: Text('Syndicates', style: _titleStyle))
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageChilderen: pages,
      childeren: _items,
    );
  }
}
