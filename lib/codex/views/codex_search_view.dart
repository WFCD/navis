// We actually want the same color and elevation for containers.
// ignore_for_file: no-equal-arguments
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo/matomo.dart';
import 'package:navis/codex/bloc/search_bloc.dart';
import 'package:navis/codex/views/codex_entry.dart';
import 'package:navis/codex/widgets/codex_widgets.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class CodexSearchView extends TraceableStatelessWidget {
  const CodexSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SearchBloc(RepositoryProvider.of<WorldstateRepository>(context)),
      child: const _CodexSearch(),
    );
  }
}

class _CodexSearch extends StatelessWidget {
  const _CodexSearch();

  List<Widget> _headerSliverBuilder(BuildContext context) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: const SliverTopbar(
          floating: true,
          snap: true,
          child: CodexTextEditior(),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    const openContainerColor = Colors.transparent;
    const openContainerElevation = 0.0;
    const cacheExtent = 250.0;

    final l10n = context.l10n;

    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, _) => _headerSliverBuilder(context),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is CodexSuccessfulSearch && state.results.isNotEmpty) {
            return ListView.builder(
              itemCount: state.results.length,
              cacheExtent: cacheExtent,
              itemBuilder: (BuildContext context, int index) {
                return OpenContainer(
                  openColor: openContainerColor,
                  openElevation: openContainerElevation,
                  closedColor: openContainerColor,
                  closedElevation: openContainerElevation,
                  transitionType: ContainerTransitionType.fadeThrough,
                  openBuilder: (_, __) {
                    return CodexEntry(item: state.results[index]);
                  },
                  closedBuilder: (_, __) {
                    return CodexResult(item: state.results[index]);
                  },
                );
              },
            );
          }

          if (state is CodexSuccessfulSearch && state.results.isEmpty) {
            return Center(child: Text(l10n.codexNoResults));
          }

          if (state is CodexSearchEmpty) {
            return Center(
              child: Text(
                l10n.codexHint,
                textAlign: TextAlign.center,
              ),
            );
          }

          if (state is CodexSearchError) {
            return Center(child: Text(state.message));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
