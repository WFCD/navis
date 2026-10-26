import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

const _gracePeriod = Duration(seconds: 1);

class ArbitrationCard extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _ArbitrationContent(),
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
    return BlocSelector<WorldstateBloc, WorldState, Arbitration?>(
      selector: (state) => switch (state) {
        WorldstateSuccess(:final seed) => seed.arbitration,
        _ => null,
      },
      builder: (context, arbitration) {
        final expiry = arbitration?.expiry ?? DateTime.timestamp().add(_gracePeriod);

        return ListTile(
          leading: const AppIcon(WarframeIcons.arbitrations, size: 50),
          title: Text(arbitration?.node ?? ''),
          subtitle: Text('${arbitration?.faction ?? 'MITW'} | ${arbitration?.type ?? '[PH] Type'}'),
          trailing: CountdownTimer(tooltip: context.l10n.countdownTooltip(expiry), expiry: expiry),
        );
      },
    );
  }
}
