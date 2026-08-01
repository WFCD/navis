import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/drops/drops.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

class SyndicateBountyTile extends StatelessWidget {
  const SyndicateBountyTile({super.key, required this.color, required this.job});

  final Color color;
  final SyndicateBounty job;

  @override
  Widget build(BuildContext context) {
    var title = job.type;
    if (job.isVault ?? false) {
      final tier = switch (job.maxLevel) {
        40 => 1,
        50 => 2,
        60 => 3,
        _ => 0,
      };

      title = context.l10n.isolationVaultText(tier);
    }

    return ListTile(
      title: Text(title!),
      subtitle: Text(context.l10n.levelInfo(job.minLevel, job.maxLevel)),
      trailing: _Standing(standing: job.standing),
      onTap: () => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.2,
            maxChildSize: 0.9,
            expand: false,
            builder: (context, scrollController) =>
                BountyRewardsView(controller: scrollController, bounty: job, color: color),
          );
        },
      ),
    );
  }
}

class _Standing extends StatelessWidget {
  const _Standing({required this.standing});

  final int standing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          NumberFormat().format(standing),
          style: context.textTheme.labelLarge,
        ),
        const Icon(WarframeIcons.standing, size: 20),
      ],
    );
  }
}
