import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../../../l10n/l10n.dart';

class SteelPathCard extends StatelessWidget {
  const SteelPathCard({Key key, @required this.steelPath}) : super(key: key);

  final SteelPath steelPath;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ListTile(
        title: Text(context.l10n.steelPathTitle),
        subtitle: Text(steelPath.currentReward.name),
        trailing: CountdownTimer(expiry: steelPath.expiry),
      ),
    );
  }
}
