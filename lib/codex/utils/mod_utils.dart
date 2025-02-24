import 'dart:async';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:warframestat_client/warframestat_client.dart';

const imgHost = 'https://cdn.warframestat.us/genesis';
const imgHostPath = {'polarities': 'img/polarities', 'frames': 'modFrames'};

typedef ModBackground = ({ui.Image background, ui.Image backer, ui.Image lowerTab});

typedef ModFrame = ({ui.Image top, ui.Image sideLights, ui.Image cornerLights, ui.Image bottom});

typedef ModAssets =
    ({
      ui.Image thumbnail,
      ui.Image? polarity,
      ui.Image rankSlotActive,
      ui.Image rankSlotEmpty,
      ModBackground surface,
      ModFrame frame,
    });

String formatDescription(String? description, List<LevelStat>? levelStats, int rank) {
  if (description != null && description.isNotEmpty) return description;

  final buffer = StringBuffer();
  if (levelStats != null) {
    for (final stat in levelStats[rank].stats) {
      buffer.write('$stat\n');
    }

    return buffer.toString();
  }

  return 'Unable to parse mod description';
}

Future<ui.Image> fetchImage(String part) async {
  final completer = Completer<ImageInfo>();
  final image = CachedNetworkImageProvider(part);
  final listener = ImageStreamListener((info, _) {
    if (!completer.isCompleted) completer.complete(info);
  });

  image.resolve(ImageConfiguration.empty).addListener(listener);

  return (await completer.future).image;
}

String polarityUrl(String polarity) {
  return Uri.parse('$imgHost/${imgHostPath['polarities']}/${polarity.toLowerCase()}.png').toString();
}

class ModParts {
  const ModParts({required this.thumbnail, required this.polarity, required this.rarity});

  final String thumbnail;
  final String? polarity;
  final Rarity rarity;

  String _partUrl(String part) {
    return Uri.parse('$imgHost/${imgHostPath['frames']}/${rarity.toUniqueName()}$part.png').toString();
  }

  String _assetUrl(String asset) {
    return Uri.parse('$imgHost/${imgHostPath['frames']}/$asset.png').toString();
  }

  Future<ModBackground> fetchBackground() async {
    return (
      background: await fetchImage(_partUrl('Background')),
      lowerTab: await fetchImage(_partUrl('LowerTab')),
      backer: await fetchImage(_partUrl('TopRightBacker')),
    );
  }

  Future<ModFrame> fetchFrame() async {
    return (
      top: await fetchImage(_partUrl('FrameTop')),
      sideLights: await fetchImage(_partUrl('SideLight')),
      cornerLights: await fetchImage(_partUrl('CornerLights')),
      bottom: await fetchImage(_partUrl('FrameBottom')),
    );
  }

  Future<ModAssets> fetchAllImages() async {
    final polarity = polarityUrl(this.polarity!);

    return (
      thumbnail: await fetchImage(thumbnail),
      polarity: this.polarity != null ? await fetchImage(polarity) : null,
      rankSlotActive: await fetchImage(_assetUrl('RankSlotActive')),
      rankSlotEmpty: await fetchImage(_assetUrl('RankSlotEmpty')),
      surface: await fetchBackground(),
      frame: await fetchFrame(),
    );
  }
}

extension RarityX on Rarity {
  String toUniqueName() {
    return switch (this) {
      Rarity.common => 'Bronze',
      Rarity.uncommon => 'Silver',
      Rarity.rare => 'Gold',
      Rarity.legendary => 'Legendary',
    };
  }

  Color toColor() {
    return switch (this) {
      Rarity.common => const Color(0xFFCA9A87),
      Rarity.uncommon => Colors.white,
      Rarity.rare => const Color(0xFFFEEBC1),
      Rarity.legendary => Colors.white,
    };
  }
}
