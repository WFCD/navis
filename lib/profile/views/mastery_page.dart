import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class MasteryPage extends StatelessWidget {
  const MasteryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: MasteryView()));
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
      'items': (ArsenalSuccess state) => state.xpInfo
          .whereNot((i) => i.rank == i.maxRank || i.rank == 0)
          .toList(),
    },
    {
      'name': 'Warframes',
      'items': (ArsenalSuccess state) => state.warframes,
    },
    {
      'name': 'Primary',
      'items': (ArsenalSuccess state) => state.primaries,
    },
    {
      'name': 'Secondary',
      'items': (ArsenalSuccess state) => state.secondary,
    },
    {
      'name': 'Melee',
      'items': (ArsenalSuccess state) => state.melee,
    },
    {
      'name': 'Companions',
      'items': (ArsenalSuccess state) => state.companions,
    },
    {
      'name': 'K-Drive',
      'items': (ArsenalSuccess state) => state.kDrives,
    },
    {
      'name': 'Archwing',
      'items': (ArsenalSuccess state) => state.archwing,
    },
    {
      'name': 'Arch-Gun',
      'items': (ArsenalSuccess state) => state.archGun,
    },
    {
      'name': 'Arch-Melee',
      'items': (ArsenalSuccess state) => state.archMelee,
    },
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
    _controllers = _tabs
        .map((i) => ScrollController(debugLabel: i['name'] as String))
        .toList();
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
                title: MasteryItemSearchBar(
                  onPressed: () => Navigator.pop(context),
                ),
                bottom: TabBar(
                  isScrollable: true,
                  tabs:
                      _tabs.map((i) => Tab(text: i['name'] as String)).toList(),
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
              children: _tabs
                  .asMap()
                  .map(
                    (index, tab) {
                      return MapEntry(
                        index,
                        ArsenalItems(
                          controller: _controllers[index],
                          items: (tab['items'] as List<MasteryProgress>
                              Function(ArsenalSuccess))(state),
                        ),
                      );
                    },
                  )
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
