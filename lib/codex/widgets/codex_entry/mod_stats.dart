import 'package:flutter/material.dart';
import 'package:navis/codex/codex.dart';
import 'package:warframestat_client/warframestat_client.dart';

class ModStats extends StatelessWidget {
  const ModStats({super.key, required this.mod});

  final Mod mod;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(top: 16), child: _ModBuilder(mod: mod));
  }
}

class _ModBuilder extends StatelessWidget {
  const _ModBuilder({required this.mod});

  final Mod mod;

  @override
  Widget build(BuildContext context) {
    const size = Size(256, 512);

    final rarity = mod.rarity ?? Rarity.common;
    final modParts = ModParts(thumbnail: mod.imageUrl, polarity: mod.polarity, rarity: rarity);

    final fusionLimit = mod.fusionLimit ?? 0;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: size.width, maxHeight: size.height),
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
              Rarity.rare => CommonModPainter(assets: data!, mod: mod, rank: fusionLimit),
              Rarity.legendary => LegendaryModPainter(assets: data!, mod: mod, rank: fusionLimit),
            };

            return CustomPaint(painter: painter, size: size);
          },
        ),
      ),
    );
  }
}
