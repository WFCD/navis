import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navis/codex/widgets/codex_entry/mod_entry.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class ModStats extends StatelessWidget {
  const ModStats({Key? key, required this.mod}) : super(key: key);

  final Mod mod;

  String _modDescription([int? rank]) {
    String? description;

    if (mod.levelStats != null) {
      description =
          mod.levelStats![rank ?? 0]['stats']!.fold<String>('', (p, e) {
        if (p.isEmpty) {
          return '$e\n';
        } else {
          return '$p$e\n';
        }
      });
    }

    return description?.parseHtmlString() ??
        mod.description?.parseHtmlString() ??
        '';
  }

  Widget _buildRankedMod(BuildContext context, int rank) {
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
      rarity: mod.rarity,
    );
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(top: 16);

    if (mod.levelStats != null && mod.levelStats!.length >= 3) {
      return Padding(
        padding: padding,
        child: _ModWithStats(
          levels: mod.levelStats!.length,
          maxRank: mod.fusionLimit.toDouble(),
          builder: _buildRankedMod,
        ),
      );
    } else {
      return Padding(
        padding: padding,
        child: _ModBuilder(
          imageUrl: mod.imageUrl,
          name: mod.name,
          stats: _modDescription(),
          maxRank: mod.fusionLimit,
          rank: mod.fusionLimit,
          drain: mod.baseDrain.isNegative ? mod.fusionLimit : mod.baseDrain,
          polarity: mod.polarity,
          compatName: mod.compatName,
          modSet: mod.modSet,
          rarity: mod.rarity,
        ),
      );
    }
  }
}

typedef BuildRankedMod = Widget Function(BuildContext, int);

class _ModWithStats extends StatefulWidget {
  const _ModWithStats({
    Key? key,
    required this.levels,
    required this.maxRank,
    required this.builder,
  }) : super(key: key);

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
              label: NavisLocalizations.of(context)!
                  .modLevelLabel(snapshot.data ?? 0),
              value: snapshot.data?.toDouble() ?? 0.0,
              max: widget.maxRank,
              divisions: widget.levels - 1,
              onChanged: onChanged,
            ),
            widget.builder(context, snapshot.data ?? 0)
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
    Key? key,
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
  }) : super(key: key);

  final String imageUrl;
  final String name;
  final String stats;
  final String? compatName;
  final String? modSet;
  final int maxRank;
  final int rank;
  final int drain;
  final String polarity;
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
