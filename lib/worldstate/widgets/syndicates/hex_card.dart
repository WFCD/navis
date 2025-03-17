import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

typedef OnTap = void Function();

class HexCard extends StatelessWidget {
  const HexCard({super.key, required this.calendar, required this.onTap});

  final Calendar calendar;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SyndicateCard(
      syndicate: Syndicates.hex,
      title: context.l10n.calendar1999Title,
      subtitle: calendar.season,
      trailing: CountdownTimer(
        color: SyndicateColors.theHexIconColor.hsl.withLightness(.4).toColor(),
        tooltip: context.l10n.countdownTooltip(calendar.expiry),
        expiry: calendar.expiry,
      ),
      onTap: onTap,
    );
  }
}
