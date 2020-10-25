import 'package:flutter/material.dart';
import 'package:navis/features/codex/presentation/widgets/codex_entry/weapon_stats.dart';
import 'package:warframestat_api_models/entities.dart';

import '../../../../core/utils/helper_methods.dart';
import '../widgets/codex_entry/entry_info.dart';
import '../widgets/codex_entry/frame_stats.dart';

class CodexEntry extends StatelessWidget {
  const CodexEntry({Key key}) : super(key: key);

  static const route = '/codexEntry';

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context).settings.arguments as BaseItem;
    final heightRatio = (MediaQuery.of(context).size.longestSide ?? 0) / 100;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: BasicItemInfo(
              name: item.name,
              description: parseHtmlString(item.description),
              wikiaUrl: item.wikiaUrl,
              imageUrl: item.imageUrl,
              expandedHeight: heightRatio * 36,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 4.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(<Widget>[
                if (item is BioWeapon)
                  FrameStats(
                    health: item.health,
                    shield: item.shield,
                    armor: item.armor,
                    power: item.power,
                    sprintSpeed: item.sprintSpeed,
                    passive: item.passiveDescription,
                    category: item.category,
                  )
                else if (item is Gun)
                  GunStats(
                    masteryReq: item.masteryReq,
                    type: item.type,
                    category: item.category,
                    accuracy: item.accuracy,
                    criticalChance: item.criticalChance,
                    criticalMultiplier: item.criticalMultiplier,
                    fireRate: item.fireRate,
                    magazineSize: item.magazineSize,
                    multishot: item.multishot,
                    noise: item.noise,
                    reload: item.reloadTime,
                    disposition: item.disposition,
                    procChance: item.procChance,
                    trigger: item.trigger,
                    damageTypes: item.damageTypes,
                  )
                else if (item is Melee)
                  MeleeStats(
                    masteryReq: item.masteryReq,
                    type: item.type,
                    category: item.category,
                    criticalChance: item.criticalChance,
                    criticalMultiplier: item.criticalMultiplier,
                    attackSpeed: item.attackSpeed,
                    disposition: item.disposition,
                    procChance: item.procChance,
                    damageTypes: item.damageTypes,
                  ),
                // if (item is BioWeapon || item is Gun || item is Melee)
                //   ItemComponents(components: (item as Gun).components)
              ]),
            ),
          )
        ],
      ),
    );
  }
}
