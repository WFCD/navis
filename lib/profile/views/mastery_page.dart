import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoria/inventoria.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis/profile/utils/extensions.dart';
import 'package:navis_ui/navis_ui.dart';

class MasteryPage extends StatelessWidget {
  const MasteryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final inventoria = RepositoryProvider.of<Inventoria>(context);

    return Scaffold(
      body: SafeArea(
        child: BlocProvider(create: (_) => ArsenalCubit(inventoria)..fetchXpInfo(), child: const MasteryView()),
      ),
    );
  }
}

class MasteryView extends StatefulWidget {
  const MasteryView({super.key});

  @override
  State<MasteryView> createState() => _MasteryViewState();
}

class _MasteryViewState extends State<MasteryView> {
  late final List<ScrollController> _controllers;

  final _tabs = <Map<String, dynamic>>[
    {
      'name': 'In Progress',
      'items': (List<InventoryItemData> items) => items.whereNot((i) => i.rank == i.maxRank || i.isMissing).toList(),
    },
    {'name': 'Warframes', 'items': (List<InventoryItemData> items) => items.warframes},
    {'name': 'Primary', 'items': (List<InventoryItemData> items) => items.primaries},
    {'name': 'Secondary', 'items': (List<InventoryItemData> items) => items.secondary},
    {'name': 'Melee', 'items': (List<InventoryItemData> items) => items.melee},
    {'name': 'Companions', 'items': (List<InventoryItemData> items) => items.companions},
    {'name': 'K-Drive', 'items': (List<InventoryItemData> items) => items.kDrives},
    {'name': 'Archwing', 'items': (List<InventoryItemData> items) => items.archwing},
    {'name': 'Arch-Gun', 'items': (List<InventoryItemData> items) => items.archGun},
    {'name': 'Arch-Melee', 'items': (List<InventoryItemData> items) => items.archMelee},
  ];

  void _onTap(int index) {
    if (!mounted) return;

    final controller = _controllers[index];
    if (!controller.hasClients) return;
    if (controller.position.pixels == 0) return;

    controller.animateTo(0, duration: Durations.short4, curve: Curves.easeIn);
  }

  @override
  void initState() {
    super.initState();
    _controllers = _tabs.map((i) => ScrollController(debugLabel: i['name'] as String)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                floating: true,
                snap: true,
                clipBehavior: Clip.hardEdge,
                automaticallyImplyLeading: false,
                title: MasteryItemSearchBar(onPressed: () => Navigator.pop(context)),
                bottom: TabBar(
                  isScrollable: true,
                  tabs: _tabs.map((i) => Tab(text: i['name'] as String)).toList(),
                  onTap: _onTap,
                ),
              ),
            ),
          ];
        },
        body: BlocBuilder<ArsenalCubit, ArsenalState>(
          builder: (context, state) {
            if (state is! ArsenalSuccess) {
              return const Center(child: WarframeSpinner());
            }

            return TabBarView(
              children:
                  _tabs
                      .asMap()
                      .map((index, tab) {
                        return MapEntry(
                          index,
                          ArsenalItems(
                            controller: _controllers[index],
                            items: (tab['items'] as List<InventoryItemData> Function(List<InventoryItemData>))(
                              state.items,
                            ),
                          ),
                        );
                      })
                      .values
                      .toList(),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }

    super.dispose();
  }
}
