import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/items/items.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/search/bloc/search_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final l10n = context.l10n;

        return switch (state) {
          SearchEmpty() => const SizedBox.shrink(),
          SearchInProgress() => const Center(child: WarframeSpinner()),
          SearchSuccessful(:final results) => _SearchResults(results: results),
          SearchFailure() => Center(child: Text(l10n.itemFailureErrorText)),
        };
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({required this.results});

  final List<WarframeItem> results;

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) return Center(child: Text(context.l10n.codexNoResults));

    return CustomScrollView(
      key: const PageStorageKey<String>('codex_search'),
      slivers: [
        SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
        SliverList.builder(
          itemCount: results.length,
          itemBuilder: (_, index) => ItemTile(item: results[index]),
        ),
      ],
    );
  }
}
