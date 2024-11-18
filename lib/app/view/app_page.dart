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
            icon: const Icon(Icons.home_rounded),
            label: context.l10n.homePageTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.error_rounded),
            label: context.l10n.activitiesTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.explore_rounded),
            label: context.l10n.exploreTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_rounded),
            label: context.l10n.exploreTitle,
          ),
        ],
      ),
    );
  }
}
