import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../../../core/widgets/countdown_banner.dart';
import '../../../../../core/widgets/icons.dart';
import '../../../../../core/widgets/widgets.dart';

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
            message: context.locale.kuvaBanner,
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
                  if (kuva.archwingRequired)
                    NavisSystemIconWidgets.archwingIcon,
                  const SizedBox(width: 8.0),
                  Text(
                    '${kuva.node} | ${kuva.type} - ${kuva.enemy}',
                    style: textTheme.bodyText1.copyWith(fontSize: 15),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
