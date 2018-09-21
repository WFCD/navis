import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../app_model.dart';
import '../../resources/constants.dart';
import '../animation/route.dart';
import '../widgets/offlineDelegate.dart';
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
  PageController _pageController;
  List<Widget> _children = [Orbiter(), Feed(), Fissure(), Ostrons()];
  int index = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: index);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NavisModel>(
      rebuildOnChange: false,
      builder: (context, child, model) {
        final title = RichText(
            text: TextSpan(
                text: 'Navis',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)));

        final appBar = AppBar(elevation: 8.0, title: title, actions: <Widget>[
          IconButton(
              icon: Icon(Icons.map),
              onPressed: () =>
                  Navigator.of(context).push(FadeRoute(child: Maps()))),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () =>
                  Navigator.of(context).push(FadeRoute(child: Settings())))
        ]);

        final pageView = PageView(
            scrollDirection: Axis.horizontal,
            controller: _pageController,
            onPageChanged: (value) => setState(() => index = value),
            children: _children);

        final bottomNav = Theme(
            data: Theme.of(context)
                .copyWith(canvasColor: Color.fromRGBO(34, 34, 34, .9)),
            child: BottomNavigationBar(
                iconSize: 20.0,
                items: Constants.items,
                currentIndex: index,
                onTap: (value) {
                  //if (model.hasError)
                  //return null;
                  //else
                  _pageController.animateToPage(value,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn);
                }));

        return Scaffold(
            appBar: appBar,
            body: Offline(child: pageView, model: model),
            bottomNavigationBar: bottomNav);
      },
    );
  }
}
