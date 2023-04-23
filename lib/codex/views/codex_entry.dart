import 'package:flutter/material.dart';
import 'package:navis/codex/widgets/codex_entry/drops.dart';
import 'package:navis/codex/widgets/codex_entry/mod_stats.dart';
import 'package:navis/codex/widgets/codex_widgets.dart';
import 'package:navis/utils/item_extensions.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class CodexEntry extends StatelessWidget {
  const CodexEntry({super.key, required this.item});

  final Item item;

  static const route = '/codexEntry';

  @override
  Widget build(BuildContext context) {
    // Final item = ModalRoute.of(context)?.settings.arguments! as Item;.
    final heightRatio = MediaQuery.of(context).size.height / 100;
    final height = item is Mod ? kMinExtent : heightRatio * 25;

    return Scaffold(
      body: SafeArea(
        child: (item.patchlogs != null || (item.tradable ?? false))
            ? _TabbedEntry(item: item, height: height)
            : _SingleEntry(item: item, height: height),
      ),
    );
  }
}

class _SingleEntry extends StatelessWidget {
  const _SingleEntry({required this.item, required this.height});

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
          child: _Overview(item: item),
        ),
      ],
    );
  }
}

class _TabbedEntry extends StatelessWidget {
  const _TabbedEntry({required this.item, required this.height});

  final Item item;
  final double height;

  List<Widget> _headerSliverBuilder(BuildContext context, List<Widget> tabs) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

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
          isVaulted: item is FoundryItem ? (item as FoundryItem).vaulted : null,
          bottom: TabBar(
            labelColor: textColor,
            // We want the same color
            // ignore: no-equal-arguments
            indicatorColor: textColor,
            tabs: tabs,
          ),
          expandedHeight: height,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final patchlogs = item.patchlogs;

    final tabs = [
      const Tab(text: 'Overview'),
      if (patchlogs != null && (patchlogs.isNotEmpty))
        const Tab(text: 'Patchlogs'),
      if (item.isMarketTradable) const Tab(text: 'Market'),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: NestedScrollView(
        headerSliverBuilder: (context, _) =>
            _headerSliverBuilder(context, tabs),
        body: TabBarView(
          children: [
            _Overview(item: item),
            if (item.patchlogs != null && (item.patchlogs?.isNotEmpty ?? false))
              _PatchlogsTimeline(patchlogs: item.patchlogs ?? []),
            if (item.isMarketTradable) MarketItemView(itemName: item.name),
          ],
        ),
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({required this.item});

  final Item item;

  bool get _isPowerSuit => item is PowerSuit;
  bool get _isGun => item is Gun;
  bool get _isMeleeWeapon => item is Melee;
  bool get _isMod => item is Mod;
  bool get _isFoundryItem {
    if (item is BuildableItem) {
      final foundryItem = item as BuildableItem;

      return foundryItem.components != null &&
          foundryItem.components!.length > 1;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final patchlogs = item.patchlogs;
    final heightRatio = MediaQuery.of(context).size.height / 100;

    final height = item is Mod ? kToolbarHeight : heightRatio * 25;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: BasicItemInfo(
                uniqueName: item.uniqueName,
                name: item.name,
                description: item.description?.parseHtmlString() ?? '',
                wikiaUrl: item.wikiaUrl,
                imageUrl: item.imageUrl,
                expandedHeight: height,
                enable: !_isMod,
                isVaulted: item is EquipableItem
                    ? (item as EquipableItem).vaulted
                    : false,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  if (_isFoundryItem)
                    ItemComponents(
                      itemImageUrl: item.imageUrl,
                      components: (item as BuildableItem).components!,
                    ),
                  if (_isPowerSuit)
                    AppCard(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: FrameStats(powerSuit: item as PowerSuit),
                    ),
                  if (_isGun)
                    AppCard(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GunStats(gun: item as Gun),
                    ),
                  if (_isMeleeWeapon)
                    AppCard(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: MeleeStats(melee: item as Melee),
                    ),
                  if (_isMod) ...{
                    ModStats(mod: item as Mod),
                    SizedBoxSpacer.spacerHeight24,
                    DropLocations(drops: (item as Mod).drops!)
                  },
                  if (patchlogs != null) PatchlogCard(patchlogs: patchlogs),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
