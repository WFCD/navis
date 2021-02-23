import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/navigation_bloc.dart';
import '../utils/extensions.dart';
import '../utils/helper_methods.dart';
import 'widgets.dart';

// import 'navis_sys_icons.dart';

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
    const isDense = true;
    final expansionTileKey = GlobalKey(debugLabel: 'links');

    return BlocBuilder<NavigationBloc, Widget>(
      builder: (BuildContext context, Widget state) {
        return ListView(
          controller: _controller,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(context.locale.homePageTitle),
              onTap: () => _onTap(context, NavigationEvent.timers),
              selected:
                  state == NavigationBloc.navigationMap[NavigationEvent.timers],
            ),
            ListTile(
              leading: const Icon(Icons.web),
              title: Text(context.locale.warframeNewsTitle),
              onTap: () => _onTap(context, NavigationEvent.warframeNews),
              selected: state ==
                  NavigationBloc.navigationMap[NavigationEvent.warframeNews],
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: Text(context.locale.codexTitle),
              onTap: () => _onTap(context, NavigationEvent.codex),
              selected:
                  state == NavigationBloc.navigationMap[NavigationEvent.codex],
            ),
            ListTile(
              leading: const FaIcon(SyndicateGlyphs.simaris),
              title: const Text('SynthTargets'),
              onTap: () => _onTap(context, NavigationEvent.synthTargets),
              selected: state ==
                  NavigationBloc.navigationMap[NavigationEvent.synthTargets],
            ),
            ExpansionTile(
              key: expansionTileKey,
              leading: const Icon(Icons.help),
              title: Text(context.locale.helpfulLinksTitle),
              onExpansionChanged: (b) {
                if (b) {
                  scrollToSelectedContent(context);
                }
              },
              children: <Widget>[
                ListTile(
                    title: const Text('Plains of Eidolon map'),
                    dense: isDense,
                    onTap: () => launchLink(context, _poe, pop: true)),
                ListTile(
                    title: const Text('Orb Vallis map'),
                    dense: isDense,
                    onTap: () => launchLink(context, _vallis, pop: true)),
                ListTile(
                    title: const Text('PoE: Fishing Data'),
                    dense: isDense,
                    onTap: () =>
                        launchLink(context, _poeFishingData, pop: true)),
                ListTile(
                    title: const Text('Vallis: Fishing Data'),
                    dense: isDense,
                    onTap: () =>
                        launchLink(context, _vallisFishingData, pop: true)),
                ListTile(
                    title: const Text('How to Fish'),
                    dense: isDense,
                    onTap: () => launchLink(context, _howToFish, pop: true))
              ],
            )
          ],
        );
      },
    );
  }
}
