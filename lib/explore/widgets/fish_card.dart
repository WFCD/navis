import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_data/fish_data.dart';
import 'package:flutter/material.dart';
import 'package:navis/items/items.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/string_extensions.dart';
import 'package:navis_ui/navis_ui.dart';

class FishCard extends StatelessWidget {
  const FishCard({super.key, required this.fish});

  // I'm sure this won't cause any problems down the line but I shoooould fix
  // that up later
  // ignore: strict_raw_type
  final Fish fish;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AppCard(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: 'webp/fish/${fish.thumbnail}.webp'.genesisGitCdn().optimize(
                  pixelRatio: MediaQuery.devicePixelRatioOf(context),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: StatsColumn(
                padding: const EdgeInsets.only(bottom: 4),
                stats: [
                  Stat(name: Text(l10n.fishName), value: Text(fish.name)),
                  Stat(name: Text(l10n.fishTime), value: Text(fish.time.string)),
                  Stat(name: Text(l10n.location), value: Text(fish.location)),
                  Stat(
                    name: Text(l10n.fishSpear),
                    value: _BuildSpearRequirement(requirements: fish.spearRequirments),
                  ),
                  Stat(name: Text(l10n.fishRarity), value: Text(fish.rarity)),
                  Stat(name: Text(l10n.fishBait), value: Text(fish.bait.name), isVisible: fish.bait.recommended),
                  Stat(
                    name: Text(l10n.fishStanding),
                    value: Text(
                      '${fish.small.standing}'
                      '/${fish.medium.standing}'
                      '/${fish.large.standing}',
                    ),
                    isVisible: fish.small.standing != null,
                  ),
                  Stat(
                    name: Text(l10n.fishUnique),
                    value: _BuildUniqueResources(uniqueResources: fish.uniqueResources),
                    isVisible: !fish.name.contains('Boot'),
                  ),
                ],
              ),
            ),
            if (!fish.name.contains('Boot')) ...{
              _BuildResources(small: fish.small.resources, medium: fish.medium.resources, large: fish.large.resources),
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
            .map((r) => Text(r.name, textAlign: TextAlign.end, maxLines: 1, overflow: TextOverflow.ellipsis))
            .toList(),
      );
    } else {
      resources = Text((uniqueResources as UniqueResource).name);
    }

    return resources;
  }
}

class _BuildResources extends StatelessWidget {
  const _BuildResources({required this.small, required this.medium, required this.large});

  final RegionResources small;
  final RegionResources medium;
  final RegionResources large;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final sizes = (small, medium, large);

    var stats = <Stat>[];

    if (sizes case (
      final DeimosRegionResources small,
      final DeimosRegionResources medium,
      final DeimosRegionResources large,
    )) {
      stats = [
        Stat(name: Text(l10n.fishBladder), value: Text('${small.bladder}/${medium.bladder}/${large.bladder}')),
        Stat(name: Text(l10n.fishGills), value: Text('${small.gills}/${medium.gills}/${large.gills}')),
        Stat(name: Text(l10n.fishTumors), value: Text('${small.tumor}/${medium.tumor}/${large.tumor}')),
      ];
    }

    if (sizes case (
      final PoeRegionResources small,
      final PoeRegionResources medium,
      final PoeRegionResources large,
    )) {
      stats = [
        Stat(name: Text(l10n.fishMeat), value: Text('${small.meat}/${medium.meat}/${large.meat}')),
        Stat(name: Text(l10n.fishOil), value: Text('${small.oil}/${medium.oil}/${large.oil}')),
        Stat(name: Text(l10n.fishScales), value: Text('${small.scales}/${medium.scales}/${large.scales}')),
      ];
    }

    if (sizes case (
      final VallisRegionResources small,
      final VallisRegionResources medium,
      final VallisRegionResources large,
    )) {
      stats = [Stat(name: Text(l10n.fishScrap), value: Text('${small.scrap}/${medium.scrap}/${large.scrap}'))];
    }

    return StatsColumn(padding: const EdgeInsets.only(bottom: 4), stats: stats);
  }
}

class _BuildSpearRequirement extends StatelessWidget {
  const _BuildSpearRequirement({required this.requirements});

  final SpearRequirements requirements;

  @override
  Widget build(BuildContext context) {
    if (requirements case DeimosRequirements(:final requiresEbisu, :final requiresSpari)) {
      final requiresAny = requiresEbisu && requiresSpari;

      if (requiresAny) return const Text('Ebisu/Spari');
      if (requiresEbisu) return const Text('Ebisu');
      if (requiresSpari) return const Text('Spari');
    }

    if (requirements case PoeRequirements(:final requiresLanzo, :final requiresPeram, :final requiresTulok)) {
      final requiresAny = requiresLanzo && requiresPeram && requiresTulok;

      if (requiresAny) return const Text('Lanzo/Peram/Tulok');
      if (requiresLanzo) return const Text('Lanzo');
      if (requiresPeram) return const Text('Peram');
      if (requiresTulok) return const Text('Tulok');
    }

    if (requirements is VallisRequirements) {
      return const Text('Shockprod/Stunna');
    }

    return Text(context.l10n.fishAny);
  }
}
