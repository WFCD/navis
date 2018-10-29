import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';

import '../../resources/assets.dart';
import '../widgets/navgationIconView.dart';
import 'feed.dart';
import 'fissures.dart';
import 'map.dart';
import 'news.dart';
import 'settings.dart';
import 'syndicates.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 1;
  Color _color = Color.fromRGBO(34, 34, 34, .9);
  List<NavigationIconView> _items;

  @override
  initState() {
    super.initState();

    _items = [
      NavigationIconView(
          icon: Icons.update,
          title: 'News',
          child: Orbiter(
            key: PageStorageKey<int>(0),
          ),
          vsync: this),
      NavigationIconView(
          icon: Icons.view_headline,
          title: 'Feed',
          child: Feed(key: PageStorageKey<int>(1)),
          vsync: this),
      NavigationIconView(
          icon: ImageAssets.fissure,
          title: 'Fissures',
          child: Fissure(key: PageStorageKey<int>(2)),
          vsync: this),
      NavigationIconView(
          icon: ImageAssets.ostrons,
          title: 'Ostrons',
          child: Ostrons(),
          vsync: this)
    ];

    for (NavigationIconView view in _items)
      view.controller.addListener(_rebuild);

    _items[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _items)
      view.controller.dispose();
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationIconView view in _items)
      transitions.add(view.transition());

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return new Stack(children: transitions);
  }

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);
    final title = RichText(
        text: TextSpan(
            text: 'Navis',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)));

    return Scaffold(
        appBar: AppBar(elevation: 8.0, title: title, actions: <Widget>[
          IconButton(
              icon: Icon(Icons.map),
              onPressed: () =>
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => Maps()))),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () =>
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => Settings())))
        ]),
        body: StreamBuilder(
            stream: state.worldstate,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());

              return _buildTransitionsStack();
            }),
        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(canvasColor: _color),
            child: BottomNavigationBar(
                iconSize: 25.0,
                items:
                _items.map((NavigationIconView view) => view.item).toList(),
                currentIndex: _currentIndex,
                onTap: (int index) {
                  setState(() {
                    _items[_currentIndex].controller.reverse();
                    _currentIndex = index;
                    _items[_currentIndex].controller.forward();
                  });
                })));
  }
}
