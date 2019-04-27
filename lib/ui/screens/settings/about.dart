import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info/package_info.dart';

const legalese =
    'Warframe and the Warframe logo are registered trademarks of Digital Extremes Ltd. Cephalon Navis is not affiliated with Digital Extremes Ltd. in any way.';

class _AppIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.circular(60.0)),
      child: SvgPicture.asset(
        'assets/general/nightmare.svg',
        height: 60,
        width: 60,
        color: const Color.fromRGBO(26, 80, 144, .9),
      ),
    );
  }
}

class Miscellaneous extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      Container(
          margin: const EdgeInsets.only(top: 10.0, left: 8.0),
          alignment: Alignment.centerLeft,
          child: Text('Miscellaneous',
              style:
                  Theme.of(context).textTheme.subtitle.copyWith(fontSize: 15))),
      FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (_, snapshot) {
            return AboutListTile(
              icon: null,
              applicationIcon: _AppIcon(),
              applicationName: 'Cephalon Navis',
              applicationVersion: snapshot.data?.version ?? '',
              applicationLegalese: legalese,
            );
          })
    ]));
  }
}
