import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/utils/helper_methods.dart';
import '../widgets/codex_widgets.dart';

class CodexEntry extends StatelessWidget {
  const CodexEntry({Key? key}) : super(key: key);

  static const route = '/codexEntry';

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)?.settings.arguments as Item;
    final heightRatio = MediaQuery.of(context).size.longestSide / 100;

    return Scaffold(
      body: item.patchlogs != null
          ? DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder: (context, index) {
                  return [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: BasicItemInfo(
                        uniqueName: item.uniqueName,
                        name: item.name,
                        description: item.description?.parseHtmlString() ?? '',
                        wikiaUrl: item.wikiaUrl,
                        imageUrl: item.imageUrl,
                        bottom: const TabBar(
                          tabs: [Tab(text: 'Overview'), Tab(text: 'Patchlogs')],
                        ),
                        expandedHeight: heightRatio * 38,
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    Overview(item: item),
                    PatchlogsTimeline(patchlogs: item.patchlogs ?? [])
                  ],
                ),
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: BasicItemInfo(
                    uniqueName: item.uniqueName,
                    name: item.name,
                    description: item.description?.parseHtmlString() ?? '',
                    wikiaUrl: item.wikiaUrl,
                    imageUrl: item.imageUrl,
                    expandedHeight: heightRatio * 38,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Overview(item: item),
                )
              ],
            ),
    );
  }
}

class Overview extends StatelessWidget {
  const Overview({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('overview'),
      children: [
        if (item is PowerSuit)
          FrameStats(powerSuit: item as PowerSuit)
        else if (item is ProjectileWeapon && item.category != 'Pets')
          GunStats(projectileWeapon: item as ProjectileWeapon)
        else if (item is MeleeWeapon)
          MeleeStats(meleeWeapon: item as MeleeWeapon),
        if (item is FoundryItem &&
            (item as FoundryItem).components != null &&
            ((item as FoundryItem).components?.isNotEmpty ?? false))
          ItemComponents(
            itemImageUrl: item.imageUrl,
            components: (item as FoundryItem).components!,
          ),
      ],
    );
  }
}

class PatchlogsTimeline extends StatelessWidget {
  const PatchlogsTimeline({Key? key, required this.patchlogs})
      : super(key: key);

  final List<Patchlog> patchlogs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const PageStorageKey('patchlogs'),
      itemCount: patchlogs.length,
      itemBuilder: (_, index) => PatchlogCard(patchlog: patchlogs[index]),
    );
  }
}
