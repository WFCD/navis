import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class CodexSearchPage extends StatelessWidget {
  const CodexSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<WarframestatRepository>(context);

    return TraceableWidget(
      child: Scaffold(
        body: SafeArea(
          child: BlocProvider(
            create: (_) => SearchBloc(repo),
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context,
                    ),
                    sliver: SliverAppBar(
                      clipBehavior: Clip.none,
                      shape: const StadiumBorder(),
                      scrolledUnderElevation: 0,
                      titleSpacing: 0,
                      backgroundColor: Colors.transparent,
                      automaticallyImplyLeading: false,
                      floating: true,
                      forceElevated: innerBoxIsScrolled,
                      title: const CodexSearchBar(),
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
        if (state is CodexSuccessfulSearch && state.results.isNotEmpty) {
          return CustomScrollView(
            key: const PageStorageKey<String>('codex_search'),
            slivers: [
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverList.builder(
                itemCount: state.results.length,
                itemBuilder: (BuildContext context, int index) {
                  return EntryViewOpenContainer(
                    item: state.results[index],
                    builder: (_, onTap) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CodexResult(
                          item: state.results[index],
                          showDescription: true,
                          onTap: onTap,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          );
        }

        if (state is CodexSuccessfulSearch && state.results.isEmpty) {
          return Center(child: Text(l10n.codexNoResults));
        }

        if (state is CodexSearchEmpty) {
          return const SizedBox.shrink();
        }

        if (state is CodexSearchError) {
          return Center(child: Text(state.message));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
