import 'package:material_ui/material_ui.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart' hide Syndicates;

typedef OnTap = void Function();

class HexCard extends StatelessWidget {
  const new({super.key, required this.calendar, required this.onTap});

  final Calendar calendar;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final hsl = HSLColor.fromColor(SyndicateColors.theHexIconColor);

    return SyndicateCard(
      syndicate: Syndicates.hex,
      title: context.l10n.calendar1999Title,
      subtitle: calendar.season,
      trailing: CountdownTimer(
        color: hsl.withLightness(.4).toColor(),
        tooltip: context.l10n.countdownTooltip(calendar.expiry),
        expiry: calendar.expiry,
      ),
      onTap: onTap,
    );
  }
}
