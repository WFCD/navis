import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/arbitration_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class ArbitrationCard extends StatelessWidget {
  const ArbitrationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<WarframestatRepository>(context);
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocProvider(
            create: (_) => ArbitrationCubit(repo)..fetchArbitrations(),
            child: const _ArbitrationContent(),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                'via browse.wf',
                style: context.textTheme.labelMedium?.copyWith(color: context.colorScheme.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArbitrationContent extends StatelessWidget {
  const _ArbitrationContent();

  @override
  Widget build(BuildContext context) {
    const gracePeriod = Duration(seconds: 1);

    return BlocBuilder<ArbitrationCubit, ArbitrationState>(
      builder: (context, state) {
        final arbitration = switch (state) {
          ArbitrationActive(:final arbitration) => arbitration,
          _ => null,
        };

        final now = DateTime.timestamp();
        final expiry = arbitration?.expiry ?? now.add(gracePeriod);

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
    );
  }
}
