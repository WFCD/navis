import 'package:material_ui/material_ui.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

class PatchlogSection extends StatelessWidget {
  const new({super.key, required this.patchlogs});

  final List<Patchlog> patchlogs;

  @override
  Widget build(BuildContext context) {
    final maxRange = this.patchlogs.length > 4 ? 4 : this.patchlogs.length;
    final patchlogs = List.of(this.patchlogs.getRange(0, maxRange));

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoryTitle(title: context.l10n.patchlogsTitle, contentPadding: EdgeInsets.zero),
        ...patchlogs.map((e) => _PatchlogEntry(patchlog: e)),
      ],
    );
  }
}

class _PatchlogEntry extends StatelessWidget {
  const new({required this.patchlog});

  final Patchlog patchlog;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(patchlog.name),
      subtitle: Text(MaterialLocalizations.of(context).formatFullDate(patchlog.date.toLocal())),
      onTap: () => patchlog.url.launchLink(context),
    );
  }
}
