import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

// TODO(SLayerOrnstein): add a more detailed patchlog page
//  with maybe a timeline.
class PatchlogCard extends StatelessWidget {
  const PatchlogCard({super.key, required this.patchlogs});

  final List<Patchlog> patchlogs;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CategoryTitle(title: 'Patchlogs'),
          ...patchlogs.map(
            (e) => ListTile(
              title: Text(e.name),
              subtitle: Text(
                MaterialLocalizations.of(context)
                    .formatFullDate(e.date.toLocal()),
              ),
              onTap: () => e.url.launchLink(context),
            ),
          ),
          // ButtonBar(
          //   children: [
          //     TextButton(
          //       style: ButtonStyle(
          //         foregroundColor: MaterialStateProperty.all(Colors.white),
          //       ),
          //       onPressed: () {},
          //       child: const Text('See more patchlogs'),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class _PatchlogEntry extends StatelessWidget {
  const _PatchlogEntry({required this.context, required this.log});

  final BuildContext context;
  final String log;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        log.splitMapJoin('\n', onMatch: (m) => '\n\n', onNonMatch: (n) => n),
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
