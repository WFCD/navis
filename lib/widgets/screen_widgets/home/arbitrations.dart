import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:navis/widgets/animations.dart';
import 'package:navis/widgets/widgets/background_image_card.dart';

class ArbitrationBuilder extends StatelessWidget {
  const ArbitrationBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldstateBloc, WorldStates>(
      builder: (context, state) {
        final arbitration = state.worldstate.arbitration;

        return ArbitrationWidget(
          node: arbitration.node,
          type: arbitration.type,
          enemy: arbitration.enemy,
          expiry: arbitration.expiry,
        );
      },
    );
  }
}

class ArbitrationWidget extends StatelessWidget {
  const ArbitrationWidget(
      {Key key, this.node, this.type, this.enemy, this.expiry})
      : super(key: key);

  final String node, type, enemy;
  final DateTime expiry;

  @override
  Widget build(BuildContext context) {
    return BackgroundImageCard(
      provider: skybox(context, node),
      height: 150,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          SvgPicture.asset('assets/sigils/hexis.svg', color: Colors.grey[600]),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(node, style: Theme.of(context).textTheme.title),
                const SizedBox(height: 4.0),
                Text('$enemy | $type',
                    style: Theme.of(context).textTheme.subhead),
                const SizedBox(height: 8.0),
                CountdownBox(expiry: expiry),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
