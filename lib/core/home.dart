import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/constants/links.dart';
import 'package:navis/core/local/user_settings.dart';
import 'package:navis/core/widgets/fa_icon.dart';
import 'package:provider/provider.dart';

import '../resources/resources.dart';
import 'bloc/navigation_bloc.dart';
import 'utils/extensions.dart';
import 'utils/helper_methods.dart';
import 'widgets/drawer_options.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  Future<bool> _willPop() {
    if (context.read<Usersettings>().backkey) {
      if (!scaffold.currentState.isDrawerOpen) {
        scaffold.currentState.openDrawer();
        return Future.value(false);
      } else {
        return Future.value(true);
      }
    }

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
        key: scaffold,
        appBar: AppBar(),
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
                    image: AssetImage(NavisAssets.derelict),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  left: false,
                  right: false,
                  top: true,
                  child: SvgPicture.asset(
                    NavisAssets.wfcdLogoColor,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
              Expanded(child: DrawerOptions()),
              const Divider(height: 4.0),
              ListTile(
                leading: const FaIcon(
                  BrandIcons.discord,
                  color: Color(0xFF7289DA),
                ),
                title: const Text('Support'),
                onTap: () => launchLink(context, discordInvite),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: Text(context.locale.settingsTitle),
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
      ),
    );
  }
}
