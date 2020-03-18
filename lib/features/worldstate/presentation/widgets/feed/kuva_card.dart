import 'package:flutter/material.dart';
import 'package:navis/core/widgets/countdown_banner.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/generated/l10n.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class KuvaCard extends StatelessWidget {
  const KuvaCard({Key key, this.kuva}) : super(key: key);

  final List<Kuva> kuva;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CustomCard(
      child: Column(
        children: <Widget>[
          CountdownBanner(
            message: NavisLocalizations.of(context).kuvaBanner,
            time: kuva.first.expiry,
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          ),
          for (final kuva in kuva)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  const Icon(NavisSysIcons.kuva, color: Colors.red),
                  const SizedBox(width: 2.0),
                  if (kuva.archwingRequired) const Icon(NavisSysIcons.archwing),
                  const SizedBox(width: 8.0),
                  Text(
                    '${kuva.node} | ${kuva.type} - ${kuva.enemy}',
                    style: textTheme.body1.copyWith(fontSize: 15),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
