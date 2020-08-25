import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:navis/generated/l10n.dart';
import 'package:navis/utils/size_config.dart';

import 'drawer_options.dart';

class LotusDrawer extends StatelessWidget {
  const LotusDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const _Header(),
          Expanded(child: DrawerOptions()),
          const Divider(height: 4.0),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(NavisLocalizations.of(context).settingsTitle),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/settings');
            },
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20 * SizeConfig.heightMultiplier,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          const Image(
            image: AssetImage('assets/skyboxes/Void.webp'),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SafeArea(
            bottom: false,
            left: false,
            right: false,
            top: true,
            child: SvgPicture.asset(
              'assets/wfcd_logo_color.svg',
              color: Colors.white.withOpacity(0.5),
            ),
          )
        ],
      ),
    );
  }
}
