import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

typedef OnTap = void Function();

class NightwaveCard extends StatelessWidget {
  const NightwaveCard({super.key, required this.nightwave, required this.onTap});

  final Nightwave nightwave;
  final OnTap onTap;

  @override
  Widget build(BuildContext context) {
    return SyndicateCard(
      syndicate: Syndicates.nightwave,
      subtitle: context.l10n.nightwaveSeasonSubtitle(nightwave.season),
      trailing: CountdownTimer(
        tooltip: context.l10n.countdownTooltip(nightwave.expiry),
        expiry: nightwave.expiry,
        color: Colors.red[600],
      ),
      onTap: onTap,
    );
  }
}
