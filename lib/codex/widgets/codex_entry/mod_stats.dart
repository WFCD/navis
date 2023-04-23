import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navis/codex/widgets/codex_entry/mod_entry.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/item_extensions.dart';
import 'package:warframestat_client/warframestat_client.dart';

class ModStats extends StatelessWidget {
  const ModStats({super.key, required this.mod});

  final Mod mod;

  String _modDescription([int rank = 0]) {
    if (mod.description != null && mod.description!.isNotEmpty) {
      return mod.description!;
    }

    final description = StringBuffer();

    if (mod.levelStats != null) {
      for (final stat in mod.levelStats![rank].stats) {
        description.write('$stat\n');
      }
    }

    return description.toString();
  }

  Widget _buildRankedMod(int rank) {
    return _ModBuilder(
      imageUrl: mod.imageUrl,
      name: mod.name,
      stats: _modDescription(rank),
      compatName: mod.compatName,
      modSet: mod.modSet,
      maxRank: mod.fusionLimit,
      rank: rank,
      drain: mod.baseDrain + rank,
      polarity: mod.polarity,
      rarity: mod.rarity.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(top: 16);
    const statsLimit = 3;

    final levelStats = mod.levelStats;

    // Already being checked for null.
    // ignore: avoid-non-null-assertion
    if (mod.levelStats != null && levelStats!.length >= statsLimit) {
      return Padding(
        padding: padding,
        child: _ModWithStats(
          levels: levelStats.length,
          maxRank: mod.fusionLimit.toDouble(),
          builder: (_, rank) => _buildRankedMod(rank),
        ),
      );
    }

    return Padding(
      padding: padding,
      child: _ModBuilder(
        imageUrl: mod.imageUrl,
        name: mod.name,
        stats: _modDescription(),
        maxRank: mod.fusionLimit,
        rank: 0,
        drain: (mod.baseDrain.isNegative) ? mod.fusionLimit : mod.baseDrain,
        polarity: mod.polarity,
        compatName: mod.compatName,
        modSet: mod.modSet,
        rarity: mod.rarity.name,
      ),
    );
  }
}

typedef BuildRankedMod = Widget Function(BuildContext, int);

class _ModWithStats extends StatefulWidget {
  const _ModWithStats({
    required this.levels,
    required this.maxRank,
    required this.builder,
  });

  final int levels;
  final double maxRank;
  final BuildRankedMod builder;

  @override
  __ModWithStatsState createState() => __ModWithStatsState();
}

class __ModWithStatsState extends State<_ModWithStats> {
  StreamController<int>? _controller;

  @override
  void initState() {
    super.initState();
    _controller = StreamController<int>();
  }

  void onChanged(double value) {
    _controller?.sink.add(value.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      initialData: 0,
      stream: _controller?.stream,
      builder: (context, snapshot) {
        return Column(
          children: [
            Slider(
              label: context.l10n.modLevelLabel(snapshot.data ?? 0),
              value: snapshot.data?.toDouble() ?? 0.0,
              max: widget.maxRank,
              divisions: widget.levels - 1,
              onChanged: onChanged,
            ),
            widget.builder(context, snapshot.data ?? 0),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.close();
    _controller = null;
  }
}

class _ModBuilder extends StatelessWidget {
  const _ModBuilder({
    required this.imageUrl,
    required this.name,
    required this.stats,
    this.compatName,
    this.modSet,
    required this.maxRank,
    required this.rank,
    required this.drain,
    required this.polarity,
    required this.rarity,
  });

  final String imageUrl;
  final String name;
  final String stats;
  final String? compatName;
  final String? modSet;
  final int maxRank;
  final int rank;
  final int? drain;
  final String? polarity;
  final String rarity;

  @override
  Widget build(BuildContext context) {
    switch (rarity) {
      case 'Rare':
        return ModFrame.rare(
          image: imageUrl,
          name: name,
          stats: stats,
          compatName: compatName ?? '',
          modSet: modSet,
          maxRank: maxRank,
          rank: rank,
          baseDrain: drain,
          polarity: polarity,
          rarity: rarity,
        );
      case 'Uncommon':
        return ModFrame.uncommon(
          image: imageUrl,
          name: name,
          stats: stats,
          compatName: compatName ?? '',
          modSet: modSet,
          maxRank: maxRank,
          rank: rank,
          baseDrain: drain,
          polarity: polarity,
          rarity: rarity,
        );
      case 'Legendary':
        return ModFrame.primed(
          image: imageUrl,
          name: name,
          stats: stats,
          compatName: compatName ?? '',
          modSet: modSet,
          maxRank: maxRank,
          rank: rank,
          baseDrain: drain,
          polarity: polarity,
          rarity: rarity,
        );
      default:
        return ModFrame.common(
          image: imageUrl,
          name: name,
          stats: stats,
          compatName: compatName ?? '',
          modSet: modSet,
          maxRank: maxRank,
          rank: rank,
          baseDrain: drain,
          polarity: polarity,
          rarity: rarity,
        );
    }
  }
}
