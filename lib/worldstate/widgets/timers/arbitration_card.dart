import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

const _gracePeriod = Duration(seconds: 1);

class ArbitrationCard extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final repo = RepositoryProvider.of<WorldstateRepository>(context);

    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocProvider(
            create: (_) => ArbitrationCubit(repo)..fetchArbitrations(locale),
            child: const _ArbitrationContent(),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 12, bottom: 4),
              child: Text(
                'via browse.wf',
                style: TextTheme.of(context).labelMedium?.copyWith(color: ColorScheme.of(context).primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArbitrationContent extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorldstateBloc, WorldState>(
      listener: (context, state) {
        context.read<ArbitrationCubit>().fetchArbitrations(Localizations.localeOf(context).languageCode);
      },
      child: BlocBuilder<ArbitrationCubit, ArbitrationState>(
        builder: (context, state) {
          final arbitration = switch (state) {
            ArbitrationActive(:final arbitration) => arbitration,
            _ => null,
          };

          final expiry = arbitration?.expiry ?? DateTime.timestamp().add(_gracePeriod);

          return ListTile(
            leading: const AppIcon(WarframeIcons.arbitrations, size: 50),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (arbitration?.archwing ?? false)
                  const Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Icon(WarframeIcons.archwing, color: Colors.blue, size: 25),
                  ),
                Text(arbitration?.node ?? ''),
              ],
            ),
            subtitle: Text('${arbitration?.enemy ?? 'MITW'} | ${arbitration?.type ?? '[PH] Type'}'),
            trailing: CountdownTimer(tooltip: context.l10n.countdownTooltip(expiry), expiry: expiry),
          );
        },
      ),
    );
  }
}
