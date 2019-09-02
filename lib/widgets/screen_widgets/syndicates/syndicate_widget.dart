import 'package:flutter/material.dart';
import 'package:navis/router.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_model/worldstate_models.dart';

class SyndicateWidget extends StatelessWidget {
  const SyndicateWidget({this.syndicate});

  final Syndicate syndicate;

  static const Color ostronsColor = Color.fromRGBO(183, 70, 36, 1.0);
  static const Color solarisColor = Color.fromRGBO(206, 162, 54, 1.0);

  @override
  Widget build(BuildContext context) {
    final bool ostron = syndicate.name == 'Ostrons';

    return Tiles(
      color: ostron ? ostronsColor : solarisColor,
      child: InkWell(
        onTap: () => navigateToBounties(context, syndicate),
        splashColor: Colors.transparent,
        child: Container(
          child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
            Container(child: FactionIcon(syndicate.name, size: 60.0)),
            Expanded(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(syndicate.name,
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.white)),
                    Text('Tap to see bounties',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.white70))
                  ]),
            )
          ]),
        ),
      ),
    );
  }
}
