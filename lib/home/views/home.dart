import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/home/cubit/navigation_cubit.dart';
import 'package:navis/home/widgets/nav_bar.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:simple_icons/simple_icons.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: const _Home(),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => discordInvite.launchLink(context),
            icon: const AppIcon(SimpleIcons.discord),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/settings'),
            icon: const Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: BlocBuilder<NavigationCubit, Widget>(
        builder: (BuildContext context, Widget state) {
          return AnimatedSwitcher(
            duration: kAnimationShort,
            child: state,
          );
        },
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
