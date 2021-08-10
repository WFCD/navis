import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/widgets/icons.dart';
import '../../../../../core/widgets/widgets.dart';

class ArbitrationCard extends StatelessWidget {
  const ArbitrationCard({Key? key, required this.arbitration})
      : super(key: key);

  final Arbitration arbitration;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ListTile(
        leading: const Icon(SyndicateGlyphs.hexis, size: 50),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (arbitration.archwingRequired)
              const Padding(
                padding: EdgeInsets.only(left: 6),
                child: NavisSystemIconWidgets.archwingIcon,
              ),
            Text(arbitration.node!),
          ],
        ),
        subtitle: Text('${arbitration.enemy} | ${arbitration.type}'),
        trailing: CountdownTimer(expiry: arbitration.expiry!),
      ),
    );
  }
}
