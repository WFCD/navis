import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class PatchlogCard extends StatelessWidget {
  const PatchlogCard({super.key, required this.patchlog});

  final Patchlog patchlog;

  static const _backupImage = 'https://i.imgur.com/CNrsc7V.png';

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // This is what just worked for the style.
            // ignore: no-magic-number
            height: 95,
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    CachedNetworkImageProvider(patchlog.imgUrl ?? _backupImage),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  // This is what just worked for the style.
                  // ignore: no-magic-number
                  Colors.black.withOpacity(0.6),
                  BlendMode.darken,
                ),
              ),
            ),
            child: CategoryTitle(
              title: patchlog.name,
              subtitle: MaterialLocalizations.of(context)
                  .formatFullDate(patchlog.date),
            ),
          ),
          if (patchlog.additions.isNotEmpty) ...{
            const CategoryTitle(title: 'Additions'),
            _PatchlogEntry(context: context, log: patchlog.additions),
          },
          if (patchlog.changes.isNotEmpty) ...{
            const CategoryTitle(title: 'Changes'),
            _PatchlogEntry(context: context, log: patchlog.changes),
          },
          if (patchlog.fixes.isNotEmpty) ...{
            const CategoryTitle(title: 'Fixes'),
            _PatchlogEntry(context: context, log: patchlog.fixes),
          },
          ButtonBar(
            children: [
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () => patchlog.url.launchLink(context),
                child: const Text('FULL PATCH NOTES'),
              ),
            ],
          ),
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
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
