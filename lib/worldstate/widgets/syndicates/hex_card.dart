import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis/worldstate/cubits/worldstate_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

typedef OnTap = void Function();

class HexCard extends StatelessWidget {
  const HexCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final titleStyle = context.textTheme.titleMedium?.copyWith(color: Typography.whiteMountainView.titleMedium?.color);
    final captionStyle = context.textTheme.bodySmall?.copyWith(color: Typography.whiteMountainView.bodySmall?.color);

    return BlocSelector<WorldstateCubit, SolsystemState, Calendar?>(
      selector: (state) {
        return switch (state) {
          WorldstateSuccess() => state.worldstate.calendar.first,
          _ => null,
        };
      },
      builder: (context, state) {
        // final seasonColor = SeasonColors.color(state?.season.toLowerCase() ?? 'winter')!;
        final expiry = state?.expiry ?? DateTime.timestamp().add(const Duration(minutes: 1));

        return InkWell(
          onTap:
              () =>
                  Calendar1999PageRoute(state?.season ?? 'winter', state?.days ?? <CalendarDay>[]).push<void>(context),
          customBorder: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
          child: AppCard(
            color: SyndicateColors.theHexBackgroundColor,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: (size.longestSide / 100) * 1.5),
              child: ListTile(
                leading: const Icon(WarframeSymbols.the_hex, size: 60, color: SyndicateColors.theHexIconColor),
                title: Text('1999 Calendar', style: titleStyle),
                subtitle: Text(state?.season ?? 'Rebooting', style: captionStyle),
                trailing: CountdownTimer(
                  color: SyndicateColors.theHexIconColor.hsl.withLightness(.4).toColor(),
                  tooltip: context.l10n.countdownTooltip(expiry),
                  expiry: expiry,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
