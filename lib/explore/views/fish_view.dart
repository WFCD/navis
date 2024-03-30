import 'package:fish_repository/fish_repository.dart';
import 'package:flutter/material.dart';
import 'package:navis/explore/explore.dart';

class FishPage extends StatelessWidget {
  const FishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: FishView());
  }
}

class FishView extends StatelessWidget {
  const FishView({super.key});

  @override
  Widget build(BuildContext context) {
    const tabs = [
      {'name': 'Deimos', 'region': FishingRegion.deimos},
      {'name': 'Plains of Eidolon', 'region': FishingRegion.poe},
      {'name': 'Orb Vallis', 'region': FishingRegion.vallis},
    ];

    return SafeArea(
      child: DefaultTabController(
        length: tabs.length,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: const Text('Fishing data'),
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    tabs: tabs
                        .map((r) => Tab(text: r['name']! as String))
                        .toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            // These are the contents of the tab views, below the tabs.
            children: tabs.map((r) {
              return FishDataView(region: r['region']! as FishingRegion);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
