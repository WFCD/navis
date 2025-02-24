import 'package:fish_repository/fish_repository.dart';
import 'package:flutter/material.dart';
import 'package:navis/explore/explore.dart';

class FishDataView extends StatelessWidget {
  const FishDataView({super.key, required this.region});

  final FishingRegion region;

  @override
  Widget build(BuildContext context) {
    // See FishCard widget
    // ignore: strict_raw_type
    return FutureBuilder<List<Fish>>(
      future: loadFishResources(region),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data;

        return CustomScrollView(
          key: PageStorageKey<String>(region.name),
          slivers: <Widget>[
            SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                return FishCard(fish: data[index]);
                // format doesn't know whether it needs it or not
                // ignore: require_trailing_commas
              }, childCount: data!.length),
            ),
          ],
        );
      },
    );
  }
}
