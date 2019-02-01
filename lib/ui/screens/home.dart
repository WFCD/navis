import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:navis/ui/widgets/scaffold.dart';
import 'package:navis/ui/widgets/icons.dart';

import 'feed/feed.dart';
import 'fissures/fissures.dart';
import 'news/news.dart';
import 'syndicates/syndicates.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  double size = 20;
  final TextStyle _titleStyle = const TextStyle(color: Colors.white);

  List<Widget> pages = [
    const Orbiter(),
    const Feed(),
    const Fissure(),
    SyndicatesList()
  ];

  List<BottomNavyBarItem> _items;

  @override
  void initState() {
    super.initState();

    _items = [
      BottomNavyBarItem(
          icon: const Icon(Icons.update, color: Colors.white),
          title: Text('News', style: _titleStyle)),
      BottomNavyBarItem(
          icon: const Icon(Icons.view_headline, color: Colors.white),
          title: Text('Feed', style: _titleStyle)),
      BottomNavyBarItem(
          icon: const Icon(VoidTear.voidtearicon, color: Colors.white),
          title: Text('Fissures', style: _titleStyle)),
      BottomNavyBarItem(
          icon: const Icon(Standing.standing, color: Colors.white),
          title: Text('Syndicates', style: _titleStyle))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageChilderen: pages,
      childeren: _items,
    );
  }
}
