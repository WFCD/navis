import 'package:flutter/material.dart';
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
  //static const TextStyle _titleStyle = TextStyle(color: Colors.white);

  List<Widget> pages = [
    const Orbiter(),
    const Feed(),
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
      pageChilderen: pages,
      childeren: _items,
    );
  }
}
