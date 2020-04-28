import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/core/bloc/navigation_bloc.dart';

import 'widgets/drawer_options.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Expanded(child: DrawerOptions()),
            const Divider(height: 4.0),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/settings');
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<NavigationBloc, Widget>(
        builder: (BuildContext context, Widget state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: state,
          );
        },
      ),
    );
  }
}
