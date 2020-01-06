import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:navis/utils/size_config.dart';
import 'package:navis/widgets/icons.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class ArbitrationPanel extends StatelessWidget {
  const ArbitrationPanel({Key key, this.arbitration}) : super(key: key);

  final Arbitration arbitration;

  @override
  Widget build(BuildContext context) {
    return ArbitrationWidget(
      node: arbitration?.node,
      type: arbitration?.type,
      enemy: arbitration?.enemy,
      expiry:
          arbitration?.expiry ?? DateTime.now().add(const Duration(minutes: 1)),
      archwingRequired: arbitration.archwing || arbitration.sharkwing,
    );
  }
}

class ArbitrationWidget extends StatelessWidget {
  const ArbitrationWidget({
    Key key,
    @required this.node,
    @required this.type,
    @required this.enemy,
    @required this.expiry,
    this.archwingRequired = false,
  })  : assert(expiry != null),
        super(key: key);

  final String node, type, enemy;
  final bool archwingRequired;
  final DateTime expiry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SkyboxCard(
      node: node,
      height: 150,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Icon(
            SyndicateIcons.hexis,
            size: 125,
            color: Colors.grey[600],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                node,
                textAlign: TextAlign.center,
                style: textTheme.subhead.copyWith(
                  color: Colors.white,
                  fontSize: SizeConfig.widthMultiplier * 6,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                '${enemy ?? 'unknown'} | ${type ?? 'unknown'}',
                textAlign: TextAlign.center,
                style: textTheme.caption.copyWith(
                  color: Colors.white,
                  fontSize: SizeConfig.widthMultiplier * 3.2,
                ),
              ),
              const SizedBox(height: 4.0),
              if (archwingRequired)
                SvgPicture.asset('assets/general/archwing.svg',
                    color: Colors.blue, height: 25, width: 25),
              const SizedBox(height: 4.0),
              CountdownBox(
                expiry: expiry,
                size: SizeConfig.widthMultiplier * 3.7,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
