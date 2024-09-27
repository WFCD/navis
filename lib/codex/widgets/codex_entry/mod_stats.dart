import 'package:flutter/material.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:warframestat_client/warframestat_client.dart';

class ModStats extends StatelessWidget {
  const ModStats({super.key, required this.mod});

  final Mod mod;

  @override
  Widget build(BuildContext context) {
    const minRank = 3;
    final hasRanks = (mod.fusionLimit ?? 0) >= minRank;

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: !hasRanks
          ? _ModBuilder(mod: mod)
          : _ModWithStats(
              maxRank: mod.fusionLimit ?? 0,
              builder: (_, rank) => _ModBuilder(mod: mod, rank: rank),
            ),
    );
  }
}

typedef BuildRankedMod = Widget Function(BuildContext, int);

class _ModWithStats extends StatefulWidget {
  const _ModWithStats({required this.maxRank, required this.builder});

  final int maxRank;
  final BuildRankedMod builder;

  @override
  State<_ModWithStats> createState() => _ModWithStatsState();
}

class _ModWithStatsState extends State<_ModWithStats> {
  int _value = 0;

  void _slide(double value) {
    if (context.mounted && value != _value) {
      setState(() => _value = value.toInt());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.maxRank != 0)
          Slider(
            label: context.l10n.modLevelLabel(_value),
            value: _value.toDouble(),
            max: widget.maxRank.toDouble(),
            divisions: widget.maxRank,
            onChanged: _slide,
          ),
        widget.builder(context, _value),
      ],
    );
  }
}

class _ModBuilder extends StatelessWidget {
  const _ModBuilder({required this.mod, this.rank = 0});

  final Mod mod;
  final int rank;

  @override
  Widget build(BuildContext context) {
    const size = Size(256, 512);

    final rarity = mod.rarity ?? Rarity.common;
    final modParts = ModParts(
      thumbnail: mod.imageUrl,
      polarity: mod.polarity,
      rarity: rarity,
    );

    return Center(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: size.width, maxHeight: size.height),
        child: FutureBuilder(
          future: modParts.fetchAllImages(),
          builder: (_, snapshot) {
            final hasData = snapshot.hasData;
            final data = snapshot.data;

            if (!hasData) return const CircularProgressIndicator();

            if (hasData && data == null) {
              return const Text('Failed to load one or more assets');
            }

            final painter = switch (rarity) {
              Rarity.common ||
              Rarity.uncommon ||
              Rarity.rare =>
                CommonModPainter(assets: data!, mod: mod, rank: rank),
              Rarity.legendary =>
                LegendaryModPainter(assets: data!, mod: mod, rank: rank)
            };

            return CustomPaint(painter: painter, size: size);
          },
        ),
      ),
    );
  }
}
