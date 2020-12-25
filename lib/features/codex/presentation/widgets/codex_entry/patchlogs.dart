import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/helper_methods.dart';
import '../../../../../core/widgets/widgets.dart';

class PatchlogCards extends StatelessWidget {
  const PatchlogCards({Key key, this.patchlogs}) : super(key: key);

  final List<Patchlog> patchlogs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0,
      child: PageView.builder(
        itemCount: patchlogs.length,
        itemBuilder: (context, index) {
          return PatchlogCard(patchlog: patchlogs[index]);
        },
      ),
    );
  }
}

class PatchlogCard extends StatelessWidget {
  const PatchlogCard({Key key, @required this.patchlog})
      : assert(patchlog != null),
        super(key: key);

  final Patchlog patchlog;

  static const _backupImage = 'https://i.imgur.com/CNrsc7V.png';

  Widget _log(String log) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        log.splitMapJoin('\n', onMatch: (m) => '\n\n', onNonMatch: (n) => n),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.zero,
      child: Column(
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
                    Colors.black.withOpacity(.6), BlendMode.darken),
              ),
            ),
            child: CategoryTitle(
              title: patchlog.name,
              subtitle: patchlog.date.format(context),
            ),
          ),
          if (patchlog.additions.isNotEmpty) ...{
            const CategoryTitle(title: 'Additions'),
            _log(patchlog.additions)
          },
          if (patchlog.changes.isNotEmpty) ...{
            const CategoryTitle(title: 'Changes'),
            _log(patchlog.changes)
          },
          if (patchlog.fixes.isNotEmpty) ...{
            const CategoryTitle(title: 'Fixes'),
            _log(patchlog.fixes)
          },
          const Spacer(),
          ButtonBar(
            children: [
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () => launchLink(context, patchlog.url),
                child: const Text('FULL PATCH NOTES'),
              )
            ],
          )
        ],
      ),
    );
  }
}
