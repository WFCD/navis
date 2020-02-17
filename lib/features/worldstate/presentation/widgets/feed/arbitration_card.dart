import 'package:flutter/material.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class ArbitrationCard extends StatelessWidget {
  const ArbitrationCard({Key key, @required this.arbitration})
      : assert(arbitration != null),
        super(key: key);

  final Arbitration arbitration;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ListTile(
        leading: const Icon(SyndicateIcons.hexis, size: 50),
        title: Text(arbitration.node),
        subtitle: Text('${arbitration.enemy} | ${arbitration.type}'),
        trailing: CountdownTimer(expiry: arbitration.expiry),
      ),
    );
  }
}
