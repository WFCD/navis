import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_model/worldstate_models.dart';

class FissureWidget extends StatelessWidget {
  const FissureWidget({Key key, @required this.fissure}) : super(key: key);

  final VoidFissure fissure;

  @override
  Widget build(BuildContext context) {
    const size = Size(60, 60);
    const color = Colors.white;
    const shadow = Shadow(offset: Offset(1.0, 0.0), blurRadius: 3.0);

    const _nodeStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        fontSize: 18,
        color: color,
        shadows: <Shadow>[shadow]);

    const _missionTypeStyle = TextStyle(
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontSize: 14,
        color: color,
        shadows: <Shadow>[shadow]);

    final tierIcon = SvgPicture.asset(
      'assets/relics/${fissure.tierNum != 5 ? fissure.tier : 'Axi'}.svg',
      height: size.height,
      width: size.width,
      color: fissure.tierNum != 5 ? Colors.white : const Color(0xFFFA0808),
    );

    return SkyboxCard(
      elevation: 6.0,
      node: fissure.node,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        child: ListTile(
          leading: tierIcon,
          title: Text(fissure.node, style: _nodeStyle),
          subtitle: Text(
            '${fissure.missionType} | ${fissure.tier}',
            style: _missionTypeStyle,
          ),
          trailing: CountdownBox(expiry: fissure.expiry),
        ),
      ),
    );
  }
}
