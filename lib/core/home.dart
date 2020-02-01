import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';

import '../injection_container.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Navis')),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 8.0),
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor)),
              // Expanded(child: DrawerOptions()),
              const Divider(height: 4.0),
              ListTile(
                leading: Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/settings');
                },
              ),
            ],
          ),
        ),
        body: BlocProvider(
          create: (_) => sl<SolsystemBloc>(),
          child: Container(),
        ),
      ),
    );
  }
}
