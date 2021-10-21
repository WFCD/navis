import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo/matomo.dart';

import '../../../../l10n/l10n.dart';
import '../bloc/search_bloc.dart';
import '../widgets/codex_widgets.dart';
import 'codex_entry.dart';

class CodexSearchScreen extends TraceableStatelessWidget {
  const CodexSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const openContainerColor = Colors.transparent;
    const openContainerElevation = 0.0;

    final l10n = NavisLocalizations.of(context)!;

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: const SliverPersistentHeader(
              pinned: true,
              delegate: CodexSearchBar(),
            ),
          )
        ];
      },
      body: Padding(
        padding: const EdgeInsets.only(top: kTextTabBarHeight + 10),
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is CodexSuccessfulSearch && state.results.isNotEmpty) {
              return ListView.builder(
                itemCount: state.results.length,
                cacheExtent: 500,
                itemBuilder: (BuildContext context, int index) {
                  return OpenContainer(
                    openColor: openContainerColor,
                    closedColor: openContainerColor,
                    openElevation: openContainerElevation,
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
            } else if (state is CodexSuccessfulSearch &&
                state.results.isEmpty) {
              return Center(child: Text(l10n.codexNoResults));
            } else if (state is CodexSearchEmpty) {
              return Center(
                child: Text(
                  l10n.codexHint,
                  textAlign: TextAlign.center,
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
