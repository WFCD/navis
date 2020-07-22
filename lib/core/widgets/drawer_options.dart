import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/core/bloc/navigation_bloc.dart';
import 'package:navis/core/utils/helper_methods.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/generated/l10n.dart';

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
    const bool isDense = true;
    final navisLocalizations = NavisLocalizations.of(context);

    return BlocBuilder<NavigationBloc, Widget>(
      builder: (BuildContext context, Widget state) {
        return Container(
          child: ListView(
            controller: _controller,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.home),
                title: Text(navisLocalizations.homePageTitle),
                onTap: () => _onTap(context, NavigationEvent.timers),
                selected: state ==
                    NavigationBloc.navigationMap[NavigationEvent.timers],
              ),
              ListTile(
                leading: Icon(Icons.web),
                title: const Text('Warframe News'),
                onTap: () => _onTap(context, NavigationEvent.warframe_news),
                selected: state ==
                    NavigationBloc.navigationMap[NavigationEvent.warframe_news],
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Codex'),
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
                leading: const Icon(Icons.help),
                title: Text(navisLocalizations.helpfulLinksTitle),
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
          ),
        );
      },
    );
  }
}
