import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo/matomo.dart';

import '../../../../l10n/l10n.dart';
import '../bloc/search_bloc.dart';
import '../widgets/codex_widgets.dart';

class CodexSearchScreen extends TraceableStatelessWidget {
  const CodexSearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                itemBuilder: (BuildContext context, int index) =>
                    CodexResult(item: state.results[index]),
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
