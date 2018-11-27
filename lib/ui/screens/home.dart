import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:navis/blocs/provider.dart';
//import 'package:navis/blocs/worldstate_bloc.dart';

import 'feed.dart';
import 'fissures.dart';
import 'news.dart';
import 'syndicates.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 1;
  double size = 22;
  Color _color = Color.fromRGBO(34, 34, 34, .9);
  TextStyle _titleStyle = TextStyle(fontSize: 12);
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

  Widget _buildStack() {
    return Stack(children: <Widget>[
      Offstage(
          offstage: _currentIndex != 0,
          child: Orbiter(key: PageStorageKey<String>('news'))),
      Offstage(
          offstage: _currentIndex != 1,
          child: Feed(key: PageStorageKey<String>('feed'))),
      Offstage(
          offstage: _currentIndex != 2,
          child: Fissure(key: PageStorageKey<String>('relics'))),
      Offstage(offstage: _currentIndex != 3, child: SyndicatesList())
    ]);
  }

  @override
  Widget build(BuildContext context) {
    //final state = BlocProvider.of<WorldstateBloc>(context);
    final title = RichText(
        text: TextSpan(
            text: 'Navis',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)));

    return Scaffold(
        appBar: AppBar(elevation: 8.0, title: title, actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Navigator.of(context).pushNamed('/Settings'))
        ]),
        body: _buildStack(),
        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(canvasColor: _color),
            child: BottomNavigationBar(
                iconSize: 25.0,
                items: _items,
                currentIndex: _currentIndex,
                onTap: (int index) {
                  setState(() => _currentIndex = index);
                })));
  }
}
