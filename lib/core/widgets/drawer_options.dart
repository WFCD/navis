import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/l10n.dart';
import '../bloc/navigation_bloc.dart';
import '../themes/colors.dart';
import '../utils/helper_methods.dart';
import 'widgets.dart';

// import 'navis_sys_icons.dart';

class DrawerOptions extends StatelessWidget {
  DrawerOptions({Key? key}) : super(key: key);

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
    final l10n = context.l10n;

    return ListTileTheme(
      selectedColor: secondary,
      child: BlocBuilder<NavigationBloc, Widget>(
        builder: (BuildContext context, Widget state) {
          return ListView(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.home),
                title: Text(l10n.homePageTitle),
                onTap: () => _onTap(context, NavigationEvent.timers),
                selected: state ==
                    NavigationBloc.navigationMap[NavigationEvent.timers],
              ),
              ListTile(
                leading: const Icon(Icons.web),
                title: Text(l10n.warframeNewsTitle),
                onTap: () => _onTap(context, NavigationEvent.warframeNews),
                selected: state ==
                    NavigationBloc.navigationMap[NavigationEvent.warframeNews],
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: Text(l10n.codexTitle),
                onTap: () => _onTap(context, NavigationEvent.codex),
                selected: state ==
                    NavigationBloc.navigationMap[NavigationEvent.codex],
              ),
              ListTile(
                leading: const FaIcon(SyndicateGlyphs.simaris),
                title: const Text('SynthTargets'),
                onTap: () => _onTap(context, NavigationEvent.synthTargets),
                selected: state ==
                    NavigationBloc.navigationMap[NavigationEvent.synthTargets],
              ),
              ExpansionTile(
                key: const Key('links'),
                leading: const Icon(Icons.help),
                title: Text(l10n.helpfulLinksTitle),
                onExpansionChanged: (b) {
                  if (b) {
                    context.scrollToSelectedContent();
                  }
                },
                children: <Widget>[
                  ListTile(
                    title: Text(l10n.plainsofEidolonMapTitle),
                    dense: isDense,
                    onTap: () => _poe.launchLink(context, pop: true),
                  ),
                  ListTile(
                    title: Text(l10n.orbVallisMapTitle),
                    dense: isDense,
                    onTap: () => _vallis.launchLink(context, pop: true),
                  ),
                  ListTile(
                    title: Text(l10n.plainsofEidolonFishingDataTitle),
                    dense: isDense,
                    onTap: () => _poeFishingData.launchLink(context, pop: true),
                  ),
                  ListTile(
                    title: Text(l10n.orbVallisFishingDataTitle),
                    dense: isDense,
                    onTap: () =>
                        _vallisFishingData.launchLink(context, pop: true),
                  ),
                  ListTile(
                    title: Text(l10n.howToFishTitle),
                    dense: isDense,
                    onTap: () => _howToFish.launchLink(context, pop: true),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
