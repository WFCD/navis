import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/home/cubit/navigation_cubit.dart';
import 'package:navis/l10n/l10n.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  void _onTap(BuildContext context, NavigationEvent newRoute) {
    BlocProvider.of<NavigationCubit>(context).changePage(newRoute);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (i) {
        _onTap(context, NavigationEvent.values[i]);
      },
      selectedIndex: NavigationCubit.navigationMap.values
          .toList()
          .indexOf(context.watch<NavigationCubit>().state),
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
          icon: const Icon(Icons.search_rounded),
          label: context.l10n.codexTitle,
        ),
        NavigationDestination(
          icon: const Icon(Icons.explore_rounded),
          label: context.l10n.synthTargetTitle,
        )
      ],
    );
  }
}
