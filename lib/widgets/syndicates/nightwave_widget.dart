import 'package:flutter/material.dart';
import 'package:navis/utils/syndicate_utils.dart';
import 'package:navis/widgets/widgets.dart';

class NightWaveWidget extends StatelessWidget {
  const NightWaveWidget({Key key, @required this.season}) : super(key: key);

  final int season;

  @override
  Widget build(BuildContext context) {
    return Tiles(
      color: const Color(0xFF6c1822),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: ListTile(
          leading: const GetSyndicateIcon(syndicate: 'Nightwave'),
          title: Text(
            'Nightwaves',
            style: Typography.whiteMountainView.subhead,
          ),
          subtitle: Text(
            'Season $season',
            style: Typography.whiteMountainView.caption,
          ),
          onTap: () => Navigator.of(context).pushNamed('/nightwave'),
        ),
      ),
    );
  }
}
