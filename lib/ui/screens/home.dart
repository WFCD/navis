import 'package:flutter/material.dart';
//import 'package:navis/ui/widgets/s_prototype.dart';
import 'package:navis/ui/widgets/scaffold.dart';
import 'package:navis/ui/widgets/icons.dart';
import 'package:navis/global_keys.dart';

import 'feed/feed.dart';
import 'fissures/fissures.dart';
import 'news/news.dart';
import 'syndicates/syndicates.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  final double size = 20;

  final List<Widget> _pages = [
    const Orbiter(),
    Feed(key: feed),
    const Fissure(),
    SyndicatesList()
  ];

  final List<BottomNavigationBarItem> _items = const [
    BottomNavigationBarItem(icon: Icon(Icons.update), title: Text('News')),
    BottomNavigationBarItem(
        icon: Icon(Icons.view_headline), title: Text('Feed')),
    BottomNavigationBarItem(
        icon: Icon(VoidTear.voidtearicon), title: Text('Fissures')),
    BottomNavigationBarItem(
        icon: Icon(Standing.standing), title: Text('Syndicates'))
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      pageChilderen: _pages,
      childeren: _items,
    );
  }
}
