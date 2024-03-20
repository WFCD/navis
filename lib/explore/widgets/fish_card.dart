import 'package:fish_repository/fish_repository.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

class FishCard extends StatelessWidget {
  const FishCard({super.key, required this.fish});

  // ignore: strict_raw_type
  final Fish fish;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CategoryTitle(title: 'Name'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fish.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  if (fish.small.standing != null)
                    Text(
                      'Standing: '
                      '${fish.small.standing}'
                      '/${fish.medium.standing}'
                      '/${fish.large.standing}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.grey[400],
                          ),
                    ),
                ],
              ),
            ),
            if (!fish.name.contains('Boot')) ...{
              const CategoryTitle(title: 'Unique Resources'),
              _BuildUniqueResources(uniqueResources: fish.uniqueResources),
            },
            if (!fish.name.contains('Boot')) ...{
              const CategoryTitle(title: 'Resources S/M/L'),
              _BuildResources(
                small: fish.small.resources,
                medium: fish.medium.resources,
                large: fish.large.resources,
              ),
            }
          ],
        ),
      ),
    );
  }
}

class _BuildUniqueResources<T> extends StatelessWidget {
  const _BuildUniqueResources({super.key, required this.uniqueResources});

  final T uniqueResources;

  @override
  Widget build(BuildContext context) {
    Widget resources;
    if (uniqueResources is List<UniqueResource>) {
      resources = Wrap(
        children: (uniqueResources as List<UniqueResource>).map(
          (r) {
            return ColoredContainer(
              tooltip: r.name,
              child: Text(r.name),
            );
          },
        ).toList(),
      );
    } else {
      resources = ColoredContainer(
        tooltip: (uniqueResources as UniqueResource).name,
        child: Text((uniqueResources as UniqueResource).name),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: resources,
    );
  }
}

class _BuildResources extends StatelessWidget {
  const _BuildResources({
    required this.small,
    required this.medium,
    required this.large,
  });

  final RegionResources small;
  final RegionResources medium;
  final RegionResources large;

  @override
  Widget build(BuildContext context) {
    Widget widget;
    // Check small and assume the reset are all from the same region.
    if (small is DeimosRegionResources) {
      final small = this.small as DeimosRegionResources;
      final medium = this.medium as DeimosRegionResources;
      final large = this.large as DeimosRegionResources;

      widget = Wrap(
        children: [
          if (small.bladder > 1)
            ColoredContainer(
              tooltip: 'Bladder',
              child: Text(
                'Bladder: '
                '${small.bladder}/${medium.bladder}/${large.bladder}',
              ),
            ),
          if (small.gills > 1)
            ColoredContainer(
              tooltip: 'Gills',
              child: Text(
                'Gills: '
                '${small.gills}/${medium.gills}/${large.gills}',
              ),
            ),
          if (small.tumor > 1)
            ColoredContainer(
              tooltip: 'Tumor',
              child: Text(
                'Tumor: '
                '${small.tumor}/${medium.tumor}/${large.tumor}',
              ),
            ),
        ],
      );
    } else if (small is PoeRegionResources) {
      final small = this.small as PoeRegionResources;
      final medium = this.medium as PoeRegionResources;
      final large = this.large as PoeRegionResources;

      widget = Wrap(
        children: [
          if (small.meat > 1)
            ColoredContainer(
              tooltip: 'Meat',
              child: Text(
                'Meat: '
                '${small.meat}/${medium.meat}/${large.meat}',
              ),
            ),
          if (small.oil > 1)
            ColoredContainer(
              tooltip: 'Oil',
              child: Text(
                'Oil: '
                '${small.oil}/${medium.oil}/${large.oil}',
              ),
            ),
          if (small.scales > 1)
            ColoredContainer(
              tooltip: 'Scales',
              child: Text(
                'Scales: '
                '${small.scales}/${medium.scales}/${large.scales}',
              ),
            ),
        ],
      );
    } else {
      final small = this.small as VallisRegionResources;
      final medium = this.medium as VallisRegionResources;
      final large = this.large as VallisRegionResources;

      widget = ColoredContainer(
        tooltip: 'Scrap',
        child: Text('Scrap: ${small.scrap}/${medium.scrap}/${large.scrap}'),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: widget,
    );
  }
}
