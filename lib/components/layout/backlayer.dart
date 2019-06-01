import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/layout/setting_title.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/screens/settings/components/dateformat.dart';
import 'package:navis/screens/settings/components/theme_choice.dart';

class Backlayer extends StatelessWidget {
  const Backlayer({Key key, this.controller}) : super(key: key);

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        selectedColor: Theme.of(context).accentColor,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(children: <Widget>[
              _Pages(controller: controller),
              const SizedBox(height: 16.0),
              const SettingTitle(title: 'Settings'),
              const ThemeChoice(enableTitle: false),
              const DateformatSetting(enableTitle: false),
              ListTile(
                  title: const Text('More Settings'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.of(context).pushNamed('/Settings');
                  })
            ])));
  }
}

class _Pages extends StatelessWidget {
  const _Pages({this.controller});

  final AnimationController controller;

  //temp flag
  //static bool _isDev = false;

  static const _poe = 'https://hub.warframestat.us/#/poe/map';
  static const _vallis = 'https://hub.warframestat.us/#/vallis/map';
  static const _poeFishingData = 'https://hub.warframestat.us/#/poe/fish';
  static const _vallisFishingData = 'https://hub.warframestat.us/#/vallis/fish';
  static const _howToFish = 'https://hub.warframestat.us/#/poe/fish/howto';

  @override
  Widget build(BuildContext context) {
    const bool isDense = true;
    void _changeRoute(RouteEvent event) {
      BlocProvider.of<NavigationBloc>(context).dispatch(event);
      controller.fling(velocity: 1.0);
    }

    //assert(_isDev = true);
    return BlocBuilder<RouteEvent, RouteState>(
      bloc: BlocProvider.of<NavigationBloc>(context),
      builder: (context, state) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: const Text('News'),
                onTap: () => _changeRoute(RouteEvent.news),
                selected: state.route == RouteEvent.news,
              ),
              ListTile(
                title: const Text('Timers'),
                onTap: () => _changeRoute(RouteEvent.timers),
                selected: state.route == RouteEvent.timers,
              ),
              ListTile(
                title: const Text('Syndicate'),
                onTap: () => _changeRoute(RouteEvent.syndicates),
                selected: state.route == RouteEvent.syndicates,
              ),
              ExpansionTile(
                title: Text('Helpful Links',
                    style: DefaultTextStyle.of(context)
                        .style
                        .copyWith(color: Colors.white)),
                children: <Widget>[
                  ListTile(
                      title: const Text('Plains of Eidolon map'),
                      dense: true,
                      onTap: () => _launchUrl(context, _poe)),
                  ListTile(
                      title: const Text('Orb Vallis map'),
                      dense: isDense,
                      onTap: () => _launchUrl(context, _vallis)),
                  ListTile(
                      title: const Text('PoE: Fishing Data'),
                      dense: isDense,
                      onTap: () => _launchUrl(context, _poeFishingData)),
                  ListTile(
                      title: const Text('Vallis: Fishing Data'),
                      dense: isDense,
                      onTap: () => _launchUrl(context, _vallisFishingData)),
                  ListTile(
                      title: const Text('How to Fish'),
                      dense: isDense,
                      onTap: () => _launchUrl(context, _howToFish))
                ],
              ),
            ]);
      },
    );
  }
}

/*void _navigateToMap(BuildContext context, Location syndicate) {
  Navigator.of(context).pop();
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (_) => Maps(location: syndicate)));
}*/

Future<void> _launchUrl(BuildContext context, String url) async {
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
