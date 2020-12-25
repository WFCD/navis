import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/utils/helper_methods.dart';
import '../widgets/codex_entry/components.dart';
import '../widgets/codex_entry/entry_info.dart';
import '../widgets/codex_entry/frame_stats.dart';
import '../widgets/codex_entry/patchlogs.dart';
import '../widgets/codex_entry/weapon_stats.dart';

class CodexEntry extends StatelessWidget {
  const CodexEntry({Key key}) : super(key: key);

  static const route = '/codexEntry';

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context).settings.arguments as Item;
    final heightRatio = (MediaQuery.of(context).size.longestSide ?? 0) / 100;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: BasicItemInfo(
              uniqueName: item.uniqueName,
              name: item.name,
              description: parseHtmlString(item.description ?? ''),
              wikiaUrl: item.wikiaUrl,
              imageUrl: item.imageUrl,
              expandedHeight: heightRatio * 36,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 4.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                if (item is PowerSuit)
                  FrameStats(powerSuit: item)
                else if (item is ProjectileWeapon && item.category != 'Pets')
                  GunStats(projectileWeapon: item)
                else if (item is MeleeWeapon)
                  MeleeStats(meleeWeapon: item),
                if (item is FoundryItem && item.components != null)
                  ItemComponents(
                      itemImageUrl: item.imageUrl, components: item.components),
                if (item.patchlogs != null)
                  PatchlogCards(patchlogs: item.patchlogs)
              ]),
            ),
          )
        ],
      ),
    );
  }
}
