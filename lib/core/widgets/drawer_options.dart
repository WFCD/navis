import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/core/bloc/navigation_bloc.dart';
import 'package:navis/core/utils/helper_methods.dart';

import 'app_icons.dart';

class DrawerOptions extends StatelessWidget {
  DrawerOptions({Key key}) : super(key: key);

  final ScrollController _controller = ScrollController();

  void _onTap(BuildContext context, NavigationEvent newRoute) {
    BlocProvider.of<NavigationBloc>(context).add(newRoute);
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

    return BlocBuilder<NavigationBloc, Widget>(
      builder: (BuildContext context, Widget state) {
        return Container(
          child: ListView(
            controller: _controller,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Home'),
                onTap: () => _onTap(context, NavigationEvent.feed),
                selected:
                    state == NavigationBloc.navigationMap[NavigationEvent.feed],
              ),
              ListTile(
                leading: const Icon(AppIcons.voidfissure),
                title: const Text('Fissures'),
                onTap: () => _onTap(context, NavigationEvent.fissures),
                selected: state ==
                    NavigationBloc.navigationMap[NavigationEvent.fissures],
              ),
              // ListTile(
              //   leading: Icon(Icons.security),
              //   title: const Text('Invasions'),
              //   onTap: () => _onTap(context, NavigationEvent.invasions),
              //   selected: state == RouteState.invasions,
              // ),
              // ListTile(
              //   leading: Icon(AppIcons.sortie),
              //   title: const Text('Sorties'),
              //   onTap: () => _onTap(context, NavigationEvent.sorties),
              //   selected: state == RouteState.sortie,
              // ),
              // ListTile(
              //   leading: const Icon(AppIcons.standing),
              //   title: const Text('Syndicates'),
              //   onTap: () => _onTap(context, NavigationEvent.syndicates),
              //   selected: state == RouteState.syndicates,
              // ),
              // ListTile(
              //   leading: const Icon(Icons.search),
              //   title: const Text('Codex'),
              //   onTap: () => _onTap(context, NavigationEvent.codex),
              //   selected: state == RouteState.droptable,
              // ),
              ExpansionTile(
                leading: Icon(Icons.help),
                title: const Text('Helpful Links'),
                onExpansionChanged: (b) async {
                  if (b) {
                    // wait for tile to finish expanding before animating to the bottom
                    await Future<void>.delayed(
                        const Duration(milliseconds: 200));

                    await _controller.animateTo(250.0,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut);
                  }
                },
                children: <Widget>[
                  ListTile(
                      title: const Text('Plains of Eidolon map'),
                      dense: true,
                      onTap: () => launchLink(_poe)),
                  ListTile(
                      title: const Text('Orb Vallis map'),
                      dense: isDense,
                      onTap: () => launchLink(_vallis)),
                  ListTile(
                      title: const Text('PoE: Fishing Data'),
                      dense: isDense,
                      onTap: () => launchLink(_poeFishingData)),
                  ListTile(
                      title: const Text('Vallis: Fishing Data'),
                      dense: isDense,
                      onTap: () => launchLink(_vallisFishingData)),
                  ListTile(
                      title: const Text('How to Fish'),
                      dense: isDense,
                      onTap: () => launchLink(_howToFish))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
