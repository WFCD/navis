import 'package:flutter/material.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_model/worldstate_models.dart';

class SyndicateWidget extends StatelessWidget {
  const SyndicateWidget({this.syndicate});

  final Syndicate syndicate;

  static const String route = '/syndicate';

  static const Color ostronsColor = Color.fromRGBO(183, 70, 36, 1.0);
  static const Color solarisColor = Color.fromRGBO(206, 162, 54, 1.0);

  @override
  Widget build(BuildContext context) {
    final bool ostron = syndicate.name == 'Ostrons';

    return Tiles(
      color: ostron ? ostronsColor : solarisColor,
      child: ListTile(
        leading: FactionIcon(syndicate.name, size: 60.0),
        title: Text(syndicate.name),
        subtitle: const Text('Tap to see bounties'),
        onTap: () => Navigator.of(context)
            .pushNamed('/syndicate_jobs', arguments: syndicate),
      ),
    );
  }
}
