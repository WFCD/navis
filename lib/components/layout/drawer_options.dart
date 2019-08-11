import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/icons.dart';
import 'package:navis/utils/utils.dart';

class DrawerOptions extends StatelessWidget {
  DrawerOptions({Key key}) : super(key: key);

  final ScrollController _controller = ScrollController();

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

    return BlocBuilder(
      bloc: navigation,
      builder: (BuildContext context, RouteState state) {
        return Container(
          child: ListView(
            controller: _controller,
            children: <Widget>[
              ListTile(
                  leading: Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () => _onTap(context, RouteEvent.home),
                  selected: state == RouteState.home),
              ListTile(
                leading: const Icon(VoidFissureIcon.void_icon),
                title: const Text('Fissures'),
                onTap: () => _onTap(context, RouteEvent.fissures),
                selected: state == RouteState.fissures,
              ),
              ListTile(
                leading: Icon(Icons.security),
                title: const Text('Invasions'),
                onTap: () => _onTap(context, RouteEvent.invasions),
                selected: state == RouteState.invasions,
              ),
              ListTile(
                leading: const Icon(Sortie.sortie),
                title: const Text('Sorties'),
                onTap: () => _onTap(context, RouteEvent.sortie),
                selected: state == RouteState.sortie,
              ),
              ListTile(
                leading: const Icon(Standing.standing),
                title: const Text('Syndicates'),
                onTap: () => _onTap(context, RouteEvent.syndicates),
                selected: state == RouteState.syndicates,
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Drop Rates'),
                onTap: () => _onTap(context, RouteEvent.droptable),
                selected: state == RouteState.droptable,
              ),
              ExpansionTile(
                leading: Icon(Icons.help),
                title: const Text('Helpful Links'),
                onExpansionChanged: (b) async {
                  if (b) {
                    // wait for tile to finish expanding before animating to the bottom
                    await Future.delayed(const Duration(milliseconds: 100));

                    await _controller.animateTo(250.0,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut);
                  }
                },
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
