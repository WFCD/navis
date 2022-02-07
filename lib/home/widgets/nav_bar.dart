import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/home/cubit/navigation_cubit.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

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
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_rounded),
          label: 'Homepage',
        ),
        NavigationDestination(
          icon: Icon(Icons.web_rounded),
          label: 'News',
        ),
        NavigationDestination(
          icon: Icon(Icons.search_rounded),
          label: 'Codex',
        ),
        NavigationDestination(
          icon: Icon(Icons.explore_rounded),
          label: 'Explore',
        )
      ],
    );
  }
}
