import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/codex/cubit/rank_slider_cubit.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:warframestat_client/warframestat_client.dart';

class ModStats extends StatelessWidget {
  const ModStats({super.key, required this.mod});

  final Mod mod;

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.only(top: 16);
    const statsLimit = 3;

    final levelStats = mod.levelStats;
    final hasRanks = mod.levelStats != null && levelStats!.length >= statsLimit;

    return Padding(
      padding: padding,
      child: !hasRanks
          ? _ModBuilder(mod: mod)
          : BlocProvider(
              create: (context) => RankSliderCubit(),
              child: _ModWithStats(
                levels: levelStats.length,
                maxRank: mod.fusionLimit ?? 0,
                builder: (_, rank) => _ModBuilder(mod: mod, rank: rank),
              ),
            ),
    );
  }
}

typedef BuildRankedMod = Widget Function(BuildContext, int);

class _ModWithStats extends StatelessWidget {
  const _ModWithStats({
    required this.levels,
    required this.maxRank,
    required this.builder,
  });

  final int levels;
  final int maxRank;
  final BuildRankedMod builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RankSliderCubit, int>(
      builder: (context, state) {
        return Column(
          children: [
            if (maxRank != 0)
              Slider(
                label: context.l10n.modLevelLabel(state),
                value: state.toDouble(),
                max: maxRank.toDouble(),
                divisions: levels - 1,
                onChanged: BlocProvider.of<RankSliderCubit>(context).update,
              ),
            builder(context, state),
          ],
        );
      },
    );
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

          return BlocBuilder<RankSliderCubit, int>(
            builder: (context, state) {
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
          );
        },
      ),
    );
  }
}
