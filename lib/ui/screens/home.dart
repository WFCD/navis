import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_villains/villain.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/ui/routes/maps/map.dart';
import 'package:navis/ui/widgets/drawer.dart';
import 'package:navis/ui/widgets/icons.dart';
import 'package:rxdart/rxdart.dart';

import 'feed/feed.dart';
import 'news/news.dart';
import 'syndicates/syndicates.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _currentTab = 1;
  StreamController<int> _pageIndex;
  List<DrawerItem> _drawerItem;

  final List<Widget> _pages = [
    const Orbiter(),
    Feed(key: feed),
    Container(),
    SyndicatesList(),
    //Container()
  ];

  @override
  void initState() {
    super.initState();
    _pageIndex = BehaviorSubject<int>();

    _drawerItem = [
      DrawerItem(
          icon: const Icon(Icons.update),
          title: 'News',
          callback: () => _setBody(0)),
      DrawerItem(
          icon: const Icon(Icons.timer),
          title: 'Timers',
          callback: () => _setBody(1)),
      DrawerItem(icon: const Icon(Icons.map), title: 'Maps', children: <
          DrawerItem>[
        DrawerItem(title: 'Plains', callback: () => _navigateToMap('Ostrons')),
        DrawerItem(
            title: 'Vallis', callback: () => _navigateToMap('Solaris United')),
        DrawerItem(
            title: 'Fishing Data',
            callback: () => _launchUrl('https://hub.warframestat.us/fish')),
        DrawerItem(
            title: 'How to Fish',
            callback: () => _launchUrl('https://hub.warframestat.us/howtofish'))
      ]),
      DrawerItem(
          icon: const Icon(Standing.standing),
          title: 'Syndicate',
          callback: () => _setBody(3)),
      /*DrawerItem(
          icon: const Icon(PriceTag.tag),
          title: 'Flash Sales',
          callback: () => _setBody(4))*/
    ];

    _pageIndex.stream
        .distinct()
        .listen((index) => VillainController.playAllVillains(context));
  }

  void _setBody(int index) {
    _pageIndex.sink.add(index);
    Navigator.of(context).pop();
  }

  void _navigateToMap(String syndicate) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => Maps(location: _locaton(syndicate))));
  }

  Location _locaton(String syndicateName) {
    switch (syndicateName) {
      case 'Ostrons':
        return Location.plains;
      default:
        return Location.vallis;
    }
  }

  Future<void> _launchUrl(String url) async {
    Navigator.of(context).pop();
    try {
      await launch(url,
          option: CustomTabsOption(
              toolbarColor: Theme.of(context).primaryColor,
              enableDefaultShare: true,
              enableUrlBarHiding: true,
              showPageTitle: true,
              animation: CustomTabsAnimation.slideIn(),
              extraCustomTabs: <String>['org.mozilla.firefox']));
    } catch (err) {
      scaffold.currentState.showSnackBar(const SnackBar(
          duration: Duration(seconds: 30),
          content: Text('No Browser detected')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      initialData: _currentTab,
      stream: _pageIndex.stream,
      builder: (_, snapshot) {
        return Scaffold(
          key: scaffold,
          appBar: AppBar(title: const Text('Navis'), elevation: 6),
          drawer:
              CustomDrawer(currentIndex: snapshot.data, children: _drawerItem),
          body: Villain(
              villainAnimation: VillainAnimation.fade(),
              child: _pages[snapshot.data]),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageIndex?.close();
    super.dispose();
  }
}
