import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/screens/drops/components/search_bar.dart';
import 'package:navis/screens/drops/components/search_results.dart';

class DropTableList extends StatelessWidget {
  const DropTableList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<TableSearchBloc>(context),
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
            Center(child: Text('An unknown error has occured: ${state.error}'))
        ]);
      },
    );
  }
}
