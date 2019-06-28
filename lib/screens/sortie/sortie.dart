import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/animations.dart';
import 'package:navis/components/layout/image_card.dart';
import 'package:navis/models/export.dart';

final _nodeBackground = RegExp(r'\(([^)]*)\)');

class SortieScreen extends StatelessWidget {
  const SortieScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocBuilder(
            bloc: BlocProvider.of<WorldstateBloc>(context),
            condition: (WorldStates previous, WorldStates current) =>
                previous.sortie != current.sortie,
            builder: (BuildContext context, WorldStates state) {
              if (state is WorldstateLoaded) {
                if (state.sortie?.variants?.isNotEmpty ?? false) {
                  final variants = state.sortie.variants;
                  final faction = state.sortie.faction;

                  final light = 'assets/factions/$faction/light.webp';
                  final medium = 'assets/factions/$faction/medium.webp';
                  final heavy = 'assets/factions/$faction/heavy.webp';

                  return ListView(children: <Widget>[
                    Card(
                        color: Theme.of(context).primaryColor,
                        child: ListTile(
                          title: const Text('Sortie will reset in: ',
                              style: TextStyle(color: Colors.white)),
                          trailing: CountdownBox(
                              color: Colors.transparent,
                              expiry: state.sortie.expiry,
                              size: 16),
                        )),
                    _BuildMission(variant: variants[0], index: 0, asset: light),
                    _BuildMission(
                        variant: variants[1], index: 1, asset: medium),
                    _BuildMission(
                        variant: variants[2],
                        index: 2,
                        asset: heavy,
                        boss: state.sortie.boss,
                        faction: state.sortie.faction)
                  ]);
                }
              }
            }));
  }
}

class _BuildMission extends StatelessWidget {
  const _BuildMission(
      {@required this.variant,
      @required this.index,
      @required this.asset,
      this.faction,
      this.boss});

  final Variants variant;
  final int index;
  final String asset, faction, boss;

  Widget _buildDetails(BuildContext context) {
    const shadow = Shadow(offset: Offset(1.0, 0.0), blurRadius: 3.0);
    const color = Colors.white;
    const sortie = TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        fontSize: 18,
        color: color,
        shadows: <Shadow>[shadow]);
    const mode = TextStyle(
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontSize: 14,
        color: color,
        shadows: <Shadow>[shadow]);

    final info = Theme.of(context).textTheme.caption.copyWith(
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontSize: 12,
        color: color,
        shadows: <Shadow>[shadow]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(child: Text('Sortie ${index + 1}', style: sortie)),
        Container(
            child:
                Text('${variant.missionType} - ${variant.node}', style: mode)),
        const SizedBox(height: 16),
        Container(child: Text(variant.modifierDescription, style: info))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final node = _nodeBackground.firstMatch(variant.node).group(1);
    final bool isAssassination = variant.missionType == 'Assassination';

    return BackgroundImageCard(
      height: 150,
      provider: AssetImage('assets/skyboxes/$node.webp'),
      child: Container(
        padding: const EdgeInsets.only(left: 8, top: 16, bottom: 16),
        child: Row(children: <Widget>[
          Expanded(child: _buildDetails(context)),
          Container(
            child: Image.asset(
                isAssassination ? 'assets/factions/$faction/$boss.webp' : asset,
                height: 150,
                width: 150),
          )
        ]),
      ),
    );
  }
}
