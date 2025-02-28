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

    return BlocSelector<WorldstateCubit, SolsystemState, Calendar?>(
      selector: (state) {
        return switch (state) {
          WorldstateSuccess() => state.worldstate.calendar.first,
          _ => null,
        };
      },
      builder: (context, state) {
        final seasonColor = SeasonColors.color(state?.season.toLowerCase() ?? 'winter')!;
        final colorScheme = ColorScheme.fromSeed(seedColor: seasonColor);
        final expiry = state?.expiry ?? DateTime.timestamp().add(const Duration(minutes: 1));

        return InkWell(
          onTap:
              () =>
                  Calendar1999PageRoute(state?.season ?? 'winter', state?.days ?? <CalendarDay>[]).push<void>(context),
          customBorder: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Theme(
            data: Theme.of(context).copyWith(colorScheme: colorScheme),
            child: AppCard(
              color: seasonColor,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: (size.longestSide / 100) * 1.5),
                child: ListTile(
                  leading: Icon(WarframeSymbols.the_hex, size: 60, color: colorScheme.secondary),
                  title: const Text('1999 Calendar'),
                  subtitle: Text(state?.season ?? 'Rebooting'),
                  trailing: CountdownTimer(
                    color: colorScheme.secondary,
                    tooltip: context.l10n.countdownTooltip(expiry),
                    expiry: expiry,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
