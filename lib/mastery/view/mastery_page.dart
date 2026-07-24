import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/mastery/widgets/mastery_item_tile.dart';
import 'package:navis/mastery_search/mastery_search.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:profile_repository/profile_repository.dart';

class MasteryPage extends StatelessWidget {
  const MasteryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MasterySearchBloc(context.read<ProfileRepository>()),
      child: const Scaffold(body: SafeArea(child: MasteryView())),
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

  final _tabs = <({String name, List<MasterableItem> Function(List<MasterableItem> items) items})>[
    (name: 'In Progress', items: (List<MasterableItem> items) => items.inProgress),
    (name: 'Warframes', items: (List<MasterableItem> items) => items.warframes),
    (name: 'Primary', items: (List<MasterableItem> items) => items.primaries),
    (name: 'Secondary', items: (List<MasterableItem> items) => items.secondary),
    (name: 'Melee', items: (List<MasterableItem> items) => items.melee),
    (name: 'Companions', items: (List<MasterableItem> items) => items.companions),
    (name: 'K-Drive', items: (List<MasterableItem> items) => items.kDrives),
    (name: 'Archwing', items: (List<MasterableItem> items) => items.archwing),
    (name: 'Arch-Gun', items: (List<MasterableItem> items) => items.archGun),
    (name: 'Arch-Melee', items: (List<MasterableItem> items) => items.archMelee),
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
                title: BlocSelector<ProfileCubit, ProfileState, List<MasterableItem>>(
                  selector: (state) => switch (state) {
                    ProfileSuccessful(:final xpInfo) => xpInfo.list,
                    _ => [],
                  },
                  builder: (context, items) {
                    final completed = items.where((i) => i.level >= 30).length;
                    return MasterySearchBar(hintText: 'Mastered $completed out of ${items.length}');
                  },
                ),
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
                  .asMap()
                  .map((index, tab) {
                    return MapEntry(
                      index,
                      _MasteryList(
                        controller: _controllers[index],
                        items: tab.items(state.xpInfo.list),
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

class _MasteryList extends StatelessWidget {
  const _MasteryList({this.controller, required this.items});

  final ScrollController? controller;
  final List<MasterableItem> items;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => BlocProvider.of<ProfileCubit>(context).refreshProfile(),
      child: items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(WarframeIcons.menuWoundedInfestedPredator, size: 200),
                  Text(
                    'Nothing to see here',
                    style: context.textTheme.titleLarge,
                  ),
                ],
              ),
            )
          : ListView.builder(
              controller: controller,
              itemCount: items.length,
              itemBuilder: (context, index) => MasteryItemTile(masterableItem: items[index]),
            ),
    );
  }
}
