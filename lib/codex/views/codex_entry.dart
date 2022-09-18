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
    // Final item = ModalRoute.of(context)?.settings.arguments! as Item;.
    final heightRatio = MediaQuery.of(context).size.height / 100;

    final height = item is Mod ? kMinExtent : heightRatio * 30;

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
    final textColor = Theme.of(context).textTheme.bodyText1?.color;

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
  bool get _isGun => item is ProjectileWeapon && item.category != 'Pets';
  bool get _isMeleeWeapon => item is MeleeWeapon;
  bool get _isMod => item is Mod;

  bool get _isFoundryItem {
    if (item is FoundryItem) {
      final foundryItem = item as FoundryItem;

      return foundryItem.components != null &&
          (foundryItem.components?.isNotEmpty ?? false);
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('overview'),
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      children: [
        if (_isFoundryItem) ...{
          ItemComponents(
            itemImageUrl: item.imageUrl,
            components: (item as FoundryItem).components ?? <Component>[],
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
          ModDropLocations(drops: item.drops ?? <Drop>[]),
        },
      ],
    );
  }
}

class _PatchlogsTimeline extends StatelessWidget {
  const _PatchlogsTimeline({required this.patchlogs});

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
