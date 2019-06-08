import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/utils/link_handler.dart';

import '../icons.dart';

class LotusDrawer extends StatelessWidget {
  const LotusDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          const Expanded(child: DrawerOptions()),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/Settings');
            },
          )
        ])));
  }
}

class DrawerOptions extends StatelessWidget {
  const DrawerOptions({Key key}) : super(key: key);

  void _onTap(BuildContext context, RouteEvent newRoute) {
    BlocProvider.of<NavigationBloc>(context).dispatch(newRoute);
    Navigator.of(context).pop();
  }

  static const _poe = 'https://hub.warframestat.us/#/poe/map';
  static const _vallis = 'https://hub.warframestat.us/#/vallis/map';
  static const _poeFishingData = 'https://hub.warframestat.us/#/poe/fish';
  static const _vallisFishingData = 'https://hub.warframestat.us/#/vallis/fish';
  static const _howToFish = 'https://hub.warframestat.us/#/poe/fish/howto';

  @override
  Widget build(BuildContext context) {
    const bool isDense = true;
    final navigation = BlocProvider.of<NavigationBloc>(context);

    return BlocBuilder<RouteEvent, RouteState>(
      bloc: navigation,
      builder: (BuildContext context, RouteState state) {
        return Container(
          child: ListView(
            children: <Widget>[
              ListTile(
                  leading: Icon(Icons.new_releases),
                  title: const Text('News'),
                  onTap: () => _onTap(context, RouteEvent.news),
                  selected: state.route == RouteEvent.news),
              ListTile(
                  leading: Icon(Icons.timer),
                  title: const Text('Timers'),
                  onTap: () => _onTap(context, RouteEvent.timers),
                  selected: state.route == RouteEvent.timers),
              ListTile(
                leading: Icon(VoidFissureIcon.void_icon),
                title: const Text('Fissures'),
                onTap: () => _onTap(context, RouteEvent.fissures),
                selected: state.route == RouteEvent.fissures,
              ),
              ListTile(
                  enabled: false,
                  leading: Icon(Icons.security),
                  title: const Text('Invasions')),
              ListTile(
                enabled: false,
                leading: Icon(Sortie.sortie),
                title: const Text('Sorties'),
              ),
              ListTile(
                leading: const Icon(Standing.standing),
                title: const Text('Syndicates'),
                onTap: () => _onTap(context, RouteEvent.syndicates),
                selected: state.route == RouteEvent.syndicates,
              ),
              ListTile(
                  enabled: false,
                  leading: Icon(Icons.search),
                  title: const Text('Drop Rates')),
              ExpansionTile(
                title: Text('Helpful Links',
                    style: DefaultTextStyle.of(context)
                        .style
                        .copyWith(color: Colors.white)),
                children: <Widget>[
                  ListTile(
                      title: const Text('Plains of Eidolon map'),
                      dense: true,
                      onTap: () => launchLink(context, _poe)),
                  ListTile(
                      title: const Text('Orb Vallis map'),
                      dense: isDense,
                      onTap: () => launchLink(context, _vallis)),
                  ListTile(
                      title: const Text('PoE: Fishing Data'),
                      dense: isDense,
                      onTap: () => launchLink(context, _poeFishingData)),
                  ListTile(
                      title: const Text('Vallis: Fishing Data'),
                      dense: isDense,
                      onTap: () => launchLink(context, _vallisFishingData)),
                  ListTile(
                      title: const Text('How to Fish'),
                      dense: isDense,
                      onTap: () => launchLink(context, _howToFish))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
