import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/home/cubit/navigation_cubit.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/resources/resources.dart';
import 'package:navis/settings/views/settings.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:simple_icons/simple_icons.dart';

class NDrawer extends StatelessWidget {
  const NDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final mediaQuery = MediaQuery.of(context);

    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 20 * (mediaQuery.size.height / 100),
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: const Image(
                    image: AssetImage(NavisAssets.derelict),
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  bottom: false,
                  left: false,
                  right: false,
                  child: SvgPicture.asset(
                    NavisAssets.wfcdLogoColor,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: DrawerOptions()),
          ListTile(
            leading: const AppIcon(
              SimpleIcons.discord,
              color: Color(0xFF7289DA),
            ),
            title: Text(l10n.discordSupportTitle),
            onTap: () => discordInvite.launchLink(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(l10n.settingsTitle),
            onTap: () {
              final deviceType = getDeviceType(mediaQuery.size);

              if (deviceType != DeviceScreenType.mobile) {
                showDialog<void>(
                  context: context,
                  builder: (_) => const SettingsDialog(),
                );
              } else {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/settings');
              }
            },
          ),
        ],
      ),
    );
  }
}

class DrawerOptions extends StatelessWidget {
  const DrawerOptions({Key? key}) : super(key: key);

  void _onTap(BuildContext context, NavigationEvent newRoute) {
    BlocProvider.of<NavigationCubit>(context).changePage(newRoute);
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
      selectedColor: NavisColors.secondary,
      child: BlocBuilder<NavigationCubit, Widget>(
        builder: (BuildContext context, Widget state) {
          return ListView(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.home),
                title: Text(l10n.homePageTitle),
                onTap: () => _onTap(context, NavigationEvent.timers),
                selected: state ==
                    NavigationCubit.navigationMap[NavigationEvent.timers],
              ),
              ListTile(
                leading: const Icon(Icons.web),
                title: Text(l10n.warframeNewsTitle),
                onTap: () => _onTap(context, NavigationEvent.warframeNews),
                selected: state ==
                    NavigationCubit.navigationMap[NavigationEvent.warframeNews],
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: Text(l10n.codexTitle),
                onTap: () => _onTap(context, NavigationEvent.codex),
                selected: state ==
                    NavigationCubit.navigationMap[NavigationEvent.codex],
              ),
              ListTile(
                leading: const AppIcon(SyndicateIcons.simaris),
                title: const Text('SynthTargets'),
                onTap: () => _onTap(context, NavigationEvent.synthTargets),
                selected: state ==
                    NavigationCubit.navigationMap[NavigationEvent.synthTargets],
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
