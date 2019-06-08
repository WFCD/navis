import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/animations.dart';
import 'package:navis/components/layout/image_card.dart';
import 'package:navis/models/export.dart';
import 'package:navis/utils/factionutils.dart';

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
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Card(
                            color: const Color(0xFF4855B8),
                            child: ListTile(
                              leading:
                                  FactionIcon(state.sortie.faction, size: 45),
                              title: Text(state.sortie.boss),
                              subtitle: Text(state.sortie.faction),
                              trailing: CountdownBox(
                                  color: Colors.transparent,
                                  expiry: state.sortie.expiry,
                                  size: 20),
                            )),
                        for (Variants v in state.sortie.variants)
                          _BuildMissions(v, state.sortie.variants.indexOf(v))
                      ]);
                }
              }
            }));
  }
}

class _BuildMissions extends StatelessWidget {
  const _BuildMissions(this.variant, this.index);

  final Variants variant;
  final int index;

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

    return BackgroundImageCard(
      height: 145,
      provider: AssetImage('assets/skyboxes/$node.webp'),
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
        child: Row(
            children: <Widget>[_buildDetails(context), const Spacer(flex: 2)]),
      ),
    );
  }
}
