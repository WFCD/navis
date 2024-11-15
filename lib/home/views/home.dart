import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.navigationShell,
    required this.children,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return HomeView(navigationShell: navigationShell, children: children);
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    required this.navigationShell,
    required this.children,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;

    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      appBar: AppBar(
        toolbarHeight: kTextTabBarHeight,
        actions: [
          // IconButton(
          //   onPressed: () => discordInvite.launchLink(context),
          //   icon: const AppIcon(SimpleIcons.discord),
          // ),
          IconButton(
            onPressed: () => const SettingsPageRoute().push<void>(context),
            icon: const Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: children[currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (i) {
          navigationShell.goBranch(i, initialLocation: i == currentIndex);
        },
        selectedIndex: currentIndex,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_rounded),
            label: context.l10n.homePageTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.web_rounded),
            label: context.l10n.warframeNewsTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.explore),
            label: context.l10n.exploreTitle,
          ),
        ],
      ),
    );
  }
}
