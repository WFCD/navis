import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/core/widgets/sliver_top_bar.dart';
import 'package:navis/features/codex/presentation/widgets/codex_result.dart';
// import 'package:navis/generated/l10n.dart';

import '../bloc/search_bloc.dart';
import '../bloc/search_state.dart';
import '../widgets/search_bar.dart';

class CodexSearchScreen extends StatelessWidget {
  const CodexSearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final navisLocalizations = NavisLocalizations.of(context);

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: const SliverTopbar(
              pinned: true,
              child: CodexSearchBar(),
            ),
          )
        ];
      },
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is CodexSuccessfulSearch && state.results.isNotEmpty) {
            return ListView.builder(
              itemCount: state.results.length,
              cacheExtent: 500,
              itemBuilder: (BuildContext context, int index) =>
                  CodexResult(item: state.results[index]),
            );
          } else if (state is CodexSuccessfulSearch && state.results.isEmpty) {
            return const Center(child: Text('No Results'));
          } else if (state is CodexSearchEmpty) {
            return const Center(
              child: Text(
                'Type what you\'re looking for into the search bar above!',
                textAlign: TextAlign.center,
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
