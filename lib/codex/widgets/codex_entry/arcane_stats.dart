import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:navis/gen/assets.gen.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/string_extensions.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart' hide Alignment;

class ArcaneStats extends StatelessWidget {
  const ArcaneStats({super.key, required this.arcane});

  final Arcane arcane;

  // Widget _rankImage(int rank) {
  //   final image = switch (rank) {
  //     0 => Assets.arcanes.arcaneProgressIcon1.image(),
  //     1 => Assets.arcanes.arcaneProgressIcon2.image(),
  //     2 => Assets.arcanes.arcaneProgressIcon3.image(),
  //     3 => Assets.arcanes.arcaneProgressIcon4.image(),
  //     4 => Assets.arcanes.arcaneProgressIcon5.image(),
  //     5 => Assets.arcanes.arcaneProgressIcon6.image(),
  //     _ => null,
  //   };

  //   return image ?? const Icon(WarframeIcons.nightmare);
  // }

  @override
  Widget build(BuildContext context) {
    final imageName = arcane.imageName;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (imageName != null) _ArcaneImage(imageName: imageName, rarity: arcane.rarity!),
        CategoryTitle(title: context.l10n.rankCategoryTitle, contentPadding: EdgeInsets.zero),
        ...?arcane.levelStats?.mapIndexed((i, l) => _ArcaneLevelTile(index: i, level: l)),
      ],
    );
  }
}

class _ArcaneImage extends StatelessWidget {
  const _ArcaneImage({required this.imageName, required this.rarity});

  final String imageName;
  final Rarity rarity;

  @override
  Widget build(BuildContext context) {
    const imageSize = Size.square(256);
    const imagePadding = 60;
    final widgetSize = Size(imageSize.width - imagePadding, imageSize.height - imagePadding);

    final image = switch (rarity) {
      Rarity.common => Assets.arcanes.common.image(),
      Rarity.uncommon => Assets.arcanes.uncommon.image(),
      Rarity.rare => Assets.arcanes.rare.image(),
      Rarity.legendary => Assets.arcanes.legendary.image(),
    };

    return SizedBox.fromSize(
      size: widgetSize,
      child: Stack(
        children: [
          image,
          Align(
            alignment: const Alignment(0, -0.50),
            child: CachedNetworkImage(
              imageUrl: imageName.warframeItemsCdn(),
              width: widgetSize.width / 2,
              height: widgetSize.height / 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ArcaneLevelTile extends StatelessWidget {
  const _ArcaneLevelTile({required this.index, required this.level});

  final int index;
  final LevelStat level;

  int get _totalCost => ((index + 1) * (index + 2) / 2).floor();
  int get _costForNextRank => index + 2;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hintStyle = context.textTheme.bodySmall?.copyWith(color: context.colorScheme.primary);

    final title = index == 0 ? l10n.unrankedTitle : context.l10n.itemRankSubtitle(index);
    final requiredForNextRank = l10n.requiresForNextArcaneRank(_costForNextRank);
    final totalForRank = l10n.totalArcaneCost(_totalCost);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: context.textTheme.titleMedium),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(totalForRank, style: hintStyle),
              if (_totalCost != 21) Text(requiredForNextRank, style: hintStyle),
            ],
          ),
        ],
      ),
      subtitle: Text(level.stats.join('\n').replaceAll(r'\n', '\n')),
    );
  }
}
