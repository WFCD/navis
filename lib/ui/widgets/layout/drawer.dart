import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/ui/routes/maps/map.dart';
import 'package:navis/ui/widgets/icons.dart';

import '../styles/platform_choices.dart';

class DrawerItem {
  const DrawerItem(
      {this.icon, this.title, this.routeType, this.children, this.callback});

  final Icon icon;
  final String title;
  final RouteEvent routeType;
  final List<DrawerItem> children;
  final VoidCallback callback;
}

class _BuildDrawerItem extends StatelessWidget {
  const _BuildDrawerItem({Key key, this.item}) : super(key: key);

  final DrawerItem item;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<NavigationBloc>(context),
        builder: (BuildContext context, RouteState route) {
          if (item.children == null || item.children.isEmpty)
            return ListTile(
              leading: item.icon,
              title: Text(item.title),
              onTap: item.callback,
              selected: item.routeType == route.route,
            );

          return ExpansionTile(
            leading: item.icon,
            title: Text(item.title),
            children:
                item.children.map((i) => _BuildDrawerItem(item: i)).toList(),
          );
        });
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({@required this.bloc});

  final NavigationBloc bloc;

  void _changeRoute(BuildContext context, RouteEvent event) {
    bloc.dispatch(event);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final List<DrawerItem> _drawerItem = [
      DrawerItem(
          icon: const Icon(Icons.update),
          title: 'News',
          routeType: RouteEvent.news,
          callback: () => _changeRoute(context, RouteEvent.news)),
      DrawerItem(
          icon: const Icon(Icons.timer),
          title: 'Timers',
          routeType: RouteEvent.timers,
          callback: () => _changeRoute(context, RouteEvent.timers)),
      DrawerItem(
          icon: const Icon(Icons.map),
          title: 'Maps',
          children: <DrawerItem>[
            DrawerItem(
                title: 'Plains',
                callback: () => _navigateToMap(context, 'Ostrons')),
            DrawerItem(
                title: 'Vallis',
                callback: () => _navigateToMap(context, 'Solaris United')),
            DrawerItem(
                title: 'Fishing Data',
                callback: () =>
                    _launchUrl(context, 'https://hub.warframestat.us/fish')),
            DrawerItem(
                title: 'How to Fish',
                callback: () => _launchUrl(
                    context, 'https://hub.warframestat.us/howtofish'))
          ]),
      DrawerItem(
          icon: const Icon(Standing.standing),
          title: 'Syndicate',
          routeType: RouteEvent.syndicates,
          callback: () => _changeRoute(context, RouteEvent.syndicates)),
      /*DrawerItem(
          icon: const Icon(PriceTag.tag),
          title: 'Riven Market',
          callback: () => _setBody(4))*/
    ];

    final List<Widget> _items = []
      ..insert(0, Container(height: 76, color: Theme.of(context).accentColor))
      ..add(Expanded(
          child: ListView(
              padding: EdgeInsets.zero,
              children:
                  _drawerItem.map((i) => _BuildDrawerItem(item: i)).toList())))
      ..add(const PlatformChoice())
      ..add(ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('Settings'),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed('/Settings');
        },
      ));
    //..add(aboutTile());

    return Drawer(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, children: _items));
  }
}

void _navigateToMap(BuildContext context, String syndicate) {
  Location _locaton(String syndicateName) {
    switch (syndicateName) {
      case 'Ostrons':
        return Location.plains;
      default:
        return Location.vallis;
    }
  }

  Navigator.of(context).pop();
  Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Maps(location: _locaton(syndicate))));
}

Future<void> _launchUrl(BuildContext context, String url) async {
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
        duration: Duration(seconds: 30), content: Text('No Browser detected')));
  }
}
