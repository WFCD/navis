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
            builder: (BuildContext context, WorldStates state) {
              if (state is WorldstateLoaded) {
                if (state.sortie?.variants?.isNotEmpty ?? false) {
                  final variants = state.sortie.variants;
                  final faction = state.sortie.faction;

                  final light = 'assets/factions/$faction/light.webp';
                  final medium = 'assets/factions/$faction/medium.webp';
                  final heavy = 'assets/factions/$faction/heavy.webp';

                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Card(
                            color: Theme.of(context).primaryColor,
                            child: ListTile(
                              title: const Text('Sortie will reset in: '),
                              trailing: CountdownBox(
                                  color: Colors.transparent,
                                  expiry: state.sortie.expiry,
                                  size: 16),
                            )),
                        _BuildMission(
                            variant: variants[0], index: 0, asset: light),
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
    const node = TextStyle(
        fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, fontSize: 18);
    const mode = TextStyle(
        fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: 14);

    final info = Theme.of(context).textTheme.caption.copyWith(
        fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: 12);

    return Flexible(
      flex: 3,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Sortie ${index + 1}', style: node),
            Text('${variant.missionType} - ${variant.node}', style: mode),
            const SizedBox(height: 16),
            Text(variant.modifierDescription, style: info, maxLines: 3)
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final node = _nodeBackground.firstMatch(variant.node).group(1);
    final bool isAssassination = variant.missionType == 'Assassination';

    return BackgroundImageCard(
      height: 145,
      provider: AssetImage('assets/skyboxes/$node.webp'),
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
        child: Row(children: <Widget>[
          _buildDetails(context),
          const Spacer(flex: 2),
          Container(
            margin: const EdgeInsets.all(16.0),
            child: Image.asset(isAssassination
                ? 'assets/factions/$faction/$boss.webp'
                : asset),
          )
        ]),
      ),
    );
  }
}
