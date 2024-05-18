import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:warframestat_client/warframestat_client.dart';

class ModStats extends StatelessWidget {
  const ModStats({super.key, required this.mod});

  final Mod mod;

  Widget _buildRankedMod(int rank) {
    return _ModBuilder(mod: mod, rank: rank);
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(top: 16);
    const statsLimit = 3;

    final levelStats = mod.levelStats;

    if (mod.levelStats != null && levelStats!.length >= statsLimit) {
      return Padding(
        padding: padding,
        child: _ModWithStats(
          levels: levelStats.length,
          maxRank: mod.fusionLimit,
          builder: (_, rank) => _buildRankedMod(rank),
        ),
      );
    }

    return Padding(
      padding: padding,
      child: _ModBuilder(mod: mod),
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
  final int? maxRank;
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
            if (widget.maxRank != null)
              Slider(
                label: context.l10n.modLevelLabel(snapshot.data ?? 0),
                value: snapshot.data?.toDouble() ?? 0.0,
                max: widget.maxRank!.toDouble(),
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
  const _ModBuilder({required this.mod, this.rank = 0});

  final Mod mod;
  final int rank;

  @override
  Widget build(BuildContext context) {
    final rarity = mod.rarity ?? Rarity.common;
    final modParts = ModParts(
      thumbnail: mod.imageUrl,
      polarity: mod.polarity,
      rarity: rarity,
    );

    return SizedBox(
      width: 256,
      height: 512,
      child: FutureBuilder(
        future: modParts.fetchAllImages(),
        builder: (_, snapshot) {
          final hasData = snapshot.hasData;
          final data = snapshot.data;

          if (!hasData) return const Center(child: CircularProgressIndicator());

          if (hasData && data == null) {
            return const Center(
              child: Text('Failed to load one or more assets'),
            );
          }

          final painter = switch (rarity) {
            Rarity.common ||
            Rarity.uncommon ||
            Rarity.rare =>
              CommonModPainter(assets: data!, mod: mod, rank: rank),
            Rarity.legendary =>
              LegendaryModPainter(assets: data!, mod: mod, rank: rank)
          };

          return CustomPaint(painter: painter, size: const Size(256, 512));
        },
      ),
    );
  }
}
