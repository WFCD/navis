import 'package:flutter/material.dart';
import 'package:flutter_villains/villain.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/ui/widgets/layout.dart';
import 'package:navis/blocs/bloc.dart';

class HomeScreen extends StatelessWidget {
  final _navBloc = NavigationBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _navBloc,
      child: Scaffold(
        key: scaffold,
        appBar: AppBar(title: const Text('Navis'), elevation: 6),
        drawer: CustomDrawer(bloc: _navBloc),
        body: BlocBuilder(
          bloc: _navBloc,
          builder: (BuildContext context, RouteState route) => Villain(
              villainAnimation: VillainAnimation.fade(), child: route.widget),
        ),
      ),
    );
  }
}
