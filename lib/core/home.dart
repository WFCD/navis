import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/core/bloc/navigation_bloc.dart';
import 'package:navis/core/utils/ui_util.dart';

import 'themes/colors.dart';
import 'widgets/drawer_options.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Navis')),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 20 * (mediaQuery.size.height / 100),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                image: const DecorationImage(
                  image: AssetImage('assets/skyboxes/Void.webp'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                  bottom: false,
                  left: false,
                  right: false,
                  top: true,
                  child: SvgPicture.asset(
                    'assets/wfcd_logo_color.svg',
                    color: Colors.white.withOpacity(0.5),
                  )),
            ),
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
