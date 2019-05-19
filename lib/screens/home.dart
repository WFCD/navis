import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/global_keys.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      appBar: AppBar(title: const Text('Navis'), elevation: 6),
      drawer: CustomDrawer(bloc: BlocProvider.of<NavigationBloc>(context)),
      body: BlocBuilder<RouteEvent, RouteState>(
        bloc: BlocProvider.of<NavigationBloc>(context),
        builder: (BuildContext context, RouteState route) => route.widget,
      ),
    );
  }
}
