import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:profile_repository/profile_repository.dart';

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

typedef _MasteryCategory = ({String name, List<MasterableItem> Function(List<MasterableItem> items) filter});

class _MasteryViewState extends State<MasteryView> {
  late final List<ScrollController> _controllers;

  final _tabs = <_MasteryCategory>[
    (name: 'In Progress', filter: (items) => items.inProgress),
    (name: 'Warframes', filter: (items) => items.warframes),
    (name: 'Primary', filter: (items) => items.primaries),
    (name: 'Secondary', filter: (items) => items.secondary),
    (name: 'Melee', filter: (items) => items.melee),
    (name: 'Companions', filter: (items) => items.companions),
    (name: 'K-Drive', filter: (items) => items.kDrives),
    (name: 'Archwing', filter: (items) => items.archwing),
    (name: 'Arch-Gun', filter: (items) => items.archGun),
    (name: 'Arch-Melee', filter: (items) => items.archMelee),
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
    _controllers = _tabs.map((i) => ScrollController(debugLabel: i.name)).toList();
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
                title: const MasteryItemSearchBar(),
                bottom: TabBar(
                  isScrollable: true,
                  tabs: _tabs.map((i) => Tab(text: i.name)).toList(),
                  onTap: _onTap,
                ),
              ),
            ),
          ];
        },
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is! ProfileSuccessful) {
              return const Center(child: WarframeSpinner());
            }

            return TabBarView(
              children: _tabs
                  .mapIndexed(
                    (index, tab) => ArsenalItems(
                      controller: _controllers[index],
                      items: tab.filter(state.xpInfo.list),
                    ),
                  )
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
