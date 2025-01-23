import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/app/widgets/widgets.dart';
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
        child: TraceableWidget(
          actionName: children[currentIndex].toStringShort(),
          child: children[currentIndex],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (i) {
          navigationShell.goBranch(i, initialLocation: i == currentIndex);
        },
        selectedIndex: currentIndex,
        destinations: [
          NavigationDestination(
            icon: NavigationIcon(
              activeIcon: const Icon(Icons.home),
              inactiveIcon: const Icon(Icons.home_outlined),
              isActive: currentIndex == 0,
            ),
            label: context.l10n.homePageTitle,
          ),
          NavigationDestination(
            icon: NavigationIcon(
              activeIcon: const Icon(Icons.error),
              inactiveIcon: const Icon(Icons.error_outline),
              isActive: currentIndex == 1,
            ),
            label: context.l10n.activitiesTitle,
          ),
          NavigationDestination(
            icon: NavigationIcon(
              activeIcon: const Icon(Icons.explore),
              inactiveIcon: const Icon(Icons.explore_outlined),
              isActive: currentIndex == 2,
            ),
            label: context.l10n.exploreTitle,
          ),
          NavigationDestination(
            icon: NavigationIcon(
              activeIcon: const Icon(Icons.settings),
              inactiveIcon: const Icon(Icons.settings_outlined),
              isActive: currentIndex == 3,
            ),
            label: context.l10n.settingsTitle,
          ),
        ],
      ),
    );
  }
}
