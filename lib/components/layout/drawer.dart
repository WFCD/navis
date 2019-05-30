import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/icons/standing.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/screens/maps/map.dart';

import '../styles/platform_choices.dart';

class _BuildDrawerOptions extends StatelessWidget {
  const _BuildDrawerOptions({Key key}) : super(key: key);

  //temp flag
  static bool _isDev = false;

  static const _poe = 'https://hub.warframestat.us/#/poe/map';
  static const _vallis = 'https://hub.warframestat.us/#/vallis/map';
  static const _poeFishingData = 'https://hub.warframestat.us/#/poe/fish';
  static const _vallisFishingData = 'https://hub.warframestat.us/#/vallis/fish';
  static const _howToFish = 'https://hub.warframestat.us/#/poe/fish/howto';

  @override
  Widget build(BuildContext context) {
    void _changeRoute(RouteEvent event) {
      BlocProvider.of<NavigationBloc>(context).dispatch(event);
      Navigator.of(context).pop();
    }

    assert(_isDev = true);
    return BlocBuilder<RouteEvent, RouteState>(
      bloc: BlocProvider.of<NavigationBloc>(context),
      builder: (context, state) {
        return Expanded(
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          ListTile(
            leading: const Icon(Icons.update),
            title: const Text('News'),
            onTap: () => _changeRoute(RouteEvent.news),
            selected: state.route == RouteEvent.news,
          ),
          ListTile(
            leading: const Icon(Icons.timer),
            title: const Text('Timers'),
            onTap: () => _changeRoute(RouteEvent.timers),
            selected: state.route == RouteEvent.timers,
          ),
          ExpansionTile(
            leading: const Icon(Icons.map),
            title: const Text('Maps'),
            children: <Widget>[
              ListTile(
                  title: const Text('Plains of Eidolon map'),
                  onTap: () => _isDev
                      ? _navigateToMap(context, Location.plains)
                      : _launchUrl(context, _poe)),
              ListTile(
                  title: const Text('Orb Vallis map'),
                  onTap: () => _launchUrl(context, _vallis)),
              ListTile(
                  title: const Text('PoE: Fishing Data'),
                  onTap: () => _launchUrl(context, _poeFishingData)),
              ListTile(
                  title: const Text('Vallis: Fishing Data'),
                  onTap: () => _launchUrl(context, _vallisFishingData)),
              ListTile(
                  title: const Text('How to Fish'),
                  onTap: () => _launchUrl(context, _howToFish))
            ],
          ),
          ListTile(
            leading: const Icon(Standing.standing),
            title: const Text('Syndicate'),
            onTap: () => _changeRoute(RouteEvent.syndicates),
            selected: state.route == RouteEvent.syndicates,
          )
        ]));
      },
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
            child: Column(children: <Widget>[
      Container(height: 76, color: Theme.of(context).accentColor),
      const _BuildDrawerOptions(),
      const PlatformChoice(),
      ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('Settings'),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed('/Settings');
        },
      )
    ])));
  }
}

void _navigateToMap(BuildContext context, Location syndicate) {
  Navigator.of(context).pop();
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => Maps(location: syndicate)));
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
