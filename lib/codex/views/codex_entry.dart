import 'package:flutter/material.dart';
import 'package:navis/codex/utils/item_extensions.dart';
import 'package:navis/codex/views/market_view.dart';
import 'package:navis/codex/widgets/codex_entry/mod_drops.dart';
import 'package:navis/codex/widgets/codex_entry/mod_stats.dart';
import 'package:navis/codex/widgets/codex_widgets.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class CodexEntry extends StatelessWidget {
  const CodexEntry({super.key, required this.item});

  final Item item;

  static const route = '/codexEntry';

  @override
  Widget build(BuildContext context) {
    // ignore: cast_nullable_to_non_nullable
    // final item = ModalRoute.of(context)?.settings.arguments! as Item;
    final heightRatio = MediaQuery.of(context).size.height / 100;

    final height = item is Mod ? kMinExtent : heightRatio * 30;

    return Scaffold(
      body: SafeArea(
        child: (item.patchlogs != null || (item.tradable ?? false))
            ? TabbedEntry(item: item, height: height)
            : SingleEntry(item: item, height: height),
      ),
    );
  }
}

class SingleEntry extends StatelessWidget {
  const SingleEntry({
    super.key,
    required this.item,
    required this.height,
  });

  final Item item;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: BasicItemInfo(
            uniqueName: item.uniqueName,
            name: item.name,
            description: item.description?.parseHtmlString() ?? '',
            wikiaUrl: item.wikiaUrl,
            imageUrl: item.imageUrl,
            isMod: item is Mod,
            expandedHeight: height,
          ),
        ),
        SliverFillRemaining(
          child: Overview(item: item),
        )
      ],
    );
  }
}

class TabbedEntry extends StatelessWidget {
  const TabbedEntry({
    super.key,
    required this.item,
    required this.height,
  });

  final Item item;
  final double height;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const Tab(text: 'Overview'),
      if (item.patchlogs != null && (item.patchlogs?.isNotEmpty ?? false))
        const Tab(text: 'Patchlogs'),
      if (item.isMarketTradable) const Tab(text: 'Market')
    ];

    return DefaultTabController(
      length: tabs.length,
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
                isMod: item is Mod,
                isVaulted:
                    item is FoundryItem ? (item as FoundryItem).vaulted : null,
                bottom: TabBar(
                  labelColor: Theme.of(context).textTheme.bodyText1?.color,
                  indicatorColor: Theme.of(context).textTheme.bodyText1?.color,
                  tabs: tabs,
                ),
                expandedHeight: height,
              ),
            ),
          ];
        },
        body: TabBarView(
          children: [
            Overview(item: item),
            if (item.patchlogs != null && (item.patchlogs?.isNotEmpty ?? false))
              PatchlogsTimeline(patchlogs: item.patchlogs ?? []),
            if (item.isMarketTradable) MarketItemView(itemName: item.name)
          ],
        ),
      ),
    );
  }
}

class Overview extends StatelessWidget {
  const Overview({super.key, required this.item});

  final Item item;

  bool get _isPowerSuit => item is PowerSuit;
  bool get _isGun => item is ProjectileWeapon && item.category != 'Pets';
  bool get _isMeleeWeapon => item is MeleeWeapon;
  bool get _isMod => item is Mod;
  bool get _isFoundryItem {
    return item is FoundryItem &&
        (item as FoundryItem).components != null &&
        ((item as FoundryItem).components?.isNotEmpty ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('overview'),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        if (_isFoundryItem) ...{
          ItemComponents(
            itemImageUrl: item.imageUrl,
            components: (item as FoundryItem).components!,
          ),
          SizedBoxSpacer.spacerHeight16,
        },
        if (_isPowerSuit) FrameStats(powerSuit: item as PowerSuit),
        if (_isGun) GunStats(projectileWeapon: item as ProjectileWeapon),
        if (_isMeleeWeapon) MeleeStats(meleeWeapon: item as MeleeWeapon),
        if (_isMod) ModStats(mod: item as Mod),
        if (item.drops != null) ...{
          SizedBoxSpacer.spacerHeight20,
          const CategoryTitle(title: 'Drops'),
          ModDropLocations(drops: item.drops!),
        },
      ],
    );
  }
}

class PatchlogsTimeline extends StatelessWidget {
  const PatchlogsTimeline({super.key, required this.patchlogs});

  final List<Patchlog> patchlogs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const PageStorageKey('patchlogs'),
      padding: EdgeInsets.zero,
      itemCount: patchlogs.length,
      itemBuilder: (_, index) => PatchlogCard(patchlog: patchlogs[index]),
    );
  }
}
