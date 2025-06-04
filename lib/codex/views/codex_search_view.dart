import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class CodexSearchPage extends StatelessWidget {
  const CodexSearchPage({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<WarframestatRepository>(context);

    return TraceableWidget(
      child: Scaffold(
        body: SafeArea(
          child: BlocProvider(
            create: (_) => SearchBloc(repo)..add(CodexTextChanged(query)),
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    sliver: SliverAppBar(
                      titleSpacing: 0,
                      floating: true,
                      scrolledUnderElevation: 0,
                      automaticallyImplyLeading: false,
                      clipBehavior: Clip.none,
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.transparent,
                      forceElevated: innerBoxIsScrolled,
                      title: CodexSearchBar(hintText: query),
                    ),
                  ),
                ];
              },
              body: const CodexSearchView(),
            ),
          ),
        ),
      ),
    );
  }
}

class CodexSearchView extends StatelessWidget {
  const CodexSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return switch (state) {
          CodexSearchEmpty() => const SizedBox.shrink(),
          CodexSearchInProgress() => const Center(child: WarframeSpinner()),
          CodexSearchFailure() => Center(child: Text(state.error.toString())),
          CodexSearchSuccess(results: final r) =>
            r.isNotEmpty ? Center(child: Text(l10n.codexNoResults)) : _CodexViewContent(results: r),
        };
      },
    );
  }
}

class _CodexViewContent extends StatelessWidget {
  const _CodexViewContent({required this.results});

  final List<MinimalItem> results;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: const PageStorageKey<String>('codex_search'),
      slivers: [
        SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
        SliverList.builder(
          itemCount: results.length,
          itemBuilder: (BuildContext context, int index) {
            final item = results[index];

            return EntryViewOpenContainer(
              item: item,
              builder: (_, onTap) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CodexResult(item: results[index], showDescription: item.description != null, onTap: onTap),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
