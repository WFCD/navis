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
      child:
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(
          height: 20 * SizeConfig.heightMultiplier,
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 8.0),
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
          leading: Icon(Icons.settings),
          title: Text(NavisLocalizations.of(context).settingsTitle),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/settings');
          },
        ),
      ]),
    );
  }
}
