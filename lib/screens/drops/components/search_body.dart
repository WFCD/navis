import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/screens/drops/components/search_results.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<TableSearchBloc>(context),
      builder: (BuildContext context, SearchState state) {
        if (state is SearchStateEmpty)
          return const Center(
              child: Text(
                  'Type what you\'re looking for into the search above above!'));
        if (state is SearchStateLoading)
          return const Center(child: CircularProgressIndicator());

        if (state is SearchStateSuccess)
          return state.results.isEmpty
              ? const Center(
                  child: Text('No Results'),
                )
              : Expanded(child: SearchResults(rewards: state.results));
      },
    );
  }
}
