import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/widgets/screen_widgets/codex/codex.dart';

class Codex extends StatelessWidget {
  const Codex({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<SearchBloc>(context),
      builder: (BuildContext context, SearchState state) {
        return Stack(children: <Widget>[
          CustomScrollView(
            slivers: const <Widget>[SearchBar(), SearchResults()],
          ),
          if (state is SearchStateSuccess && state.results.isEmpty)
            const Center(child: Text('No Results')),
          if (state is SearchStateLoading)
            const Center(child: CircularProgressIndicator()),
          if (state is SearchStateEmpty)
            const Center(
                child: Text(
                    'Type what you\'re looking for into the search above!')),
          if (state is SearchStateError)
            const Center(child: Text('An error has occurred'))
        ]);
      },
    );
  }
}
