import 'package:flutter/material.dart';
import 'package:navis/core/widgets/icons.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:worldstate_api_model/entities.dart';

class ArbitrationCard extends StatelessWidget {
  const ArbitrationCard({Key key, @required this.arbitration})
      : assert(arbitration != null),
        super(key: key);

  final Arbitration arbitration;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: ListTile(
      leading:
          const Icon(SyndicateIcons.hexis, size: 50, color: Color(0xFFcfe1e4)),
      title: Row(
        children: <Widget>[
          if (arbitration.archwingRequired)
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: NavisSystemIconWidgets.archwingIcon,
            ),
          Text(arbitration.node),
        ],
      ),
      subtitle: Text('${arbitration.enemy} | ${arbitration.type}'),
      trailing: CountdownTimer(expiry: arbitration.expiry),
    ));
  }
}
