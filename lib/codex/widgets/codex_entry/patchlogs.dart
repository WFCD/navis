import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class PatchlogCard extends StatelessWidget {
  const PatchlogCard({super.key, required this.patchlogs});

  final List<Patchlog> patchlogs;

  @override
  Widget build(BuildContext context) {
    final maxRange = this.patchlogs.length > 4 ? 4 : this.patchlogs.length;
    final patchlogs = List.of(this.patchlogs.getRange(0, maxRange));

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryTitle(title: context.l10n.patchlogsTitle),
          ...patchlogs.map(
            (e) => _PatchlogEntry(patchlog: e),
          ),
        ],
      ),
    );
  }
}

class _PatchlogEntry extends StatelessWidget {
  const _PatchlogEntry({required this.patchlog});

  final Patchlog patchlog;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(patchlog.name),
      subtitle: Text(
        MaterialLocalizations.of(context)
            .formatFullDate(patchlog.date.toLocal()),
      ),
      onTap: () => patchlog.url.launchLink(context),
    );
  }
}
