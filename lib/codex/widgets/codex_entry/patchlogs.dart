import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class PatchlogCard extends StatelessWidget {
  const PatchlogCard({super.key, required this.patchlog});

  final Patchlog patchlog;

  static const _backupImage = 'https://i.imgur.com/CNrsc7V.png';

  Widget _log(BuildContext context, String log) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        log.splitMapJoin('\n', onMatch: (m) => '\n\n', onNonMatch: (n) => n),
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 95,
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    CachedNetworkImageProvider(patchlog.imgUrl ?? _backupImage),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(.6),
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
            _log(context, patchlog.additions)
          },
          if (patchlog.changes.isNotEmpty) ...{
            const CategoryTitle(title: 'Changes'),
            _log(context, patchlog.changes)
          },
          if (patchlog.fixes.isNotEmpty) ...{
            const CategoryTitle(title: 'Fixes'),
            _log(context, patchlog.fixes)
          },
          ButtonBar(
            children: [
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () => patchlog.url.launchLink(context),
                child: const Text('FULL PATCH NOTES'),
              )
            ],
          )
        ],
      ),
    );
  }
}
