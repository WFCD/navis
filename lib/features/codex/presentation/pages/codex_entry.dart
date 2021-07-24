import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/utils/helper_methods.dart';
import '../widgets/codex_widgets.dart';

class CodexEntry extends StatelessWidget {
  const CodexEntry({Key? key}) : super(key: key);

  static const route = '/codexEntry';

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)?.settings.arguments as Item;
    final heightRatio = MediaQuery.of(context).size.height / 100;
    final heightMultiplier =
        getValueForScreenType(context: context, mobile: 32.0, tablet: 38.0);

    final height = heightRatio * heightMultiplier;

    return Scaffold(
      body: item.patchlogs != null
          ? TabbedEntry(item: item, height: height)
          : SingleEntry(item: item, height: height),
    );
  }
}

class SingleEntry extends StatelessWidget {
  const SingleEntry({
    Key? key,
    required this.item,
    required this.height,
  }) : super(key: key);

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
    Key? key,
    required this.item,
    required this.height,
  }) : super(key: key);

  final Item item;
  final double height;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                bottom: TabBar(
                  labelColor: Theme.of(context).textTheme.bodyText1?.color,
                  indicatorColor: Theme.of(context).textTheme.bodyText1?.color,
                  tabs: const [Tab(text: 'Overview'), Tab(text: 'Patchlogs')],
                ),
                expandedHeight: height,
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
    );
  }
}

class Overview extends StatelessWidget {
  const Overview({Key? key, required this.item}) : super(key: key);

  final Item item;

  bool get _isPowerSuit => item is PowerSuit;
  bool get _isGun => item is ProjectileWeapon && item.category != 'Pets';
  bool get _isMeleeWeapon => item is MeleeWeapon;
  bool get _isFoundryItem {
    return item is FoundryItem &&
        (item as FoundryItem).components != null &&
        ((item as FoundryItem).components?.isNotEmpty ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('overview'),
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      children: [
        if (_isFoundryItem) ...{
          ItemComponents(
            itemImageUrl: item.imageUrl,
            components: (item as FoundryItem).components!,
          ),
          const SizedBox(height: 16.0),
        },
        if (_isPowerSuit)
          FrameStats(powerSuit: item as PowerSuit)
        else if (_isGun)
          GunStats(projectileWeapon: item as ProjectileWeapon)
        else if (_isMeleeWeapon)
          MeleeStats(meleeWeapon: item as MeleeWeapon),
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
