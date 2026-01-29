import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_codex/navis_codex.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart' hide ItemNotFound;
import 'package:warframestat_repository/warframestat_repository.dart';

class ComponentDrops extends StatelessWidget {
  const ComponentDrops({super.key, required this.controller, required this.drops});

  final ScrollController controller;
  final List<Drop> drops;

  void _loadRelic(BuildContext context, String itemName) {
    final codex = RepositoryProvider.of<CodexDatabase>(context);
    final repo = RepositoryProvider.of<WarframestatRepository>(context);

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return BlocProvider(
            create: (context) => ItemCubit(itemName, codex, repo)..fetchItem(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  return BlocBuilder<ItemCubit, ItemState>(
                    builder: (context, state) {
                      final l10n = context.l10n;

                      if (state is! ItemFetchSuccess) {
                        return const Center(child: WarframeSpinner());
                      }

                      if (state is ItemNotFound) {
                        return Center(child: Text(l10n.codexNoResults));
                      }

                      return EntryView(
                        uniqueName: state.item.uniqueName,
                        name: state.item.name,
                        description: state.item.description,
                        imageName: state.item.imageName,
                        type: state.item.type,
                        wikiaUrl: state.item.wikiaUrl,
                        wikiaThumbnail: state.item.wikiaThumbnail,
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const cacheExtent = 150.0;
    const densityThreshold = 10;

    final drops = this.drops
      ..removeWhere((d) => d.location.contains(RegExp(r'\(([^)]+)\)')))
      ..sort((a, b) {
        return ((b.chance ?? 0) * 100).compareTo((a.chance ?? 0) * 100);
      });

    return ListView.builder(
      controller: controller,
      cacheExtent: cacheExtent,
      itemCount: drops.length,
      itemBuilder: (context, index) {
        final drop = drops[index];
        final percentage = ((drop.chance ?? 0) * 100).toStringAsFixed(2);

        return ListTile(
          title: Text(drop.location),
          subtitle: Text('$percentage% drop chance'),
          onTap: drop.uniqueName != null ? () => _loadRelic(context, drop.uniqueName!) : null,
          dense: drops.length > densityThreshold,
        );
      },
    );
  }
}
