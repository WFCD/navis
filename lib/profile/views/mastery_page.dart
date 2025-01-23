import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis_ui/navis_ui.dart';

class MasteryPage extends StatelessWidget {
  const MasteryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: MasteryView()));
  }
}

class MasteryView extends StatelessWidget {
  const MasteryView({super.key});

  @override
  Widget build(BuildContext context) {
    const tabs = [
      Tab(text: 'In Progress'),
      Tab(text: 'Warframes'),
      Tab(text: 'Primary'),
      Tab(text: 'Secondary'),
      Tab(text: 'Melee'),
      Tab(text: 'Companions'),
      Tab(text: 'K-Drive'),
      Tab(text: 'Archwing'),
      Tab(text: 'Arch-Gun'),
      Tab(text: 'Arch-Melee'),
    ];

    return DefaultTabController(
      length: tabs.length,
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
                bottom: const TabBar(isScrollable: true, tabs: tabs),
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
              children: [
                ArsenalItems(
                  items: state.xpInfo
                      .whereNot((i) => i.rank == i.maxRank || i.rank == 0)
                      .toList(),
                ),
                ArsenalItems(items: state.warframes),
                ArsenalItems(items: state.primaries),
                ArsenalItems(items: state.secondary),
                ArsenalItems(items: state.melee),
                ArsenalItems(items: state.companions),
                ArsenalItems(items: state.kDrives),
                ArsenalItems(items: state.archwing),
                ArsenalItems(items: state.archGun),
                ArsenalItems(items: state.archMelee),
              ],
            );
          },
        ),
      ),
    );
  }
}
