import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navis/l10n/l10n.dart';

class AppView extends StatelessWidget {
  const AppView({
    required this.navigationShell,
    required this.children,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;

    Icon icon(Icon enabled, Icon disabled, int index) {
      return currentIndex == index ? enabled : disabled;
    }

    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
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
        child: SafeArea(child: children[currentIndex]),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (i) {
          navigationShell.goBranch(i, initialLocation: i == currentIndex);
        },
        selectedIndex: currentIndex,
        destinations: [
          NavigationDestination(
            icon: icon(
              const Icon(Icons.home),
              const Icon(Icons.home_outlined),
              0,
            ),
            label: context.l10n.homePageTitle,
          ),
          NavigationDestination(
            icon: icon(
              const Icon(Icons.error),
              const Icon(Icons.error_outline),
              1,
            ),
            label: context.l10n.activitiesTitle,
          ),
          NavigationDestination(
            icon: icon(
              const Icon(Icons.explore),
              const Icon(Icons.explore_outlined),
              2,
            ),
            label: context.l10n.exploreTitle,
          ),
          NavigationDestination(
            icon: icon(
              const Icon(Icons.settings),
              const Icon(Icons.settings_outlined),
              3,
            ),
            label: context.l10n.settingsTitle,
          ),
        ],
      ),
    );
  }
}
