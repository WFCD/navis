import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_repository/fish_repository.dart';
import 'package:flutter/material.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/utils/string_extensions.dart';
import 'package:navis_ui/navis_ui.dart';

class FishCard extends StatelessWidget {
  const FishCard({super.key, required this.fish});

  // ignore: strict_raw_type
  final Fish fish;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CachedNetworkImage(
                width: 150,
                height: 100,
                imageUrl: 'webp/fish/${fish.thumbnail}.webp'
                    .genesisGitCdn()
                    .optimize(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Stats(
                padding: const EdgeInsets.only(bottom: 4),
                stats: [
                  RowItem(
                    text: const Text('Name'),
                    child: Text(fish.name),
                  ),
                  RowItem(
                    text: const Text('Time'),
                    child: Text(fish.time.string),
                  ),
                  RowItem(
                    text: const Text('Location'),
                    child: Text(fish.location),
                  ),
                  RowItem(
                    text: const Text('Spear'),
                    child: _BuildSpearRequirement(
                      requirements: fish.spearRequirments,
                    ),
                  ),
                  RowItem(
                    text: const Text('Rarity'),
                    child: Text(fish.rarity),
                  ),
                  if (fish.bait.recommended)
                    RowItem(
                      text: const Text('Bait'),
                      child: Text(fish.bait.name),
                    ),
                  if (fish.small.standing != null)
                    RowItem(
                      text: const Text('Standing'),
                      child: Text(
                        '${fish.small.standing}'
                        '/${fish.medium.standing}'
                        '/${fish.large.standing}',
                      ),
                    ),
                  if (!fish.name.contains('Boot'))
                    RowItem(
                      text: const Text('Unique'),
                      child: _BuildUniqueResources(
                        uniqueResources: fish.uniqueResources,
                      ),
                    ),
                ],
              ),
            ),
            if (!fish.name.contains('Boot')) ...{
              _BuildResources(
                small: fish.small.resources,
                medium: fish.medium.resources,
                large: fish.large.resources,
              ),
              // RowItem(text: text, child: child),
            },
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
      resources = Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: (uniqueResources as List<UniqueResource>)
            .map(
              (r) => Text(
                r.name,
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
            .toList(),
      );
    } else {
      resources = Text((uniqueResources as UniqueResource).name);
    }

    return resources;
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
    List<RowItem> widgets;

    // Check small and assume the reset are all from the same region.
    if (small is DeimosRegionResources) {
      final small = this.small as DeimosRegionResources;
      final medium = this.medium as DeimosRegionResources;
      final large = this.large as DeimosRegionResources;

      widgets = [
        if (small.bladder > 1)
          RowItem(
            text: const Text('Bladder'),
            child: Text('${small.bladder}/${medium.bladder}/${large.bladder}'),
          ),
        if (small.gills > 1)
          RowItem(
            text: const Text('Gills'),
            child: Text('${small.gills}/${medium.gills}/${large.gills}'),
          ),
        if (small.tumor > 1)
          RowItem(
            text: const Text('Tumor'),
            child: Text('${small.tumor}/${medium.tumor}/${large.tumor}'),
          ),
      ];
    } else if (small is PoeRegionResources) {
      final small = this.small as PoeRegionResources;
      final medium = this.medium as PoeRegionResources;
      final large = this.large as PoeRegionResources;

      widgets = [
        if (small.meat > 1)
          RowItem(
            text: const Text('Meat'),
            child: Text('${small.meat}/${medium.meat}/${large.meat}'),
          ),
        if (small.oil > 1)
          RowItem(
            text: const Text('Oil'),
            child: Text('${small.oil}/${medium.oil}/${large.oil}'),
          ),
        if (small.scales > 1)
          RowItem(
            text: const Text('Scales'),
            child: Text('${small.scales}/${medium.scales}/${large.scales}'),
          ),
      ];
    } else {
      final small = this.small as VallisRegionResources;
      final medium = this.medium as VallisRegionResources;
      final large = this.large as VallisRegionResources;

      widgets = [
        RowItem(
          text: const Text('Scrap'),
          child: Text('${small.scrap}/${medium.scrap}/${large.scrap}'),
        ),
      ];
    }

    return Stats(
      padding: const EdgeInsets.only(bottom: 4),
      stats: widgets,
    );
  }
}

class _BuildSpearRequirement extends StatelessWidget {
  const _BuildSpearRequirement({required this.requirements});

  final SpearRequirements requirements;

  @override
  Widget build(BuildContext context) {
    if (requirements is DeimosRequirements) {
      final requirements = this.requirements as DeimosRequirements;
      final requiresAny =
          requirements.requiresEbisu && requirements.requiresSpari;

      if (requiresAny) return const Text('Ebisu/Spari');
      if (requirements.requiresEbisu) return const Text('Ebisu');
      if (requirements.requiresSpari) return const Text('Spari');
    }

    if (requirements is PoeRequirements) {
      final requirements = this.requirements as PoeRequirements;
      final requiresAny = requirements.requiresLanzo &&
          requirements.requiresPeram &&
          requirements.requiresTulok;

      if (requiresAny) return const Text('Lanzo/Peram/Tulok');
      if (requirements.requiresLanzo) return const Text('Lanzo');
      if (requirements.requiresPeram) return const Text('Peram');
      if (requirements.requiresTulok) return const Text('Tulok');
    }

    if (requirements is VallisRequirements) {
      return const Text('Shockprod/Stunna');
    }

    return const Text('Any');
  }
}
