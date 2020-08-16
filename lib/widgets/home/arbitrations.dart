import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/widgets/icons.dart';
import 'package:navis/widgets/widgets.dart';

class ArbitrationBuilder extends StatelessWidget {
  const ArbitrationBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldstateBloc, WorldStates>(
      buildWhen: (previous, current) {
        return (previous.worldstate?.arbitration?.expiry !=
                current.worldstate?.arbitration?.expiry) ??
            false;
      },
      builder: (context, state) {
        final arbitration = state.worldstate.arbitration;

        return ArbitrationWidget(
          node: arbitration?.node,
          type: arbitration?.type,
          enemy: arbitration?.enemy,
          expiry: arbitration?.expiry ??
              DateTime.now().add(const Duration(minutes: 1)),
          archwingRequired: arbitration.archwingRequired,
        );
      },
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
    // final textTheme = Theme.of(context).textTheme;

    return SkyboxCard(
      node: node,
      height: 150,
      child: ListTile(
        leading: const Icon(SyndicateGlyphs.hexis, size: 50),
        title: Row(
          children: <Widget>[
            if (archwingRequired)
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: SvgPicture.asset('assets/general/archwing.svg',
                    color: Colors.blue, height: 25, width: 25),
              ),
            Text(node),
          ],
        ),
        subtitle: Text('$enemy | $type'),
        trailing: CountdownBox(expiry: expiry),
      ),
    );
  }
}
